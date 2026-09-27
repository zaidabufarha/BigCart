import { Anchor, Breadcrumbs, Text } from "@mantine/core";
import { Link } from "react-router-dom";

export type Crumb = { label: string; to?: string };

type CrumbsProps = { items: Crumb[] };

/** One breadcrumb style for every page: links dimmed, the current page black. */
function Crumbs({ items }: CrumbsProps) {
  return (
    <Breadcrumbs>
      {items.map((crumb) =>
        crumb.to ? (
          <Anchor key={crumb.label} component={Link} to={crumb.to} fz="sm" fw={400} c="dimmed">
            {crumb.label}
          </Anchor>
        ) : (
          <Text key={crumb.label} fz="sm" fw={500} c="black">
            {crumb.label}
          </Text>
        ),
      )}
    </Breadcrumbs>
  );
}

export default Crumbs;
