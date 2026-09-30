import prisma from '../../prisma';
import { AuthRequest } from '../../types/auth-request';
import { HttpError } from '../../types/error';
import checkAuth from '../check-auth';
import { ProductFilterInput } from '../../types/graphql-inputs';
import type { Prisma } from '../../generated/prisma/client';
import { formatCategory, formatProduct, formatReview } from '../format';


export default {
    categories: async function () {
        const list = await prisma.category.findMany();
        return list.map(formatCategory);
    },

    category: async function ({ id }: { id: string }) {
        const cat = await prisma.category.findUnique({ where: { id: +id } });
        if (!cat) {
            const err: HttpError = new Error('Category not found');
            err.statusCode = 404;
            throw err;
        }
        return formatCategory(cat);
    },

    products: async function ({ filter }: { filter?: ProductFilterInput }, req: AuthRequest) {
        const where: Prisma.productWhereInput = {};
        if (filter) {
            if (filter.category_id) where.category_id = +filter.category_id;
            if (filter.search) where.name = { contains: filter.search, mode: 'insensitive' };
            if (filter.min_price !== undefined || filter.max_price !== undefined) {
                // Prisma skips a bound that's undefined
                where.price = { gte: filter.min_price, lte: filter.max_price };
            }
            if (filter.min_rating !== undefined) where.rating = { gte: filter.min_rating };
            if (filter.discount_only) where.discount = { gt: 0 };
            if (filter.locally_sourced_only) where.locally_sourced = true;
            if (filter.pesticide_free_only) where.pesticide_free = true;
        }

        const list = await prisma.product.findMany({
            where,
            take: filter?.limit,
            skip: filter?.offset,
            include: {
                category: true,
                favorite: req.isAuth && req.id ? { where: { user_id: req.id } } : false,
                review: {
                    include: {
                        user: true
                    }
                }
            }
        });

        return list.map((p) => formatProduct(p));
    },

    product: async function ({ id }: { id: string }, req: AuthRequest) {
        const prod = await prisma.product.findUnique({
            where: { id: +id },
            include: {
                category: true,
                favorite: req.isAuth && req.id ? { where: { user_id: req.id } } : false,
                review: {
                    include: {
                        user: true
                    }
                }
            }
        });
        if (!prod) {
            const err: HttpError = new Error('Product not found');
            err.statusCode = 404;
            throw err;
        }
        return formatProduct(prod);
    },

    productReviews: async function ({ product_id }: { product_id: string }) {
        const list = await prisma.review.findMany({
            where: { product_id: +product_id },
            include: {
                user: true
            }
        });
        return list.map(formatReview);
    },

    addReview: async function ({ product_id, rating, comment }: { product_id: string; rating: number; comment: string }, req: AuthRequest) {
        checkAuth(req);
        const pId = +product_id;
        const review = await prisma.review.create({
            data: {
                product_id: pId,
                user_id: req.id!,
                rating,
                comment
            },
            include: {
                user: true
            }
        });

        const allReviews = await prisma.review.findMany({
            where: { product_id: pId }
        });
        const totalRating = allReviews.reduce((sum, r) => sum + Number(r.rating), 0);
        const avgRating = allReviews.length > 0 ? totalRating / allReviews.length : 0;

        await prisma.product.update({
            where: { id: pId },
            data: {
                rating: avgRating
            }
        });

        return formatReview(review);
    },

    toggleFavorite: async function ({ product_id }: { product_id: string }, req: AuthRequest) {
        checkAuth(req);
        const pId = +product_id;
        const existing = await prisma.favorite.findUnique({
            where: {
                user_id_product_id: {
                    user_id: req.id!,
                    product_id: pId
                }
            }
        });

        if (existing) {
            await prisma.favorite.delete({
                where: {
                    user_id_product_id: {
                        user_id: req.id!,
                        product_id: pId
                    }
                }
            });
            return false;
        } else {
            await prisma.favorite.create({
                data: {
                    user_id: req.id!,
                    product_id: pId
                }
            });
            return true;
        }
    }
};
