#!/usr/bin/env node
/**
 * `content/` に実在するラベルを集めて `labels.generated.ts` を生成する。
 *
 * これが「参照の誤りをコンパイル時に検出する」仕組みの土台である:
 *   - 生成されるのはラベル文字列のユニオン型 `Label`
 *   - `schema.ts` の `ref(target: Label)` とノートの `targets: [Label, ...]` が
 *     このユニオンしか受け付けないため、**存在しないラベルへの参照は tsc が落とす**
 *   - ブロックの `labels: readonly Label[]` も同じユニオンで縛るので、
 *     ラベルを増減したまま再生成を忘れると型検査が落ちる（生成物の陳腐化を検出できる）
 *
 * 抽出はソースの構文解析ではなく、モジュールを実際に import して `block.labels` を読む
 * （実行時の値そのものを正としたいため。`.mjs` と `.ts` のどちらでも同じ経路で読める）。
 *
 * 使い方:
 *   node tools/generate-labels.ts          生成（書き込み）
 *   node tools/generate-labels.ts --check  生成結果と現物が一致するかだけ検査（CI 用）
 */

import { readFileSync, writeFileSync } from "node:fs";
import { join } from "node:path";

import { loadContentFiles, structuredLatexDir } from "./content-modules.ts";

const outputPath = join(structuredLatexDir, "labels.generated.ts");
const checkOnly = process.argv.includes("--check");

type LabelOrigin = { label: string; blockId: string; file: string };

const origins: LabelOrigin[] = [];
for (const { file, blocks } of await loadContentFiles()) {
  for (const block of blocks) {
    for (const label of block.labels) {
      origins.push({ label, blockId: block.id, file });
    }
  }
}

// 重複ラベルは参照の一意解決を壊す（どのブロックを指すか決まらない）。
const seen = new Map<string, LabelOrigin>();
const duplicates: string[] = [];
for (const origin of origins) {
  const previous = seen.get(origin.label);
  if (previous !== undefined) {
    duplicates.push(
      `  ${origin.label}: ${previous.file}:${previous.blockId} と ${origin.file}:${origin.blockId}`,
    );
    continue;
  }
  seen.set(origin.label, origin);
}
if (duplicates.length > 0) {
  throw new Error(`duplicate label(s):\n${duplicates.join("\n")}`);
}

const labels = [...seen.keys()].sort();
if (labels.length === 0) {
  throw new Error(
    "content/ からラベルを 1 件も抽出できなかった（読み込み経路が壊れている可能性が高い）",
  );
}

const rendered = render(labels);

if (checkOnly) {
  let current: string | null = null;
  try {
    current = readFileSync(outputPath, "utf8");
  } catch {
    current = null;
  }
  if (current !== rendered) {
    throw new Error(
      `labels.generated.ts が content/ の実状と一致していない。` +
        `\n  修正: (cd ${structuredLatexDir} && node tools/generate-labels.ts)`,
    );
  }
  console.log(`labels.generated.ts is up to date (${labels.length} labels)`);
} else {
  writeFileSync(outputPath, rendered, "utf8");
  console.log(`generated labels.generated.ts (${labels.length} labels)`);
}

function render(sortedLabels: readonly string[]): string {
  const body = sortedLabels.map((label) => `  ${JSON.stringify(label)},`).join("\n");
  return `// 自動生成ファイル — 直接編集しない。
// 生成元: content/ の全ブロックの labels（tools/generate-labels.ts）
// 再生成: node tools/generate-labels.ts
//
// このユニオン型が「実在するラベル」の全体であり、ref() / notes の targets は
// これ以外を受け付けない。存在しないラベルへの参照はコンパイル時に落ちる。

export const ALL_LABELS = [
${body}
] as const;

/** content/ に実在するラベル。相互参照はこの型の値しか指せない。 */
export type Label = (typeof ALL_LABELS)[number];
`;
}
