import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useQrCode } from '../components';
import {
	createApiContext,
	createItemContext,
	useExternalPartProps,
	usePartProps,
	useRootProps,
	useRootProviderProps,
	type ArkPartProps,
	type ComponentProps,
	type GetterProps,
	type PartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useQrCode;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
	const mergedProps = useRootProps(
		{
			context,
			configKeys: [
				'defaultValue',
				'encoding',
				'id',
				'ids',
				'onValueChange',
				'pixelSize',
				'value',
			],

			useMachine: useQrCode as any,
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function DownloadTrigger(props: DownloadTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getDownloadTriggerProps',
			propKeys: [
				'fileName',
				'mimeType',
				'quality',
			],
		},
		props,
	);
	<button {...mergedProps.value}>{children}</button>
}
export function Overlay(props: OverlayProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getOverlayProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Frame(props: FrameProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getFrameProps' }, props);
	<svg {...mergedProps.value}>{children}</svg>
}
export function Pattern(props: PatternProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getPatternProps' }, props);
	<path {...mergedProps.value}>{children}</path>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps<'div'> & { value: ReturnType<Hook> };
export type DownloadTriggerProps = PartProps<'button', Api['getDownloadTriggerProps']>;
export type OverlayProps = PartProps<'div', Api['getOverlayProps']>;
export type FrameProps = PartProps<'svg', Api['getFrameProps']>;
export type PatternProps = PartProps<'path', Api['getPatternProps']>;

export const QrCode = { Root, RootProvider, DownloadTrigger, Overlay, Frame, Pattern, Context };
