#!/usr/bin/env node
/**
 * 由来の書き方を、システム（リポジトリ直下 `structured-latex/`）の入力言語へ合わせるコードモッド。
 *
 * 先行実装（このプロジェクトの旧 `schema.ts`）はブロックへ `sourcePath` / `sourceOrdinal` を
 * **必須**で持たせていた。システムはこれを `origin?: { path, ordinal }` へ一般化し、
 * **任意**にしている（Typst 原本からの移行という一時的な事情は入力言語の契約ではない、という判断）。
 * その差を content/ notes/ の全ファイルへ機械的に反映する。
 *
 * 変換は 3 つ:
 *
 *   1. ブロック: `sourcePath: "P",` + `sourceOrdinal: N,` → `origin: { path: "P", ordinal: N },`
 *   2. ノート:   `sourcePath: "P",` → `origin: { path: "P", ordinal: K },`
 *      `K` はそのノートの**ファイル内での 1 始まりの位置**。システムの `Origin` は `ordinal` を
 *      必須にしているが、先行実装のノートは通し番号を持っていなかったため、失われない値として
 *      位置を割り当てる（パスを捨てるより、位置を与えて原本への手がかりを残す方を採る）。
 *   3. 見出しブロック: `conversion: { status: "..." },` を落とす。
 *      システムの `HeadingBlock` はプロジェクト固有メタデータ `M` を受け取らない（定理型だけに効く）。
 *      **落としてよいのは情報が失われないときだけ**なので、事前に全見出しについて
 *      「`status` が `origin.path` から一意に決まる（`_old/` 配下なら converted、そうでなければ added）」
 *      かつ「`notes` を持たない」ことを実データで確認し、1 件でも破れていたら中止する。
 *
 * **冪等である。** 2 回目以降は `sourcePath` も見出しの `conversion` も残っていないため何もしない。
 *
 * 使い方:
 *   node tools/codemod-source-to-origin.ts           何をどう変えるかだけ表示する（書き込まない）
 *   node tools/codemod-source-to-origin.ts --apply    実際に書き込む
 */

import { readFileSync, readdirSync, writeFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath, pathToFileURL } from "node:url";

const here = dirname(fileURLToPath(import.meta.url));
const structuredLatexDir = join(here, "..");
const contentDir = join(structuredLatexDir, "content");
const notesDir = join(structuredLatexDir, "notes");
const apply = process.argv.includes("--apply");

/** 長くなった行は折り返して書く（1 行 100 文字を目安にする）。 */
const LINE_BUDGET = 100;

const sourceFiles = (dir: string): string[] =>
  readdirSync(dir)
    .filter((name) => name.endsWith(".ts") && !name.endsWith(".d.ts"))
    .sort();

// --- 1. 見出しの conversion を落としてよいかを、実データで確認する -------------
//
// 型を経由せずに値そのものを読む（ソースの見た目ではなく、実際に定義されている値を正とする）。

type LoadedBlock = {
  id: string;
  kind: string;
  sourcePath?: string;
  origin?: { path: string; ordinal: number };
  conversion?: { status: string; notes?: string[] };
};

const loadBlocks = async (): Promise<{ file: string; blocks: LoadedBlock[] }[]> => {
  const loaded: { file: string; blocks: LoadedBlock[] }[] = [];
  for (const file of sourceFiles(contentDir)) {
    const module: { default?: unknown } = await import(
      pathToFileURL(join(contentDir, file)).href
    );
    const blocks = module.default;
    if (!Array.isArray(blocks)) throw new TypeError(`${file} の default export が配列でない`);
    loaded.push({ file, blocks: blocks as LoadedBlock[] });
  }
  return loaded;
};

const violations: string[] = [];
for (const { file, blocks } of await loadBlocks()) {
  for (const block of blocks) {
    if (block.kind !== "heading") continue;
    const conversion = block.conversion;
    if (conversion === undefined) continue; // 変換済み（冪等）
    const path = block.sourcePath ?? block.origin?.path;
    if (path === undefined) {
      violations.push(`${file}:${block.id} — 由来が無いので status を復元できない`);
      continue;
    }
    const expected = path.startsWith("_old/") ? "converted" : "added";
    if (conversion.status !== expected) {
      violations.push(
        `${file}:${block.id} — status=${conversion.status} だが由来は ${path}（期待: ${expected}）`,
      );
    }
    if (conversion.notes !== undefined) {
      violations.push(`${file}:${block.id} — conversion.notes を持つので落とすと情報が失われる`);
    }
  }
}
if (violations.length > 0) {
  console.error(
    "見出しの conversion を落とすと情報が失われる（中止）:\n" +
      violations.map((line) => `  ${line}`).join("\n"),
  );
  process.exit(1);
}

// --- 2. テキスト変換 ----------------------------------------------------------

/** 由来 1 件を、桁数に応じて 1 行か複数行で書く。 */
const renderOrigin = (indent: string, path: string, ordinal: number): string => {
  const oneLine = `${indent}origin: { path: ${path}, ordinal: ${ordinal} },\n`;
  if (oneLine.length - 1 <= LINE_BUDGET) return oneLine;
  return (
    `${indent}origin: {\n` +
    `${indent}  path: ${path},\n` +
    `${indent}  ordinal: ${ordinal},\n` +
    `${indent}},\n`
  );
};

