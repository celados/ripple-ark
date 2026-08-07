import {
	highlightWord,
	type HighlightChunk,
	type HighlightWordProps,
} from '@zag-js/highlight-word';

export type UseHighlightProps = HighlightWordProps;

export function useHighlight(props: UseHighlightProps): HighlightChunk[] {
	return highlightWord(props);
}

export type HighlightProps = UseHighlightProps & Omit<JSX.IntrinsicElements['mark'], 'children'>;

export function Highlight(props: HighlightProps) @{
	if (
		typeof props.text !== 'string'
	) throw new Error('[ripple-ark/highlight] text must be a string');
	const { query, text, ignoreCase, matchAll, exactMatch, ...localProps } = props;
	const chunks = useHighlight({ query, text, ignoreCase, matchAll, exactMatch });

	<>
		@for (const chunk of chunks) {
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
