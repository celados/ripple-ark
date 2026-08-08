import { trapFocus, type FocusTrapOptions } from '@zag-js/focus-trap';
import { effect, type Children } from 'ripple';

export type FocusTrapProps =
	Omit<JSX.IntrinsicElements['div'], 'children'> & Pick<
		FocusTrapOptions,
		| 'onActivate'
		| 'onDeactivate'
		| 'initialFocus'
		| 'fallbackFocus'
		| 'returnFocusOnDeactivate'
		| 'setReturnFocus'
		| 'persistentElements'
	> & { disabled?: boolean; children?: Children | Children[] };

export function FocusTrap(props: FocusTrapProps) @{
	let &{
		disabled,
		onActivate,
		onDeactivate,
		initialFocus,
		fallbackFocus,
		returnFocusOnDeactivate,
		setReturnFocus,
		persistentElements,
		children,
		ref,
		...localProps
	} = props;
	let node: HTMLDivElement | undefined;
	effect(() => {
		if (!node || disabled) return;
		return trapFocus(node, {
			onActivate,
			onDeactivate,
			initialFocus: initialFocus ??
				node.querySelector<HTMLElement>('[autofocus], [data-autofocus]') ??
				undefined,
			fallbackFocus,
			returnFocusOnDeactivate,
			setReturnFocus,
			persistentElements,
		});
	});

	<div
		{...localProps}
		ref={(element) => {
			node = element;
			if (typeof ref === 'function') ref(element);
		}}
	>{children}</div>
}
