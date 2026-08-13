/**
 * `content/` と `notes/` のモジュールを読み込む共通処理。
 *
 * ソース形式は **`.ts` に統一**する（書き方の種類を増やさない）。ファイル名昇順が文書順。
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

async function loadDefaultExport(dir: string, fileName: string): Promise<unknown> {
  const mod: { default?: unknown } = await import(pathToFileURL(join(dir, fileName)).href);
  return mod.default;
}

export type LoadedBlockFile = { file: string; blocks: ConvertedBlock[] };
export type LoadedNoteFile = { file: string; notes: Note[] };

/** content/ の全ファイルを文書順で読む。default export が配列でなければ落とす。 */
export async function loadContentFiles(): Promise<LoadedBlockFile[]> {
  const out: LoadedBlockFile[] = [];
  for (const file of listSourceFiles(contentDir)) {
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
