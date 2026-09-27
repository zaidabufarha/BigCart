import { Button, Container, Flex, Stack, Text, ThemeIcon, Title } from "@mantine/core";
import { IconCircleCheck } from "@tabler/icons-react";
import { Link, Navigate, useParams } from "react-router-dom";
import { useIsLoggedIn } from "../../../../app/hooks";

function OrderSuccessPage() {
  // only needed for the Track order link; the details live on that page
  const { orderId = "" } = useParams();
  const isLoggedIn = useIsLoggedIn();

  if (!isLoggedIn) return <Navigate to="/login" replace />;

  return (
    <Container size="sm" py={{ base: 60, sm: 100 }}>
      <Stack align="center" gap="md">
        <ThemeIcon size={140}>
          <IconCircleCheck size={72} stroke={1.5} />
        </ThemeIcon>
        <Title order={2}>Order placed!</Title>
        <Text ta="center">Thanks for shopping with BigCart. Your order is on its way.</Text>
        {/* phones: stacked, full width, primary on top; wider: side by side */}
        <Flex
          mt="md"
          w="100%"
          direction={{ base: "column", sm: "row" }}
          justify="center"
          gap="md"
        >
          <Button component={Link} to={`/account/orders/${orderId}`} w={{ base: "100%", sm: 200 }}>
            Track order
          </Button>
          <Button component={Link} to="/" variant="light" w={{ base: "100%", sm: 200 }}>
            Continue shopping
          </Button>
        </Flex>
      </Stack>
    </Container>
  );
}

export default OrderSuccessPage;
