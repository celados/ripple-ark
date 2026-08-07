import { useFileUpload } from '../index.ts';
import { LuX } from '../internal/lucide-icons.tsrx';

export function FileUpload() @{
	let api = useFileUpload({
		id: 'file-upload',
		accept: 'image/*',
	});

	<>
		<div {...api.value.getRootProps()}>
			<div {...api.value.getDropzoneProps()}>
				<input {...api.value.getHiddenInputProps()} />
				<span>Drag your files here</span>
				<button {...api.value.getTriggerProps()}>Open File Upload</button>
			</div>

			<div>
				@for (const file of api.value.acceptedFiles) {
					<div {...api.value.getItemProps({ file })}>
						<span {...api.value.getItemNameProps({ file })}>{file.name}</span>
						<span {...api.value.getItemSizeTextProps({ file })}>{api.value.getFileSize(file)}</span>
						<button {...api.value.getItemDeleteTriggerProps({ file })}>
							<LuX />
						</button>
					</div>
				}
			</div>
		</div>
	</>
}
