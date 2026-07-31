#!/usr/bin/env node
/**
 * 「誤った入力を書くと型検査が落ちる」ことの実証テスト（英語版）。
 *
 * 入力言語一般のケース（ラベル解決・重複・見出しと本文の混同 等）は**システム側の負テスト**が
 * 持つので複製しない。ここで確かめるのは、**英語版の具体化が本当に効いているか**だけである。
 * 英語版は住処の語彙を日本語版から import しているので、その配線が切れていても
 * 「型検査は通るが何も検出しない」状態になりうる。それを否定するのがこのテストの目的。
 *
 * 各ケースは対で回す（正しい版は通り、壊した版は落ちて期待する語が診断に出る）。
 * 走らせ方の骨格は日本語版 `../structured-latex/tools/negative-type-test.ts` と同じである
 * （スクリプトなので import して共有できない。共有するには日本語版の書き換えが要り、
 * この作業は日本語版を変更しない方針である）。
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
  files: (broken: boolean) => Record<string, string>;
  expect: string;
};

const block = (options: {
  id: string;
  statement?: string;
  habitat?: string;
  extra?: string;
}): string => `  {
    id: ${JSON.stringify(options.id)},
    kind: "claim",
    origin: { path: "type-tests/.tmp", ordinal: 1 },
    labels: [],
    habitat: ${JSON.stringify(options.habitat ?? "Lambda")},
    statement: [${options.statement ?? ""}],${options.extra ?? ""}
  },`;

const blocksModule = (body: string, imports = "defineBlocks, paragraph, ref"): string =>
  `import { ${imports} } from "../../../schema.ts";

export default defineBlocks([
${body}
]);
`;

const cases: Case[] = [
  {
    name: "具体化: 本文中の ref が存在しないラベルを指す",
    expect: brokenLabel,
    files: (broken) => ({
      "fixture.ts": blocksModule(
        block({
          id: "neg_ref",
          statement: `paragraph(["see ", ref(${JSON.stringify(broken ? brokenLabel : realLabel)})])`,
        }),
      ),
    }),
  },
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
    expect: "not assignable to type 'CountableHabitat | EscapingHabitat'",
    files: (broken) => ({
      "fixture.ts": blocksModule(
        block({ id: "neg_habitat_unknown", habitat: broken ? "Lamda" : "Lambda" }),
        "defineBlocks",
      ),
    }),
  },
  {
    name: "【固有】可算な habitat（Z）なのに realEscape を書いている",
    expect: "not assignable to type 'undefined'",
    files: (broken) => ({
      "fixture.ts": blocksModule(
        block({
          id: "neg_escape_on_countable",
          habitat: "Z",
          extra: broken ? '\n    realEscape: "we used the reals here",' : "",
        }),
        "defineBlocks",
      ),
    }),
  },
  {
    name: "【固有】非可算な habitat（mixed）なのに realEscape が無い",
    expect: "realEscape",
    files: (broken) => ({
      "fixture.ts": blocksModule(
        block({
          id: "neg_escape_missing_mixed",
          habitat: "mixed",
          extra: broken ? "" : '\n    realEscape: "one continuous limit only",',
        }),
        "defineBlocks",
      ),
    }),
  },
  {
    name: "【固有】見出しブロックが habitat を持つ",
    expect: "not assignable to type 'undefined'",
    files: (broken) => ({
      "fixture.ts": `import { defineBlocks } from "../../../schema.ts";

export default defineBlocks([
  {
    id: "neg_heading_habitat",
    kind: "heading",
    level: 2,
    origin: { path: "type-tests/.tmp", ordinal: 1 },
    title: { text: "A heading" },
    labels: [],${broken ? '\n    habitat: "Lambda",' : ""}
  },
]);
`,
    }),
  },
];

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

    const control = await runCase(testCase, index, false);
    if (control.status !== 0) {
      failed += 1;
      results[index] = `✗ ${testCase.name}: 正しい入力なのに型検査が落ちた（テストの設定不備）\n${indent(control.output)}`;
      continue;
    }
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
