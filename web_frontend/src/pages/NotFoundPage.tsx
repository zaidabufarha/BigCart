import { Button, Container, Stack, Text, ThemeIcon, Title } from "@mantine/core";
import { IconMapPinOff } from "@tabler/icons-react";
import { Link } from "react-router-dom";

/** Catch-all for URLs that match nothing. */
function NotFoundPage() {
  return (
    <Container size="sm" py={100}>
      <Stack align="center" gap="md">
        <ThemeIcon size={120}>
          <IconMapPinOff size={60} stroke={1.5} />
        </ThemeIcon>
        <Title order={2}>Page not found</Title>
        <Text ta="center">There's nothing at this address. The shop is still where you left it.</Text>
        <Button component={Link} to="/" w={240} mt="md">
          Back to home
        </Button>
      </Stack>
    </Container>
  );
}

export default NotFoundPage;
