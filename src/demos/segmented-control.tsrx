import { useRadioGroup } from '../index.ts';

export function SegmentedControl() @{
	let api = useRadioGroup({
		id: 'segmented-control',
		defaultValue: 'ripplejs',
		orientation: 'horizontal',
	});

	<>
		<div {...api.value.getRootProps()}>
			<div {...api.value.getIndicatorProps()} />
			@for (const opt of items) {
				<label {...api.value.getItemProps({ value: opt.value })}>
					<span {...api.value.getItemTextProps({ value: opt.value })}>{opt.label}</span>
					<input {...api.value.getItemHiddenInputProps({ value: opt.value })} />
				</label>
			}
		</div>
	</>
}

const items = [
	{ value: 'react', label: 'React' },
	{ value: 'vue', label: 'Vue' },
	{ value: 'ripplejs', label: 'RippleJS' },
	{ value: 'svelte', label: 'Svelte' },
];
