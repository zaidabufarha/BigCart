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
            <Stack gap={30} p={100} align="center">
              <Stack>
                <Title ta={"center"}>Welcome Back!</Title>
                <Text ta={"center"}>Sign In to your account</Text>
              </Stack>
              <TextInput
                size="xl"
                w={500}
                label={"Email"}
                placeholder="Enter your email"
                leftSection={<IconMail />}
                {...field("email")}
              />
              <PasswordInput
                size="xl"
                w={500}
                label={"Password"}
                placeholder="Enter your password"
                leftSection={<IconLock />}
                {...field("password")}
              />
              <Group justify="space-between" w={500}>
                <Group>
                  <Switch
                    {...form.getInputProps("remember", { type: "checkbox" })}
                  />
                  <Text>Remember me</Text>
                </Group>
                <Anchor component={Link} to="/forgot-password" c="black">
                  Forgot password?
                </Anchor>
              </Group>
              {error && (
                <Text c="red" w={500} ta="center">
                  {error.message}
                </Text>
              )}
              <Button
                type="submit"
                variant="gradient"
                w={500}
                loading={isLoading}
              >
                Sign In
              </Button>
              <Divider w={500} label="or" labelPosition="center" />
              <Button
                type="button"
                onClick={() => alert("Still no google integration")}
                variant="default"
                w={500}
                leftSection={<img src={google} />}
              >
                Continue with Google
              </Button>
              <Anchor component={Link} to="/signup" c={"black"}>
                {"Don't have an account? "}
                <Text span fw={600} c={"black"}>
                  Sign up
                </Text>
              </Anchor>
              <Text w={500} ta={"center"} c={"black"}>
                {"By signing in, you agree to our "}
                <Text span fw={600} c={"black"}>
                  Terms and Conditions.
                </Text>
                {" Learn how we use your data in our "}{" "}
                <Text span fw={600} c={"black"}>
                  Privacy Policy.
                </Text>
              </Text>
            </Stack>
          </form>
    </AuthShell>
  );
}

export default LoginPage;
