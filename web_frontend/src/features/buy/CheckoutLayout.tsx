import { Box, Center, Container, Flex, Loader, Stack, Stepper } from "@mantine/core";
import { IconCreditCard, IconMapPin, IconTruck } from "@tabler/icons-react";
import { useEffect } from "react";
import { Navigate, Outlet, useLocation } from "react-router-dom";
import { useIsLoggedIn } from "../../app/hooks";
import { useCreateOrderMutation, useGetCartQuery } from "./buyApi";
import CartSummary from "./components/CartSummary";
import { useCheckoutParams, type CheckoutStep } from "./checkoutParams";
import { findShipping } from "./shipping";

const STEPS: { step: CheckoutStep; label: string; icon: typeof IconTruck }[] = [
  { step: "delivery", label: "Delivery", icon: IconTruck },
  { step: "address", label: "Address", icon: IconMapPin },
  { step: "payment", label: "Payment", icon: IconCreditCard },
];

/**
 * Layout route for /checkout/*: the Delivery › Address › Payment indicator,
 * the current step through <Outlet />, and the order summary alongside, with
 * the shipping line following the chosen method. Nothing to check out with an
 * empty cart, so that bounces back to /cart.
 */
function CheckoutLayout() {
  const { pathname } = useLocation();
  const isLoggedIn = useIsLoggedIn();
  const { data: cart = [], isLoading } = useGetCartQuery(undefined, { skip: !isLoggedIn });
  // PaymentStep fires the mutation with the same fixedCacheKey, so this
  // layout sees its result. Cleared on unmount so a later visit starts fresh.
  const [, { isSuccess: orderPlaced, reset }] = useCreateOrderMutation({
    fixedCacheKey: "place-order",
  });
  useEffect(() => reset, [reset]);
  const { shipping, goTo } = useCheckoutParams();

  if (!isLoggedIn) return <Navigate to="/login" replace />;

  if (isLoading) {
    return (
      <Center h={400}>
        <Loader color="green" />
      </Center>
    );
  }

  // Placing an order empties the cart on the server and the refetch reflects
  // it here while PaymentStep is still navigating to the success page — so an
  // empty cart only bounces to /cart when no order was just placed.
  if (cart.length === 0 && !orderPlaced) return <Navigate to="/cart" replace />;

  const current = pathname.split("/")[2] as CheckoutStep | undefined;
  const active = Math.max(0, STEPS.findIndex((s) => s.step === current));

  return (
    <Container py={40}>
      <Stack gap={40}>
        <Stepper
          active={active}
          color="green"
          // completed steps are clickable to go back; you can't skip ahead
          onStepClick={(i) => i < active && goTo(STEPS[i].step)}
          allowNextStepsSelect={false}
          maw={640}
          mx="auto"
          w="100%"
        >
          {STEPS.map(({ step, label, icon: Icon }) => (
            <Stepper.Step
              key={step}
              // icons only on phones, where three labels don't fit on one
              // line; each step's page has its own title anyway
              label={
                <Box component="span" visibleFrom="sm">
                  {label}
                </Box>
              }
              aria-label={label}
              icon={<Icon size={18} />}
            />
          ))}
        </Stepper>

        {/* summary beside the step on desktop, under it on smaller screens */}
        <Flex direction={{ base: "column", md: "row" }} align="flex-start" gap={40}>
          <Box w="100%" style={{ flex: 1, minWidth: 0 }}>
            <Outlet />
          </Box>
          <Stack w={{ base: "100%", md: 420 }} style={{ flexShrink: 0 }}>
            <CartSummary items={cart} shipping={findShipping(shipping)} />
          </Stack>
        </Flex>
      </Stack>
    </Container>
  );
}

export default CheckoutLayout;
