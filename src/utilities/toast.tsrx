import * as toast from '@zag-js/toast';
import { Context as RippleContext, type Children } from 'ripple';
import { useToast, useToastGroup } from '../components';

export type CreateToasterProps = Partial<toast.StoreProps> & { placement: toast.Placement };
export type CreateToasterReturn<T = Children> = toast.Store<T>;
export type ToastOptions = toast.Options<Children>;

export const createToaster = <T = Children,>(props: CreateToasterProps): CreateToasterReturn<T> =>
	toast.createStore(props);

type ToastApi = ReturnType<typeof useToast>;
const context = /*#__PURE__*/ new RippleContext<ToastApi | null>(null);

type ToastActorProps = {
	value: ToastOptions;
	index: number;
	parent: ReturnType<typeof useToastGroup>['service'];
	render: (value: ToastOptions) => Children;
};

function ToastActor(props: ToastActorProps) @{
	const api = useToast({ ...props.value, index: props.index, parent: props.parent });
	context.set(api);
	const Content = () => props.render(props.value);
	<{Content} />
}

export type ToasterProps =
	Omit<JSX.IntrinsicElements['div'], 'children' | 'id'> & {
		id: string;
		toaster: CreateToasterReturn<any>;
		render: (value: ToastOptions) => Children;
	};

export function Toaster(props: ToasterProps) @{
	let &{ id, toaster, render, ...localProps } = props;
	const group = useToastGroup({ id, store: toaster });

	<div {...group.value.getGroupProps()} {...localProps}>
		@for (const item of group.value.getToasts(); index index; key item.id) {
			<ToastActor value={item} {index} parent={group.service} {render} />
		}
	</div>
}

function useToastContext(): ToastApi {
	const api = context.get();
	if (!api) throw new Error('Toast part must be rendered inside Toaster');
	return api;
}

export function ToastRoot(props: JSX.IntrinsicElements['div']) @{
	const api = useToastContext();
	<div {...api.value.getRootProps()} {...props}>
		<span {...api.value.getGhostBeforeProps()} />
		{props.children}
		<span {...api.value.getGhostAfterProps()} />
	</div>
}
export function ToastTitle(props: JSX.IntrinsicElements['div']) @{
	const api = useToastContext();
	<div {...api.value.getTitleProps()} {...props} />
}
export function ToastDescription(props: JSX.IntrinsicElements['div']) @{
	const api = useToastContext();
	<div {...api.value.getDescriptionProps()} {...props} />
}
export function ToastActionTrigger(props: JSX.IntrinsicElements['button']) @{
	const api = useToastContext();
	<button {...api.value.getActionTriggerProps()} {...props} />
}
export function ToastCloseTrigger(props: JSX.IntrinsicElements['button']) @{
	const api = useToastContext();
	<button {...api.value.getCloseTriggerProps()} {...props} />
}
export function ToastContext(props: { render: (api: ToastApi['value']) => Children }) @{
	const api = useToastContext();
	const Content = () => props.render(api.value);
	<{Content} />
}

export const Toast = {
	Root: ToastRoot,
	Title: ToastTitle,
	Description: ToastDescription,
	ActionTrigger: ToastActionTrigger,
	CloseTrigger: ToastCloseTrigger,
	Context: ToastContext,
};
