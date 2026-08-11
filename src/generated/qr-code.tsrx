import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useQrCode } from '../components';
import {
	Part,
	createApiContext,
	createItemContext,
	useRootProps,
	useRootProviderProps,
	type ArkPartProps,
	type ComponentProps,
	type GetterProps,
	type PartProps,
	type RenderProp,
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
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function DownloadTrigger(props: DownloadTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{
			context,
			getter: 'getDownloadTriggerProps',
			propKeys: [
				'fileName',
				'mimeType',
				'quality',
			],
		}}
		of={props}
	>{children}</Part>
}
export function Overlay(props: OverlayProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getOverlayProps' }} of={props}>{children}</Part>
}
export function Frame(props: FrameProps) @{
	let &{ children } = props;
	<Part tag="svg" options={{ context, getter: 'getFrameProps' }} of={props}>{children}</Part>
}
export function Pattern(props: PatternProps) @{
	let &{ children } = props;
	<Part tag="path" options={{ context, getter: 'getPatternProps' }} of={props}>{children}</Part>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps =
	ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]> & { render?: RenderProp<'div'> };
export type RootProviderProps =
	ArkPartProps<'div'> & { value: ReturnType<Hook> } & { render?: RenderProp<'div'> };
export type DownloadTriggerProps =
	(PartProps<'button', Api['getDownloadTriggerProps']>) & { render?: RenderProp<'button'> };
export type OverlayProps =
	(PartProps<'div', Api['getOverlayProps']>) & { render?: RenderProp<'div'> };
export type FrameProps = (PartProps<'svg', Api['getFrameProps']>) & { render?: RenderProp<'svg'> };
export type PatternProps =
	(PartProps<'path', Api['getPatternProps']>) & { render?: RenderProp<'path'> };

export const QrCode = { Root, RootProvider, DownloadTrigger, Overlay, Frame, Pattern, Context };
