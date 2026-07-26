#!/usr/bin/env node
/**
 * 「存在しないラベルを参照すると型検査が落ちる」ことの実証テスト。
 *
 * `type-tests/label-typing.test-d.ts` は `@ts-expect-error` による回帰テストで、
 * 通常の `tsc` に同乗して回る。こちらは**実際に tsc を落として、その診断メッセージを見せる**
 * ためのテスト。「型検査は通っているが、実は何も検出していない」状態を否定する。
 *
 * 手順（ケースごとに）:
 *   1. 一時ディレクトリ（type-tests/.tmp/）に、正しいラベルを使った版を書いて tsc を回す → 成功すること
 *   2. 同じファイルのラベルだけを壊した版を書いて tsc を回す → **失敗し**、
 *      壊したラベル名が診断に現れること
 *
 * 1 を必ず対にするのは、失敗が「設定ミスで常に落ちているだけ」でないことを示すため。
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
if (realLabel === undefined) {
  throw new Error("labels.generated.ts が空（先に node tools/generate-labels.ts を回す）");
}
const brokenLabel = `${realLabel}__does_not_exist`;

type Case = {
  name: string;
  /** ラベルを埋め込んでソースを作る。 */
  source: (label: string) => string;
};

const cases: Case[] = [
  {
    name: "本文中の ref が存在しないラベルを指す",
    source: (label) => `import { defineBlocks, paragraph, ref } from "../../schema.ts";

export default defineBlocks([
  {
    id: "negative_type_test_ref",
    kind: "claim",
    sourcePath: "type-tests/.tmp",
    sourceOrdinal: 1,
    labels: [],
    statement: [paragraph(["参照: ", ref(${JSON.stringify(label)})])],
  },
]);
`,
  },
  {
    name: "ノートの targets が存在しないラベルを指す",
    source: (label) => `import { defineNotes, paragraph } from "../../schema.ts";

export default defineNotes([
  {
    id: "note_negative_type_test",
    targets: [${JSON.stringify(label)}],
    body: [paragraph(["参照用ノート"])],
  },
]);
`,
  },
  {
    name: "ブロックが未登録のラベルを宣言する（生成物の再生成漏れ）",
    source: (label) => `import { defineBlocks } from "../../schema.ts";

export default defineBlocks([
  {
    id: "negative_type_test_label",
    kind: "definition",
    sourcePath: "type-tests/.tmp",
    sourceOrdinal: 1,
    labels: [${JSON.stringify(label)}],
    statement: [],
  },
]);
`,
  },
];

rmSync(tmpDir, { recursive: true, force: true });
mkdirSync(tmpDir, { recursive: true });
writeFileSync(
  join(tmpDir, "tsconfig.json"),
  `${JSON.stringify(
    {
      extends: "../../tsconfig.json",
      compilerOptions: { noEmit: true },
      include: ["fixture.ts"],
      // 親の exclude（type-tests/.tmp）を打ち消す。ここでは fixture だけを検査する。
      exclude: [],
    },
    null,
    2,
  )}\n`,
  "utf8",
);

let failed = 0;
for (const testCase of cases) {
  // 1. 正しいラベル版はコンパイルが通る（対照）。
  writeFileSync(join(tmpDir, "fixture.ts"), testCase.source(realLabel), "utf8");
  const control = runTsc();
  if (control.status !== 0) {
    failed += 1;
    console.error(`✗ ${testCase.name}: 正しいラベルなのに型検査が落ちた（設定不備）`);
    console.error(indent(control.output));
    continue;
  }

  // 2. ラベルを壊すと型検査が落ち、壊したラベル名が診断に出る。
  writeFileSync(join(tmpDir, "fixture.ts"), testCase.source(brokenLabel), "utf8");
  const broken = runTsc();
  if (broken.status === 0) {
    failed += 1;
    console.error(`✗ ${testCase.name}: 存在しないラベルなのに型検査が通ってしまった`);
    continue;
  }
  if (!broken.output.includes(brokenLabel)) {
    failed += 1;
    console.error(`✗ ${testCase.name}: 型検査は落ちたが、原因が当該ラベルではない`);
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
console.log(`\nすべての負テストが期待どおり: 存在しないラベルは tsc が拒否する（${cases.length} 件）`);

function runTsc(): { status: number; output: string } {
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
