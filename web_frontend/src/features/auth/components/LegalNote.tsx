import { Anchor } from "@mantine/core";
import { Link } from "react-router-dom";

/**
 * The "By signing in, you agree to…" line under the auth forms: plain text,
 * and the whole line is one link to the privacy policy, the only legal page.
 */
function LegalNote({ action }: { action: "signing in" | "signing up" }) {
  return (
    <Anchor component={Link} to="/privacy" w="100%" maw={500} ta="center" c="black" fz="md" fw={400}>
      {`By ${action}, you agree to our Terms and Conditions. Learn how we use your data in our Privacy Policy.`}
    </Anchor>
  );
}

export default LegalNote;
