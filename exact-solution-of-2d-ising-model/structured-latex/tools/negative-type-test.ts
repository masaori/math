#!/usr/bin/env node
/**
 * 「誤った入力を書くと型検査が落ちる」ことの実証テスト。
 *
 * `type-tests/label-typing.test-d.ts` は `@ts-expect-error` による回帰テストで、通常の
 * `tsc` に同乗して回る。こちらは**実際に tsc を落として、その診断メッセージを見せる**ためのテスト。
 * 「型検査は通っているが、実は何も検出していない」状態を否定する
 * （実際、集約モジュールを tsconfig の include に入れ忘れて検査が無効化されていた事故がある）。
 *
 * 各ケースは対で回す:
 *   1. 正しい版を書いて tsc → **成功すること**（設定不備で常に落ちているだけではないことの対照）
 *   2. 壊した版を書いて tsc → **失敗し**、診断に期待する語が現れること
 *
 * 使い方: node tools/negative-type-test.ts
 */

import { spawnSync } from "node:child_process";
import { mkdirSync, rmSync, writeFileSync } from "node:fs";
import { join } from "node:path";

import { ALL_LABELS } from "../labels.generated.ts";
import { structuredLatexDir } from "./content-modules.ts";

const tmpDir = join(structuredLatexDir, "type-tests", ".tmp");
const tsc = join(structuredLatexDir, "node_modules", ".bin", "tsc");

const realLabel = ALL_LABELS[0];
const otherLabel = ALL_LABELS[1];
if (realLabel === undefined || otherLabel === undefined) {
  throw new Error("labels.generated.ts が空（先に node tools/generate-index.ts を回す）");
}
const brokenLabel = `${realLabel}__does_not_exist`;

type Case = {
  name: string;
  /** `broken` が true のときだけ誤りを含むファイル群を返す。 */
  files: (broken: boolean) => Record<string, string>;
  /** 壊した版の診断に必ず現れるべき文字列。 */
  expect: string;
};

/** 1 ブロック分のリテラル（差し込み用）。 */
const block = (options: {
  id: string;
  labels?: readonly string[];
  statement?: string;
  extra?: string;
}): string => `  {
    id: ${JSON.stringify(options.id)},
    kind: "claim",
    sourcePath: "type-tests/.tmp",
    sourceOrdinal: 1,
    labels: [${(options.labels ?? []).map((label) => JSON.stringify(label)).join(", ")}],
    statement: [${options.statement ?? ""}],${options.extra ?? ""}
  },`;

const blocksModule = (body: string, imports = "defineBlocks, paragraph, ref"): string =>
  `import { ${imports} } from "../../schema.ts";

export default defineBlocks([
${body}
]);
`;

const noteModule = (body: string): string =>
  `import { defineNotes, paragraph } from "../../schema.ts";

void paragraph;

export default defineNotes([
${body}
]);
`;

/** 複数ファイルを跨いだ検査（document.generated.ts と同じ形の集約モジュール）。 */
const aggregatorModule = (): string => `import type {
  AssertNoDuplicate,
  BlockIdsOf,
  FindDuplicate,
  LabelsOf,
  NoteIdsOf,
} from "../../schema.ts";
import blocksA from "./a.ts";
import blocksB from "./b.ts";
import notesC from "./c.ts";

type AllBlocks = [...typeof blocksA, ...typeof blocksB];
type AllNotes = [...typeof notesC];
type AllBlockIds = BlockIdsOf<AllBlocks>;
type AllNoteIds = NoteIdsOf<AllNotes>;

export type _UniqueBlockIds = AssertNoDuplicate<FindDuplicate<AllBlockIds>>;
export type _UniqueLabels = AssertNoDuplicate<FindDuplicate<LabelsOf<AllBlocks>>>;
export type _UniqueNoteIds = AssertNoDuplicate<FindDuplicate<AllNoteIds>>;
export type _NoIdCollision = AssertNoDuplicate<FindDuplicate<[...AllBlockIds, ...AllNoteIds]>>;
`;

/** 集約ケース用の、誤りを含まない相棒ファイル。 */
const companionNote = (id: string): string => `  {
    id: ${JSON.stringify(id)},
    targets: [${JSON.stringify(realLabel)}],
    body: [],
  },`;

