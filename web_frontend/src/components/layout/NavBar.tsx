import {
  ActionIcon,
  Anchor,
  Avatar,
  Badge,
  Box,
  Button,
  Flex,
  Group,
  Indicator,
  Menu,
  Stack,
  Text,
  TextInput,
  UnstyledButton,
  useMantineTheme,
} from "@mantine/core";
import logo from "../../assets/logo.png";
import { Link, useNavigate, useSearchParams } from "react-router-dom";
import {
  IconChevronDown,
  IconHeart,
  IconLogout,
  IconSearch,
  IconShoppingCart,
  IconUser,
} from "@tabler/icons-react";
import { useState } from "react";
import { useIsLoggedIn } from "../../app/hooks";
import { useGetUserDataQuery } from "../../features/account/accountApi";
import { useLogOut } from "../../features/auth/useLogOut";
import { useGetCartQuery, useGetCategoriesQuery } from "../../features/buy/buyApi";
import { slugify } from "../../features/buy/slug";
import { ACCOUNT_LINKS } from "./accountLinks";
import MobileNav from "./MobileNav";

function NavBar() {
  const navigate = useNavigate();
  const [searchParams] = useSearchParams();
  const urlSearch = searchParams.get("search") ?? "";
  const [query, setQuery] = useState(urlSearch);

  // keep the box in step with the URL, so "Clear filters", the back button or
  // a pasted link all show the right text. Done during render (React's
  // "adjust state when a prop changes" pattern) rather than in an effect,
  // which would draw the stale text once first.
  const [seenSearch, setSeenSearch] = useState(urlSearch);
  if (urlSearch !== seenSearch) {
    setSeenSearch(urlSearch);
    setQuery(urlSearch);
  }
  const isLoggedIn = useIsLoggedIn();
  const handleLogOut = useLogOut();

  // same cached query the home page uses, so this costs no extra request
  const { data: categories = [] } = useGetCategoriesQuery();
  // name, email and picture for the account menu; per-user, so skipped logged out
  const { data: user } = useGetUserDataQuery(undefined, { skip: !isLoggedIn });
  // same cached cart the pages use — the badge costs no extra request
  const { data: cart = [] } = useGetCartQuery(undefined, { skip: !isLoggedIn });
  const cartCount = cart.reduce((n, item) => n + item.quantity, 0);
  const theme = useMantineTheme();

  // One search form for both layouts: the desktop bar and the phone header
  // are separate markup (hidden/shown by breakpoint), but the typed text and
  // submit behaviour are shared here.
  const searchForm = (style: React.CSSProperties) => (
    <form
      style={style}
      onSubmit={(e) => {
        e.preventDefault();
        const term = query.trim();
        // a new search starts from a clean slate; an empty one clears it
        navigate(term ? `/?search=${encodeURIComponent(term)}` : "/");
      }}
    >
      <TextInput
        w="100%"
        leftSection={<IconSearch size={20} />}
        placeholder="Search"
        value={query}
        onChange={(e) => {
          setQuery(e.currentTarget.value);
        }}
      />
    </form>
  );

  return (
    // sticky so the cart is always one click away; the green TopBar above
    // scrolls off. Pure CSS — the Outlet below is untouched.
    <Box pos="sticky" top={0} bg="white" style={{ zIndex: 100, borderBottom: `1px solid ${theme.other.border}` }}>
      {/* phone header (below sm) */}
      <MobileNav
        cartCount={cartCount}
        isLoggedIn={isLoggedIn}
        user={user}
        categories={categories}
        onLogOut={handleLogOut}
        search={searchForm({ width: "100%" })}
      />

      {/* tablet and desktop bar: one row at every width — padding and gaps
          shrink, then the search box narrows, then the logo scales down */}
      <Box visibleFrom="sm" h={105} px={{ base: 16, md: 40, lg: 100 }} pt={20}>
        <Flex justify="space-between" align="center" wrap="nowrap" gap={{ base: "md", lg: 50 }}>
          <Box
            component={Link}
            to="/"
            aria-label="BigCart home"
            w={200}
            miw={90}
            style={{ flexShrink: 1, display: "block" }}
          >
            <img src={logo} alt="BigCart" style={{ width: "100%", display: "block" }} />
          </Box>
          <Flex align="center" wrap="nowrap" gap={{ base: "md", lg: 50 }}>
            <Menu trigger="hover">
              <Menu.Target>
                <Anchor component="button" style={{ flexShrink: 0 }}>
                  <Group gap={10} wrap="nowrap">
                    Category <IconChevronDown size={25} />
                  </Group>
                </Anchor>
              </Menu.Target>
              <Menu.Dropdown>
                {categories.map((c) => (
                  <Menu.Item key={c.id} component={Link} to={`/?category=${slugify(c.name)}`}>
                    {c.name}
                  </Menu.Item>
                ))}
              </Menu.Dropdown>
            </Menu>
            {/* 300px when there's room, first thing to give way when there isn't */}
            {searchForm({ width: 300, minWidth: 100, flexShrink: 1 })}
          </Flex>
          <Flex align="center" wrap="nowrap" gap={{ base: "md", lg: 30 }} style={{ flexShrink: 0 }}>
            <Indicator label={cartCount} size={18} color="green" offset={4} disabled={cartCount === 0}>
              <ActionIcon
                component={Link}
                to="/cart"
                color="black"
                size={40}
                aria-label={`Cart, ${cartCount} ${cartCount === 1 ? "item" : "items"}`}
              >
                <IconShoppingCart size={40} />
              </ActionIcon>
            </Indicator>
            <ActionIcon component={Link} to="/favorites" color="black" size={40} aria-label="Favorites">
              <IconHeart size={40} />
            </ActionIcon>
            {isLoggedIn ? (
              <Menu position="bottom-end" width={260}>
                <Menu.Target>
                  <UnstyledButton aria-label="Account menu">
                    {/* real profile picture; the icon only shows if it fails to load */}
                    <Avatar src={user?.image_path} size={40} radius="xl" color="green">
                      <IconUser />
                    </Avatar>
                  </UnstyledButton>
                </Menu.Target>
                <Menu.Dropdown>
                  {/* the header opens the profile, same as the phone drawer */}
                  <Menu.Item component={Link} to="/account/profile" p="sm">
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
                  </Menu.Item>
                  <Menu.Divider />
                  {ACCOUNT_LINKS.map(({ label, icon: Icon, to }) =>
                    to ? (
                      <Menu.Item key={label} component={Link} to={to} leftSection={<Icon size={18} />}>
                        {label}
                      </Menu.Item>
                    ) : (
                      <Menu.Item
                        key={label}
                        disabled
                        leftSection={<Icon size={18} />}
                        rightSection={
                          <Badge size="xs" color="gray">
                            Soon
                          </Badge>
                        }
                      >
                        {label}
                      </Menu.Item>
                    ),
                  )}
                  <Menu.Divider />
                  <Menu.Item leftSection={<IconLogout size={18} />} onClick={handleLogOut}>
                    Sign out
                  </Menu.Item>
                </Menu.Dropdown>
              </Menu>
            ) : (
              // same gradient and radius as every other primary button, just shorter
              <Button component={Link} to="/login" h={40} px="lg">
                Sign In
              </Button>
            )}
          </Flex>
        </Flex>
      </Box>
    </Box>
  );
}

export default NavBar;
