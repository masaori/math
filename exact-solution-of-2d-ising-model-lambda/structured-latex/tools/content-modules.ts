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

import { compileDocumentStructure } from "../schema.ts";
import type { ConvertedBlock, Note, Section } from "../schema.ts";
import type { CompiledDocumentStructure } from "../../../structured-latex/domain-model/index.ts";

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

/** 節・グループ所属を保った索引。所属を文書順から推測しないための正本。 */
export type LoadedStructure = CompiledDocumentStructure<string, unknown>;
export type LoadedNoteFile = { file: string; notes: Note[] };

const isSectionArray = (value: unknown): value is readonly Section[] =>
  Array.isArray(value) &&
  value.length > 0 &&
  value.every(
    (item) =>
      typeof item === "object" && item !== null && (item as { kind?: unknown }).kind === "section",
  );

/**
 * content/ の全ファイルを文書順で読む。
 *
 * default export は **章（`Section`）の配列**（木が正本のファイル）か、ブロックの配列
 * （まだ移していないファイル）のどちらか。木は `compileDocumentStructure` で平坦化する。
 * **フォールバックしない**: 構造の不備はここで止める。
 */
export async function loadContentFiles(): Promise<LoadedBlockFile[]> {
  const { files } = await loadContent();
  return files;
}

/** 平坦なブロック列と、節・グループ所属の索引を同時に返す。 */
export async function loadContent(): Promise<{
  files: LoadedBlockFile[];
  structures: Map<string, LoadedStructure>;
}> {
  const files: LoadedBlockFile[] = [];
  const structures = new Map<string, LoadedStructure>();
  for (const file of listSourceFiles(contentDir)) {
    const source = await loadDefaultExport(contentDir, file);
    if (isSectionArray(source)) {
      const compiled = compileDocumentStructure({
        kind: "documentStructure",
        sections: source,
      });
      if (!compiled.success) {
        throw new TypeError(
          `${file} の文書構造を正規化できない: ${JSON.stringify(compiled.error)}`,
        );
      }
      structures.set(file, compiled.data as LoadedStructure);
      files.push({ file, blocks: compiled.data.blocks as ConvertedBlock[] });
      continue;
    }
    if (!Array.isArray(source)) {
      throw new TypeError(`${file} default export must be an array`);
    }
    files.push({ file, blocks: source as ConvertedBlock[] });
  }
  return { files, structures };
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
