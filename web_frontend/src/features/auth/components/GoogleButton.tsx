import { Box, Text } from "@mantine/core";
import { useElementSize } from "@mantine/hooks";
import { GoogleLogin } from "@react-oauth/google";
import { useNavigate } from "react-router-dom";
import { useGoogleSignInMutation } from "../authApi";

type GoogleButtonProps = {
  text: "signin_with" | "signup_with";
  /** Keep the session after the browser closes. */
  remember?: boolean;
};

/**
 * "Continue with Google" for the login and signup pages.
 *
 * Google draws this button itself (its sign-in script only hands out an ID
 * token through its own button). On click it opens Google's popup; when the
 * person picks an account, Google gives us an ID token, which the backend
 * verifies and swaps for our own session — the same one a password login gets.
 */
function GoogleButton({ text, remember = true }: GoogleButtonProps) {
  const [googleSignIn, { error }] = useGoogleSignInMutation();
  const navigate = useNavigate();
  // Google's button takes a fixed pixel width, at most 400
  const { ref, width } = useElementSize();

  return (
    <Box ref={ref} w="100%" maw={500}>
      <Box w="fit-content" mx="auto">
        {width > 0 && (
          <GoogleLogin
            text={text}
            width={Math.min(Math.round(width), 400)}
            size="large"
            shape="rectangular"
            onSuccess={async ({ credential }) => {
              if (!credential) return;
              try {
                await googleSignIn({ idToken: credential, remember }).unwrap();
                navigate("/");
              } catch {
                // shown below
              }
            }}
            onError={() => {
              // the popup closed or Google refused; nothing to do
            }}
          />
        )}
      </Box>
      {error && (
        <Text c="red" ta="center" mt="sm">
          {error.message}
        </Text>
      )}
    </Box>
  );
}

export default GoogleButton;
