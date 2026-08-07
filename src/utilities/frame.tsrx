import { effect, Portal, track, type Children } from 'ripple';

const resetStyle = '<style>*,*::before,*::after{margin:0;padding:0;box-sizing:border-box}</style>';
const initialSrcdoc = `<html><head>${resetStyle}</head><body><div class="frame-root"></div></body></html>`;

export type FrameProps =
	Omit<JSX.IntrinsicElements['iframe'], 'children'> & {
		head?: Children | Children[];
		children?: Children | Children[];
		onMount?: () => void;
		onUnmount?: () => void;
	};

export function Frame(props: FrameProps) @{
	const { head, children, onMount, onUnmount, srcdoc = initialSrcdoc, ref, ...localProps } = props;
	const frame = track<HTMLIFrameElement | null>(null);
	const bodyTarget = track<HTMLElement | null>(null);
	const headTarget = track<HTMLElement | null>(null);

	effect(() => {
		const element = frame.value;
		if (!element?.contentDocument) return;
		const document = element.contentDocument;
		document.open();
		document.write(srcdoc);
		document.close();
		bodyTarget.value = document.body.querySelector<HTMLElement>('.frame-root') ?? document.body;
		headTarget.value = document.head;
		onMount?.();
		return () => onUnmount?.();
	});

	<iframe
		{...localProps}
		ref={(element) => {
			frame.value = element;
			if (typeof ref === 'function') ref(element);
		}}
	>
		@if (bodyTarget.value) {
			<Portal target={bodyTarget.value}>{children}</Portal>
		}
		@if (headTarget.value) {
			<Portal target={headTarget.value}>{head}</Portal>
		}
	</iframe>
}
