#!/usr/bin/env node
import toolkit from "../content/mathematical-toolkit.ts";
import semantics from "../content/three-dimensional-ising-semantics.ts";
import type { Node } from "../schema.ts";

const blocks = [...toolkit, ...semantics];
const toolkitLabels = new Set<string>(toolkit.flatMap((block) => [...block.labels]));
const chapters = blocks.filter((block) => block.kind === "heading" && block.level === 1);
if (chapters.length !== 2) throw new Error(`第一階層の章が二つではない: ${chapters.length}`);
if (chapters[0]?.title.text !== "数学的道具立て") throw new Error("第一章が数学的道具立てではない");
if (chapters[1]?.title.text !== "3次元Isingモデルのセマンティクスを持つもの") {
  throw new Error("第二章が3次元Isingモデルの意味論ではない");
}

let chapter = "";
const chapterByLabel = new Map<string, string>();
const positionByLabel = new Map<string, number>();
const refsByLabel = new Map<string, Set<string>>();
const forbiddenToolkitTerms = /Ising|Fisher|スピン|破れ辺|有限箱|箱サイズ|分配多項式|模型|極限/;

function collect(nodes: readonly Node[], refs: Set<string>, text: string[]): void {
  for (const node of nodes) {
    if (node.type === "ref") refs.add(node.target);
    if (node.type === "text") text.push(node.value);
    if (node.type === "math" || node.type === "displayMath") text.push(node.tex);
    if (node.type === "paragraph") collect(node.children, refs, text);
    if (node.type === "list") node.items.forEach((item) => collect(item, refs, text));
  }
}

for (const [index, block] of blocks.entries()) {
  if (block.kind === "heading" && block.level === 1) chapter = block.title.text;
  if (block.kind === "heading" && block.level === 2) {
    const guide = blocks[index + 1];
    if (guide?.kind !== "remark") throw new Error(`節「${block.title.text}」の直後に入出力案内がない`);
    const guideText: string[] = [];
    collect(guide.statement, new Set(), guideText);
    const joined = guideText.join("");
    for (const marker of ["入力:", "出力:", "主定理・主張:"]) {
      if (!joined.includes(marker)) throw new Error(`節「${block.title.text}」の案内に ${marker} がない`);
    }
  }
  if (block.kind === "heading" || block.labels.length === 0) continue;
  const refs = new Set<string>();
  const text: string[] = [block.title?.text ?? ""];
  collect(block.statement, refs, text);
  if ("proof" in block) collect(block.proof ?? [], refs, text);
  for (const match of text.join("").matchAll(/\\blkref\{([^}]+)\}/g)) {
    if (match[1] !== undefined) refs.add(match[1]);
  }
  for (const label of block.labels) {
    if (chapterByLabel.has(label)) throw new Error(`分類が重複している: ${label}`);
    chapterByLabel.set(label, chapter);
    positionByLabel.set(label, index);
    refsByLabel.set(label, refs);
    const inToolkit = chapter === "数学的道具立て";
    if (inToolkit !== toolkitLabels.has(label)) throw new Error(`章境界が不一致: ${label}`);
    if (inToolkit && forbiddenToolkitTerms.test(text.join(""))) {
      throw new Error(`数学的道具立てへ3次元Ising固有意味論が混入: ${label}`);
    }
  }
}

if (toolkitLabels.size !== 11) throw new Error(`道具章が11ラベルではない: ${toolkitLabels.size}`);
if (chapterByLabel.size !== 176) throw new Error(`分類された数学ラベルが176個ではない: ${chapterByLabel.size}`);
for (const [label, refs] of refsByLabel) {
  for (const target of refs) {
    const targetPosition = positionByLabel.get(target);
    if (targetPosition === undefined) throw new Error(`未分類の参照先: ${label} -> ${target}`);
    if (targetPosition >= positionByLabel.get(label)!) throw new Error(`依存順序が逆転: ${label} -> ${target}`);
    if (toolkitLabels.has(label) && !toolkitLabels.has(target)) {
      throw new Error(`道具から3次元Ising意味論への依存: ${label} -> ${target}`);
    }
  }
}

console.log("verified chapter organization: 2 chapters, toolkit=11, semantics=165, guides and dependency order");
