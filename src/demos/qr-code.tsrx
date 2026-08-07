import { useQrCode } from '../index';

export function QrCode() @{
	let api = useQrCode({
		id: 'qr-code',
		value: 'https://www.tsrxjs.com',
		encoding: { ecc: 'H' },
	});

	<>
		<div {...api.value.getRootProps()}>
			<svg {...api.value.getFrameProps()}>
				<path {...api.value.getPatternProps()} />
			</svg>
			<div {...api.value.getOverlayProps()}>
				<img src="https://www.tsrxjs.com/favicon.svg" alt="" />
			</div>
		</div>
	</>
}
