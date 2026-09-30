import prisma from '../../prisma';
import { AuthRequest } from '../../types/auth-request';
import { HttpError } from '../../types/error';
import checkAuth from '../check-auth';
import { DEFAULT_SHIPPING_METHOD, SHIPPING_METHODS } from '../shipping';
import { catchUpOrders } from '../order-progress';
import { formatOrder } from '../format';
import { OrderInput } from '../../types/graphql-inputs';


export default {
    createOrder: async function (args: OrderInput, req: AuthRequest) { // get almost all the data internally instead of having it all as arguments
        checkAuth(req)

        const cartItems = await prisma.cart_item.findMany({
            where: { user_id: req.id! },
            include: { product: true }
        })
        if (cartItems.length === 0) {
            const err: HttpError = new Error('No items in cart')
            err.statusCode = 404
            throw err
        }
        else {
            //not empty cart
            const shippingMethod = args.shipping_method ?? DEFAULT_SHIPPING_METHOD
            const shippingPrice = SHIPPING_METHODS[shippingMethod]?.price
            if (shippingPrice === undefined) {
                const err: HttpError = new Error('Unknown shipping method')
                err.statusCode = 422
                throw err
            }
            let sum = 0
            cartItems.forEach(item => { //decimal needs to be converted to number
                const discountFactor = 1 - (item.product.discount.toNumber() / 100);
                const itemPrice = item.product.price.toNumber() * discountFactor;
                sum += itemPrice * item.quantity;
            })
            sum += shippingPrice
            return await prisma.$transaction(async (tx) => { //transaction means that it all has to work to be done or it all rolls back. no cleared carts without orders or vice versa
                const newOrder = await tx.order.create({
                    data: {
                        user_id: req.id!,
                        address_id: +args.address_id,
                        card_id: +args.card_id,
                        shipping_method: shippingMethod,
                        total_amount: sum,
                        //we also need to add order items using the id of this order. we have a relationship that simplifies this
                        order_item: {
                            create: cartItems.map(item => {
                                const discountFactor = 1 - (item.product.discount.toNumber() / 100);
                                const priceAtPurchase = item.product.price.toNumber() * discountFactor;
                                return {
                                    product_id: item.product_id,
                                    quantity: item.quantity,
                                    price_at_purchase: priceAtPurchase
                                };
                            })
                        }
                    },
                    include: {
                        order_item: {
                            include: {
                                product: {
                                    include: {
                                        category: true,
                                        favorite: { where: { user_id: req.id! } }
                                    }
                                }
                            }
                        },
                        address: true,
                        credit_card: true
                    }

                })
                const card = await tx.credit_card.findUnique({
                    where: { id: +args.card_id }
                });

                await tx.transaction.create({
                    data: {
                        user_id: req.id!,
                        order_id: newOrder.id,
                        amount: sum,
                        status: 'success',
                        payment_method: card ? card.processor : 'mastercard'
                    }
                });

                //clear cart
                await tx.cart_item.deleteMany({
                    where: { user_id: req.id! }
                })

                return formatOrder(newOrder);
            })
        }
    },

    order: async function ({ id }: { id: string }, req: AuthRequest) {
        checkAuth(req)
        const found = await prisma.order.findUnique({
            where: { id: +id },
            include: {
                order_item: {
                    include: {
                        product: {
                            include: {
                                category: true,
                                favorite: { where: { user_id: req.id! } }
                            }
                        }
                    }
                },
                address: true,
                credit_card: true
            }
        });
        if (!found) {
            const err: HttpError = new Error('Order not found')
            err.statusCode = 404
            throw err
        }
        else if (found.user_id != req.id) {
            const err: HttpError = new Error('This order belongs to another account')
            err.statusCode = 403
            throw err
        }
        else {
            const [order] = await catchUpOrders([found])
            return formatOrder(order);
        }
    }
};
