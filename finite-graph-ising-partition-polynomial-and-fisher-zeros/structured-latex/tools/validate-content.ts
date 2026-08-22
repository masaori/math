#!/usr/bin/env node
import { existsSync } from "node:fs";
import { join } from "node:path";

import { ALL_LABELS } from "../labels.generated.ts";
import { checkHabitation, HABITAT_VALUES, runtimeSchema } from "../schema.ts";
import type { Node, ValidationIssue } from "../schema.ts";
import { loadContentFiles, loadNoteFiles, structuredLatexDir } from "./content-modules.ts";

const schemaIssues: ValidationIssue[] = [];
const projectIssues: string[] = [];
const ids = new Set<string>();
const labels = new Set<string>();
const refs: { target: string; where: string }[] = [];
let blockCount = 0;

for (const { file, blocks } of await loadContentFiles()) {
  for (const block of blocks) {
    blockCount += 1;
    const parsed = runtimeSchema.validateBlock(block, file);
    if (!parsed.success) schemaIssues.push(...parsed.error);
    if (ids.has(block.id)) projectIssues.push(`${file}: block id ${block.id} が重複`);
    ids.add(block.id);
    for (const label of block.labels) {
      if (labels.has(label)) projectIssues.push(`${file}: label ${label} が重複`);
      labels.add(label);
    }
    if (block.kind === "heading" || block.kind === "figure") continue;
    projectIssues.push(...checkHabitation(block).map((message) => `${file}: ${message}`));
    const bodies = [block.statement, block.proof ?? []];
    for (const nodes of bodies) {
      scanNodes(nodes, `${file}:${block.id}`);
      if (HABITAT_VALUES.countable.has(block.habitat) && block.habitat !== "none") {
        const formulae: string[] = [];
        collectFormulae(nodes, formulae);
        const bad = formulae.find((formula) => /\\mathbb\{(R|C)\}/.test(formula));
        if (bad !== undefined) projectIssues.push(`${file}:${block.id}: 可算 habitat に R/C が現れる: ${bad}`);
      }
    }
    for (const path of block.verification ?? []) {
      if (!existsSync(join(structuredLatexDir, "..", path))) {
        projectIssues.push(`${file}:${block.id}: verification が存在しない: ${path}`);
      }
    }
  }
}

for (const { file, notes } of await loadNoteFiles()) {
  const parsed = runtimeSchema.validateNotes(notes, file);
  if (!parsed.success) schemaIssues.push(...parsed.error);
  for (const note of notes) {
    if (ids.has(note.id)) projectIssues.push(`${file}: note id ${note.id} が block id と衝突`);
    ids.add(note.id);
    for (const target of note.targets) refs.push({ target, where: `${file}:${note.id}.targets` });
    scanNodes(note.body, `${file}:${note.id}`);
  }
}

if (blockCount === 0) projectIssues.push("content が空である");
for (const ref of refs) if (!labels.has(ref.target)) projectIssues.push(`${ref.where}: 未解決参照 ${ref.target}`);
const generated = new Set<string>(ALL_LABELS);
for (const label of labels) if (!generated.has(label)) projectIssues.push(`生成ラベルに無い: ${label}`);
for (const label of generated) if (!labels.has(label)) projectIssues.push(`実在しない生成ラベル: ${label}`);

if (schemaIssues.length > 0 || projectIssues.length > 0) {
  for (const issue of schemaIssues) console.error(`${issue.path}: ${issue.message}`);
  for (const issue of projectIssues) console.error(issue);
  process.exit(1);
}

console.log(`validated ${blockCount} blocks, ${labels.size} labels, ${refs.length} refs`);

function scanNodes(nodes: readonly Node[], where: string): void {
  for (const node of nodes) {
    if (node.type === "ref") refs.push({ target: node.target, where });
    if (node.type === "paragraph") scanNodes(node.children, where);
    if (node.type === "list") node.items.forEach((item) => scanNodes(item, where));
  }
}

function collectFormulae(nodes: readonly Node[], output: string[]): void {
  for (const node of nodes) {
    if (node.type === "math" || node.type === "displayMath") output.push(node.tex);
    if (node.type === "paragraph") collectFormulae(node.children, output);
    if (node.type === "list") node.items.forEach((item) => collectFormulae(item, output));
  }
}
