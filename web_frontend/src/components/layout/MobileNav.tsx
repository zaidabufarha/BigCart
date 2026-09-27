import {
  ActionIcon,
  Avatar,
  Box,
  Burger,
  Button,
  Divider,
  Drawer,
  Group,
  Indicator,
  NavLink,
  Stack,
  Text,
  UnstyledButton,
} from "@mantine/core";
import { useDisclosure } from "@mantine/hooks";
import { IconCategory, IconHeart, IconLogout, IconShoppingCart, IconUser } from "@tabler/icons-react";
import { useEffect, type ReactNode } from "react";
import { Link, useLocation } from "react-router-dom";
import logo from "../../assets/logo.png";
import { slugify } from "../../features/buy/slug";
import { ACCOUNT_LINKS } from "./accountLinks";

type MobileNavProps = {
  cartCount: number;
  isLoggedIn: boolean;
  user?: { name?: string | null; email?: string | null; image_path?: string | null } | null;
  categories: { id: string; name: string }[];
  onLogOut: () => void;
  /** The search form, owned by NavBar so both layouts share its state. */
  search: ReactNode;
};

/**
 * The phone header (below the `sm` breakpoint): menu, logo and cart on one
 * row, search on its own full-width row underneath — for a grocery store
 * search is the main way in, so it isn't hidden behind the menu. Everything
 * else (categories, favorites, the account pages, sign out) lives in the
 * drawer, with the account header at the top like the desktop dropdown.
 */
function MobileNav({ cartCount, isLoggedIn, user, categories, onLogOut, search }: MobileNavProps) {
  const [opened, { open, close }] = useDisclosure(false);
  const location = useLocation();

  // any navigation closes the drawer, so a tap on a link doesn't leave it open
  useEffect(() => {
    close();
  }, [location.key, close]);

  return (
    <Box hiddenFrom="sm" px="md" py="sm">
      <Group justify="space-between" wrap="nowrap">
        <Burger opened={opened} onClick={open} aria-label="Menu" size="sm" />
        <Link to="/" aria-label="BigCart home">
          <img src={logo} alt="BigCart" width={120} />
        </Link>
        <Indicator label={cartCount} size={16} color="green" offset={4} disabled={cartCount === 0}>
          <ActionIcon
            component={Link}
            to="/cart"
            color="black"
            size={36}
            aria-label={`Cart, ${cartCount} ${cartCount === 1 ? "item" : "items"}`}
          >
            <IconShoppingCart size={30} />
          </ActionIcon>
        </Indicator>
      </Group>
      <Box mt="sm">{search}</Box>

      <Drawer
        opened={opened}
        onClose={close}
        size="85%"
        padding="md"
        title={<img src={logo} alt="BigCart" width={110} />}
      >
        <Stack gap={4}>
          {isLoggedIn ? (
            // the header is itself the way into the account section
            <UnstyledButton component={Link} to="/account" py="sm" aria-label="Account">
              <Group gap="sm" wrap="nowrap">
                <Avatar src={user?.image_path} size={44} radius="xl" color="green">
                  <IconUser />
                </Avatar>
                <Stack gap={0} style={{ minWidth: 0 }}>
                  <Text fw={600} c="black" lineClamp={1}>
                    {user?.name ?? "…"}
                  </Text>
                  <Text size="xs" lineClamp={1}>
                    {user?.email ?? ""}
                  </Text>
                </Stack>
              </Group>
            </UnstyledButton>
          ) : (
            <Button component={Link} to="/login" fullWidth h={44} my="sm">
              Sign In
            </Button>
          )}
          <Divider my="xs" />

          <NavLink label="Categories" leftSection={<IconCategory size={18} />} childrenOffset={28}>
            {categories.map((c) => (
              <NavLink key={c.id} component={Link} to={`/?category=${slugify(c.name)}`} label={c.name} />
            ))}
          </NavLink>
          <NavLink component={Link} to="/favorites" label="Favorites" leftSection={<IconHeart size={18} />} />

          {isLoggedIn && (
            <>
              <Divider my="xs" />
              {ACCOUNT_LINKS.map(({ label, icon: Icon, to }) =>
                to ? (
                  <NavLink key={label} component={Link} to={to} label={label} leftSection={<Icon size={18} />} />
                ) : null,
              )}
              <Divider my="xs" />
              <NavLink label="Sign out" leftSection={<IconLogout size={18} />} onClick={onLogOut} />
            </>
          )}
        </Stack>
      </Drawer>
    </Box>
  );
}

export default MobileNav;
