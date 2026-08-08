import type {
	ItemProps as AccordionItemProps,
	ItemTriggerProps as AccordionItemTriggerProps,
	RootProps as AccordionRootProps,
} from '../src/generated/accordion.tsrx';
import type {
	Api as ComboboxApi,
	ItemProps as ComboboxItemProps,
	RootProps as ComboboxRootProps,
} from '../src/generated/combobox.tsrx';

// These assignments are compile-time contract tests. They guard the three layers
// that the generator must preserve: native element props, machine props, and
// semantic part props passed to Zag getters.
const accordionRoot: AccordionRootProps = {
	defaultValue: ['details'],
	id: 'faq',
	class: 'accordion',
};
void accordionRoot;

const accordionItem: AccordionItemProps = { value: 'details', class: 'item' };
void accordionItem;

const accordionTrigger: AccordionItemTriggerProps = { disabled: true, type: 'button' };
void accordionTrigger;

// @ts-expect-error Ripple's intrinsic button contract declares disabled as boolean.
const nativeButton: JSX.IntrinsicElements['button'] = { disabled: 1 };
void nativeButton;

// @ts-expect-error Accordion items require the value consumed by getItemProps.
const missingAccordionItemValue: AccordionItemProps = { class: 'item' };
void missingAccordionItemValue;

// @ts-expect-error Native boolean attributes must not collapse to any.
const triggerWithInvalidDisabled: AccordionItemTriggerProps = { disabled: 1 };
void triggerWithInvalidDisabled;

declare const collection: ComboboxRootProps['collection'];
const comboboxRoot: ComboboxRootProps = { collection, inputBehavior: 'autohighlight' };
void comboboxRoot;

declare const item: Parameters<ComboboxApi['getItemProps']>[0]['item'];
const comboboxItem: ComboboxItemProps = { item, class: 'option' };
void comboboxItem;

declare const comboboxApi: ComboboxApi;
const openCombobox: (open: boolean) => void = comboboxApi.setOpen;
void openCombobox;
