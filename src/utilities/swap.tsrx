import { Context as RippleContext, track, type Children, type DynamicElementType } from 'ripple';

export type UseSwapProps = { swap?: boolean };

export function useSwap(props: UseSwapProps = {}) {
	return track(() => ({ swap: props.swap ?? false }));
}

type SwapValue = ReturnType<typeof useSwap>;
const context = /*#__PURE__*/ new RippleContext<SwapValue | null>(null);

export type SwapRootProps =
	Omit<JSX.IntrinsicElements['span'], 'children'> & UseSwapProps & {
		as?: DynamicElementType;
		children?: Children | Children[];
	};

export function SwapRoot(props: SwapRootProps) @{
	let &{ as = 'span', swap: _swap, children, ...localProps } = props;
	const value = useSwap(props);
	context.set(value);
	<{as}
		{...localProps}
		data-scope="swap"
		data-part="root"
		data-swap={value.value.swap ? 'on' : 'off'}
		style={{ display: 'inline-grid', ...(localProps.style as object ?? {}) }}
	>{children}</{as}>
}

export type SwapRootProviderProps = Omit<SwapRootProps, keyof UseSwapProps> & { value: SwapValue };

export function SwapRootProvider(props: SwapRootProviderProps) @{
	let &{ as = 'span', value, children, ...localProps } = props;
	const api = track(() => value.value);
	context.set(api);
	<{as}
		{...localProps}
		data-scope="swap"
		data-part="root"
		data-swap={api.value.swap ? 'on' : 'off'}
	>{children}</{as}>
}

export type SwapIndicatorProps =
	Omit<JSX.IntrinsicElements['span'], 'children'> & {
		type: 'on' | 'off';
		children?: Children | Children[];
	};

export function SwapIndicator(props: SwapIndicatorProps) @{
	const value = context.get();
	if (!value) throw new Error('Swap.Indicator must be rendered inside Swap.Root');
	let &{ type, children, ...localProps } = props;
	const visible = track(() => type === 'on' ? value.value.swap : !value.value.swap);

	<>
		@if (visible.value) {
			<span
				{...localProps}
				data-scope="swap"
				data-part="indicator"
				data-type={type}
				style={{
					'grid-area': '1 / 1',
					display: 'inline-flex',
					...(localProps.style as object ?? {}),
				}}
			>{children}</span>
		}
	</>
}

export const Swap = { Root: SwapRoot, RootProvider: SwapRootProvider, Indicator: SwapIndicator };
