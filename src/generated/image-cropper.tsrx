import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useImageCropper } from '../components';
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
	<div {...mergedProps.value}>{children}</div>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Image(props: ImageProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getImageProps' }, props);
	<img {...mergedProps.value} />
}
export function Selection(props: SelectionProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getSelectionProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Handle(props: HandleProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getHandleProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Grid(props: GridProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getGridProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Viewport(props: ViewportProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getViewportProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps<'div'> & { value: ReturnType<Hook> };
export type ImageProps = PartProps<'img', Api['getImageProps']>;
export type SelectionProps = PartProps<'div', Api['getSelectionProps']>;
export type HandleProps = PartProps<'div', Api['getHandleProps']>;
export type GridProps = PartProps<'div', Api['getGridProps']>;
export type ViewportProps = PartProps<'div', Api['getViewportProps']>;

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
