import {
  Badge,
  Box,
  Button,
  Chip,
  Drawer,
  Group,
  NumberInput,
  Rating,
  Stack,
  Text,
} from "@mantine/core";
import { useDisclosure } from "@mantine/hooks";
import { IconAdjustmentsHorizontal, IconHeartFilled, IconX } from "@tabler/icons-react";
import { FILTERS, useFilterParams } from "../filters";

type FilterBarProps = {
  /** On the /favorites route. */
  favorites: boolean;
  isLoggedIn: boolean;
};

/**
 * The shop's filter controls. Desktop: chips on the left, price and rating on
 * the right, wrapping to two lines when the window is narrow. Phone: one
 * "Filters" button (with a count of what's active) that opens the same
 * controls in a bottom sheet. Both edit the URL through useFilterParams, so
 * there is no local state to keep in sync.
 */
function FilterBar({ favorites, isLoggedIn }: FilterBarProps) {
  const f = useFilterParams();
  const [opened, { open, close }] = useDisclosure(false);

  // Favorites is a route rather than a filter, but "clear" should drop it too
  const canClear = f.hasAnyFilter || favorites;
  // what the sheet controls (category and search are set elsewhere)
  const activeCount =
    f.activeFilters.length +
    (f.minPrice !== undefined ? 1 : 0) +
    (f.maxPrice !== undefined ? 1 : 0) +
    (f.minRating > 0 ? 1 : 0) +
    (favorites ? 1 : 0);

  // Two steps: filters go first (staying on favorites if you're there), then
  // on bare favorites it leaves for the full list. Always laid out (just
  // hidden when idle) so appearing shifts nothing. Both labels sit in the same
  // grid cell with only one visible, so the button is always as wide as the
  // longer one and switching labels shifts nothing either.
  const label = (text: string, shown: boolean) => (
    <span style={{ gridArea: "1 / 1", visibility: shown ? "visible" : "hidden" }}>{text}</span>
  );
  const clearButton = (
    <Button
      variant="light"
      color="gray"
      radius="xl"
      h={32}
      px="md"
      leftSection={<IconX size={14} />}
      onClick={f.hasAnyFilter ? f.clearFilters : f.showAll}
      style={{ visibility: canClear ? "visible" : "hidden" }}
      tabIndex={canClear ? 0 : -1}
      aria-hidden={!canClear}
    >
      <span style={{ display: "inline-grid" }}>
        {label("Clear filters", f.hasAnyFilter)}
        {label("Show all", !f.hasAnyFilter)}
      </span>
    </Button>
  );

  const chips = (wrap: "wrap" | "nowrap") => (
    <Group gap="sm" wrap={wrap}>
      {isLoggedIn && (
        // Favorites must sit OUTSIDE Chip.Group: the group's context overrides
        // any inner chip's checked/onChange, which is why it wouldn't toggle.
        <Chip checked={favorites} icon={<IconHeartFilled size={14} />} onChange={f.setFavorites}>
          Favorites
        </Chip>
      )}
      <Chip.Group
        multiple
        value={f.activeFilters.length ? f.activeFilters : ["all"]}
        onChange={(values) => {
          // "All" is exclusive: picking it clears the rest, and picking
          // anything else drops it
          const pickedAll = values.includes("all") && f.activeFilters.length > 0;
          f.setFilters(pickedAll ? [] : values.filter((v) => v !== "all"));
        }}
      >
        <Chip value="all">All</Chip>
        {FILTERS.map((filter) => (
          <Chip key={filter.value} value={filter.value}>
            {filter.label}
          </Chip>
        ))}
      </Chip.Group>
    </Group>
  );

  const priceAndRating = (fill: boolean) => (
    <>
      <NumberInput
        label="Min price"
        placeholder="Min"
        // wider where the row has room (xl ≈ 1400px+), compact below
        w={fill ? "100%" : { base: 110, xl: 150 }}
        min={0}
        prefix="$"
        decimalScale={2}
        value={f.minPrice ?? ""}
        onChange={(v) => f.setParam("min", v === "" ? null : String(v), true)}
      />
      <NumberInput
        label="Max price"
        placeholder="Max"
        w={fill ? "100%" : { base: 110, xl: 150 }}
        min={0}
        prefix="$"
        decimalScale={2}
        value={f.maxPrice ?? ""}
        onChange={(v) => f.setParam("max", v === "" ? null : String(v), true)}
      />
      <Stack gap={4}>
        <Text size="sm" fw={500} c="black">
          Min rating
        </Text>
        <Box h={36} display="flex" style={{ alignItems: "center" }}>
          <Rating size="md" value={f.minRating} onChange={(v) => f.setParam("rating", String(v), true)} />
        </Box>
      </Stack>
    </>
  );

  return (
    <>
      {/* desktop (md and up): the right group drops to its own line when the
          window is narrow rather than running off the edge; that depends only
          on width, so toggling a filter never moves anything. Below md the
          chip row alone no longer fits, so phones and tablets get the sheet. */}
      <Group visibleFrom="md" justify="space-between" align="flex-end" gap="md">
        <Group gap="sm" wrap="nowrap" style={{ flexShrink: 0 }}>
          {chips("nowrap")}
          {clearButton}
        </Group>
        {/* ml auto keeps it right-aligned even when it wraps to its own line */}
        <Group gap="md" align="flex-end" wrap="nowrap" ml="auto" style={{ flexShrink: 0 }}>
          {priceAndRating(false)}
        </Group>
      </Group>

      {/* phone and tablet */}
      <Group hiddenFrom="md" justify="space-between" wrap="nowrap">
        <Button
          variant="light"
          color="gray"
          radius="xl"
          h={36}
          px="md"
          leftSection={<IconAdjustmentsHorizontal size={16} />}
          rightSection={
            activeCount > 0 ? (
              <Badge size="sm" circle color="green">
                {activeCount}
              </Badge>
            ) : undefined
          }
          onClick={open}
        >
          Filters
        </Button>
        {clearButton}
      </Group>
      <Drawer opened={opened} onClose={close} position="bottom" size={480} title="Filters" padding="md">
        <Stack gap="lg">
          {chips("wrap")}
          <Group grow align="flex-end">
            {priceAndRating(true)}
          </Group>
          <Button onClick={close}>Done</Button>
        </Stack>
      </Drawer>
    </>
  );
}

export default FilterBar;
