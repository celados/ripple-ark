import { execFile } from 'node:child_process';
import { access, readFile } from 'node:fs/promises';
import { fileURLToPath } from 'node:url';
import { promisify } from 'node:util';

import { ripple } from '@ripple-ts/vite-plugin';
import { render } from 'ripple/server';
import { build, createServer } from 'vite';

const execFileAsync = promisify(execFile);
const root = new URL('../', import.meta.url);
const rootPath = fileURLToPath(root);
const consumerPath = fileURLToPath(
	new URL('../tests/fixtures/source-consumer.tsrx', import.meta.url)
);
const allComponentsPath = fileURLToPath(
	new URL('../tests/fixtures/all-components.ts', import.meta.url)
);
const packageJson = JSON.parse(await readFile(new URL('../package.json', import.meta.url), 'utf8'));

if (
	packageJson.name !== '@celados/ripple-ark' ||
	packageJson.publishConfig?.registry !== 'https://npm.celados.com' ||
	packageJson.publishConfig?.access !== 'public'
) {
	throw new Error('The package identity or private registry contract is invalid');
}

if (packageJson.files.includes('dist') || !packageJson.files.includes('src')) {
	throw new Error('The Ripple adapter must publish source and exclude dist');
}

for (const target of Object.values(packageJson.exports)) {
	if (typeof target !== 'string' || !target.startsWith('./')) continue;
	if (target.includes('*')) continue;
	await access(new URL(`..${target.slice(1)}`, import.meta.url));
}

const { stdout: packOutput } = await execFileAsync('pnpm', ['pack', '--dry-run', '--json'], {
	cwd: rootPath,
});
const packedPackage = JSON.parse(packOutput);
if (packedPackage.name !== packageJson.name || packedPackage.version !== packageJson.version) {
	throw new Error('The packed name or version differs from package.json');
}
const packedFiles = packedPackage.files.map((file) => file.path);
if (packedFiles.some((file) => file.startsWith('dist/'))) {
	throw new Error('The source package must not contain dist output');
}

const clientOutput = await build({
	build: {
		rollupOptions: {
			external: [/^@zag-js\//, '@celados/ripple-zag', 'ripple', 'ripple/internal/client'],
			input: [consumerPath, allComponentsPath],
		},
		write: false,
	},
	configFile: false,
	logLevel: 'silent',
	plugins: ripple({ excludeRippleExternalModules: true }),
	root: rootPath,
});
const outputs = Array.isArray(clientOutput) ? clientOutput : [clientOutput];
const clientCode = outputs
	.flatMap((output) => output.output)
	.filter((output) => output.type === 'chunk')
	.map((output) => output.code)
	.join('\n');
if (!clientCode.includes('ripple/internal/client')) {
	throw new Error('The clean source consumer was not compiled by the Ripple client transform');
}

const server = await createServer({
	configFile: false,
	logLevel: 'silent',
	plugins: ripple({ excludeRippleExternalModules: true }),
	root: rootPath,
	server: { middlewareMode: true },
});

try {
	const consumer = await server.ssrLoadModule('/tests/fixtures/source-consumer.tsrx');
	const result = await render(consumer.SourceConsumer);
	if (!result.body.includes('data-scope="accordion"') || !result.body.includes('First content')) {
		throw new Error(
			'The Ripple adapter did not render machine props and nested content during SSR'
		);
	}
} finally {
	await server.close();
}

console.log(`Verified ${packageJson.name}@${packageJson.version} as a Ripple source package`);