const cases: Case[] = [
  {
    name: "本文中の ref が存在しないラベルを指す",
    expect: brokenLabel,
    files: (broken) => ({
      "fixture.ts": blocksModule(
        block({
          id: "neg_ref",
          statement: `paragraph(["参照: ", ref(${JSON.stringify(broken ? brokenLabel : realLabel)})])`,
        }),
      ),
    }),
  },
  {
    name: "ノートの targets が存在しないラベルを指す",
    expect: brokenLabel,
    files: (broken) => ({
      "fixture.ts": noteModule(`  {
    id: "note_neg_target",
    targets: [${JSON.stringify(broken ? brokenLabel : realLabel)}],
    body: [paragraph(["参照用ノート"])],
  },`),
    }),
  },
  {
    name: "ブロックが未登録のラベルを宣言する（生成物の再生成漏れ）",
    expect: brokenLabel,
    files: (broken) => ({
      "fixture.ts": blocksModule(
        block({ id: "neg_label", labels: [broken ? brokenLabel : realLabel] }),
        "defineBlocks",
      ),
    }),
  },
  {
    name: "同一ファイル内でブロック id が重複する",
    expect: "__ブロックidが重複している",
    files: (broken) => ({
      "fixture.ts": blocksModule(
        `${block({ id: "neg_dup_a" })}\n${block({ id: broken ? "neg_dup_a" : "neg_dup_b" })}`,
        "defineBlocks",
      ),
    }),
  },
  {
    name: "同一ファイル内でラベルが重複する",
    expect: "__ラベルが重複している",
    files: (broken) => ({
      "fixture.ts": blocksModule(
        `${block({ id: "neg_lbl_a", labels: [realLabel] })}\n${block({
          id: "neg_lbl_b",
          labels: [broken ? realLabel : otherLabel],
        })}`,
        "defineBlocks",
      ),
    }),
  },
  {
    name: "同一ファイル内でノート id が重複する",
    expect: "__ノートidが重複している",
    files: (broken) => ({
      "fixture.ts": noteModule(`${companionNote("note_neg_dup_a")}
  {
    id: ${JSON.stringify(broken ? "note_neg_dup_a" : "note_neg_dup_b")},
    targets: [${JSON.stringify(realLabel)}],
    body: [],
  },`),
    }),
  },
  {
    name: "ファイルを跨いでブロック id が重複する",
    expect: "does not satisfy the constraint 'never'",
    files: (broken) => ({
      "a.ts": blocksModule(block({ id: "neg_cross_a" }), "defineBlocks"),
      "b.ts": blocksModule(block({ id: broken ? "neg_cross_a" : "neg_cross_b" }), "defineBlocks"),
      "c.ts": noteModule(companionNote("note_neg_cross")),
      "fixture.ts": aggregatorModule(),
    }),
  },
  {
    name: "ファイルを跨いでラベルが重複する",
    expect: "does not satisfy the constraint 'never'",
    files: (broken) => ({
      "a.ts": blocksModule(block({ id: "neg_lc_a", labels: [realLabel] }), "defineBlocks"),
      "b.ts": blocksModule(
        block({ id: "neg_lc_b", labels: [broken ? realLabel : otherLabel] }),
        "defineBlocks",
      ),
      "c.ts": noteModule(companionNote("note_neg_lc")),
      "fixture.ts": aggregatorModule(),
    }),
  },
  {
    name: "ノート id がブロック id と衝突する",
    expect: "does not satisfy the constraint 'never'",
    files: (broken) => ({
      "a.ts": blocksModule(block({ id: "neg_collide_block" }), "defineBlocks"),
      "b.ts": blocksModule(block({ id: "neg_collide_other" }), "defineBlocks"),
      "c.ts": noteModule(companionNote(broken ? "neg_collide_block" : "note_neg_collide")),
      "fixture.ts": aggregatorModule(),
    }),
  },
  {
    name: "見出しブロックが本文を持つ",
    expect: "statement",
    files: (broken) => ({
      "fixture.ts": `import { defineBlocks, paragraph } from "../../schema.ts";

void paragraph;

export default defineBlocks([
  {
    id: "neg_heading",
    kind: "heading",
    level: 2,
    sourcePath: "type-tests/.tmp",
    sourceOrdinal: 1,
    title: { text: "見出し" },
    labels: [],${broken ? '\n    statement: [paragraph(["本文"])],' : ""}
  },
]);
`,
    }),
  },
  {
    name: "定理型ブロックが見出し専用の level を持つ",
    expect: "not assignable to type 'HeadingLevel | undefined'",
    files: (broken) => ({
      "fixture.ts": blocksModule(
        block({ id: "neg_level", extra: broken ? "\n    level: 2," : "" }),
        "defineBlocks",
      ),
    }),
  },
  {
    name: "見出しの level が 1〜6 の範囲外",
    expect: "Type '7' is not assignable",
    files: (broken) => ({
      "fixture.ts": `import { defineBlocks } from "../../schema.ts";

export default defineBlocks([
  {
    id: "neg_level_range",
    kind: "heading",
    level: ${broken ? 7 : 2},
    sourcePath: "type-tests/.tmp",
    sourceOrdinal: 1,
    title: { text: "見出し" },
    labels: [],
  },
]);
`,
    }),
  },
  {
    name: "タイトルが text も tex も持たない",
    expect: "Type '{}' is not assignable",
    files: (broken) => ({
      "fixture.ts": blocksModule(
        block({ id: "neg_title", extra: `\n    title: { ${broken ? "" : 'text: "題"'} },` }),
        "defineBlocks",
      ),
    }),
  },
  {
    name: "conversion.status が想定外の値",
    expect: "not assignable to type 'ConversionStatus'",
    files: (broken) => ({
      "fixture.ts": blocksModule(
        block({
          id: "neg_status",
          extra: `\n    conversion: { status: ${JSON.stringify(broken ? "convertd" : "converted")} },`,
        }),
        "defineBlocks",
      ),
    }),
  },
  {
    name: "フィールド名の打ち間違い（proof → proofs）",
    expect: "proofs",
    files: (broken) => ({
      "fixture.ts": blocksModule(
        block({
          id: "neg_typo",
          extra: broken ? '\n    proofs: [paragraph(["証明のつもり"])],' : "",
        }),
        "defineBlocks, paragraph",
      ),
    }),
  },
  {
    name: "ノートの targets が空",
    expect: "Source has 0 element(s) but target requires 1",
    files: (broken) => ({
      "fixture.ts": noteModule(`  {
    id: "note_neg_empty",
    targets: [${broken ? "" : JSON.stringify(realLabel)}],
    body: [],
  },`),
    }),
  },
];

