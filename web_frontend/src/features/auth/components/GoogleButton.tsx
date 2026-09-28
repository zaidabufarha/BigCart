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

// Google's large button is 40px tall and at most 400px wide; ours are 50px
// tall and up to 500px wide. Drawing Google's at 1/1.25 of the target width
// and scaling it up by 1.25 matches both, keeping Google's own proportions.
const SCALE = 1.25;

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
  const { ref, width } = useElementSize();
  const drawnWidth = Math.min(Math.round(width / SCALE), 400);

  return (
    <Box ref={ref} w="100%" maw={500}>
      {width > 0 && (
        // the box reserves the scaled size, since a transform doesn't change layout
        <Box h={40 * SCALE} display="flex" style={{ justifyContent: "center" }}>
          <Box style={{ transform: `scale(${SCALE})`, transformOrigin: "top center" }}>
            <GoogleLogin
              text={text}
              width={drawnWidth}
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
          </Box>
        </Box>
      )}
      {error && (
        <Text c="red" ta="center" mt="sm">
          {error.message}
        </Text>
      )}
    </Box>
  );
}

export default GoogleButton;
