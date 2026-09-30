import prisma from '../prisma';
import { stepFor } from './shipping';

// Fulfilment is simulated. An order moves through four stages after it's
// placed, one shipping step apart (a day for Standard, 6 hours for Next Day,
// 15 minutes for 1-Hour). There is no background job: every resolver that
// returns orders passes them through catchUpOrders first, which fills in and
// saves every stage whose time has come. Stage times are counted from
// date_placed, never from "now", so they come out the same whenever the
// order happens to be read.
const STAGES = [
    { field: 'date_confirmed', status: 'confirmed' },
    { field: 'date_shipped', status: 'shipped' },
    { field: 'date_out_for_delivery', status: 'out_for_delivery' },
    { field: 'date_delivered', status: 'delivered' },
] as const;

type StageField = (typeof STAGES)[number]['field'];

type ProgressFields = {
    id: number;
    date_placed: Date;
    shipping_method: string;
    status: string;
} & Record<StageField, Date | null>;

/** The fields to save so the order is up to date at `now`, or null if it already is. */
export function dueChanges(order: ProgressFields, now: Date): Partial<ProgressFields> | null {
    const step = stepFor(order.shipping_method);
    const changes: Partial<ProgressFields> = {};
    let status = 'placed';

    STAGES.forEach((stage, i) => {
        const due = new Date(order.date_placed.getTime() + (i + 1) * step);
        if (due > now) return;
        status = stage.status;
        if (order[stage.field] === null) changes[stage.field] = due;
    });
    if (status !== order.status) changes.status = status;

    return Object.keys(changes).length > 0 ? changes : null;
}

/** Brings the orders up to date, saving any stages that came due, and returns them updated. */
export async function catchUpOrders<T extends ProgressFields>(orders: T[]): Promise<T[]> {
    const now = new Date();
    const updates = orders.map((order) => ({ order, changes: dueChanges(order, now) }));
    const pending = updates.filter((u) => u.changes !== null);

    if (pending.length > 0) {
        await prisma.$transaction(
            pending.map(({ order, changes }) =>
                prisma.order.update({ where: { id: order.id }, data: changes! }),
            ),
        );
    }
    return updates.map(({ order, changes }) => (changes ? { ...order, ...changes } : order));
}
