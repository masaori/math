/**
 * プロジェクトの `content/` と `notes/` を読み込む共通処理。
 *
 * 先行実装（`structured-latex/tools/content-modules.ts`）の一般化。
 * **ファイル名昇順が文書順**であり、これはセグメントのキー昇順という一般規則の
 * ファイルシステム上の具体化である（docs/domain-model.md F1, §9.4）。
 *
 * 抽出はソースの構文解析ではなく、モジュールを実際に import して値を読む
 * （実行時の値そのものを正とするため）。
 */

import { existsSync, readdirSync } from 'node:fs'
import { join } from 'node:path'
import { pathToFileURL } from 'node:url'

import type { Block, Note } from '../../domain-model/index.ts'

export type LoadedBlockFile = { file: string; blocks: readonly Block[] }
export type LoadedNoteFile = { file: string; notes: readonly Note[] }

const isSourceFile = (fileName: string): boolean =>
  fileName.endsWith('.ts') && !fileName.endsWith('.d.ts')

/** dir 直下のソースファイル名を昇順（＝文書順）で返す。 */
export const listSourceFiles = (dir: string): string[] => {
  if (!existsSync(dir)) return []
  return readdirSync(dir).filter(isSourceFile).sort()
}

const loadDefaultExport = async (dir: string, fileName: string): Promise<unknown> => {
  const module: { default?: unknown } = await import(pathToFileURL(join(dir, fileName)).href)
  return module.default
}

export const contentDirOf = (projectDir: string): string => join(projectDir, 'content')
export const notesDirOf = (projectDir: string): string => join(projectDir, 'notes')

/** `content/` の全ファイルを文書順で読む。default export が配列でなければ落とす。 */
export const loadContentFiles = async (projectDir: string): Promise<LoadedBlockFile[]> => {
  return loadBlockFiles(contentDirOf(projectDir))
}

/** 任意の content ディレクトリを文書順で読む（翻訳ロケール用）。 */
export const loadBlockFiles = async (dir: string): Promise<LoadedBlockFile[]> => {
  const loaded: LoadedBlockFile[] = []
  for (const file of listSourceFiles(dir)) {
    const blocks = await loadDefaultExport(dir, file)
    if (!Array.isArray(blocks)) {
      throw new TypeError(`${file} の default export は配列でなければならない`)
    }
    loaded.push({ file, blocks: blocks as readonly Block[] })
  }
  return loaded
}

/** `notes/` の全ファイルを読む。ディレクトリが無ければ 0 件。 */
export const loadNoteFiles = async (projectDir: string): Promise<LoadedNoteFile[]> => {
  return loadNotesFiles(notesDirOf(projectDir))
}

/** 任意の notes ディレクトリを読む（翻訳ロケール用）。 */
export const loadNotesFiles = async (dir: string): Promise<LoadedNoteFile[]> => {
  const loaded: LoadedNoteFile[] = []
  for (const file of listSourceFiles(dir)) {
    const notes = await loadDefaultExport(dir, file)
    if (!Array.isArray(notes)) {
      throw new TypeError(`${file} の default export は配列でなければならない`)
    }
    loaded.push({ file, notes: notes as readonly Note[] })
  }
  return loaded
}
