import * as accordion from "@zag-js/accordion";
import * as angleSlider from "@zag-js/angle-slider";
import * as avatar from "@zag-js/avatar";
import * as carousel from "@zag-js/carousel";
import * as cascadeSelect from "@zag-js/cascade-select";
import * as checkbox from "@zag-js/checkbox";
import * as clipboard from "@zag-js/clipboard";
import * as collapsible from "@zag-js/collapsible";
import * as colorPicker from "@zag-js/color-picker";
import * as combobox from "@zag-js/combobox";
import * as dateInput from "@zag-js/date-input";
import * as datePicker from "@zag-js/date-picker";
import * as dialog from "@zag-js/dialog";
import * as drawer from "@zag-js/drawer";
import * as editable from "@zag-js/editable";
import * as fileUpload from "@zag-js/file-upload";
import * as floatingPanel from "@zag-js/floating-panel";
import * as hoverCard from "@zag-js/hover-card";
import * as imageCropper from "@zag-js/image-cropper";
import * as listbox from "@zag-js/listbox";
import * as marquee from "@zag-js/marquee";
import * as menu from "@zag-js/menu";
import * as navigationMenu from "@zag-js/navigation-menu";
import * as numberInput from "@zag-js/number-input";
import * as pagination from "@zag-js/pagination";
import * as passwordInput from "@zag-js/password-input";
import * as pinInput from "@zag-js/pin-input";
import * as popover from "@zag-js/popover";
import * as presence from "@zag-js/presence";
import * as progress from "@zag-js/progress";
import * as qrCode from "@zag-js/qr-code";
import * as radioGroup from "@zag-js/radio-group";
import * as ratingGroup from "@zag-js/rating-group";
import * as scrollArea from "@zag-js/scroll-area";
import * as select from "@zag-js/select";
import * as signaturePad from "@zag-js/signature-pad";
import * as slider from "@zag-js/slider";
import * as splitter from "@zag-js/splitter";
import * as steps from "@zag-js/steps";
import * as switchMachine from "@zag-js/switch";
import * as tabs from "@zag-js/tabs";
import * as tagsInput from "@zag-js/tags-input";
import * as timer from "@zag-js/timer";
import * as toast from "@zag-js/toast";
import * as toggle from "@zag-js/toggle";
import * as toggleGroup from "@zag-js/toggle-group";
import * as tooltip from "@zag-js/tooltip";
import * as tour from "@zag-js/tour";
import * as treeView from "@zag-js/tree-view";
import type { PropTypes } from "@celados/ripple-zag";
import {
  createMachineHook,
  type MachineHook,
  type MachineProps,
} from "./create-machine";

export type CascadeSelectApi = cascadeSelect.Api;
export type RatingGroupApi = ratingGroup.Api;

export const createCascadeSelectCollection = cascadeSelect.collection;
export const createComboboxCollection = combobox.collection;
export const createListboxCollection = listbox.collection;
export const createSelectCollection = select.collection;
export const createTreeCollection = treeView.collection;
export const imageCropperHandles = imageCropper.handles;
export const parseColor = colorPicker.parse;
export const parseTimerDuration = timer.parse;

export const useAccordion: MachineHook<
  MachineProps<accordion.Machine>,
  accordion.Api<PropTypes>,
  accordion.Service
> = createMachineHook(accordion.machine, accordion.connect);
export const useAngleSlider: MachineHook<
  MachineProps<angleSlider.Machine>,
  angleSlider.Api<PropTypes>,
  angleSlider.Service
> = createMachineHook(angleSlider.machine, angleSlider.connect);
export const useAvatar: MachineHook<
  MachineProps<avatar.Machine>,
  avatar.Api<PropTypes>,
  avatar.Service
> = createMachineHook(avatar.machine, avatar.connect);
export const useCarousel: MachineHook<
  MachineProps<carousel.Machine>,
  carousel.Api<PropTypes>,
  carousel.Service
> = createMachineHook(carousel.machine, carousel.connect);
export const useCascadeSelect: MachineHook<
  MachineProps<cascadeSelect.Machine>,
  cascadeSelect.Api<PropTypes>,
  cascadeSelect.Service
> = createMachineHook(cascadeSelect.machine, cascadeSelect.connect);
export const useCheckbox: MachineHook<
  MachineProps<checkbox.Machine>,
  checkbox.Api<PropTypes>,
  checkbox.Service
> = createMachineHook(checkbox.machine, checkbox.connect);
export const useClipboard: MachineHook<
  MachineProps<clipboard.Machine>,
  clipboard.Api<PropTypes>,
  clipboard.Service
