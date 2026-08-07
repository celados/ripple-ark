import { DateFormatter } from '@internationalized/date';
import {
	createCollator,
	createFilter,
	isRTL,
	type FilterOptions,
	type Locale,
} from '@zag-js/i18n-utils';
import { Context, track, type Children, type Tracked } from 'ripple';

const context = new Context<Tracked<Locale> | null>(null);

export function useLocaleContext() {
	return context.get() ?? track<Locale>({ dir: 'ltr', locale: 'en-US' });
}

export type LocaleProviderProps = { locale: string; children?: Children | Children[] };

export function LocaleProvider(props: LocaleProviderProps) @{
	const locale = track((): Locale => {
		return { locale: props.locale, dir: isRTL(props.locale) ? 'rtl' : 'ltr' };
	});
	context.set(locale);
	<>
		{props.children}
	</>
}

export type UseCollatorProps = Intl.CollatorOptions & { locale?: string };
export function useCollator(props: UseCollatorProps = {}) {
	const environment = useLocaleContext();
	return track(() => {
		const { locale = environment.value.locale, ...options } = props;
		return createCollator(locale, options);
	});
}

export type UseDateFormatterProps = Intl.DateTimeFormatOptions & { locale?: string };
export function useDateFormatter(props: UseDateFormatterProps = {}) {
	const environment = useLocaleContext();
	return track(() => {
		const { locale = environment.value.locale, ...options } = props;
		return new DateFormatter(locale, options);
	});
}

export type UseFilterProps = FilterOptions;
export function useFilter(props: UseFilterProps) {
	const environment = useLocaleContext();
	return track(() => createFilter({ ...props, locale: props.locale ?? environment.value.locale }));
}
