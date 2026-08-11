import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useImageCropper } from '../components';
import {
	createApiContext,
	createItemContext,
	useExternalPartProps,
	usePartProps,
	useRootProps,
	useRootProviderProps,
	createRenderContent,
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
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function Image(props: ImageProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getImageProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<img {...mergedProps.value} />
	}
}
export function Selection(props: SelectionProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getSelectionProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function Handle(props: HandleProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getHandleProps',
			propKeys: [
				'position',
			],
		},
		props,
	);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function Grid(props: GridProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getGridProps',
			propKeys: [
				'axis',
			],
		},
		props,
	);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function Viewport(props: ViewportProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getViewportProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
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
