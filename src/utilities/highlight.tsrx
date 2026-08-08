import {
	highlightWord,
	type HighlightChunk,
	type HighlightWordProps,
} from '@zag-js/highlight-word';
import { track } from 'ripple';

export type UseHighlightProps = HighlightWordProps;

export function useHighlight(props: UseHighlightProps): HighlightChunk[] {
	return highlightWord(props);
}

export type HighlightProps = UseHighlightProps & Omit<JSX.IntrinsicElements['mark'], 'children'>;

export function Highlight(props: HighlightProps) @{
	if (
		typeof props.text !== 'string'
	) throw new Error('[ripple-ark/highlight] text must be a string');
	let &{ query, text, ignoreCase, matchAll, exactMatch, ...localProps } = props;
	const chunks = track(() => useHighlight({ query, text, ignoreCase, matchAll, exactMatch }));

	<>
		@for (const chunk of chunks.value) {
			@if (chunk.match) {
				<mark {...localProps}>{chunk.text}</mark>
			} @else {
				{
					chunk.text;
				}
			}
		}
	</>
}
