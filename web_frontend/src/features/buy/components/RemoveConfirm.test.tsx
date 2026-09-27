import userEvent from "@testing-library/user-event";
import { describe, expect, it, vi } from "vitest";
import { renderWithProviders, screen } from "../../../test/render";
import RemoveConfirm from "./RemoveConfirm";

describe("RemoveConfirm — the red minus on the last item", () => {
  it("asks before removing, and Keep leaves the item alone", async () => {
    const user = userEvent.setup();
    const onConfirm = vi.fn();
    renderWithProviders(<RemoveConfirm name="Fresh Broccoli" onConfirm={onConfirm} />);

    await user.click(screen.getByRole("button", { name: /remove fresh broccoli/i }));
    expect(screen.getByText(/from your cart\?/)).toBeInTheDocument();

    await user.click(screen.getByRole("button", { name: "Keep" }));
    expect(onConfirm).not.toHaveBeenCalled();
  });

  it("removes only when Remove is chosen", async () => {
    const user = userEvent.setup();
    const onConfirm = vi.fn();
    renderWithProviders(<RemoveConfirm name="Fresh Broccoli" onConfirm={onConfirm} />);

    await user.click(screen.getByRole("button", { name: /remove fresh broccoli/i }));
    await user.click(screen.getByRole("button", { name: "Remove" }));

    expect(onConfirm).toHaveBeenCalledTimes(1);
  });
});
