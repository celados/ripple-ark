import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useImageCropper } from '../components';
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

type Hook = typeof useImageCropper;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
	const mergedProps = useRootProps(
		{
			context,
			configKeys: [
				'aspectRatio',
				'cropShape',
				'defaultFlip',
				'defaultRotation',
				'defaultZoom',
				'fixedCropArea',
				'flip',
				'id',
				'ids',
				'initialCrop',
				'maxHeight',
				'maxWidth',
				'maxZoom',
				'minHeight',
				'minWidth',
				'minZoom',
				'nudgeStep',
				'nudgeStepCtrl',
				'nudgeStepShift',
				'onCropChange',
				'onFlipChange',
				'onRotationChange',
				'onZoomChange',
				'rotation',
				'translations',
				'zoom',
				'zoomSensitivity',
				'zoomStep',
			],

			useMachine: useImageCropper as any,
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
export function Image(props: ImageProps) @{
	<Part tag="img" options={{ context, getter: 'getImageProps' }} of={props} />
}
export function Selection(props: SelectionProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getSelectionProps' }} of={props}>{children}</Part>
}
export function Handle(props: HandleProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{
			context,
			getter: 'getHandleProps',
			propKeys: [
				'position',
			],
		}}
		of={props}
	>{children}</Part>
}
export function Grid(props: GridProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{
			context,
			getter: 'getGridProps',
			propKeys: [
				'axis',
			],
		}}
		of={props}
	>{children}</Part>
}
export function Viewport(props: ViewportProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getViewportProps' }} of={props}>{children}</Part>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps =
	ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]> & { render?: RenderProp<'div'> };
export type RootProviderProps =
	ArkPartProps<'div'> & { value: ReturnType<Hook> } & { render?: RenderProp<'div'> };
export type ImageProps = (PartProps<'img', Api['getImageProps']>) & { render?: RenderProp<'img'> };
export type SelectionProps =
	(PartProps<'div', Api['getSelectionProps']>) & { render?: RenderProp<'div'> };
export type HandleProps =
	(PartProps<'div', Api['getHandleProps']>) & { render?: RenderProp<'div'> };
export type GridProps = (PartProps<'div', Api['getGridProps']>) & { render?: RenderProp<'div'> };
export type ViewportProps =
	(PartProps<'div', Api['getViewportProps']>) & { render?: RenderProp<'div'> };

export const ImageCropper = {
	Root,
	RootProvider,
	Image,
	Selection,
	Handle,
	Grid,
	Viewport,
	Context,
};
