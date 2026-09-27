import { Box, Grid, Image, Paper, Stack, Title } from "@mantine/core";
import type { ReactNode } from "react";
import vegetables from "../../../assets/auth_veg.jpg";

/**
 * The layout every auth page shares. Tablet and desktop: the produce photo
 * with its welcome copy on the left, the page's own content on the right.
 * Phone: the same photo becomes the page background and the content sits in
 * a frosted card over it, so nothing is lost and no column has to squeeze.
 */
function AuthShell({ children }: { children: ReactNode }) {
  return (
    <Box pos="relative">
      {/* phone only: photo as background */}
      <Box
        hiddenFrom="sm"
        pos="absolute"
        inset={0}
        style={{
          backgroundImage: `url(${vegetables})`,
          backgroundSize: "cover",
          backgroundPosition: "center",
        }}
      />
      <Grid>
        <Grid.Col span={5} visibleFrom="sm">
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
        <Grid.Col span={{ base: 12, sm: 6 }}>
          {/* the frosted card: only visible on phone, where it has a photo
              behind it; on wider screens it's transparent with no padding */}
          <Paper
            pos="relative"
            radius="lg"
            m={{ base: "md", sm: 0 }}
            p={{ base: "md", sm: 0 }}
            bg={{ base: "rgba(255, 255, 255, 0.85)", sm: "transparent" }}
            style={{ backdropFilter: "blur(12px)" }}
          >
            {children}
          </Paper>
        </Grid.Col>
      </Grid>
    </Box>
  );
}

export default AuthShell;
