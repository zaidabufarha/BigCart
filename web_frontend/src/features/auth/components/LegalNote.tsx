import { Anchor, Text } from "@mantine/core";

/**
 * The "By signing in, you agree to…" line under the auth forms. It links the
 * way a real store's would, but this is a demo with no legal pages, so the
 * links say so — the same placeholder-alert approach as the newsletter.
 */
function LegalNote({ action }: { action: "signing in" | "signing up" }) {
  const placeholder = (doc: string) => () =>
    alert(`${doc} (placeholder — BigCart is a demo store, so there isn't one yet).`);

  return (
    <Text w="100%" maw={500} ta={"center"} c={"black"}>
      {`By ${action}, you agree to our `}
      <Anchor component="button" type="button" inherit fw={600} onClick={placeholder("Terms and Conditions")}>
        Terms and Conditions.
      </Anchor>
      {" Learn how we use your data in our "}
      <Anchor component="button" type="button" inherit fw={600} onClick={placeholder("Privacy Policy")}>
        Privacy Policy.
      </Anchor>
    </Text>
  );
}

export default LegalNote;
