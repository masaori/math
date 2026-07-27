#!/usr/bin/env node
/**
 * 複製したツールが、複製元（`exact-solution-of-2d-ising-model/structured-latex/`）から
 * **知らないうちにずれていないか**を検査する。
 *
 * この基盤は共有ライブラリではなく**複製**である（判断の根拠は
 * `integrable-lattice/docs/structured-latex-decision.md`）。複製の弱点は「片方だけ直して
 * もう片方が古いまま腐る」ことなので、次の 2 つを機械で見る。
 *
 *   1. **同一であるべきファイル**（ドメインに依存しない土台）がバイト一致していること。
 *      片方で不具合を直したのに、もう片方が直っていない状態を検出する。
 *   2. **意図的に違えているファイル**が、意図どおり「違っている」こと。
 *      複製元の内容で上書きしてしまった（プロジェクト固有の検査を消した）事故を検出する。
 *
 * 検査は**この複製側だけ**で走らせる。複製元（Ising 側）の `npm run check` からは呼ばない
 * ——あちらは複数セッションが並行で触っており、こちらの都合で落としてはならないため。
 *
 * 複製元が見つからない場合（このリポジトリ以外へ切り出した場合など）は、検査を飛ばさずに
 * **エラーにする**。黙って飛ばすと、検査があるように見えて何も見ていない状態になる。
 *
 * 使い方: node tools/verify-shared-tools-in-sync.ts
 */

import { existsSync, readFileSync } from "node:fs";
import { join, resolve } from "node:path";

import { structuredLatexDir } from "./content-modules.ts";

/** 複製元（Ising 側の structured-latex）。 */
const originDir = resolve(
  structuredLatexDir,
  "..",
  "..",
  "exact-solution-of-2d-ising-model",
  "structured-latex",
);

/**
 * バイト一致であるべきファイル。
 * いずれも「ブロックの中身（ドメイン）を知らない土台」であり、両プロジェクトで同じ挙動が要る。
 */
const MUST_BE_IDENTICAL = [
  "tools/content-modules.ts",
  "tools/generate-index.ts",
  "tools/latex-escape.ts",
  "tools/verify-no-notes-in-output.ts",
] as const;

/**
 * 意図的に違えているファイルと、その理由。
 * ここに挙げたものが複製元と一致してしまったら、プロジェクト固有の部分を失っている。
 */
const MUST_DIFFER: readonly { path: string; why: string }[] = [
  { path: "schema.ts", why: "habitat / realEscape / verification / lean を型で足している" },
  { path: "tools/validate-content.ts", why: "住処と数式の食い違い・検証ディレクトリの実在を見る" },
  { path: "tools/negative-type-test.ts", why: "habitat・realEscape の負テストを足している" },
  { path: "tools/schema-runtime-test.ts", why: "同上（実行時側）" },
  { path: "tools/build-latex.ts", why: "住処と ℝ 脱出を PDF へ印字する" },
  { path: "tsconfig.json", why: "検査対象に含めるディレクトリが違う" },
];

if (!existsSync(originDir)) {
  throw new Error(
    `複製元が見つからない: ${originDir}\n` +
      "  この検査は複製元と突き合わせるためのもので、見つからないなら検査は成立しない。\n" +
      "  複製元を移動・改名したなら、このツールの originDir を直すこと。",
  );
}

const problems: string[] = [];
let identicalCount = 0;

for (const relative of MUST_BE_IDENTICAL) {
  const here = join(structuredLatexDir, relative);
  const there = join(originDir, relative);
  if (!existsSync(there)) {
    problems.push(`複製元に ${relative} が無い（改名・削除された可能性）`);
    continue;
  }
  if (!existsSync(here)) {
    problems.push(`こちらに ${relative} が無い（複製漏れ）`);
    continue;
  }
  if (readFileSync(here, "utf8") !== readFileSync(there, "utf8")) {
    problems.push(
      `${relative} が複製元とずれている` +
        "（土台は同一に保つ。どちらかの修正がもう片方へ運ばれていない）",
    );
    continue;
  }
  identicalCount += 1;
}

let intentionalCount = 0;
for (const { path: relative, why } of MUST_DIFFER) {
  const here = join(structuredLatexDir, relative);
  const there = join(originDir, relative);
  if (!existsSync(here) || !existsSync(there)) continue;
  if (readFileSync(here, "utf8") === readFileSync(there, "utf8")) {
    problems.push(
      `${relative} が複製元と完全一致している（${why}はずが失われている可能性）`,
    );
    continue;
  }
  intentionalCount += 1;
}

if (problems.length > 0) {
  console.error("複製元との同期が崩れている:");
  for (const problem of problems) console.error(`  - ${problem}`);
  console.error(`\n複製元: ${originDir}`);
  process.exit(1);
}

console.log(
  `shared tools in sync: 土台 ${identicalCount} ファイルは複製元と一致、` +
    `固有化した ${intentionalCount} ファイルは意図どおり相違`,
);
