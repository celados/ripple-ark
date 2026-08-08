import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useProgress } from '../components';
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

type Hook = typeof useProgress;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export function Root(props: RootProps) @{
	const children = props.children;
	const mergedProps = useRootProps(
		{
			context,
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
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function RootProvider(props: RootProviderProps) @{
	const children = props.children;
	const mergedProps = useRootProviderProps({ context }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function CircleRange(props: CircleRangeProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getCircleRangeProps' }, props);
	<circle {...mergedProps.value}>{children}</circle>
}
export function View(props: ViewProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getViewProps',
			propKeys: [
				'state',
			],
		},
		props,
	);
	<span {...mergedProps.value}>{children}</span>
}
export function Range(props: RangeProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getRangeProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function CircleTrack(props: CircleTrackProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getCircleTrackProps' }, props);
	<circle {...mergedProps.value}>{children}</circle>
}
export function ValueText(props: ValueTextProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getValueTextProps' }, props);
	<span {...mergedProps.value}>{children}</span>
}
export function Track(props: TrackProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getTrackProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Circle(props: CircleProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getCircleProps' }, props);
	<svg {...mergedProps.value}>{children}</svg>
}
export function Label(props: LabelProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getLabelProps' }, props);
	<span {...mergedProps.value}>{children}</span>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps<'div'> & { value: ReturnType<Hook> };
export type CircleRangeProps = PartProps<'circle', Api['getCircleRangeProps']>;
export type ViewProps = PartProps<'span', Api['getViewProps']>;
export type RangeProps = PartProps<'div', Api['getRangeProps']>;
export type CircleTrackProps = PartProps<'circle', Api['getCircleTrackProps']>;
export type ValueTextProps = PartProps<'span', Api['getValueTextProps']>;
export type TrackProps = PartProps<'div', Api['getTrackProps']>;
export type CircleProps = PartProps<'svg', Api['getCircleProps']>;
export type LabelProps = PartProps<'span', Api['getLabelProps']>;

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
