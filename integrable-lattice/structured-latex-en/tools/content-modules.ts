/**
 * 英語版の `content/`（と `notes/`）のモジュールを読み込む共通処理。
 *
 * 中身はシステム（リポジトリ直下 `structured-latex/`）の実装をそのまま使う。
 * ここに残っているのは「英語版プロジェクトのディレクトリを固定する」ことと、
 * 読み出した値を英語版のブロック型で見せることだけである。
 */

import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

import {
  contentDirOf,
  listSourceFiles as listSourceFilesOf,
  loadContentFiles as loadContentFilesOf,
  loadNoteFiles as loadNoteFilesOf,
  notesDirOf,
} from "../../../structured-latex/codegen/structured-text-index/content-modules.ts";
import type { ConvertedBlock, Note } from "../schema.ts";

const here = dirname(fileURLToPath(import.meta.url));

/** structured-latex-en ディレクトリの絶対パス。 */
export const structuredLatexDir = join(here, "..");
export const contentDir = contentDirOf(structuredLatexDir);
export const notesDir = notesDirOf(structuredLatexDir);

/** dir 直下のソースファイル名をファイル名昇順（＝文書順）で返す。 */
export const listSourceFiles = (dir: string): string[] => listSourceFilesOf(dir);

export type LoadedBlockFile = { file: string; blocks: readonly ConvertedBlock[] };
export type LoadedNoteFile = { file: string; notes: readonly Note[] };

/** content/ の全ファイルを文書順で読む。 */
export const loadContentFiles = async (): Promise<LoadedBlockFile[]> => {
  const loaded = await loadContentFilesOf(structuredLatexDir);
  return loaded.map(({ file, blocks }) => ({ file, blocks: blocks as readonly ConvertedBlock[] }));
};

/** notes/ の全ファイルを読む。ディレクトリが無ければ 0 件。 */
export const loadNoteFiles = async (): Promise<LoadedNoteFile[]> => {
  const loaded = await loadNoteFilesOf(structuredLatexDir);
  return loaded.map(({ file, notes }) => ({ file, notes: notes as readonly Note[] }));
};
