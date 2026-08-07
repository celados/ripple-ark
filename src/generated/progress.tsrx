import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useProgress } from '../components';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useProgress;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = new RippleContext<Tracked<Api> | null>(null);

export const Root = createRoot({
	context,
	defaultTag: 'div',
	configKeys: [
		'defaultValue',
		'formatOptions',
		'id',
		'ids',
		'locale',
		'max',
		'min',
		'onValueChange',
		'orientation',
		'translations',
		'value',
	],

	useMachine: useProgress as any,
});
export const RootProvider = createRootProvider({ context, defaultTag: 'div' });
export const CircleRange = createPart({
	context,
	defaultTag: 'circle',
	getter: 'getCircleRangeProps',
});
export const View = createPart({
	context,
	defaultTag: 'span',
	getter: 'getViewProps',
	propKeys: [
		'state',
	],
});
export const Range = createPart({ context, defaultTag: 'div', getter: 'getRangeProps' });
export const CircleTrack = createPart({
	context,
	defaultTag: 'circle',
	getter: 'getCircleTrackProps',
});
export const ValueText = createPart({ context, defaultTag: 'span', getter: 'getValueTextProps' });
export const Track = createPart({ context, defaultTag: 'div', getter: 'getTrackProps' });
export const Circle = createPart({ context, defaultTag: 'svg', getter: 'getCircleProps' });
export const Label = createPart({ context, defaultTag: 'span', getter: 'getLabelProps' });

export const Context = createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type CircleRangeProps = ArkPartProps;
export type ViewProps = ArkPartProps;
export type RangeProps = ArkPartProps;
export type CircleTrackProps = ArkPartProps;
export type ValueTextProps = ArkPartProps;
export type TrackProps = ArkPartProps;
export type CircleProps = ArkPartProps;
export type LabelProps = ArkPartProps;

export const Progress = {
	Root,
	RootProvider,
	CircleRange,
	View,
	Range,
	CircleTrack,
	ValueText,
	Track,
	Circle,
	Label,
	Context,
};
