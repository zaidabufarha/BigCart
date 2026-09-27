import {
  Anchor,
  Title,
  Text,
  Divider,
  Stack,
  TextInput,
  PasswordInput,
  Group,
  Switch,
  Button,
} from "@mantine/core";
import { useForm, isEmail, isNotEmpty } from "@mantine/form";
import { useFieldProps } from "../../../hooks/useFieldProps";
import google from "../../../assets/google_logo.svg";
import { IconLock, IconMail } from "@tabler/icons-react";
import { useLogInMutation } from "../authApi";
import { Link, useNavigate } from "react-router-dom";
import AuthShell from "../components/AuthShell";
import LegalNote from "../components/LegalNote";

function LoginPage() {
  const form = useForm({
    mode: "controlled",
    initialValues: { email: "", password: "", remember: true },
    validateInputOnChange: true,
    clearInputErrorOnChange: false,
    validate: {
      email: isEmail("Enter a valid email"),
      password: isNotEmpty("Cannot be empty"),
    },
  });
  const { field, revealAll } = useFieldProps(form);

  const [logIn, { isLoading, error }] = useLogInMutation();
  const navigate = useNavigate();

  const handleSubmit = async (values: typeof form.values) => {
    try {
      await logIn({
        email: values.email,
        password: values.password,
        remember: values.remember,
      }).unwrap();
      navigate("/");
    } catch {
      // shown below the form via `error`
    }
  };

  return (
    <AuthShell>
          <form onSubmit={form.onSubmit(handleSubmit, revealAll)}>
            <Stack gap={30} p={{ base: "sm", sm: 60, lg: 100 }} align="center">
              <Stack>
                <Title ta={"center"}>Welcome Back!</Title>
                <Text ta={"center"}>Sign In to your account</Text>
              </Stack>
              <TextInput
                size="xl"
                w="100%" maw={500}
                label={"Email"}
                placeholder="Enter your email"
                leftSection={<IconMail />}
                {...field("email")}
              />
              <PasswordInput
                size="xl"
                w="100%" maw={500}
                label={"Password"}
                placeholder="Enter your password"
                leftSection={<IconLock />}
                {...field("password")}
              />
              {/* one line at every width; the link matches the label's size
                  and a phone gets one step smaller for both */}
              <Group justify="space-between" wrap="nowrap" w="100%" maw={500}>
                <Group gap="xs" wrap="nowrap">
                  <Switch
                    {...form.getInputProps("remember", { type: "checkbox" })}
                  />
                  <Text fz={{ base: "sm", sm: "md" }}>Remember me</Text>
                </Group>
                <Anchor component={Link} to="/forgot-password" fz={{ base: "sm", sm: "md" }}>
                  Forgot password?
                </Anchor>
              </Group>
              {error && (
                <Text c="red" w="100%" maw={500} ta="center">
                  {error.message}
                </Text>
              )}
              <Button type="submit" w="100%" maw={500} fz={20} loading={isLoading}>
                Sign In
              </Button>
              <Divider w="100%" maw={500} label="or" labelPosition="center" />
              <Button
                type="button"
                onClick={() => alert("Still no google integration")}
                variant="default"
                w="100%" maw={500}
                fz={20}
                leftSection={<img src={google} />}
              >
                Continue with Google
              </Button>
              <Anchor component={Link} to="/signup">
                {"Don't have an account? "}
                <Text span fw={600} c={"black"}>
                  Sign up
                </Text>
              </Anchor>
              <LegalNote action="signing in" />
            </Stack>
          </form>
    </AuthShell>
  );
}

export default LoginPage;
