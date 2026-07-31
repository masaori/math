#!/usr/bin/env node
/**
 * コードモッド: ブロック・ノートの由来フィールドを、システムの入力言語へ合わせる。
 *
 *   sourcePath: "X",          →   origin: { path: "X", ordinal: N },
 *   sourceOrdinal: N,
 *
 *   conversion: { status: "added" },   →   （削除）
 *
 * なぜ必要か:
 *   - システム（リポジトリ直下 `structured-latex/`）では、由来は `origin: { path, ordinal }`
 *     という**任意**フィールドへ一般化されている。先行実装の `sourcePath` / `sourceOrdinal` は
 *     Typst 原本からの移行という一時的な事情に由来するもので、入力言語の契約に属さない。
 *   - `conversion`（converted / added の別）も同じ移行由来の記録である。システムの入力言語には
 *     対応する場所が無く、本プロジェクトでは全 32 ブロックが `{ status: "added" }` の 1 種類しか
 *     持たない（＝情報量ゼロ。「この論文は Typst 原本を持たず構造化テキストで新規に書かれた」
 *     という 1 つの事実にすぎない）。ブロックごとに持たせる意味が無いので落とす。
 *
 * **冪等**である。既に変換済みのファイルに対しては何も書き換えない
 * （`sourcePath` / `sourceOrdinal` / `conversion` が 1 つも無ければ差分ゼロ）。
 *
 * 使い方:
 *   node tools/codemod-origin.ts           変換結果を表示するだけ（既定は dry-run）
 *   node tools/codemod-origin.ts --apply   実際に書き換える
 */

import { readFileSync, writeFileSync } from "node:fs";
import { join } from "node:path";

import { contentDir, listSourceFiles, notesDir } from "./content-modules.ts";

const apply = process.argv.includes("--apply");

/**
 * `sourcePath: "..."` と、それに続く `sourceOrdinal: N,` を 1 つの `origin` へ畳む。
 * 文字列は複数行に跨らない（content/ の実状: すべて 1 行のリテラル）ことを前提にし、
 * 前提を満たさない書き方が残っていたら後段の「取り残し検出」で落とす。
 */
const SOURCE_PAIR =
  /^(?<indent>[ \t]*)sourcePath:[ \t]*(?<path>"(?:[^"\\]|\\.)*")[ \t]*,[ \t]*\r?\n[ \t]*sourceOrdinal:[ \t]*(?<ordinal>\d+)[ \t]*,[ \t]*\r?\n/gm;

/** `conversion: { status: "..." },`（1 行）と、複数行に書かれた `conversion: { ... },`。 */
const CONVERSION_ONE_LINE = /^[ \t]*conversion:[ \t]*\{[^{}]*\}[ \t]*,[ \t]*\r?\n/gm;

/** ノート側の由来（`sourcePath` 単独。`sourceOrdinal` を持たない）。 */
const SOURCE_PATH_ONLY = /^(?<indent>[ \t]*)sourcePath:[ \t]*(?<path>"(?:[^"\\]|\\.)*")[ \t]*,[ \t]*\r?\n/gm;

export const transform = (source: string): string => {
  let out = source.replaceAll(
    SOURCE_PAIR,
    (...args): string => {
      const groups = args.at(-1) as { indent: string; path: string; ordinal: string };
      return `${groups.indent}origin: { path: ${groups.path}, ordinal: ${groups.ordinal} },\n`;
    },
  );
  out = out.replaceAll(CONVERSION_ONE_LINE, "");
  // 残った単独の sourcePath（ノート）は ordinal を持たないので origin にできない。
  // システムの origin は path と ordinal の両方を要求するため、1 始まりの通し番号は
  // 付けようがない（並び順の正本は配列であって ordinal ではない）。単純に落とす。
  out = out.replaceAll(SOURCE_PATH_ONLY, "");
  return out;
};

const targets = [
  ...listSourceFiles(contentDir).map((file) => join(contentDir, file)),
  ...listSourceFiles(notesDir).map((file) => join(notesDir, file)),
];

let changed = 0;
const leftovers: string[] = [];

for (const path of targets) {
  const before = readFileSync(path, "utf8");
  const after = transform(before);
  if (/\bsourcePath\b|\bsourceOrdinal\b|\bconversion\b/.test(after)) {
    leftovers.push(path);
  }
  if (before === after) continue;
  changed += 1;
  if (apply) writeFileSync(path, after, "utf8");
}

if (leftovers.length > 0) {
  console.error(
    "変換しきれなかった箇所がある（想定していない書き方が残っている）:\n" +
      leftovers.map((path) => `  ${path}`).join("\n"),
  );
  process.exit(1);
}

console.log(
  apply
    ? `codemod-origin: ${changed} / ${targets.length} ファイルを書き換えた（冪等。再実行しても差分は出ない）`
    : `codemod-origin(dry-run): ${changed} / ${targets.length} ファイルが変換対象。--apply で書き換える`,
);
