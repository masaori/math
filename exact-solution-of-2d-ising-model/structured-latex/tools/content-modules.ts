/**
 * `content/` と `notes/` のモジュールを読み込む共通処理。
 *
 * 移行期は `.mjs`（未変換）と `.ts`（変換済み）が混在しうるので、両方を同じ規則
 * （ファイル名昇順 = 文書順）で読む。Node 22.18+ の型ストリップにより `.ts` は
 * ビルドなしでそのまま import できる。
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

/** 文書ソースとして扱う拡張子（移行期は両方を受け付ける）。 */
const SOURCE_EXTENSIONS = [".ts", ".mjs"] as const;

const isSourceFile = (fileName: string): boolean =>
  SOURCE_EXTENSIONS.some((ext) => fileName.endsWith(ext)) && !fileName.endsWith(".d.ts");

/** dir 直下のソースファイル名をファイル名昇順（＝文書順）で返す。 */
export function listSourceFiles(dir: string): string[] {
  if (!existsSync(dir)) return [];
  return readdirSync(dir).filter(isSourceFile).sort();
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
