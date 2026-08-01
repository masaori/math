/**
 * `content/` と `notes/` のモジュールを読み込む共通処理。
 *
 * **中身はシステム（リポジトリ直下 `structured-latex/`）の実装をそのまま使う。**
 * ここに残っているのは「本プロジェクトのディレクトリを固定する」ことと、
 * 読み出した値を本プロジェクトのブロック型で見せることだけである。
 *
 * ソース形式は **`.ts` に統一**する（書き方の種類を増やさない）。ファイル名昇順が文書順。
 */

import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

import {
  contentDirOf,
  listSourceFiles as listSourceFilesOf,
  loadBlockFiles as loadBlockFilesOf,
  loadContentFiles as loadContentFilesOf,
  loadNoteFiles as loadNoteFilesOf,
  notesDirOf,
} from "../../../structured-latex/codegen/structured-text-index/content-modules.ts";
import {
  directoryFromProject,
  loadProjectLocalizationConfig,
} from "../../../structured-latex/codegen/structured-text-index/locales.ts";
import type { ConvertedBlock, Note, TranslatedBlock } from "../schema.ts";

const here = dirname(fileURLToPath(import.meta.url));

/** structured-latex ディレクトリの絶対パス。 */
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

// --- ロケール（locales.config.ts が宣言する翻訳）------------------------------
//
// 翻訳ロケールの入力ディレクトリは `locales.config.ts` だけが決める。ツールはここを通して
// 読む（ディレクトリ名をツール側へ書き写さない。写せば設定と実状が黙ってずれる）。

export type LoadedTranslatedFile = { file: string; blocks: readonly TranslatedBlock[] };

export const localizationConfig = await loadProjectLocalizationConfig(structuredLatexDir);

/** 原文ロケール（`content/` が属するロケール）。 */
export const sourceLocale = localizationConfig.sourceLocale;

export const knownLocales: readonly string[] = [
  localizationConfig.sourceLocale,
  ...localizationConfig.translations.map((translation) => translation.locale),
];

const translationOf = (locale: string) => {
  const translation = localizationConfig.translations.find((entry) => entry.locale === locale);
  if (translation === undefined) {
    throw new Error(
      `locales.config.ts が宣言していないロケール: ${locale}（宣言済み: ${knownLocales.join(", ")}）`,
    );
  }
  return translation;
};

/** そのロケールの content ディレクトリ（原文なら `content/`）。 */
export const contentDirForLocale = (locale: string): string =>
  locale === localizationConfig.sourceLocale
    ? contentDir
    : directoryFromProject(structuredLatexDir, translationOf(locale).contentDir);

/** そのロケールの content を文書順で読む。 */
export const loadContentFilesForLocale = async (locale: string): Promise<LoadedTranslatedFile[]> => {
  const loaded = await loadBlockFilesOf(contentDirForLocale(locale));
  return loaded.map(({ file, blocks }) => ({ file, blocks: blocks as readonly TranslatedBlock[] }));
};

/**
 * コマンドラインの `--locale <l>`。省略時は原文ロケール。
 * 宣言されていないロケールは受け付けない（打ち間違いを黙って原文にしない）。
 */
export const localeFromArgv = (argv: readonly string[] = process.argv): string => {
  const index = argv.indexOf("--locale");
  if (index < 0) return localizationConfig.sourceLocale;
  const locale = argv[index + 1];
  if (locale === undefined || !knownLocales.includes(locale)) {
    throw new Error(`--locale の値が不正: ${String(locale)}（宣言済み: ${knownLocales.join(", ")}）`);
  }
  return locale;
};
