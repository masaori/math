import { readdirSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath, pathToFileURL } from "node:url";

import { validateBlock } from "../schema.mjs";

const __dirname = dirname(fileURLToPath(import.meta.url));
const contentDir = join(__dirname, "..", "content");
const files = readdirSync(contentDir).filter((file) => file.endsWith(".mjs")).sort();

const ids = new Set();
const labels = new Map();
let blockCount = 0;

for (const file of files) {
  const mod = await import(pathToFileURL(join(contentDir, file)).href);
  const blocks = mod.default;
  if (!Array.isArray(blocks)) {
    throw new TypeError(`${file} default export must be an array`);
  }
  for (const block of blocks) {
    validateBlock(block);
    blockCount += 1;
    if (ids.has(block.id)) {
      throw new Error(`duplicate block id: ${block.id}`);
    }
    ids.add(block.id);
    for (const label of block.labels) {
      if (labels.has(label)) {
        throw new Error(`duplicate label ${label}: ${labels.get(label)} and ${block.id}`);
      }
      labels.set(label, block.id);
    }
    scanForTypstMath(block, file);
  }
}

if (blockCount === 0) {
  throw new Error("no blocks found — check that content/*.mjs files export defineBlocks([...])");
}

console.log(`validated ${blockCount} blocks from ${files.length} files`);

function scanForTypstMath(block, file) {
  const strings = [];
  collectStrings(block.statement, strings);
  collectStrings(block.proof ?? [], strings);
  collectStrings(block.notes ?? [], strings);
  const suspicious = strings.filter((value) =>
    /(^|[^\\])\b(dot\.op|times\.o|arrow\.l\.r|eq\.not|sqrt\(|mat\(|cases\(|quad)\b/.test(
      value.replaceAll("\\quad", ""),
    ),
  );
  if (suspicious.length > 0) {
    throw new Error(
      `${file}:${block.id} has suspicious unconverted Typst math token: ${suspicious[0]}`,
    );
  }
}

function collectStrings(nodes, out) {
  for (const node of nodes) {
    if (node.type === "math" || node.type === "displayMath") out.push(node.tex);
    if (node.type === "paragraph") collectStrings(node.children, out);
    if (node.type === "list") node.items.forEach((item) => collectStrings(item, out));
  }
}
