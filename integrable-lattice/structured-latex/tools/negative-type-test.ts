#!/usr/bin/env node
/**
 * 「誤った入力を書くと型検査が落ちる」ことの実証テスト。
 *
 * `type-tests/label-typing.test-d.ts` は `@ts-expect-error` による回帰テストで、通常の
 * `tsc` に同乗して回る。こちらは**実際に tsc を落として、その診断メッセージを見せる**ためのテスト。
 * 「型検査は通っているが、実は何も検出していない」状態を否定する。
 *
 * 各ケースは対で回す:
 *   1. 正しい版を書いて tsc → **成功すること**（設定不備で常に落ちているだけではないことの対照）
 *   2. 壊した版を書いて tsc → **失敗し**、診断に期待する語が現れること
 *
 * 本プロジェクト固有のケース（`habitat` / `realEscape`）は末尾にまとめてある。
 *
 * 使い方: node tools/negative-type-test.ts
 */

import { execFile } from "node:child_process";
import { mkdirSync, rmSync, writeFileSync } from "node:fs";
import { join } from "node:path";

import { ALL_LABELS } from "../labels.generated.ts";
import { structuredLatexDir } from "./content-modules.ts";

const tmpDir = join(structuredLatexDir, "type-tests", ".tmp");
const tsc = join(structuredLatexDir, "node_modules", ".bin", "tsc");

const realLabel = ALL_LABELS[0];
const otherLabel = ALL_LABELS[1];
if (realLabel === undefined || otherLabel === undefined) {
  throw new Error("labels.generated.ts が 2 件未満（先に node tools/generate-index.ts を回す）");
}
const brokenLabel = `${realLabel}__does_not_exist`;

type Case = {
  name: string;
  /** `broken` が true のときだけ誤りを含むファイル群を返す。 */
  files: (broken: boolean) => Record<string, string>;
  /** 壊した版の診断に必ず現れるべき文字列。 */
  expect: string;
};

/** 1 ブロック分のリテラル（差し込み用）。`habitat` は本プロジェクトでは必須。 */
const block = (options: {
  id: string;
  labels?: readonly string[];
  statement?: string;
  habitat?: string;
  extra?: string;
}): string => `  {
    id: ${JSON.stringify(options.id)},
    kind: "claim",
    sourcePath: "type-tests/.tmp",
    sourceOrdinal: 1,
    labels: [${(options.labels ?? []).map((label) => JSON.stringify(label)).join(", ")}],
    habitat: ${JSON.stringify(options.habitat ?? "Lambda")},
    statement: [${options.statement ?? ""}],${options.extra ?? ""}
  },`;

const blocksModule = (body: string, imports = "defineBlocks, paragraph, ref"): string =>
  `import { ${imports} } from "../../../schema.ts";

export default defineBlocks([
${body}
]);
`;

const noteModule = (body: string): string =>
  `import { defineNotes, paragraph } from "../../../schema.ts";

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
} from "../../../schema.ts";
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
      "fixture.ts": `import { defineBlocks, paragraph } from "../../../schema.ts";

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
      "fixture.ts": `import { defineBlocks } from "../../../schema.ts";

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
    name: "sourceOrdinal が整数でない",
    expect: "__sourceOrdinalが正の整数でない",
    files: (broken) => ({
      "fixture.ts": blocksModule(
        block({ id: "neg_ordinal" }).replace(
          "sourceOrdinal: 1,",
          `sourceOrdinal: ${broken ? "2.5" : "2"},`,
        ),
        "defineBlocks",
      ),
    }),
  },
  {
    name: "sourceOrdinal が 0 以下",
    expect: "__sourceOrdinalが正の整数でない",
    files: (broken) => ({
      "fixture.ts": blocksModule(
        block({ id: "neg_ordinal_zero" }).replace(
          "sourceOrdinal: 1,",
          `sourceOrdinal: ${broken ? "0" : "1"},`,
        ),
        "defineBlocks",
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

  // --- ここから本プロジェクト固有（可算／非可算の分別と ℝ 脱出の明示）-------------
  {
    name: "【固有】本文ブロックが habitat を宣言していない",
    expect: "habitat",
    files: (broken) => ({
      "fixture.ts": blocksModule(
        broken
          ? block({ id: "neg_habitat_missing" }).replace('\n    habitat: "Lambda",', "")
          : block({ id: "neg_habitat_missing" }),
        "defineBlocks",
      ),
    }),
  },
  {
    name: "【固有】habitat が未知の値（住処の綴り違い）",
    expect: "not assignable to type 'CountableHabitat | EscapingHabitat | undefined'",
    files: (broken) => ({
      "fixture.ts": blocksModule(
        block({ id: "neg_habitat_unknown", habitat: broken ? "Lamda" : "Lambda" }),
        "defineBlocks",
      ),
    }),
  },
  {
    name: "【固有】可算な habitat（Z）なのに realEscape を書いている",
    expect: "realEscape",
    files: (broken) => ({
      "fixture.ts": blocksModule(
        block({
          id: "neg_escape_on_countable",
          habitat: "Z",
          extra: broken ? '\n    realEscape: "ここで ℝ を使った",' : "",
        }),
        "defineBlocks",
      ),
    }),
  },
  {
    name: "【固有】非可算な habitat（R）なのに realEscape が無い",
    expect: "realEscape",
    files: (broken) => ({
      "fixture.ts": blocksModule(
        block({
          id: "neg_escape_missing",
          habitat: "R",
          extra: broken ? "" : '\n    realEscape: "指数評価で実数の順序完備性を使う",',
        }),
        "defineBlocks",
      ),
    }),
  },
  {
    name: "【固有】mixed なのに realEscape が無い",
    expect: "realEscape",
    files: (broken) => ({
      "fixture.ts": blocksModule(
        block({
          id: "neg_escape_missing_mixed",
          habitat: "mixed",
          extra: broken ? "" : '\n    realEscape: "連続極限をとる一点だけ ℝ へ出る",',
        }),
        "defineBlocks",
      ),
    }),
  },
  {
    name: "【固有】見出しブロックが habitat を持つ",
    expect: "not assignable to type 'CountableHabitat | EscapingHabitat | undefined'",
    files: (broken) => ({
      "fixture.ts": `import { defineBlocks } from "../../../schema.ts";

