import { readdirSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath, pathToFileURL } from "node:url";

import { validateBlock } from "../schema.mjs";

const __dirname = dirname(fileURLToPath(import.meta.url));
const contentDir = join(__dirname, "..", "content");
const files = readdirSync(contentDir).filter((file) => file.endsWith(".mjs")).sort();

const ids = new Set();
const labels = new Map();
// ref 解決チェック用に、全ブロックの ref を一旦集約してから（ラベルは後続ファイルで
// 定義されうるため）全ラベル確定後に target を検証する。
const refs = [];
let blockCount = 0;
let headingCount = 0;

for (const file of files) {
  const mod = await import(pathToFileURL(join(contentDir, file)).href);
  const blocks = mod.default;
  if (!Array.isArray(blocks)) {
    throw new TypeError(`${file} default export must be an array`);
  }
  for (const block of blocks) {
    validateBlock(block);
    blockCount += 1;
    if (block.kind === "heading") headingCount += 1;
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
    collectRefTargets(block, file, refs);
  }
}

if (blockCount === 0) {
  throw new Error("no blocks found — check that content/*.mjs files export defineBlocks([...])");
}

// ref 解決チェック: ref.target は必ず定義済みラベルでなければならない
// （Typst の `<label>`↔`#ref(<label>)` に対応。未解決 ref は Typst の警告に相当）。
const unresolved = refs.filter((r) => !labels.has(r.target));
if (unresolved.length > 0) {
  const detail = unresolved
    .map((r) => `  ${r.file}:${r.blockId} -> ref target "${r.target}"`)
    .join("\n");
  throw new Error(
    `unresolved ref target(s) — target must be a defined label:\n${detail}`,
  );
}

console.log(
  `validated ${blockCount} blocks from ${files.length} files ` +
    `(${headingCount} headings, ${labels.size} labels, ${refs.length} refs, all resolved)`,
);

function scanForTypstMath(block, file) {
  const strings = [];
  // 見出しブロックは本文を持たないため statement は undefined になりうる。
  collectStrings(block.statement ?? [], strings);
  collectStrings(block.proof ?? [], strings);
  collectStrings(block.notes ?? [], strings);
  // タイトルの tex も KaTeX へ渡るので同じ規約で検査する。
  if (block.title !== null && block.title !== undefined && block.title.tex !== undefined) {
    strings.push(block.title.tex);
  }
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

function collectRefTargets(block, file, out) {
  walkRefs(block.statement ?? [], block.id, file, out);
  walkRefs(block.proof ?? [], block.id, file, out);
  walkRefs(block.notes ?? [], block.id, file, out);
}

function walkRefs(nodes, blockId, file, out) {
  for (const node of nodes) {
    if (node.type === "ref") out.push({ target: node.target, blockId, file });
    if (node.type === "paragraph") walkRefs(node.children, blockId, file, out);
    if (node.type === "list") node.items.forEach((item) => walkRefs(item, blockId, file, out));
  }
}
