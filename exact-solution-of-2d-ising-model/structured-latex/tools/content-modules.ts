/**
 * `content/` と `notes/` のモジュールを読み込む共通処理。
 *
 * ソース形式は **`.ts` に統一**する（書き方の種類を増やさない）。文書順は、`LEADING_CONTENT_FILES` に
 * 宣言したファイルを先頭に置き、`TRAILING_CONTENT_FILES` に宣言したファイルを末尾に置き、残りをその間に
 * ファイル名昇順で並べたもの。
 * Node 22.18+ の型ストリップにより、`.ts` はビルドなしでそのまま import できる。
 * `.mjs` が残っていれば「型検査から漏れたファイル」なので、読まずにエラーで落とす。
 */

import { existsSync, readdirSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath, pathToFileURL } from "node:url";

import type { ConvertedBlock, Note } from "../schema.ts";

const here = dirname(fileURLToPath(import.meta.url));

/** structured-latex ディレクトリの絶対パス。 */
export const structuredLatexDir = join(here, "..");
export const contentDir = join(structuredLatexDir, "content");
export const notesDir = join(structuredLatexDir, "notes");

const isSourceFile = (fileName: string): boolean =>
  fileName.endsWith(".ts") && !fileName.endsWith(".d.ts");

/**
 * `content/` のうち、ファイル名昇順より前に、ここに書いた順で置くファイル。
 *
 * 既存の章のファイルは番号のプレフィックスを持ち、その昇順が文書順である。新しく作るファイルには
 * 番号を振らない（リポジトリの CLAUDE.md「文書・定理を番号や記号で管理しない」）。番号を持たない
 * 名前は数字より後ろに並ぶので、冒頭に置くファイルの順序は名前ではなくここで宣言する。
 */
export const LEADING_CONTENT_FILES = ["chapter_organization.ts"] as const;

/**
 * `content/` のうち、ファイル名昇順に並ぶファイルより後ろに、ここに書いた順で置くファイル。
 *
 * 承認済みの章立て（`tools/chapter-plan.ts`）の章を組み直したファイルを、部・章の順に並べる。
 * 番号を持つ既存の章のファイルには数学的道具立てが散らばっており、組み直した章はそれらを使うので、
 * 組み直した章はそれらより後ろに置く。
 */
export const TRAILING_CONTENT_FILES = [
  "partition_function_transfer_matrix_representation.ts",
  "partition_function_projection_and_jordan_wigner.ts",
] as const;

/**
 * dir 直下のソースファイル名をファイル名昇順（＝文書順）で返す。
 * `.mjs` を見つけたら、型検査の網から漏れている証拠なのでエラーにする。
 */
export function listSourceFiles(dir: string): string[] {
  if (!existsSync(dir)) return [];
  const entries = readdirSync(dir);
  const legacy = entries.filter((fileName) => fileName.endsWith(".mjs"));
  if (legacy.length > 0) {
    throw new Error(
      `${dir} に .mjs が残っている: ${legacy.join(", ")}` +
        "（ソース形式は .ts に統一する。node tools/codemod-mjs-to-ts.ts --apply で変換する）",
    );
  }
  return entries.filter(isSourceFile).sort();
}

/**
 * content/ のソースファイル名を文書順で返す。`LEADING_CONTENT_FILES` を宣言の順に先頭へ、
 * `TRAILING_CONTENT_FILES` を宣言の順に末尾へ置き、残りはファイル名昇順。
 * 宣言したファイルが無ければ、宣言が古いのでエラーにする。
 */
export function listContentFilesInDocumentOrder(): string[] {
  const files = listSourceFiles(contentDir);
  const declared: readonly string[] = [...LEADING_CONTENT_FILES, ...TRAILING_CONTENT_FILES];
  const missing = declared.filter((file) => !files.includes(file));
  if (missing.length > 0) {
    throw new Error(`LEADING_CONTENT_FILES・TRAILING_CONTENT_FILES に書いたファイルが content/ に無い: ${missing.join(", ")}`);
  }
  return [...LEADING_CONTENT_FILES, ...files.filter((file) => !declared.includes(file)), ...TRAILING_CONTENT_FILES];
}

async function loadDefaultExport(dir: string, fileName: string): Promise<unknown> {
  const mod: { default?: unknown } = await import(pathToFileURL(join(dir, fileName)).href);
  return mod.default;
}

export type LoadedBlockFile = { file: string; blocks: ConvertedBlock[] };
export type LoadedNoteFile = { file: string; notes: Note[] };

/** content/ の全ファイルを文書順（`listContentFilesInDocumentOrder`）で読む。default export が配列でなければ落とす。 */
export async function loadContentFiles(): Promise<LoadedBlockFile[]> {
  const out: LoadedBlockFile[] = [];
  for (const file of listContentFilesInDocumentOrder()) {
    const blocks = await loadDefaultExport(contentDir, file);
    if (!Array.isArray(blocks)) {
      throw new TypeError(`${file} default export must be an array`);
    }
    out.push({ file, blocks: blocks as ConvertedBlock[] });
  }
  return out;
}

/** notes/ の全ファイルを読む。ディレクトリが無ければ 0 件。 */
export async function loadNoteFiles(): Promise<LoadedNoteFile[]> {
  const out: LoadedNoteFile[] = [];
  for (const file of listSourceFiles(notesDir)) {
    const notes = await loadDefaultExport(notesDir, file);
    if (!Array.isArray(notes)) {
      throw new TypeError(`${file} default export must be an array`);
    }
    out.push({ file, notes: notes as Note[] });
  }
  return out;
}