export default defineBlocks([
  {
    id: "neg_heading_habitat",
    kind: "heading",
    level: 2,
    sourcePath: "type-tests/.tmp",
    sourceOrdinal: 1,
    title: { text: "見出し" },
    labels: [],${broken ? '\n    habitat: "Lambda",' : ""}
  },
]);
`,
    }),
  },
  {
    name: "【固有】verification が文字列の配列でない",
    expect: "not assignable to type 'readonly string[]'",
    files: (broken) => ({
      "fixture.ts": blocksModule(
        block({
          id: "neg_verification_type",
          extra: `\n    verification: ${broken ? '"sagemath/check/foo"' : '["sagemath/check/foo"]'},`,
        }),
        "defineBlocks",
      ),
    }),
  },
  {
    name: "【固有】lean が文字列の配列でない",
    expect: "not assignable to type 'readonly string[]'",
    files: (broken) => ({
      "fixture.ts": blocksModule(
        block({
          id: "neg_lean_type",
          extra: `\n    lean: ${broken ? '"Foo.bar"' : '["Foo.bar"]'},`,
        }),
        "defineBlocks",
      ),
    }),
  },
];

// ケース数 × 2 回（対照・破壊）の tsc 起動になるので、並列に回す（逐次だと数分かかる）。
const CONCURRENCY = 6;
const results: string[] = [];
let failed = 0;
let nextIndex = 0;

async function worker(): Promise<void> {
  for (;;) {
    const index = nextIndex;
    nextIndex += 1;
    const testCase = cases[index];
    if (testCase === undefined) return;

    // 1. 正しい版はコンパイルが通る（対照）。
    const control = await runCase(testCase, index, false);
    if (control.status !== 0) {
      failed += 1;
      results[index] = `✗ ${testCase.name}: 正しい入力なのに型検査が落ちた（テストの設定不備）\n${indent(control.output)}`;
      continue;
    }

    // 2. 壊すと型検査が落ち、期待する語が診断に出る。
    const broken = await runCase(testCase, index, true);
    if (broken.status === 0) {
      failed += 1;
      results[index] = `✗ ${testCase.name}: 誤った入力なのに型検査が通ってしまった`;
      continue;
    }
    if (!broken.output.includes(testCase.expect)) {
      failed += 1;
      results[index] = `✗ ${testCase.name}: 型検査は落ちたが、診断が期待と違う\n${indent(broken.output)}`;
      continue;
    }
    results[index] = `✓ ${testCase.name}\n${indent(firstDiagnostic(broken.output))}`;
  }
}

await Promise.all(Array.from({ length: CONCURRENCY }, () => worker()));

for (const line of results) {
  if (line.startsWith("✗")) console.error(line);
  else console.log(line);
}

rmSync(tmpDir, { recursive: true, force: true });

if (failed > 0) {
  console.error(`\n${failed} 件の負テストが期待どおりに動かなかった`);
  process.exit(1);
}
console.log(`\nすべての負テストが期待どおり: 誤った入力は tsc が拒否する（${cases.length} 件）`);

async function runCase(
  testCase: Case,
  index: number,
  broken: boolean,
): Promise<{ status: number; output: string }> {
  // ケースごとに別ディレクトリを使う（並列実行のため）。
  const caseDir = join(tmpDir, `case${index}${broken ? "_broken" : "_ok"}`);
  rmSync(caseDir, { recursive: true, force: true });
  mkdirSync(caseDir, { recursive: true });
  const files = testCase.files(broken);
  for (const [fileName, source] of Object.entries(files)) {
    writeFileSync(join(caseDir, fileName), source, "utf8");
  }
  writeFileSync(
    join(caseDir, "tsconfig.json"),
    `${JSON.stringify(
      {
        extends: "../../../tsconfig.json",
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
  return await new Promise((resolve, reject) => {
    execFile(
      tsc,
      ["-p", join(caseDir, "tsconfig.json")],
      { cwd: structuredLatexDir, encoding: "utf8", maxBuffer: 8 * 1024 * 1024 },
      (error, stdout, stderr) => {
        const output = `${stdout}${stderr}`;
        if (error !== null && typeof error.code !== "number") {
          reject(
            new Error(
              `tsc を起動できなかった（${tsc}）: ${error.message}` +
                `\n  修正: (cd ${structuredLatexDir} && pnpm install)`,
            ),
          );
          return;
        }
        resolve({ status: error === null ? 0 : (error.code as number), output });
      },
    );
  });
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
