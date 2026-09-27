import { TextInput } from "@mantine/core";
import { isEmail, useForm } from "@mantine/form";
import userEvent from "@testing-library/user-event";
import { describe, expect, it, vi } from "vitest";
import { renderWithProviders, screen } from "../test/render";
import { useFieldProps } from "./useFieldProps";

const ERROR = "Enter a valid email";

/** A one-field form wired exactly like the app's forms. */
function EmailForm({ onSubmit }: { onSubmit: (values: { email: string }) => void }) {
  const form = useForm({
    mode: "controlled",
    initialValues: { email: "" },
    validateInputOnChange: true,
    clearInputErrorOnChange: false,
    validate: { email: isEmail(ERROR) },
  });
  const { field, revealAll } = useFieldProps(form);

  return (
    <form onSubmit={form.onSubmit(onSubmit, revealAll)}>
      <TextInput label="Email" {...field("email")} />
      <button type="submit">Send</button>
    </form>
  );
}

describe("useFieldProps — when a field is allowed to complain", () => {
  it("stays quiet while typing into an untouched field", async () => {
    const user = userEvent.setup();
    renderWithProviders(<EmailForm onSubmit={vi.fn()} />);

    await user.type(screen.getByLabelText("Email"), "not-an-email");

    expect(screen.queryByText(ERROR)).not.toBeInTheDocument();
  });

  it("shows the error once the field is left, then clears it live as soon as the value is valid", async () => {
    const user = userEvent.setup();
    renderWithProviders(<EmailForm onSubmit={vi.fn()} />);
    const input = screen.getByLabelText("Email");

    await user.type(input, "not-an-email");
    await user.tab(); // leave the field
    expect(screen.getByText(ERROR)).toBeInTheDocument();

    await user.type(input, "@example.com"); // now "not-an-email@example.com"
    expect(screen.queryByText(ERROR)).not.toBeInTheDocument();
  });

  it("surfaces errors on never-visited fields when a submit is attempted, and blocks the submit", async () => {
    const user = userEvent.setup();
    const onSubmit = vi.fn();
    renderWithProviders(<EmailForm onSubmit={onSubmit} />);

    await user.click(screen.getByRole("button", { name: "Send" }));

    expect(screen.getByText(ERROR)).toBeInTheDocument();
    expect(onSubmit).not.toHaveBeenCalled();
  });

  it("submits a valid form with its values", async () => {
    const user = userEvent.setup();
    const onSubmit = vi.fn();
    renderWithProviders(<EmailForm onSubmit={onSubmit} />);

    await user.type(screen.getByLabelText("Email"), "zaid@example.com");
    await user.click(screen.getByRole("button", { name: "Send" }));

    expect(onSubmit).toHaveBeenCalledWith({ email: "zaid@example.com" }, expect.anything());
  });
});
