import { readdirSync, readFileSync, writeFileSync } from 'node:fs';

const demoRoot = 'src/demos';
const sources = Object.fromEntries(
	readdirSync(demoRoot)
		.filter((file) => file.endsWith('.tsrx') && file !== 'index.tsrx')
		.sort()
		.map((file) => [file.slice(0, -'.tsrx'.length), readFileSync(`${demoRoot}/${file}`, 'utf8')])
);

writeFileSync(
	`${demoRoot}/sources.ts`,
	`// Generated from the packaged TSRX demos so documentation consumers do not keep shadow copies.\nexport const demoSources: Readonly<Record<string, string>> = ${JSON.stringify(sources, null, 2)};\n`
);

console.log(`Generated source text for ${Object.keys(sources).length} demos`);
