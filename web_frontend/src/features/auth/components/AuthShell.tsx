import { Box, Grid, Image, Stack, Title } from "@mantine/core";
import type { ReactNode } from "react";
import vegetables from "../../../assets/auth_veg.jpg";

/**
 * The layout every auth page shares: the produce photo with its welcome copy
 * on the left, the page's own content on the right.
 */
function AuthShell({ children }: { children: ReactNode }) {
  return (
    <Box>
      <Grid>
        <Grid.Col span={5}>
          <Box pos={"relative"}>
            <Image
              src={vegetables}
              h={"85vh"}
              style={{ borderRadius: "0 24px 24px 0" }}
              fit="cover"
            />
            <Box
              pos={"absolute"}
              inset={0}
              p={80}
              display={"flex"}
              style={{
                alignItems: "flex-end",
                justifyContent: "center",
                borderRadius: "0 24px 24px 0",
                background:
                  "linear-gradient(180deg, rgba(30,30,30,0) 4%, rgba(30,30,30,0.26) 57%, rgba(30,30,30,1) 87%)",
              }}
            >
              <Stack>
                <Title c={"white"} ta={"center"}>
                  Welcome to BigCart
                </Title>
                <Title order={3} ta={"center"} c={"white"}>
                  Find all your daily needs here with low prices, fast delivery,
                  and no hassle.
                </Title>
              </Stack>
            </Box>
          </Box>
        </Grid.Col>
        <Grid.Col span={6}>{children}</Grid.Col>
      </Grid>
    </Box>
  );
}

export default AuthShell;
