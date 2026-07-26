import { readdir } from 'node:fs/promises'
import path from 'node:path'
import { pathToFileURL } from 'node:url'

/** 1ファイル分の default export（未検証の生の値）。 */
export type LoadedModule = {
  fileName: string
  defaultExport: unknown
}

/**
 * 入力ソースとして読むファイルの判定。
 * 形式は **TypeScript（`.ts`）に統一**する。Node 22.18+ は型ストリップでそのまま実行できるため、
 * 入力ソース側にビルド工程は要らない（実例: exact-solution-of-2d-ising-model/structured-latex）。
 * 型宣言ファイル（`.d.ts`）は値を持たないので除く。
 */
const isSourceFile = (fileName: string): boolean =>
  fileName.endsWith('.ts') && !fileName.endsWith('.d.ts')

/** dir 内の入力ソースを読み込む際に起きうる失敗（呼び出し側が Result へ変換する）。 */
export type MjsLoadFailure =
  | { kind: 'read_error'; message: string }
  | { kind: 'import_error'; fileName: string; message: string }

export type MjsLoadOutcome =
  | { ok: true; modules: LoadedModule[] }
  | { ok: false; failure: MjsLoadFailure }

const messageOf = (cause: unknown): string =>
  cause instanceof Error ? cause.message : String(cause)

/**
 * dir 直下の入力ソース（`.ts`）をファイル名昇順で動的 import し、default export を返す。
 * `version` は ESM のモジュールキャッシュを跨ぐためのクエリ（呼び出しごとに進める）。
 * 形式（ESM ソース）という外部 domain への依存を adapter 層に閉じ込めるための共通処理で、
 * 中身のスキーマは一切知らない（ドメイン非依存）。
 */
export const loadMjsDefaultExports = async (
  dir: string,
  version: number,
): Promise<MjsLoadOutcome> => {
  let fileNames: string[]
  try {
    const entries = await readdir(dir, { withFileTypes: true })
    fileNames = entries
      .filter((entry) => entry.isFile() && isSourceFile(entry.name))
      .map((entry) => entry.name)
      .sort()
  } catch (cause) {
    return { ok: false, failure: { kind: 'read_error', message: messageOf(cause) } }
  }

  const modules: LoadedModule[] = []
  for (const fileName of fileNames) {
    const moduleUrl = `${pathToFileURL(path.join(dir, fileName)).href}?v=${version}`
    try {
      const imported = (await import(moduleUrl)) as { default?: unknown }
      modules.push({ fileName, defaultExport: imported.default })
    } catch (cause) {
      return {
        ok: false,
        failure: { kind: 'import_error', fileName, message: messageOf(cause) },
      }
    }
  }
  return { ok: true, modules }
}
