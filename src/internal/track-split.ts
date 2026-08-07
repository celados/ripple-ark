import type { Tracked } from 'ripple';

export function trackSplit<T extends Record<string, any>, const K extends readonly (keyof T)[]>(
	props: T,
	keys: K
): { [I in keyof K]: Tracked<T[K[I]]> } {
	return keys.map((key) => ({
		get value() {
			return props[key];
		},
		set value(value) {
			props[key] = value;
		},
	})) as { [I in keyof K]: Tracked<T[K[I]]> };
}
