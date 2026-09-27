import {
  ActionIcon,
  Anchor,
  Box,
  Divider,
  Flex,
  Group,
  Image,
  Stack,
  Text,
  TextInput,
  Title,
  useMantineTheme,
} from "@mantine/core";
import type { ReactNode } from "react";
import logo from "../../assets/logo.png";
import visa from "../../assets/visa.png";
import mastercard from "../../assets/mastercard.png";
import paypal from "../../assets/paypal.png";

import SocialIcon from "./SocialIcon";
import TopBarItem from "./TopBarItem";
import {
  IconAlarm,
  IconMapPin,
  IconPhone,
  IconBrandFacebook,
  IconBrandInstagram,
  IconBrandLinkedin,
  IconBrandTiktok,
  IconBrandX,
  IconSend2,
} from "@tabler/icons-react";
import { Link } from "react-router-dom";
import { useForm, isEmail } from "@mantine/form";
import { useFieldProps } from "../../hooks/useFieldProps";

// A link column. Full width and tighter on phones, where the columns stack;
// half width on tablets (two per row); their natural width on desktop.
// Flex rather than Stack because only Flex takes a responsive gap.
const COLUMN = {
  direction: "column",
  align: "center",
  ta: "center",
  gap: { base: "sm", sm: 30 },
  w: { base: "100%", sm: "45%", md: "auto" },
} as const;

/** Footer grey text, always underlined so it reads as a link. */
function FooterLink({ to, children }: { to: string; children: ReactNode }) {
  const theme = useMantineTheme();
  return (
    <Anchor
      component={Link}
      to={to}
      c={theme.other.textSecondary}
      fz="md"
      fw={400}
      underline="always"
    >
      {children}
    </Anchor>
  );
}

function Footer() {
  // same setup as the login form: errors appear after the first blur (or a
  // submit attempt), then update live until the address is valid
  const form = useForm({
    mode: "controlled",
    initialValues: { email: "" },
    validateInputOnChange: true,
    clearInputErrorOnChange: false,
    validate: { email: isEmail("Enter a valid email") },
  });
  const { field, revealAll } = useFieldProps(form);
  const theme = useMantineTheme();

  const handleSubmit = ({ email }: { email: string }) => {
    // Placeholder for the real call (GraphQL mutation -> Resend, rate-limited
    // server-side). Clearing the field afterwards means a second send needs
    // the address typed again — a mild speed bump, not a rate limit.
    alert(`Subscribed ${email} to the newsletter (placeholder — no email is sent yet).`);
    form.reset();
  };

  return (
    <Box py={{ base: 40, md: 90 }} px={{ base: 16, sm: 40, lg: 90 }}>
      {/* columns wrap onto more lines as the window narrows */}
      <Group justify="space-between" align="flex-start" gap="xl">
        {/* hidden on phones: the header already shows the logo, and the
            footer is long enough there */}
        <Stack w={300} visibleFrom="sm">
          <Image src={logo} w={200} alt="BigCart" />
          <Text>
            Fresh groceries, fast delivery, unbeatable prices, BigCart has it
            all
          </Text>
        </Stack>
        {/* note do something about the colors this is ridiculous */}
        {/* every entry is a real page: shop views are URL filters on the home
            page, the rest mirror the account sidebar's groups */}
        <Flex {...COLUMN}>
          <Title order={3}>Shop</Title>
          <FooterLink to="/?filter=deals">Deals</FooterLink>
          <FooterLink to="/?filter=new">New Products</FooterLink>
          <FooterLink to="/?max=3">Under $3</FooterLink>
          <FooterLink to="/?search=organic">Organic</FooterLink>
        </Flex>
        <Flex {...COLUMN}>
          <Title order={3}>Account</Title>
          <FooterLink to="/account/profile">Profile</FooterLink>
          <FooterLink to="/favorites">Favorites</FooterLink>
          <FooterLink to="/account/addresses">Addresses</FooterLink>
          <FooterLink to="/account/notifications">Notifications</FooterLink>
        </Flex>
        <Flex {...COLUMN}>
          <Title order={3}>Orders & Payment</Title>
          <FooterLink to="/cart">Cart</FooterLink>
          <FooterLink to="/account/orders">My Orders</FooterLink>
          <FooterLink to="/account/cards">Credit Cards</FooterLink>
          <FooterLink to="/account/transactions">Transactions</FooterLink>
        </Flex>
        <Stack ta={"left"} w={{ base: "100%", md: 400 }}>
          <Title order={1}>Join the BigCart newsletter</Title>
          <form onSubmit={form.onSubmit(handleSubmit, revealAll)}>
            <TextInput
              w="100%"
              styles={{
                input: {
                  backgroundColor: "#F0F0F0",
                  height: 100,
                  border: "none",
                },
              }}
              size="xl"
              placeholder="Your email address"
              {...field("email")}
              // sections are pointer-events:none by default; the send button
              // needs clicks
              rightSectionPointerEvents="all"
              rightSection={
                <ActionIcon
                  type="submit"
                  bg={"green"}
                  size={40}
                  mr={20}
                  aria-label="Subscribe"
                >
                  <IconSend2 color="white" />
                </ActionIcon>
              }
            />
          </form>
        </Stack>
      </Group>
      <Divider my={30} />
      <Group justify="space-between" align="center" gap="lg">
        <Group gap={40}>
          <img src={visa} width={100} />
          <img src={mastercard} width={80} />
          <img src={paypal} height={40} />
        </Group>
        {/* the store details from the top bar, which isn't shown on phones
            and tablets — so they're always reachable somewhere */}
        <Group gap="lg" style={{ rowGap: 6 }}>
          <TopBarItem icon={IconMapPin} iconSize={18} fz={14} color={theme.other.textSecondary}>
            Los Angeles, USA
          </TopBarItem>
          <TopBarItem icon={IconAlarm} iconSize={18} fz={14} color={theme.other.textSecondary}>
            Everyday from 10.00 AM to 09.00 PM
          </TopBarItem>
          <TopBarItem icon={IconPhone} iconSize={18} fz={14} color={theme.other.textSecondary}>
            (603) 555-0123
          </TopBarItem>
        </Group>
        <Group gap={12}>
          <SocialIcon label="Facebook" icon={IconBrandFacebook} />
          <SocialIcon label="Instagram" icon={IconBrandInstagram} />
          <SocialIcon label="TikTok" icon={IconBrandTiktok} />
          <SocialIcon label="X" icon={IconBrandX} />
          <SocialIcon label="LinkedIn" icon={IconBrandLinkedin} />
        </Group>
      </Group>
    </Box>
  );
}

export default Footer;
