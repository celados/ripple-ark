import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useProgress } from '../components';
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

type Hook = typeof useProgress;
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
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function CircleRange(props: CircleRangeProps) @{
	let &{ children } = props;
	<Part
		tag="circle"
		options={{ context, getter: 'getCircleRangeProps' }}
		of={props}
	>{children}</Part>
}
export function View(props: ViewProps) @{
	let &{ children } = props;
	<Part
		tag="span"
		options={{
			context,
			getter: 'getViewProps',
			propKeys: [
				'state',
			],
		}}
		of={props}
	>{children}</Part>
}
export function Range(props: RangeProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getRangeProps' }} of={props}>{children}</Part>
}
export function CircleTrack(props: CircleTrackProps) @{
	let &{ children } = props;
	<Part
		tag="circle"
		options={{ context, getter: 'getCircleTrackProps' }}
		of={props}
	>{children}</Part>
}
export function ValueText(props: ValueTextProps) @{
	let &{ children } = props;
	const api = context.get()!;
	<Part tag="span" options={{ context, getter: 'getValueTextProps' }} of={props}>
		{children || api.value.percentAsString}
	</Part>
}
export function Track(props: TrackProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getTrackProps' }} of={props}>{children}</Part>
}
export function Circle(props: CircleProps) @{
	let &{ children } = props;
	<Part tag="svg" options={{ context, getter: 'getCircleProps' }} of={props}>{children}</Part>
}
export function Label(props: LabelProps) @{
	let &{ children } = props;
	<Part tag="span" options={{ context, getter: 'getLabelProps' }} of={props}>{children}</Part>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps =
	ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]> & { render?: RenderProp<'div'> };
export type RootProviderProps =
	ArkPartProps<'div'> & { value: ReturnType<Hook> } & { render?: RenderProp<'div'> };
export type CircleRangeProps =
	(PartProps<'circle', Api['getCircleRangeProps']>) & { render?: RenderProp<'circle'> };
export type ViewProps = (PartProps<'span', Api['getViewProps']>) & { render?: RenderProp<'span'> };
export type RangeProps = (PartProps<'div', Api['getRangeProps']>) & { render?: RenderProp<'div'> };
export type CircleTrackProps =
	(PartProps<'circle', Api['getCircleTrackProps']>) & { render?: RenderProp<'circle'> };
export type ValueTextProps =
	(PartProps<'span', Api['getValueTextProps']>) & { render?: RenderProp<'span'> };
export type TrackProps = (PartProps<'div', Api['getTrackProps']>) & { render?: RenderProp<'div'> };
export type CircleProps =
	(PartProps<'svg', Api['getCircleProps']>) & { render?: RenderProp<'svg'> };
export type LabelProps =
	(PartProps<'span', Api['getLabelProps']>) & { render?: RenderProp<'span'> };

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
