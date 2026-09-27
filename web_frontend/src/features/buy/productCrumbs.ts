import type { Crumb } from "../../components/Crumbs";
import { slugify } from "./slug";

type CrumbProduct = {
  id: string;
  name: string;
  category?: { name: string } | null;
};

/**
 * Home › Category › Product, plus an optional current-page tail.
 * Without a tail the product is the current page (plain text); with one it
 * becomes a link back and the tail is the current page.
 */
export function productCrumbs(product: CrumbProduct, tail?: string): Crumb[] {
  const crumbs: Crumb[] = [{ label: "Home", to: "/" }];
  if (product.category) {
    crumbs.push({
      label: product.category.name,
      to: `/?category=${slugify(product.category.name)}`,
    });
  }
  crumbs.push(
    tail ? { label: product.name, to: `/product/${product.id}` } : { label: product.name },
  );
  if (tail) crumbs.push({ label: tail });
  return crumbs;
}
