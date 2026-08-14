#!/usr/bin/env node
/**
 * 「誤った入力を書くと型検査が実際に落ちる」ことの実証テスト。
 *
 * `type-tests/label-typing.test-d.ts` は `@ts-expect-error` による回帰テストで、通常の
 * `tsc` に同乗して回る。こちらは実際に tsc を落として、その診断メッセージを見せるためのテスト。
 * 「型検査は通っているが、実は何も検出していない」状態を否定する。
 *
 * 入力言語そのものの検査は、システム側の `structured-latex/tools/negative-type-test.ts`
 * が同じ形で持っている（見出しに本文、level の範囲、`proof` の打ち間違い、
 * ファイル跨ぎの id・ラベル重複ほか）。ここに残すのは、
 * このプロジェクトの生成物とメタデータ宣言でしか確かめられないものだけである:
 *
 *   1. `labels.generated.ts` に実在するラベルへの束縛（存在しないラベルは書けない）
 *   2. 住処 `habitat` の値域と、住処 ↔ `realEscape` の対応（本プロジェクトの核）
 *
 * 各ケースは対で回す:
 *   1. 正しい版を書いて tsc → 成功すること（設定不備で常に落ちているだけではないことの対照）
 *   2. 壊した版を書いて tsc → 失敗し、診断に期待する語が現れること
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
if (realLabel === undefined) {
  throw new Error("labels.generated.ts が空（先に npm run gen を回す）");
}
const brokenLabel = `${realLabel}__does_not_exist`;

type Case = {
  name: string;
  /** `broken` が true のときだけ誤りを含むファイル群を返す。 */
  files: (broken: boolean) => Record<string, string>;
  /** 壊した版の診断に必ず現れるべき文字列。 */
  expect: string;
};

/** 1 ブロック分のリテラル（差し込み用）。住処は既定で可算側にしておく。 */
const block = (options: {
  id: string;
  labels?: readonly string[];
  statement?: string;
  habitat?: string;
  extra?: string;
}): string => `  {
    id: ${JSON.stringify(options.id)},
    kind: "claim",
    labels: [${(options.labels ?? []).map((label) => JSON.stringify(label)).join(", ")}],
    habitat: ${JSON.stringify(options.habitat ?? "N")},
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

const cases: Case[] = [
  {
    name: "本文中の ref が、このプロジェクトに実在しないラベルを指す",
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
    name: "ノートの targets が、このプロジェクトに実在しないラベルを指す",
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
    name: "habitat が想定外の値",
    // 診断は「"countably_infinite" は CountableHabitat | EscapingHabitat に代入できない」と出る。
    expect: "Habitat",
    files: (broken) => ({
      "fixture.ts": blocksModule(
        block({ id: "neg_habitat_value", habitat: broken ? "countably_infinite" : "Lambda" }),
        "defineBlocks",
      ),
    }),
  },
  {
    name: "本文ブロックが住処を宣言していない",
    expect: "habitat",
    files: (broken) => ({
      "fixture.ts": blocksModule(
        broken
          ? `  {
    id: "neg_no_habitat",
    kind: "claim",
    labels: [],
    statement: [],
  },`
          : block({ id: "neg_no_habitat" }),
        "defineBlocks",
      ),
    }),
  },
  {
    name: "非可算な住処なのに realEscape を書いていない",
    expect: "realEscape",
    files: (broken) => ({
      "fixture.ts": blocksModule(
        block({
          id: "neg_escape_missing",
          habitat: "R",
          extra: broken ? "" : '\n    realEscape: "熱力学極限 L→∞",',
        }),
        "defineBlocks",
      ),
    }),
  },
  {
    name: "可算な住処なのに realEscape を書いている",
    // realEscape は可算側では `never`（省略時 undefined）なので、診断は
    // 「string を undefined へ代入できない」の形で出る。フィールド名は診断本文に現れない。
    expect: "is not assignable to type 'undefined'",
    files: (broken) => ({
      "fixture.ts": blocksModule(
        broken
          ? block({
              id: "neg_escape_forbidden",
              habitat: "N",
              extra: '\n    realEscape: "書いてはいけない",',
            })
          : block({ id: "neg_escape_forbidden", habitat: "N" }),
        "defineBlocks",
      ),
    }),
  },
  {
    name: "見出しに住処を書く",
    // 見出しの habitat は `never` なので、診断は「string を undefined へ代入できない」の形で出る。
    expect: "is not assignable to type 'undefined'",
    files: (broken) => ({
      "fixture.ts": `import { defineBlocks } from "../../../schema.ts";

export default defineBlocks([
  {
    id: "neg_heading_meta",
    kind: "heading",
    level: 2,
    title: { text: "見出し" },
    labels: [],${broken ? '\n    habitat: "N",' : ""}
  },
]);
`,
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
      results[index] =
        `✗ ${testCase.name}: 正しい入力なのに型検査が落ちた（テストの設定不備）\n${indent(control.output)}`;
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
