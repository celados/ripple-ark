import {
	getInteractionModality,
	isFocusVisible,
	trackFocusVisible,
	trackInteractionModality,
	type Modality,
} from '@zag-js/focus-visible';
import { effect, track } from 'ripple';
import { useEnvironmentContext } from './environment.tsrx';

export type { Modality };
export type UseFocusVisibleProps = { isTextInput?: boolean; autoFocus?: boolean };

export function useFocusVisible(props: UseFocusVisibleProps = {}) {
	const environment = useEnvironmentContext();
	const visible = track(Boolean(props.autoFocus));
	effect(() =>
		trackFocusVisible({
			root: environment.value.getRootNode(),
			isTextInput: props.isTextInput,
			autoFocus: props.autoFocus,
			// This is Zag's subscription callback, not a JSX synthetic event.
			// eslint-disable-next-line ripple/prefer-oninput
			onChange: () => (visible.value = Boolean(props.autoFocus) || isFocusVisible()),
		})
	);
	return visible;
}

export function useInteractionModality() {
	const environment = useEnvironmentContext();
	const modality = track<Modality | null>(null);
	effect(() =>
		trackInteractionModality({
			root: environment.value.getRootNode(),
			// This is Zag's subscription callback, not a JSX synthetic event.
			// eslint-disable-next-line ripple/prefer-oninput
			onChange: () => (modality.value = getInteractionModality()),
		})
	);
	return modality;
}