> = createMachineHook(clipboard.machine, clipboard.connect);
export const useCollapsible: MachineHook<
  MachineProps<collapsible.Machine>,
  collapsible.Api<PropTypes>,
  collapsible.Service
> = createMachineHook(collapsible.machine, collapsible.connect);
export const useColorPicker: MachineHook<
  MachineProps<colorPicker.Machine>,
  colorPicker.Api<PropTypes>,
  colorPicker.Service
> = createMachineHook(colorPicker.machine, colorPicker.connect);
export const useCombobox: MachineHook<
  MachineProps<combobox.Machine>,
  combobox.Api<PropTypes>,
  combobox.Service
> = createMachineHook(combobox.machine, combobox.connect);
export const useDateInput: MachineHook<
  MachineProps<dateInput.Machine>,
  dateInput.Api<PropTypes>,
  dateInput.Service
> = createMachineHook(dateInput.machine, dateInput.connect);
export const useDatePicker: MachineHook<
  MachineProps<datePicker.Machine>,
  datePicker.Api<PropTypes>,
  datePicker.Service
> = createMachineHook(datePicker.machine, datePicker.connect);
export const useDialog: MachineHook<
  MachineProps<dialog.Machine>,
  dialog.Api<PropTypes>,
  dialog.Service
> = createMachineHook(dialog.machine, dialog.connect);
export const useDrawer: MachineHook<
  MachineProps<drawer.Machine>,
  drawer.Api<PropTypes>,
  drawer.Service
> = createMachineHook(drawer.machine, drawer.connect);
export const useEditable: MachineHook<
  MachineProps<editable.Machine>,
  editable.Api<PropTypes>,
  editable.Service
> = createMachineHook(editable.machine, editable.connect);
export const useFileUpload: MachineHook<
  MachineProps<fileUpload.Machine>,
  fileUpload.Api<PropTypes>,
  fileUpload.Service
> = createMachineHook(fileUpload.machine, fileUpload.connect);
export const useFloatingPanel: MachineHook<
  MachineProps<floatingPanel.Machine>,
  floatingPanel.Api<PropTypes>,
  floatingPanel.Service
> = createMachineHook(floatingPanel.machine, floatingPanel.connect);
export const useHoverCard: MachineHook<
  MachineProps<hoverCard.Machine>,
  hoverCard.Api<PropTypes>,
  hoverCard.Service
> = createMachineHook(hoverCard.machine, hoverCard.connect);
export const useImageCropper: MachineHook<
  MachineProps<imageCropper.Machine>,
  imageCropper.Api<PropTypes>,
  imageCropper.Service
> = createMachineHook(imageCropper.machine, imageCropper.connect);
export const useListbox: MachineHook<
  MachineProps<listbox.Machine>,
  listbox.Api<PropTypes>,
  listbox.Service
> = createMachineHook(listbox.machine, listbox.connect);
export const useMarquee: MachineHook<
  MachineProps<marquee.Machine>,
  marquee.Api<PropTypes>,
  marquee.Service
> = createMachineHook(marquee.machine, marquee.connect);
export const useMenu: MachineHook<
  MachineProps<menu.Machine>,
  menu.Api<PropTypes>,
  menu.Service
> = createMachineHook(menu.machine, menu.connect);
export const useNavigationMenu: MachineHook<
  MachineProps<navigationMenu.Machine>,
  navigationMenu.Api<PropTypes>,
  navigationMenu.Service
> = createMachineHook(navigationMenu.machine, navigationMenu.connect);
export const useNumberInput: MachineHook<
  MachineProps<numberInput.Machine>,
  numberInput.Api<PropTypes>,
  numberInput.Service
> = createMachineHook(numberInput.machine, numberInput.connect);
export const usePagination: MachineHook<
  MachineProps<pagination.Machine>,
  pagination.Api<PropTypes>,
  pagination.Service
> = createMachineHook(pagination.machine, pagination.connect);
export const usePasswordInput: MachineHook<
  MachineProps<passwordInput.Machine>,
  passwordInput.Api<PropTypes>,
  passwordInput.Service
> = createMachineHook(passwordInput.machine, passwordInput.connect);
export const usePinInput: MachineHook<
  MachineProps<pinInput.Machine>,
  pinInput.Api<PropTypes>,
  pinInput.Service
> = createMachineHook(pinInput.machine, pinInput.connect);
export const usePopover: MachineHook<
  MachineProps<popover.Machine>,
  popover.Api<PropTypes>,
  popover.Service
