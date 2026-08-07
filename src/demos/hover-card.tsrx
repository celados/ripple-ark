import { useHoverCard } from '../index';
import { Portal } from 'ripple';

export function HoverCard() @{
	let api = useHoverCard({
		id: 'hover-card',
	});

	<>
		<a
			href="https://x.com/ripple__js"
			target="_blank"
			rel="noreferrer noopener"
			{...api.value.getTriggerProps()}
		>
			<img alt="Ripple JS" src="https://www.tsrxjs.com/favicon.svg" />
		</a>

		@if (api.value.open) {
			<Portal target={document.body}>
				<div {...api.value.getPositionerProps()}>
					<div {...api.value.getContentProps()}>
						<div {...api.value.getArrowProps()}>
							<div {...api.value.getArrowTipProps()} />
						</div>
						<div>
							<img alt="Ripple JS" src="https://www.tsrxjs.com/favicon.svg" />

							<div>
								<div>
									<p>Ripple JS</p>
									<p>ripple__js.value</p>
								</div>
								<p>
									<span>A framework that plays really nicely with TypeScript and JSX.</span>
									Learn more at
									<a href="https://www.tsrxjs.com" target="_blank" rel="noreferrer noopener">
										ripplejs.com
									</a>
								</p>
								<div>
									<div>
										<p>2</p>
										<p>Following</p>
									</div>
									<div>
										<p>4,000</p>
										<p>Followers</p>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</Portal>
		}
	</>
}
