import { Anchor, Text } from "@mantine/core";
import { Link } from "react-router-dom";

/**
 * The "By signing in, you agree to…" line under the auth forms. The privacy
 * policy is a real page; there are no terms yet, so that link says so with a
 * placeholder alert, the same approach as the newsletter.
 */
function LegalNote({ action }: { action: "signing in" | "signing up" }) {
  return (
    <Text w="100%" maw={500} ta={"center"} c={"black"}>
      {`By ${action}, you agree to our `}
      <Anchor
        component="button"
        type="button"
        inherit
        fw={600}
        onClick={() =>
          alert("Terms and Conditions (placeholder — BigCart is a demo store, so there aren't any yet).")
        }
      >
        Terms and Conditions.
      </Anchor>
      {" Learn how we use your data in our "}
      <Anchor component={Link} to="/privacy" inherit fw={600}>
        Privacy Policy.
      </Anchor>
    </Text>
  );
}

export default LegalNote;
