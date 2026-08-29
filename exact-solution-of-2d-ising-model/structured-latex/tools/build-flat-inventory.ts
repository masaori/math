import { mkdirSync, writeFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

import { loadContentFiles } from "./content-modules.ts";

const projectDir = join(dirname(fileURLToPath(import.meta.url)), "..", "..");
const outputPath = join(projectDir, "docs", "organization", "flat-inventory.json");
const mathematicalToolFiles = new Set([
  "000_calculation_formulae_00_09.ts",
  "000_calculation_formulae_10_19.ts",
  "000_calculation_formulae_20_29.ts",
  "000_calculation_formulae_30_44.ts",
  "000_calculation_formulae_45_46.ts",
  "002_linear_space_general.ts",
  "003_exp_linear_map.ts",
  "005_exp_conjugation_proof.ts",
]);

function collectTargets(value: unknown, targets = new Set<string>()): Set<string> {
  if (Array.isArray(value)) {
    for (const item of value) collectTargets(item, targets);
  } else if (value !== null && typeof value === "object") {
    const record = value as Record<string, unknown>;
    if (record.type === "ref" && typeof record.target === "string") targets.add(record.target);
    for (const child of Object.values(record)) collectTargets(child, targets);
  }
  return targets;
}

function blockTitle(block: object): string | null {
  if (!("title" in block) || block.title === null || typeof block.title !== "object") return null;
  if ("text" in block.title && typeof block.title.text === "string") return block.title.text;
  if ("tex" in block.title && typeof block.title.tex === "string") return block.title.tex;
  return null;
}

const files = await loadContentFiles();
const allBlocks = files.flatMap(({ file, blocks }) => blocks.map((block) => ({ file, block })));
const incomingReferenceCount = new Map<string, number>();
for (const { block } of allBlocks) {
  for (const target of collectTargets(block)) {
    incomingReferenceCount.set(target, (incomingReferenceCount.get(target) ?? 0) + 1);
  }
}
const isingSemanticPattern = /Ising|イジング|spin|スピン|lattice|格子|transfer|転送|sector|セクター|momentum|運動量|fermion|フェルミオン/i;
const entries = files.flatMap(({ file, blocks }) =>
  blocks
    .filter(({ kind }) => kind === "definition" || kind === "claim" || kind === "theorem")
    .map((block) => {
      const semanticBlock = block as unknown as Record<string, unknown>;
      const serialized = JSON.stringify({
        title: semanticBlock.title,
        statement: semanticBlock.statement,
        proof: semanticBlock.proof,
      });
      const reuseCount = block.labels.reduce(
        (sum, label) => sum + (incomingReferenceCount.get(label) ?? 0),
        0,
      );
      const isingSemanticMatches = [...new Set(serialized.match(isingSemanticPattern) ?? [])].sort();
      const mathematicalTool = mathematicalToolFiles.has(file) && reuseCount >= 2 && isingSemanticMatches.length === 0;
      return {
        id: block.id,
        kind: block.kind,
        title: blockTitle(block),
        labels: block.labels,
        sourceFile: file,
        sourceOrdinal: block.origin?.ordinal ?? null,
        provisionalFinalChapter: mathematicalTool ? "数学的道具立て" : "2次元イジングモデル",
        classificationEvidence: {
          mathematicalToolCandidateFile: mathematicalToolFiles.has(file),
          incomingReferenceCount: reuseCount,
          isingSemanticMatches,
          rule: "道具候補ファイルかつ参照利用が2件以上かつイジング固有語彙なし",
        },
        dependsOnLabels: [...collectTargets(block)].sort(),
      };
    }),
);

const labelOwners = new Map<string, string>();
for (const { blocks } of files) {
  for (const block of blocks) for (const label of block.labels) labelOwners.set(label, block.id);
}
const allDependencyLabels = allBlocks.flatMap(({ block }) => [...collectTargets(block)]);
const unresolvedInventoryDependencies = [...new Set(allDependencyLabels)]
  .filter((label) => !labelOwners.has(label))
  .sort();
const dependencySupportNodes = allBlocks
  .filter(({ block }) => !entries.some(({ id }) => id === block.id))
  .map(({ file, block }) => ({
    id: block.id,
    kind: block.kind,
    title: blockTitle(block),
    labels: block.labels,
    sourceFile: file,
    dependsOnLabels: [...collectTargets(block)].sort(),
  }));

const inventory = {
  schemaVersion: 1,
  scope: "exact-solution-of-2d-ising-model/structured-latex/content の definition・claim・theorem",
  finalChapters: ["数学的道具立て", "2次元イジングモデル"],
  classificationStatus: "初回のブロック単位仮分類。分類根拠を各項目へ保存し、境界レビューを継続する。",
  entryCount: entries.length,
  dependencySupportNodeCount: dependencySupportNodes.length,
  unnamedEntryIds: entries.filter(({ title }) => title === null).map(({ id }) => id),
  unlabeledEntryIds: entries.filter(({ labels }) => labels.length === 0).map(({ id }) => id),
  unresolvedInventoryDependencies,
  entries,
  dependencySupportNodes,
};

mkdirSync(dirname(outputPath), { recursive: true });
writeFileSync(outputPath, `${JSON.stringify(inventory, null, 2)}\n`);
console.log(`wrote ${entries.length} entries to ${outputPath}`);
