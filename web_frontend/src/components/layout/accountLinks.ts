import {
  IconBell,
  IconCreditCard,
  IconMapPin,
  IconPackage,
  IconReceipt,
  IconUser,
} from "@tabler/icons-react";

// The account menu mirrors the Flutter Account page, minus Favorites, which
// the heart icon in the bar already covers. Shared by the desktop avatar
// dropdown and the phone drawer. An entry without `to` renders disabled with
// a "Soon" tag rather than linking nowhere.
export const ACCOUNT_LINKS: { label: string; icon: typeof IconUser; to?: string }[] = [
  { label: "About me", icon: IconUser, to: "/account/profile" },
  { label: "My Orders", icon: IconPackage, to: "/account/orders" },
  { label: "My Address", icon: IconMapPin, to: "/account/addresses" },
  { label: "Credit Cards", icon: IconCreditCard, to: "/account/cards" },
  { label: "Transactions", icon: IconReceipt, to: "/account/transactions" },
  { label: "Notifications", icon: IconBell, to: "/account/notifications" },
];
