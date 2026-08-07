import { useAvatar } from '../index.ts';

const name = 'John Doe';
const src = 'https://avatar.iran.liara.run/public/10';

export function Avatar() @{
	let api = useAvatar({
		id: 'avatar',
	});

	const initial = name.split(' ').map((s) => s[0]).join('');

	<>
		<div {...api.value.getRootProps()}>
			<div {...api.value.getFallbackProps()}>
				<div>{initial}</div>
			</div>
			<img alt={name} referrerPolicy="no-referrer" src={src} {...api.value.getImageProps()} />
		</div>
	</>
}
