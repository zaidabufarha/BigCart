import { Anchor, Button, Stack, Text, TextInput, ThemeIcon, Title } from "@mantine/core";
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

  const handleSubmit = async ({ email }: typeof form.values) => {
    try {
      await forgotPassword({ email }).unwrap();
      setSentTo(email);
    } catch {
      // shown below the field via `error`
    }
  };

  return (
    <AuthShell>
      {sentTo ? (
        <Stack gap={30} p={100} align="center">
          <ThemeIcon size={80} radius="xl" color="green" variant="light">
            <IconMailCheck size={44} />
          </ThemeIcon>
          <Stack gap={10}>
            <Title ta="center">Check your inbox</Title>
            <Text ta="center" w={500}>
              We sent a temporary password to{" "}
              <Text span fw={600} c="black">
                {sentTo}
              </Text>
              . Sign in with it, then set a new one under About me.
            </Text>
          </Stack>
          <Button component={Link} to="/login" variant="gradient" w={500}>
            Back to sign in
          </Button>
        </Stack>
      ) : (
        <form onSubmit={form.onSubmit(handleSubmit, revealAll)}>
          <Stack gap={30} p={100} align="center">
            <Stack gap={10}>
              <Title ta="center">Forgot Password</Title>
              <Text ta="center">We'll email you a temporary password.</Text>
            </Stack>
            <TextInput
              size="xl"
              w={500}
              label="Email"
              placeholder="Enter your email"
              leftSection={<IconMail />}
              {...field("email")}
            />
            {error && (
              <Text c="red" w={500} ta="center">
                {error.message}
              </Text>
            )}
            <Button type="submit" variant="gradient" w={500} loading={isLoading}>
              Send
            </Button>
            <Anchor component={Link} to="/login" c="black">
              Back to sign in
            </Anchor>
          </Stack>
        </form>
      )}
    </AuthShell>
  );
}

export default ForgotPasswordPage;
