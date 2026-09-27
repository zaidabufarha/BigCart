import { Box, Group } from "@mantine/core";
import { IconAlarm, IconMapPin, IconPhone } from "@tabler/icons-react";
import TopBarItem from "./TopBarItem";

function TopBar() {
  return (
    // decorative; there's no room for it on phones and tablets
    <Box bg={"green"} p={20} h={60} visibleFrom="md">
      <Group justify="flex-end" gap={30} pr={{ base: 20, lg: 100 }}>
        <TopBarItem icon={IconMapPin}>Los Angeles, USA</TopBarItem>
        <TopBarItem icon={IconAlarm}>
          Everyday from 10.00 AM to 09.00 PM
        </TopBarItem>
        <TopBarItem icon={IconPhone}>(603) 555-0123</TopBarItem>
      </Group>
    </Box>
  );
}

export default TopBar;
