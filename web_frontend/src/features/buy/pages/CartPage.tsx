import {
  Button,
  Center,
  Container,
  Divider,
  Flex,
  Loader,
  Paper,
  Stack,
  Text,
  ThemeIcon,
  Title,
  useMantineTheme,
} from "@mantine/core";
import { IconShoppingBag } from "@tabler/icons-react";
import { Fragment } from "react";
import { Link, Navigate } from "react-router-dom";
import { useIsLoggedIn } from "../../../app/hooks";
import { useGetCartQuery } from "../buyApi";
import CartRow from "../components/CartRow";
import CartSummary from "../components/CartSummary";
import { useCart } from "../useCart";

function CartPage() {
  const theme = useMantineTheme();
  const isLoggedIn = useIsLoggedIn();
  const { data: cart = [], isLoading, error } = useGetCartQuery(undefined, { skip: !isLoggedIn });
  const { changeQuantity } = useCart();

  if (!isLoggedIn) return <Navigate to="/login" replace />;

  if (isLoading) {
    return (
      <Center h={400}>
        <Loader color="green" />
      </Center>
    );
  }

  if (error) {
    return (
      <Container py={60}>
        <Text c="red">{error.message}</Text>
      </Container>
    );
  }

  if (cart.length === 0) {
    return (
      <Container size="sm" py={100}>
        <Stack align="center" gap="md">
          <ThemeIcon size={140}>
            <IconShoppingBag size={72} stroke={1.5} />
          </ThemeIcon>
          <Title order={2}>Your cart is empty!</Title>
          <Text ta="center">Looks like you haven't added anything yet.</Text>
          <Button component={Link} to="/" w={260} mt="md">
            Start shopping
          </Button>
        </Stack>
      </Container>
    );
  }

  const count = cart.reduce((n, i) => n + i.quantity, 0);

  return (
    <Container py={40}>
      {/* summary beside the list on desktop, under it on smaller screens */}
      <Flex direction={{ base: "column", md: "row" }} align="flex-start" gap={40}>
        <Stack gap="md" w="100%" style={{ flex: 1, minWidth: 0 }}>
          <Title order={2}>
            Shopping Cart{" "}
            <Text span fz="lg" fw={400}>
              ({count} {count === 1 ? "item" : "items"})
            </Text>
          </Title>
          <Paper withBorder radius="lg" p="lg" bg="white" style={{ borderColor: theme.other.border }}>
            <Stack gap="md">
              {cart.map((item, i) => (
                <Fragment key={item.id}>
                  {i > 0 && <Divider color={theme.other.border} />}
                  <CartRow
                    item={item}
                    onChangeQuantity={(next) => changeQuantity(item.product, next)}
                  />
                </Fragment>
              ))}
            </Stack>
          </Paper>
        </Stack>

        <Stack w={{ base: "100%", md: 420 }} style={{ flexShrink: 0 }}>
          <CartSummary
            items={cart}
            action={
              <Button component={Link} to="/checkout/delivery" fullWidth mt="xs">
                Checkout
              </Button>
            }
          />
        </Stack>
      </Flex>
    </Container>
  );
}

export default CartPage;
