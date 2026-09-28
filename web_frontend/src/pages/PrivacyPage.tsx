import { Anchor, Container, List, Paper, Stack, Text, Title, useMantineTheme } from "@mantine/core";
import type { ReactNode } from "react";

const CONTACT = "zaidkabufarha@gmail.com";

function Section({ title, children }: { title: string; children: ReactNode }) {
  return (
    <Stack gap="xs">
      <Title order={3}>{title}</Title>
      {children}
    </Stack>
  );
}

/**
 * The privacy policy Google's consent screen links to. Plain and specific:
 * it lists what BigCart actually stores, which is the point of the page.
 */
function PrivacyPage() {
  const theme = useMantineTheme();

  return (
    <Container size="md" py={{ base: 40, sm: 60 }}>
      <Paper radius="lg" p={{ base: "md", sm: "xl" }} bg="white" style={{ border: `1px solid ${theme.other.border}` }}>
        <Stack gap="xl">
          <Stack gap={4}>
            <Title order={1}>Privacy Policy</Title>
            <Text size="sm">Last updated September 28, 2026</Text>
          </Stack>

          <Text>
            BigCart is a portfolio project: a demo grocery store. No real orders are fulfilled and no payments
            are taken. Please don't enter a real card number.
          </Text>

          <Section title="What we store">
            {/* List doesn't take the theme's Text colour, so match it here */}
            <List spacing="xs" c={theme.other.textSecondary}>
              <List.Item>Your account: email address, name, phone number and profile picture.</List.Item>
              <List.Item>
                Saved addresses, and saved cards as the cardholder name, last four digits and expiry date. The
                full card number is discarded and never stored.
              </List.Item>
              <List.Item>Your cart, favorites, orders, reviews and notification preferences.</List.Item>
            </List>
          </Section>

          <Section title="Signing in with Google">
            <Text>
              If you sign in with Google, we receive your name, email address, profile picture and Google
              account ID. We use them only to create or find your BigCart account. We don't access anything
              else in your Google account.
            </Text>
          </Section>

          <Section title="How it's used">
            <Text>
              Your data is used only to run your account and the store: showing your cart and orders, filling
              in checkout, and sending the password-reset email you ask for. It isn't sold or shared, and the
              site has no ads, analytics or tracking.
            </Text>
          </Section>

          <Section title="Where it's kept">
            <Text>
              The database is hosted by Aiven, the API by Render and the website by Vercel. Profile pictures
              are stored on Cloudinary, and password-reset emails are sent through Resend. Your browser keeps
              your sign-in token so you stay logged in.
            </Text>
          </Section>

          <Section title="Deleting your data">
            <Text>
              To have your account and everything attached to it deleted, email{" "}
              <Anchor href={`mailto:${CONTACT}`} inherit c="green">
                {CONTACT}
              </Anchor>{" "}
              from the address on the account.
            </Text>
          </Section>
        </Stack>
      </Paper>
    </Container>
  );
}

export default PrivacyPage;
