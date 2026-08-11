import { useDialog, useDrawer, useNavigationMenu, useTabs } from '../../src/components';
import { Dialog } from '../../src/generated/dialog.tsrx';
import { Drawer } from '../../src/generated/drawer.tsrx';
import { NavigationMenu } from '../../src/generated/navigation-menu.tsrx';
import { Tabs } from '../../src/generated/tabs.tsrx';

export function OwnPresence(props: {
	onDialog: (api: ReturnType<typeof useDialog>) => void;
	onDrawer: (api: ReturnType<typeof useDrawer>) => void;
	onNavigation: (api: ReturnType<typeof useNavigationMenu>) => void;
	onTabs: (api: ReturnType<typeof useTabs>) => void;
	onDialogBackdropRef: (node: HTMLElement | null) => void;
}) @{
	const dialog = useDialog({});
	const drawer = useDrawer({});
	const navigation = useNavigationMenu({});
	const tabs = useTabs({ defaultValue: 'a' });
	props.onDialog(dialog);
	props.onDrawer(drawer);
	props.onNavigation(navigation);
	props.onTabs(tabs);
	<>
		<Dialog.RootProvider value={dialog} lazyMount>
			<Dialog.Backdrop
				ref={props.onDialogBackdropRef}
				render={(backdropProps) => <section {...backdropProps} data-testid="dialog-backdrop" />}
			/>
		</Dialog.RootProvider>
		<Drawer.RootProvider value={drawer} lazyMount>
			<Drawer.Backdrop data-testid="drawer-backdrop" />
		</Drawer.RootProvider>
		<NavigationMenu.RootProvider value={navigation} lazyMount>
			<NavigationMenu.Item value="home">
				<NavigationMenu.Trigger>Home</NavigationMenu.Trigger>
				<NavigationMenu.Content value="home" data-testid="navigation-content">
					Content
				</NavigationMenu.Content>
			</NavigationMenu.Item>
			<NavigationMenu.Indicator data-testid="navigation-indicator" />
			<NavigationMenu.ViewportPositioner>
				<NavigationMenu.Viewport data-testid="navigation-viewport" />
			</NavigationMenu.ViewportPositioner>
		</NavigationMenu.RootProvider>
		<Tabs.RootProvider value={tabs} lazyMount>
			<Tabs.Content value="a" data-testid="tab-a">A</Tabs.Content>
			<Tabs.Content value="b" data-testid="tab-b">B</Tabs.Content>
		</Tabs.RootProvider>
	</>
}
