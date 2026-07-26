#!/usr/bin/env node
/**
 * 生成物を作る:
 *   1. `labels.generated.ts` — content に実在するラベルのユニオン型 `Label`
 *   2. `document.generated.ts` — 文書全体（全 content / notes）を型として集約し、
 *      **文書横断の一意性をコンパイル時に主張する**モジュール
 *
 * なぜ 2 が要るか: 1 ファイル内の id・ラベルの重複は `defineBlocks` の型引数で落とせるが、
 * **ファイルを跨いだ重複**は、その 2 ファイルを同時に見る場所が無いと型で判定できない。
 * 全ファイルを import して 1 本のタプル型に連結する生成モジュールがその場所になる。
 *
 * 抽出はソースの構文解析ではなく、モジュールを実際に import して値を読む
 * （実行時の値そのものを正とするため）。
 *
 * 使い方:
 *   node tools/generate-index.ts          生成（書き込み）
 *   node tools/generate-index.ts --check  生成結果と現物が一致するかだけ検査（CI 用）
 */

import { readFileSync, writeFileSync } from "node:fs";
import { join } from "node:path";

import {
  contentDir,
  listSourceFiles,
  loadContentFiles,
  notesDir,
  structuredLatexDir,
} from "./content-modules.ts";

const labelsPath = join(structuredLatexDir, "labels.generated.ts");
const documentPath = join(structuredLatexDir, "document.generated.ts");
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
// 同じ検査は document.generated.ts 経由でコンパイル時にも行われるが、
// 生成物そのものが壊れるのを防ぐため、ここでも落とす。
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

const contentFiles = listSourceFiles(contentDir);
const noteFiles = listSourceFiles(notesDir);
if (contentFiles.length === 0) {
  throw new Error("content/ にソースが 1 件も無い");
}

const outputs: { path: string; rendered: string; what: string }[] = [
  { path: labelsPath, rendered: renderLabels(labels), what: `${labels.length} labels` },
  {
    path: documentPath,
    rendered: renderDocument(contentFiles, noteFiles),
    what: `${contentFiles.length} content + ${noteFiles.length} notes files`,
  },
];

if (checkOnly) {
  for (const output of outputs) {
    let current: string | null = null;
    try {
      current = readFileSync(output.path, "utf8");
    } catch {
      current = null;
    }
    if (current !== output.rendered) {
      throw new Error(
        `${output.path} が content/ notes/ の実状と一致していない。` +
          `\n  修正: (cd ${structuredLatexDir} && node tools/generate-index.ts)`,
      );
    }
  }
  console.log(`generated files are up to date (${outputs.map((o) => o.what).join(", ")})`);
} else {
  for (const output of outputs) {
    writeFileSync(output.path, output.rendered, "utf8");
  }
  console.log(`generated ${outputs.map((o) => `${o.path.split("/").pop()} (${o.what})`).join(", ")}`);
}

function renderLabels(sortedLabels: readonly string[]): string {
  const body = sortedLabels.map((label) => `  ${JSON.stringify(label)},`).join("\n");
  return `// 自動生成ファイル — 直接編集しない。
// 生成元: content/ の全ブロックの labels（tools/generate-index.ts）
// 再生成: node tools/generate-index.ts
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

/** import 識別子（ファイル名から作る。数字始まりを避ける）。 */
function identifierFor(prefix: string, fileName: string): string {
  return `${prefix}_${fileName.replace(/\.ts$/, "").replace(/[^A-Za-z0-9_]/g, "_")}`;
}

function renderDocument(content: readonly string[], notes: readonly string[]): string {
  const contentImports = content
    .map((file) => `import ${identifierFor("blocks", file)} from "./content/${file}";`)
    .join("\n");
  const noteImports = notes
    .map((file) => `import ${identifierFor("notes", file)} from "./notes/${file}";`)
    .join("\n");
  const contentSpread = content
    .map((file) => `  ...typeof ${identifierFor("blocks", file)},`)
    .join("\n");
  const noteSpread = notes.map((file) => `  ...typeof ${identifierFor("notes", file)},`).join("\n");

  return `// 自動生成ファイル — 直接編集しない。
// 生成元: content/ notes/ のファイル一覧（tools/generate-index.ts）
// 再生成: node tools/generate-index.ts
//
// 文書全体を 1 本のタプル型へ連結し、**ファイルを跨いだ一意性**をコンパイル時に主張する。
// 1 ファイル内の重複は defineBlocks / defineNotes の型引数が落とすが、ファイル間の重複は
// 両方を同時に見るこのモジュールでしか判定できない。実行時には誰も import しない
// （tsc の検査対象に入れるためだけに存在する）。

import type { Label } from "./labels.generated.ts";
import type {
  AssertNoDuplicate,
  BlockIdsOf,
  ConvertedBlock,
  FindDuplicate,
  LabelsOf,
  Note,
  NoteIdsOf,
} from "./schema.ts";
${contentImports}
${noteImports}

/** 文書順（ファイル名昇順 × 配列順）に連結した全ブロック。 */
export type AllBlocks = [
${contentSpread}
];

/** 全ノート。 */
export type AllNotes = [
${noteSpread}
];

type AllBlockIds = BlockIdsOf<AllBlocks>;
type AllNoteIds = NoteIdsOf<AllNotes>;
type AllLabels = LabelsOf<AllBlocks>;

/** 型が壊れていないことの確認（ここが落ちたら生成物か schema の不整合）。 */
export type _BlocksAreBlocks = AllBlocks extends readonly ConvertedBlock[] ? true : never;
export type _NotesAreNotes = AllNotes extends readonly Note[] ? true : never;

/** content が空でないこと（空なら「ブロック 0 件で検証通過」という無意味な状態になる）。 */
export type _ContentIsNotEmpty = AllBlocks extends readonly [] ? never : true;

/** ブロック id・ノート id・ラベルは文書全体で一意。重複するとその値が型エラーに出る。 */
export type _UniqueBlockIds = AssertNoDuplicate<FindDuplicate<AllBlockIds>>;
export type _UniqueNoteIds = AssertNoDuplicate<FindDuplicate<AllNoteIds>>;
export type _UniqueLabels = AssertNoDuplicate<FindDuplicate<AllLabels>>;

/** ノート id はブロック id とも衝突しない（アンカーが一意に決まらなくなるため）。 */
export type _NoIdCollision = AssertNoDuplicate<FindDuplicate<[...AllBlockIds, ...AllNoteIds]>>;

/** labels.generated.ts と content の実状が一致すること（両方向）。 */
export type _NoStaleGeneratedLabel = AssertNoDuplicate<Exclude<Label, AllLabels[number]>>;
export type _NoMissingGeneratedLabel = AssertNoDuplicate<Exclude<AllLabels[number], Label>>;
`;
}
