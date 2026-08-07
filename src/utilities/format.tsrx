import { formatBytes, formatNumber, formatRelativeTime, formatTime } from '@zag-js/i18n-utils';

type LocaleProps = { locale?: string };

export type FormatByteProps =
	LocaleProps & {
		unit?: 'bit' | 'byte';
		unitDisplay?: 'long' | 'short' | 'narrow';
		unitSystem?: 'decimal' | 'binary';
		value: number;
	};

export function FormatByte(props: FormatByteProps) @{
	const { value, locale = 'en-US', ...options } = props;
	{
		formatBytes(value, locale, options);
	}
}

export type FormatNumberProps = LocaleProps & Intl.NumberFormatOptions & { value: number };

export function FormatNumber(props: FormatNumberProps) @{
	const { value, locale = 'en-US', ...options } = props;
	{
		formatNumber(value, locale, options);
	}
}

export type FormatRelativeTimeProps =
	LocaleProps & Intl.RelativeTimeFormatOptions & { value: Date };

export function FormatRelativeTime(props: FormatRelativeTimeProps) @{
	const { value, locale = 'en-US', ...options } = props;
	{
		formatRelativeTime(value, locale, options);
	}
}

export type FormatTimeProps =
	LocaleProps & Parameters<typeof formatTime>[2] & { value: string | Date };

export function FormatTime(props: FormatTimeProps) @{
	const { value, locale = 'en-US', ...options } = props;
	{
		formatTime(value, locale, options);
	}
}

export const Format = {
	Byte: FormatByte,
	Number: FormatNumber,
	RelativeTime: FormatRelativeTime,
	Time: FormatTime,
};
