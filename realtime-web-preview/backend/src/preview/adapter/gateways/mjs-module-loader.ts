import { readdir } from 'node:fs/promises'
import path from 'node:path'
import { pathToFileURL } from 'node:url'

/** 1ファイル分の default export（未検証の生の値）。 */
export type LoadedModule = {
  fileName: string
  defaultExport: unknown
}

/** dir 内の `.mjs` を読み込む際に起きうる失敗（呼び出し側が Result へ変換する）。 */
export type MjsLoadFailure =
  | { kind: 'read_error'; message: string }
  | { kind: 'import_error'; fileName: string; message: string }

export type MjsLoadOutcome =
  | { ok: true; modules: LoadedModule[] }
  | { ok: false; failure: MjsLoadFailure }

const messageOf = (cause: unknown): string =>
  cause instanceof Error ? cause.message : String(cause)

/**
 * dir 直下の `.mjs` をファイル名昇順で動的 import し、default export を返す。
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
      .filter((entry) => entry.isFile() && entry.name.endsWith('.mjs'))
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