> = createMachineHook(popover.machine, popover.connect);
export const usePresence: MachineHook<
  MachineProps<presence.Machine>,
  presence.Api,
  presence.Service
> = createMachineHook(presence.machine, presence.connect);
export const useProgress: MachineHook<
  MachineProps<progress.Machine>,
  progress.Api<PropTypes>,
  progress.Service
> = createMachineHook(progress.machine, progress.connect);
export const useQrCode: MachineHook<
  MachineProps<qrCode.Machine>,
  qrCode.Api<PropTypes>,
  qrCode.Service
> = createMachineHook(qrCode.machine, qrCode.connect);
export const useRadioGroup: MachineHook<
  MachineProps<radioGroup.Machine>,
  radioGroup.Api<PropTypes>,
  radioGroup.Service
> = createMachineHook(radioGroup.machine, radioGroup.connect);
export const useRatingGroup: MachineHook<
  MachineProps<ratingGroup.Machine>,
  ratingGroup.Api<PropTypes>,
  ratingGroup.Service
> = createMachineHook(ratingGroup.machine, ratingGroup.connect);
export const useScrollArea: MachineHook<
  MachineProps<scrollArea.Machine>,
  scrollArea.Api<PropTypes>,
  scrollArea.Service
> = createMachineHook(scrollArea.machine, scrollArea.connect);
export const useSelect: MachineHook<
  MachineProps<select.Machine>,
  select.Api<PropTypes>,
  select.Service
> = createMachineHook(select.machine, select.connect);
export const useSignaturePad: MachineHook<
  MachineProps<signaturePad.Machine>,
  signaturePad.Api<PropTypes>,
  signaturePad.Service
> = createMachineHook(signaturePad.machine, signaturePad.connect);
export const useSlider: MachineHook<
  MachineProps<slider.Machine>,
  slider.Api<PropTypes>,
  slider.Service
> = createMachineHook(slider.machine, slider.connect);
export const useSplitter: MachineHook<
  MachineProps<splitter.Machine>,
  splitter.Api<PropTypes>,
  splitter.Service
> = createMachineHook(splitter.machine, splitter.connect);
export const useSteps: MachineHook<
  MachineProps<steps.Machine>,
  steps.Api<PropTypes>,
  steps.Service
> = createMachineHook(steps.machine, steps.connect);
export const useSwitch: MachineHook<
  MachineProps<switchMachine.Machine>,
  switchMachine.Api<PropTypes>,
  switchMachine.Service
> = createMachineHook(switchMachine.machine, switchMachine.connect);
export const useTabs: MachineHook<
  MachineProps<tabs.Machine>,
  tabs.Api<PropTypes>,
  tabs.Service
> = createMachineHook(tabs.machine, tabs.connect);
export const useTagsInput: MachineHook<
  MachineProps<tagsInput.Machine>,
  tagsInput.Api<PropTypes>,
  tagsInput.Service
> = createMachineHook(tagsInput.machine, tagsInput.connect);
export const useTimer: MachineHook<
  MachineProps<timer.Machine>,
  timer.Api<PropTypes>,
  timer.Service
> = createMachineHook(timer.machine, timer.connect);
export const createToaster = toast.createStore;
export const useToast: MachineHook<
  MachineProps<toast.Machine>,
  toast.Api<PropTypes>,
  toast.Service
> = createMachineHook(toast.machine, toast.connect);
export const useToastGroup: MachineHook<
  MachineProps<toast.GroupMachine>,
  toast.GroupApi<PropTypes>,
  toast.GroupService
> = createMachineHook(toast.group.machine, toast.group.connect);
export const useToggle: MachineHook<
  MachineProps<toggle.Machine>,
  toggle.Api<PropTypes>,
  toggle.Service
> = createMachineHook(toggle.machine, toggle.connect);
export const useToggleGroup: MachineHook<
  MachineProps<toggleGroup.Machine>,
  toggleGroup.Api<PropTypes>,
  toggleGroup.Service
> = createMachineHook(toggleGroup.machine, toggleGroup.connect);
export const useTooltip: MachineHook<
  MachineProps<tooltip.Machine>,
  tooltip.Api<PropTypes>,
  tooltip.Service
> = createMachineHook(tooltip.machine, tooltip.connect);
export const useTour: MachineHook<
  MachineProps<tour.Machine>,
  tour.Api<PropTypes>,
  tour.Service
> = createMachineHook(tour.machine, tour.connect);
export const useTreeView: MachineHook<
  MachineProps<treeView.Machine>,
  treeView.Api<PropTypes>,
  treeView.Service
> = createMachineHook(treeView.machine, treeView.connect);