/**
 * パスの書き方。実データにあるのは 2 通りだけである（実測: 文字列 178 件・識別子 146 件）:
 *   - ダブルクォート文字列（エスケープを含む。長いものは改行を挟んで折り返されている）
 *   - ファイル先頭で `const SRC = "…"` と束ねた識別子
 */
const PATH_EXPRESSION = String.raw`(?:"(?:[^"\\]|\\.)*"|[A-Za-z_$][A-Za-z0-9_$]*)`;

const BLOCK_ORIGIN = new RegExp(
  String.raw`^([ \t]*)sourcePath:[ \t]*\n?[ \t]*(${PATH_EXPRESSION}),[ \t]*\n[ \t]*sourceOrdinal: (\d+),[ \t]*\n`,
  "gm",
);

const LONE_SOURCE_PATH = new RegExp(
  String.raw`^([ \t]*)sourcePath:[ \t]*\n?[ \t]*(${PATH_EXPRESSION}),[ \t]*\n`,
  "gm",
);

/** 配列直下の要素（`  {` … `  },`）。閉じ括弧の字下げが開き括弧と同じことで区切る。 */
const TOP_LEVEL_ELEMENT = /^([ \t]*)\{\n([\s\S]*?)^\1\},$/gm;

const HEADING_CONVERSION = /^[ \t]*conversion: \{ status: "(?:converted|added)" \},[ \t]*\n/m;

/** ノート 1 件の始まり（`id:` はノートの直下にしか現れない）。 */
const NOTE_ID_LINE = /^[ \t]*id: /gm;

type FileChange = { path: string; blockOrigins: number; noteOrigins: number; headings: number };

const transformContent = (source: string): { text: string; blockOrigins: number; headings: number } => {
  let blockOrigins = 0;
  let text = source.replace(BLOCK_ORIGIN, (_match, indent: string, path: string, ordinal: string) => {
    blockOrigins += 1;
    return renderOrigin(indent, path, Number(ordinal));
  });

  let headings = 0;
  text = text.replace(TOP_LEVEL_ELEMENT, (match, indent: string, body: string) => {
    if (!/^[ \t]*kind: "heading",$/m.test(body)) return match;
    if (!HEADING_CONVERSION.test(body)) return match;
    headings += 1;
    return `${indent}{\n${body.replace(HEADING_CONVERSION, "")}${indent}},`;
  });

  return { text, blockOrigins, headings };
};

/**
 * ノートの `sourcePath` を `origin` へ移す。`ordinal` はそのノートのファイル内での位置
 * （直前までに現れた `id:` の個数）。
 */
const transformNotes = (source: string): { text: string; noteOrigins: number } => {
  let noteOrigins = 0;
  const text = source.replace(
    LONE_SOURCE_PATH,
    (match, indent: string, path: string, offset: number) => {
      const before = source.slice(0, offset);
      const ordinal = (before.match(NOTE_ID_LINE) ?? []).length;
      if (ordinal === 0) {
        throw new Error(`ノートの位置を特定できなかった: ${match.trim()}`);
      }
      noteOrigins += 1;
      return renderOrigin(indent, path, ordinal);
    },
  );
  return { text, noteOrigins };
};

const changes: FileChange[] = [];

for (const file of sourceFiles(contentDir)) {
  const path = join(contentDir, file);
  const source = readFileSync(path, "utf8");
  const { text, blockOrigins, headings } = transformContent(source);
  if (text === source) continue;
  changes.push({ path, blockOrigins, noteOrigins: 0, headings });
  if (apply) writeFileSync(path, text, "utf8");
}

for (const file of sourceFiles(notesDir)) {
  const path = join(notesDir, file);
  const source = readFileSync(path, "utf8");
  const { text, noteOrigins } = transformNotes(source);
  if (text === source) continue;
  changes.push({ path, blockOrigins: 0, noteOrigins, headings: 0 });
  if (apply) writeFileSync(path, text, "utf8");
}

const total = changes.reduce(
  (acc, change) => ({
    blockOrigins: acc.blockOrigins + change.blockOrigins,
    noteOrigins: acc.noteOrigins + change.noteOrigins,
    headings: acc.headings + change.headings,
  }),
  { blockOrigins: 0, noteOrigins: 0, headings: 0 },
);

if (changes.length === 0) {
  console.log("変換対象なし（すでに origin へ移行済み）");
} else {
  for (const change of changes) {
    console.log(
      `  ${change.path.replace(`${structuredLatexDir}/`, "")}: ` +
        `ブロックの由来 ${change.blockOrigins} 件 / ノートの由来 ${change.noteOrigins} 件 / ` +
        `見出しの conversion 除去 ${change.headings} 件`,
    );
  }
  console.log(
    `${changes.length} ファイル: ブロックの由来 ${total.blockOrigins} 件、` +
      `ノートの由来 ${total.noteOrigins} 件、見出しの conversion 除去 ${total.headings} 件` +
      (apply ? " を書き込んだ" : "（--apply を付けると書き込む）"),
  );
}
