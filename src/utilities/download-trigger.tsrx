import { downloadFile, type FileMimeType } from '@zag-js/file-utils';
import type { Children } from 'ripple';

export type DownloadableData = string | Blob | File;

export type UseDownloadProps = {
	fileName: string;
	mimeType: FileMimeType;
	data: DownloadableData | (() => DownloadableData | Promise<DownloadableData>);
};

export function useDownload(props: UseDownloadProps) {
	return {
		async download() {
			const data =
				typeof props.data === 'function' ? await props.data() : props.data;
			downloadFile({ file: data, name: props.fileName, type: props.mimeType, win: window });
		},
	};
}

export type DownloadTriggerProps =
	Omit<JSX.IntrinsicElements['button'], 'children'> & UseDownloadProps & {
		children?: Children | Children[];
	};

export function DownloadTrigger(props: DownloadTriggerProps) @{
	const { fileName, mimeType, data, onClick, children, ...localProps } = props;
	const download = useDownload({ fileName, mimeType, data });
	const handleClick = (event: MouseEvent) => {
		if (typeof onClick === 'function') onClick(event as any);
		if (!event.defaultPrevented) void download.download();
	};

	<button {...localProps} type="button" onClick={handleClick}>{children}</button>
}
