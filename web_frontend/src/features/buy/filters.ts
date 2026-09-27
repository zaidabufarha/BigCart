import { useNavigate, useSearchParams } from "react-router-dom";
import type { CardProduct } from "./components/ProductCard";

/** The quick-filter chips. Category, price, rating and search are separate params. */
export const FILTERS = [
  { value: "new", label: "New", match: (p: CardProduct) => p.is_new },
  { value: "deals", label: "Deals", match: (p: CardProduct) => p.discount > 0 },
  {
    value: "free-shipping",
    label: "Free Shipping",
    match: (p: CardProduct) => p.free_shipping,
  },
  {
    value: "same-day",
    label: "Same Day Delivery",
    match: (p: CardProduct) => p.same_day_delivery,
  },
];

/** "12.5" -> 12.5, and anything missing or non-numeric -> undefined. */
function numberParam(raw: string | null): number | undefined {
  if (raw === null || raw === "") return undefined;
  const n = Number(raw);
  return Number.isFinite(n) ? n : undefined;
}

/**
 * The shop's filter state, read from and written to the URL:
 *   /?search=milk&category=beverages&filter=deals&filter=new&min=1&max=5&rating=3
 * The URL is the store, so the home page (which applies the filters) and the
 * filter bar (which edits them) both call this and stay in step for free.
 * Every write keeps the scroll position: filtering is an in-page change.
 */
export function useFilterParams() {
  const [searchParams, setSearchParams] = useSearchParams();
  const navigate = useNavigate();

  const activeFilters = searchParams.getAll("filter");
  const categorySlug = searchParams.get("category");
  const minPrice = numberParam(searchParams.get("min"));
  const maxPrice = numberParam(searchParams.get("max"));
  const minRating = numberParam(searchParams.get("rating")) ?? 0;
  const search = searchParams.get("search")?.trim() ?? "";

  const hasAnyFilter =
    search !== "" ||
    activeFilters.length > 0 ||
    categorySlug !== null ||
    minPrice !== undefined ||
    maxPrice !== undefined ||
    minRating > 0;

  // Sets or clears one param, keeping the rest. `replace` is for inputs that
  // change on every keystroke, so typing "12" isn't two back-button steps.
  const setParam = (key: string, value: string | null, replace = false) => {
    const next = new URLSearchParams(searchParams);
    if (value === null || value === "") next.delete(key);
    else next.set(key, value);
    setSearchParams(next, { replace, preventScrollReset: true });
  };

  /** Replaces the chip selection wholesale. */
  const setFilters = (values: string[]) => {
    const next = new URLSearchParams(searchParams);
    next.delete("filter");
    values.forEach((v) => next.append("filter", v));
    setSearchParams(next, { preventScrollReset: true });
  };

  /** Drops every param but stays on the current route (favorites included). */
  const clearFilters = () => setSearchParams(new URLSearchParams(), { preventScrollReset: true });

  /** Back to the plain home page. */
  const showAll = () => navigate("/", { preventScrollReset: true });

  /** Favorites is a route rather than a param; the params carry over. */
  const setFavorites = (on: boolean) =>
    navigate(
      { pathname: on ? "/favorites" : "/", search: searchParams.toString() },
      { preventScrollReset: true },
    );

  return {
    activeFilters,
    categorySlug,
    minPrice,
    maxPrice,
    minRating,
    search,
    hasAnyFilter,
    setParam,
    setFilters,
    clearFilters,
    showAll,
    setFavorites,
  };
}
