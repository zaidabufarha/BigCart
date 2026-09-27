import { Center, Loader } from "@mantine/core";

/** Fills the page area while a lazily loaded page's code arrives. */
function PageLoader() {
  return (
    <Center h="60vh">
      <Loader color="green" />
    </Center>
  );
}

export default PageLoader;
