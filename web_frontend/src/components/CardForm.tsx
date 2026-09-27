import { Button, Group, Image, SimpleGrid, Stack, Switch, Text, TextInput } from "@mantine/core";
import { isNotEmpty, useForm } from "@mantine/form";
import { IconCalendar, IconCreditCard, IconUser } from "@tabler/icons-react";
import type { CardInput } from "../gql/schema";
import { useFieldProps } from "../hooks/useFieldProps";
import { detectProcessor, PROCESSOR_LABELS, PROCESSOR_LOGOS } from "../lib/processors";

export type CardFormValues = {
  card_holder_name: string;
  card_number: string;
  expiry_date: string;
  processor: string;
  is_default: boolean;
};

const EMPTY: CardFormValues = {
  card_holder_name: "",
  card_number: "",
  expiry_date: "",
  // stored as the Flutter enum names; on a new card it's read off the number
  processor: "",
  is_default: false,
};

type CardFormProps = {
  /** Existing card to edit; omit to add. The number can't be changed on an existing card — only its last 4 are stored. */
  initial?: Partial<CardFormValues> & { last4?: string };
  isCurrentDefault?: boolean;
  /** Show the values locked, with no buttons — used at checkout to display the chosen card. */
  readOnly?: boolean;
  isSaving?: boolean;
  error?: { message?: string };
  onSubmit?: (input: CardInput) => void;
  onCancel?: () => void;
};

const digits = (s: string) => s.replace(/\D/g, "");

/** Formats "4242424242424242" as "4242 4242 4242 4242" while typing. */
const groupDigits = (s: string) => digits(s).slice(0, 19).replace(/(.{4})/g, "$1 ").trim();

function CardForm({
  initial,
  isCurrentDefault = false,
  readOnly = false,
  isSaving = false,
  error,
  onSubmit,
  onCancel,
}: CardFormProps) {
  const isEdit = Boolean(initial?.last4);

  const form = useForm<CardFormValues>({
    mode: "controlled",
    initialValues: { ...EMPTY, ...initial },
    validateInputOnChange: true,
    clearInputErrorOnChange: false,
    validate: {
      card_holder_name: isNotEmpty("Cannot be empty"),
      // the number is only asked for on a new card
      card_number: (v) => (isEdit || /^\d{13,19}$/.test(digits(v)) ? null : "Enter a 13–19 digit card number"),
      expiry_date: (v) => (/^(0[1-9]|1[0-2])\/\d{2}$/.test(v) ? null : "Use MM/YY"),
    },
  });
  const { field, revealAll } = useFieldProps(form);

  // on add, the brand follows the number as it's typed; on edit it's whatever was stored
  const processor = isEdit ? form.values.processor : detectProcessor(form.values.card_number);
  const logo = processor ? PROCESSOR_LOGOS[processor] : undefined;

  return (
    <form
      onSubmit={form.onSubmit((values) => {
        const number = digits(values.card_number);
        onSubmit?.({
          card_holder_name: values.card_holder_name.trim(),
          expiry_date: values.expiry_date,
          // a valid number always yields a brand
          processor: isEdit ? values.processor : (detectProcessor(number) ?? "visa"),
          is_default: values.is_default,
          // only on add — the backend derives last4 from it and never stores the full number
          ...(isEdit ? {} : { card_number: number, last4: number.slice(-4) }),
        });
      }, revealAll)}
    >
      <Stack gap="sm">
        <TextInput
          label="Name on the card"
          placeholder="Name on the card"
          leftSection={<IconUser size={18} />}
          disabled={readOnly}
          {...field("card_holder_name")}
        />

        {isEdit ? (
          <TextInput
            label="Card number"
            value={`•••• •••• •••• ${initial?.last4}`}
            disabled
            leftSection={<IconCreditCard size={18} />}
          />
        ) : (
          <TextInput
            label="Card number"
            placeholder="Card number"
            inputMode="numeric"
            leftSection={<IconCreditCard size={18} />}
            // the brand's logo appears as soon as the number gives it away
            rightSection={logo && <Image src={logo} w={28} fit="contain" />}
            rightSectionWidth={44}
            {...field("card_number")}
            onChange={(e) => form.setFieldValue("card_number", groupDigits(e.currentTarget.value))}
          />
        )}

        <SimpleGrid cols={{ base: 1, sm: 2 }} spacing="sm">
          <TextInput
            label="Expiry"
            placeholder="MM/YY"
            maxLength={5}
            leftSection={<IconCalendar size={18} />}
            disabled={readOnly}
            {...field("expiry_date")}
          />
          {/* never typed: read off the number on add, stored on edit */}
          <TextInput
            label="Card type"
            placeholder="Detected from the number"
            value={processor ? (PROCESSOR_LABELS[processor] ?? processor) : ""}
            readOnly
            disabled
            leftSection={logo ? <Image src={logo} w={22} fit="contain" /> : <IconCreditCard size={18} />}
          />
        </SimpleGrid>

        <Switch
          label={readOnly && isCurrentDefault ? "Default card" : "Make default"}
          color="green"
          mt="xs"
          disabled={readOnly || isCurrentDefault}
          {...form.getInputProps("is_default", { type: "checkbox" })}
          checked={isCurrentDefault || form.values.is_default}
        />

        {error && (
          <Text c="red" size="sm">
            {error.message ?? "Something went wrong"}
          </Text>
        )}

        {!readOnly && (
          <Group justify="flex-end" mt="xs">
            <Button variant="subtle" color="gray" h={40} onClick={onCancel} disabled={isSaving}>
              Cancel
            </Button>
            <Button type="submit" h={40} w={140} loading={isSaving}>
              Save
            </Button>
          </Group>
        )}
      </Stack>
    </form>
  );
}

export default CardForm;