let failed = 0;
for (const testCase of cases) {
  // 1. 正しい版はコンパイルが通る（対照）。
  const control = runCase(testCase, false);
  if (control.status !== 0) {
    failed += 1;
    console.error(`✗ ${testCase.name}: 正しい入力なのに型検査が落ちた（テストの設定不備）`);
    console.error(indent(control.output));
    continue;
  }

  // 2. 壊すと型検査が落ち、期待する語が診断に出る。
  const broken = runCase(testCase, true);
  if (broken.status === 0) {
    failed += 1;
    console.error(`✗ ${testCase.name}: 誤った入力なのに型検査が通ってしまった`);
    continue;
  }
  if (!broken.output.includes(testCase.expect)) {
    failed += 1;
    console.error(`✗ ${testCase.name}: 型検査は落ちたが、診断が期待と違う`);
    console.error(indent(broken.output));
    continue;
  }
  console.log(`✓ ${testCase.name}`);
  console.log(indent(firstDiagnostic(broken.output)));
}

rmSync(tmpDir, { recursive: true, force: true });

if (failed > 0) {
  console.error(`\n${failed} 件の負テストが期待どおりに動かなかった`);
  process.exit(1);
}
console.log(`\nすべての負テストが期待どおり: 誤った入力は tsc が拒否する（${cases.length} 件）`);

function runCase(testCase: Case, broken: boolean): { status: number; output: string } {
  rmSync(tmpDir, { recursive: true, force: true });
  mkdirSync(tmpDir, { recursive: true });
  const files = testCase.files(broken);
  for (const [fileName, source] of Object.entries(files)) {
    writeFileSync(join(tmpDir, fileName), source, "utf8");
  }
  writeFileSync(
    join(tmpDir, "tsconfig.json"),
    `${JSON.stringify(
      {
        extends: "../../tsconfig.json",
        compilerOptions: { noEmit: true, noUnusedLocals: false },
        include: Object.keys(files),
        // 親の exclude（type-tests/.tmp）を打ち消す。ここでは fixture だけを検査する。
        exclude: [],
      },
      null,
      2,
    )}\n`,
    "utf8",
  );
  const result = spawnSync(tsc, ["-p", join(tmpDir, "tsconfig.json")], {
    cwd: structuredLatexDir,
    encoding: "utf8",
  });
  if (result.error !== undefined) {
    throw new Error(
      `tsc を起動できなかった（${tsc}）: ${result.error.message}\n  修正: (cd ${structuredLatexDir} && pnpm install)`,
    );
  }
  return { status: result.status ?? 1, output: `${result.stdout ?? ""}${result.stderr ?? ""}` };
}

function firstDiagnostic(output: string): string {
  const lines = output.split("\n").filter((line) => line.includes("error TS"));
  return lines[0] ?? output.trim();
}

function indent(text: string): string {
  return text
    .trimEnd()
    .split("\n")
    .map((line) => `    ${line}`)
    .join("\n");
}
