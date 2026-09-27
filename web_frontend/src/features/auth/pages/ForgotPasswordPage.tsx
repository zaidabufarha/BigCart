import {
  Anchor,
  Button,
  Group,
  Modal,
  Stack,
  Text,
  TextInput,
  ThemeIcon,
  Title,
} from "@mantine/core";
import { isEmail, useForm } from "@mantine/form";
import { IconMail, IconMailCheck } from "@tabler/icons-react";
import { useState } from "react";
import { Link } from "react-router-dom";
import { useFieldProps } from "../../../hooks/useFieldProps";
import { useForgotPasswordMutation } from "../authApi";
import AuthShell from "../components/AuthShell";

/**
 * Email form, then a confirmation. The backend doesn't send a reset link: it
 * replaces the password with a temporary one and emails that, so the copy
 * says so rather than promising a link.
 *
 * Until a sending domain is verified in Resend, that email only reaches the
 * Resend account owner — so anyone else would lose their password. The
 * confirm step says so before anything changes. Remove it once the domain is
 * set up.
 */
function ForgotPasswordPage() {
  const form = useForm({
    mode: "controlled",
    initialValues: { email: "" },
    validateInputOnChange: true,
    clearInputErrorOnChange: false,
    validate: { email: isEmail("Enter a valid email") },
  });
  const { field, revealAll } = useFieldProps(form);

  const [forgotPassword, { isLoading, error }] = useForgotPasswordMutation();
  const [sentTo, setSentTo] = useState<string | null>(null);
  const [confirming, setConfirming] = useState(false);

  // a valid submit only opens the warning; the reset happens on confirm
  const handleSubmit = () => setConfirming(true);

  const handleConfirm = async () => {
    const { email } = form.values;
    try {
      await forgotPassword({ email }).unwrap();
      setSentTo(email);
    } catch {
      // shown below the field via `error`
    } finally {
      setConfirming(false);
    }
  };

  return (
    <AuthShell>
      <Modal
        opened={confirming}
        onClose={() => setConfirming(false)}
        title={<Text fw={600} c="black">Email delivery isn't set up yet</Text>}
        centered
      >
        <Stack gap="lg">
          <Text size="sm">
            The email service is integrated and working, but without a verified domain it
            can only deliver to the site owner's inbox. Sending this replaces your password
            with a temporary one that won't reach you, so you won't be able to sign in to
            this account again.
          </Text>
          <Group justify="flex-end" gap="xs">
            <Button
              variant="subtle"
              color="gray"
              h={40}
              onClick={() => setConfirming(false)}
              disabled={isLoading}
            >
              Cancel
            </Button>
            <Button
              variant="filled"
              color="red"
              h={40}
              loading={isLoading}
              onClick={handleConfirm}
            >
              Reset anyway
            </Button>
          </Group>
        </Stack>
      </Modal>
      {sentTo ? (
        <Stack gap={30} p={{ base: "sm", sm: 60, lg: 100 }} align="center">
          <ThemeIcon size={80}>
            <IconMailCheck size={44} />
          </ThemeIcon>
          <Stack gap={10}>
            <Title ta="center">Check your inbox</Title>
            <Text ta="center" w="100%" maw={500}>
              We sent a temporary password to{" "}
              <Text span fw={600} c="black">
                {sentTo}
              </Text>
              . Sign in with it, then set a new one under About me.
            </Text>
          </Stack>
          <Button component={Link} to="/login" w="100%" maw={500} fz={20}>
            Back to sign in
          </Button>
        </Stack>
      ) : (
        <form onSubmit={form.onSubmit(handleSubmit, revealAll)}>
          <Stack gap={30} p={{ base: "sm", sm: 60, lg: 100 }} align="center">
            <Stack gap={10}>
              <Title ta="center">Forgot Password</Title>
              <Text ta="center">We'll email you a temporary password.</Text>
            </Stack>
            <TextInput
              size="xl"
              w="100%" maw={500}
              label="Email"
              placeholder="Enter your email"
              leftSection={<IconMail />}
              {...field("email")}
            />
            {error && (
              <Text c="red" w="100%" maw={500} ta="center">
                {error.message}
              </Text>
            )}
            <Button type="submit" w="100%" maw={500} fz={20} loading={isLoading}>
              Send
            </Button>
            <Anchor component={Link} to="/login">
              Back to sign in
            </Anchor>
          </Stack>
        </form>
      )}
    </AuthShell>
  );
}

export default ForgotPasswordPage;
