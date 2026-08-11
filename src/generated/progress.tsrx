import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useProgress } from '../components';
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
export function CircleRange(props: CircleRangeProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getCircleRangeProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<circle {...mergedProps.value}>{children}</circle>
	}
}
export function View(props: ViewProps) @{
	let &{ children } = props;
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
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<span {...mergedProps.value}>{children}</span>
	}
}
export function Range(props: RangeProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getRangeProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function CircleTrack(props: CircleTrackProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getCircleTrackProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<circle {...mergedProps.value}>{children}</circle>
	}
}
export function ValueText(props: ValueTextProps) @{
	let &{ children } = props;
	const api = context.get()!;
	const mergedProps = usePartProps({ context, getter: 'getValueTextProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<span {...mergedProps.value}>{children || api.value.percentAsString}</span>
	}
}
export function Track(props: TrackProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getTrackProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function Circle(props: CircleProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getCircleProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<svg {...mergedProps.value}>{children}</svg>
	}
}
export function Label(props: LabelProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getLabelProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<span {...mergedProps.value}>{children}</span>
	}
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
