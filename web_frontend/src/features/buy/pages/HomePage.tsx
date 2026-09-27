import {
  Box,
  Center,
  Container,
  Group,
  Image,
  Loader,
  SimpleGrid,
  Stack,
  Text,
  Title,
} from "@mantine/core";
import { Navigate } from "react-router-dom";
import aisle from "../../../assets/buy_aisle.jpg";
import { useGetCategoriesQuery, useGetProductsQuery } from "../buyApi";
import CategoryIcon from "../components/CategoryIcon";
import FilterBar from "../components/FilterBar";
import ProductCard from "../components/ProductCard";
import { FILTERS, useFilterParams } from "../filters";
import { slugify } from "../slug";
import { useCart } from "../useCart";

type HomePageProps = {
  /** /favorites renders this same page with only the user's favorites. */
  favorites?: boolean;
};

function HomePage({ favorites = false }: HomePageProps) {
  // Every filter lives in the URL, e.g.
  //   /?search=apple&category=fruits&filter=deals&filter=new&min=2&max=10&rating=3
  // `filter` repeats so several chips can apply at once. FilterBar edits the
  // same params; this page only reads them to decide what to show.
  const { activeFilters, categorySlug, minPrice, maxPrice, minRating, search, hasAnyFilter, setParam } =
    useFilterParams();

  // cart quantities + add/update/remove/favorite, shared with ProductPage
  const { isLoggedIn, quantityOf, changeQuantity, toggleFavorite } = useCart();

  const { data: categories = [] } = useGetCategoriesQuery();
  const { data: products = [], isLoading, error } = useGetProductsQuery();

  const selected = FILTERS.filter((f) => activeFilters.includes(f.value));
  const visibleProducts = products.filter(
    (p) =>
      selected.every((f) => f.match(p)) &&
      (categorySlug === null ||
        (p.category !== null && slugify(p.category.name) === categorySlug)) &&
      (minPrice === undefined || p.price >= minPrice) &&
      (maxPrice === undefined || p.price <= maxPrice) &&
      p.rating >= minRating &&
      // case-insensitive name match, same as Flutter's search
      (search === "" || p.name.toLowerCase().includes(search.toLowerCase())) &&
      // is_favorite is per-user; the favorites route requires login below
      (!favorites || p.is_favorite),
  );

  // Unfiltered it's a showcase; filtered, the useful thing is how many matched,
  // since the active filters are already visible right above.
  const count = visibleProducts.length;
  const noun = search
    ? count === 1
      ? "result"
      : "results"
    : count === 1
      ? "product"
      : "products";
  const heading = favorites
    ? search
      ? `${count} favorite ${noun} for "${search}"`
      : `${count} favorite ${noun}`
    : !hasAnyFilter
      ? "Popular Products"
      : search
        ? `${count} ${noun} for "${search}"`
        : `${count} ${noun}`;

  // favorites are per-user, so the route only makes sense logged in
  if (favorites && !isLoggedIn) return <Navigate to="/login" replace />;

  return (
    <Stack gap={40} pb={60}>
      {/* hero */}
      <Box pos="relative" h={{ base: 260, md: 415 }}>
        <Image src={aisle} h="100%" fit="cover" />
        <Box
          pos="absolute"
          inset={0}
          display="flex"
          style={{
            alignItems: "flex-end",
            background:
              "linear-gradient(180deg, rgba(30,30,30,0) 0%, rgba(30,30,30,1) 100%)",
          }}
        >
          <Container pb={40}>
            <Stack gap={6}>
              <Title c="white" fz={{ base: 32, md: 52 }}>
                All Your Daily Needs, All in One Place!
              </Title>
              <Text c="white" fz={{ base: 16, md: 22 }}>
                Enjoy the convenience of shopping without having to leave your
                home.
              </Text>
            </Stack>
          </Container>
        </Box>
      </Box>

      <Container>
        <Stack gap={40}>
          {/* categories */}
          <Stack gap="sm">
            <Title order={3}>Categories</Title>
            <Group gap="lg">
              {categories.map((category) => (
                <CategoryIcon
                  key={category.id}
                  category={category}
                  selected={slugify(category.name) === categorySlug}
                  // clicking the selected tile again clears it
                  onClick={() => {
                    const slug = slugify(category.name);
                    setParam("category", slug === categorySlug ? null : slug);
                  }}
                />
              ))}
            </Group>
          </Stack>

          <FilterBar favorites={favorites} isLoggedIn={isLoggedIn} />

          {/* products */}
          <Stack gap="sm">
            <Title order={3}>{heading}</Title>
            {isLoading ? (
              <Center h={200}>
                <Loader color="green" />
              </Center>
            ) : error ? (
              <Text c="red">{error.message}</Text>
            ) : visibleProducts.length === 0 ? (
              <Text>
                {favorites && !hasAnyFilter
                  ? "You haven't favorited anything yet. Tap the heart on a product to save it here."
                  : search
                    ? `No products match "${search}" with these filters.`
                    : "No products match these filters."}
              </Text>
            ) : (
              <SimpleGrid cols={{ base: 1, sm: 2, md: 3, lg: 4 }} spacing="lg">
                {visibleProducts.map((product) => (
                  <ProductCard
                    key={product.id}
                    product={product}
                    quantity={quantityOf(product.id)}
                    onChangeQuantity={(next) => changeQuantity(product, next)}
                    onToggleFavorite={() => toggleFavorite(product)}
                  />
                ))}
              </SimpleGrid>
            )}
          </Stack>
        </Stack>
      </Container>
    </Stack>
  );
}

export default HomePage;
