import { describe, it, expect } from 'vitest';
import { dueChanges } from '../src/graphql/order-progress';

const MINUTE = 60 * 1000;
const DAY = 24 * 60 * MINUTE;
const placed = new Date('2026-09-30T09:15:00Z');
const at = (ms: number) => new Date(placed.getTime() + ms);

function order(shipping_method: string, filled: Partial<Record<string, Date | null>> = {}, status = 'placed') {
  return {
    id: 1,
    date_placed: placed,
    shipping_method,
    status,
    date_confirmed: null,
    date_shipped: null,
    date_out_for_delivery: null,
    date_delivered: null,
    ...filled,
  };
}

describe('order progress', () => {
  it('fills in every stage that came due at once, each one step apart', () => {
    // a 1-Hour order read 40 minutes in: confirmed at +15, shipped at +30
    expect(dueChanges(order('1-Hour Delivery'), at(40 * MINUTE))).toEqual({
      date_confirmed: at(15 * MINUTE),
      date_shipped: at(30 * MINUTE),
      status: 'shipped',
    });
  });

  it('dates an old order from when it was placed, not from when it is read', () => {
    expect(dueChanges(order('Standard Delivery'), at(10 * DAY))).toEqual({
      date_confirmed: at(1 * DAY),
      date_shipped: at(2 * DAY),
      date_out_for_delivery: at(3 * DAY),
      date_delivered: at(4 * DAY),
      status: 'delivered',
    });
  });

  it('only adds the stages that are missing', () => {
    const halfway = order('Next Day Delivery', { date_confirmed: at(6 * 60 * MINUTE) }, 'confirmed');
    expect(dueChanges(halfway, at(13 * 60 * MINUTE))).toEqual({
      date_shipped: at(12 * 60 * MINUTE),
      status: 'shipped',
    });
  });

  it('changes nothing before the first step or after delivery', () => {
    expect(dueChanges(order('Standard Delivery'), at(DAY - MINUTE))).toBeNull();
    const delivered = order(
      '1-Hour Delivery',
      {
        date_confirmed: at(15 * MINUTE),
        date_shipped: at(30 * MINUTE),
        date_out_for_delivery: at(45 * MINUTE),
        date_delivered: at(60 * MINUTE),
      },
      'delivered',
    );
    expect(dueChanges(delivered, at(30 * DAY))).toBeNull();
  });

  it('moves orders with a retired method name at Standard pace', () => {
    expect(dueChanges(order('Nominated Delivery'), at(DAY))).toEqual({
      date_confirmed: at(DAY),
      status: 'confirmed',
    });
  });
});
