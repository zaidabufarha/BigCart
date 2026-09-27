import { Anchor, Center, Group, Loader, Paper, Stack, Text, Title, useMantineTheme } from "@mantine/core";
import { IconArrowLeft } from "@tabler/icons-react";
import type { ReactNode } from "react";
import { Link } from "react-router-dom";

type AccountShellProps = {
  title: string;
  description?: string;
  /** Top-right slot, e.g. an "add" button. */
  action?: ReactNode;
  isLoading?: boolean;
  // what RTK Query hands back: our GraphqlError, or a SerializedError whose
  // message is optional
  error?: { message?: string };
  children: ReactNode;
};

/**
 * The white card on the right of the account layout: heading, optional
 * description and action, and the loading / error states — so each page
 * only renders its data. The login gate and sidebar live in AccountLayout.
 */
function AccountShell({ title, description, action, isLoading, error, children }: AccountShellProps) {
  const theme = useMantineTheme();

  return (
    <Paper radius="lg" p={{ base: "md", sm: "xl" }} bg="white" style={{ border: `1px solid ${theme.other.border}` }}>
      <Stack gap="xl">
        {/* phones have no sidebar: the way back to the section list */}
        <Anchor component={Link} to="/account" hiddenFrom="md" c="green" fz="sm" fw={600}>
          <Group gap={4}>
            <IconArrowLeft size={16} />
            Account
          </Group>
        </Anchor>
        <Group justify="space-between" align="flex-start">
          <Stack gap={4}>
            <Title order={2}>{title}</Title>
            {description && <Text size="sm">{description}</Text>}
          </Stack>
          {action}
        </Group>

        {isLoading ? (
          <Center h={200}>
            <Loader color="green" />
          </Center>
        ) : error ? (
          <Text c="red">{error.message ?? "Something went wrong"}</Text>
        ) : (
          children
        )}
      </Stack>
    </Paper>
  );
}

export default AccountShell;
