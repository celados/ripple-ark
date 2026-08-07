import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useImageCropper } from '../components';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useImageCropper;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export const Root = /*#__PURE__*/ createRoot({
	context,
	defaultTag: 'div',
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
});
export const RootProvider = /*#__PURE__*/ createRootProvider({ context, defaultTag: 'div' });
export const Image = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'img',
	getter: 'getImageProps',
});
export const Selection = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getSelectionProps',
});
export const Handle = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getHandleProps',
});
export const Grid = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getGridProps',
});
export const Viewport = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getViewportProps',
});

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type ImageProps = ArkPartProps;
export type SelectionProps = ArkPartProps;
export type HandleProps = ArkPartProps;
export type GridProps = ArkPartProps;
export type ViewportProps = ArkPartProps;

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
