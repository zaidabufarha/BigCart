import type {
    category,
    favorite,
    order,
    order_item,
    product,
    review,
    transaction,
    user,
} from '../generated/prisma/client';

// Database rows → what the GraphQL schema returns. Every resolver goes
// through these, so a type is shaped the same wherever it comes from. Two
// things need converting: colors are BigInt in the database (GraphQL has no
// 64-bit integer, so they go out as strings), and dates go out as ISO strings.
// Decimal columns (price, rating…) need nothing: GraphQL's Float reads them.

type ProductRow = product & {
    category?: category | null;
    // included filtered to the signed-in user, so it's non-empty only if
    // they favorited this product
    favorite?: favorite[];
    review?: (review & { user?: user })[];
};

type OrderRow = order & {
    order_item?: (order_item & { product: ProductRow })[];
    transaction?: transaction[];
};

type UserRow = user & {
    order?: OrderRow[];
    transaction?: transaction[];
    favorite?: (favorite & { product: ProductRow })[];
};

const isoOrNull = (date: Date | null) => (date ? date.toISOString() : null);

export function formatCategory(c: category) {
    return { ...c, color: c.color.toString() };
}

export function formatReview(r: review & { user?: user }) {
    return { ...r, created_at: r.created_at.toISOString() };
}

/** `isFavorite` defaults to whether the signed-in user's favorite came back with it. */
export function formatProduct(p: ProductRow, isFavorite = Boolean(p.favorite?.length)) {
    return {
        ...p,
        color: p.color.toString(),
        category: p.category ? formatCategory(p.category) : undefined,
        is_favorite: isFavorite,
        review: p.review?.map(formatReview),
    };
}

export function formatTransaction(t: transaction) {
    return { ...t, created_at: t.created_at.toISOString() };
}

export function formatOrder(o: OrderRow) {
    return {
        ...o,
        date_placed: o.date_placed.toISOString(),
        date_confirmed: isoOrNull(o.date_confirmed),
        date_shipped: isoOrNull(o.date_shipped),
        date_out_for_delivery: isoOrNull(o.date_out_for_delivery),
        date_delivered: isoOrNull(o.date_delivered),
        order_item: (o.order_item ?? []).map((item) => ({ ...item, product: formatProduct(item.product) })),
        transaction: (o.transaction ?? []).map(formatTransaction),
    };
}

export function formatUser(u: UserRow) {
    return {
        ...u,
        order: (u.order ?? []).map(formatOrder),
        transaction: (u.transaction ?? []).map(formatTransaction),
        favorite: (u.favorite ?? []).map((f) => formatProduct(f.product, true)),
    };
}
