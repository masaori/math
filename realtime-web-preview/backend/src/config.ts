import path from 'node:path'
import { fileURLToPath } from 'node:url'

/**
 * サーバ設定。入力ソース dir は CLI 引数 / 環境変数で差し替え可能（F-7）。
 * 既定はリファレンス入力ソース（structured-latex/content, structured-latex/notes）。
 */
export type ServerConfig = {
  sourceDir: string
  sourceLabel: string
  /** 参照用ノートの dir。存在しなくてもよい（その場合ノート無しで動く）。 */
  notesDir: string
  /**
   * 入力ソースのブロックが持つ、プロジェクト固有メタデータのキー名（例: `habitat`）。
   * システムの実行時スキーマは `.strict()` で未宣言のキーを拒否するため、
   * メタデータを使うプロジェクトを表示するときはここで宣言する
   * （本ビューアはドメイン非依存なのでキー名を内蔵しない）。
   */
  blockMetaKeys: readonly string[]
  host: string
  port: number
  staticDir: string
}

// このファイルは backend/dist/config.js として出力される。
const here = path.dirname(fileURLToPath(import.meta.url)) // <repo>/realtime-web-preview/backend/dist
const rwpRoot = path.resolve(here, '..', '..') // <repo>/realtime-web-preview
const repoRoot = path.resolve(rwpRoot, '..') // <repo>

const DEFAULT_SOURCE_DIR = path.join(
  repoRoot,
  'exact-solution-of-2d-ising-model',
  'structured-latex',
  'content',
)
const DEFAULT_NOTES_DIR = path.join(
  repoRoot,
  'exact-solution-of-2d-ising-model',
  'structured-latex',
  'notes',
)
const STATIC_DIR = path.join(rwpRoot, 'frontend', 'dist')
const DEFAULT_PORT = 4321
const DEFAULT_HOST = '0.0.0.0'

const readArg = (name: string): string | undefined => {
  const flag = `--${name}`
  const index = process.argv.indexOf(flag)
  if (index >= 0 && index + 1 < process.argv.length) {
    return process.argv[index + 1]
  }
  const inline = process.argv.find((arg) => arg.startsWith(`${flag}=`))
  return inline ? inline.slice(flag.length + 1) : undefined
}

export const loadConfig = (): ServerConfig => {
  const sourceDirRaw = readArg('source') ?? process.env.RWP_SOURCE_DIR ?? DEFAULT_SOURCE_DIR
  const sourceDir = path.resolve(sourceDirRaw)

  const portRaw = readArg('port') ?? process.env.RWP_PORT
  const parsedPort = portRaw ? Number.parseInt(portRaw, 10) : DEFAULT_PORT
  const port = Number.isNaN(parsedPort) ? DEFAULT_PORT : parsedPort

  const host = readArg('host') ?? process.env.RWP_HOST ?? DEFAULT_HOST
  const sourceLabel = path.relative(repoRoot, sourceDir) || sourceDir

  // --source だけ差し替えられた場合は、その隣の `notes` を既定の探索先にする
  // （content/ と notes/ が並ぶ構成を前提にしすぎないよう、--notes で上書きできる）。
  const notesDirRaw =
    readArg('notes') ??
    process.env.RWP_NOTES_DIR ??
    (sourceDirRaw === DEFAULT_SOURCE_DIR
      ? DEFAULT_NOTES_DIR
      : path.join(path.dirname(sourceDir), 'notes'))
  const notesDir = path.resolve(notesDirRaw)

  const blockMetaKeysRaw = readArg('block-meta-keys') ?? process.env.RWP_BLOCK_META_KEYS ?? ''
  const blockMetaKeys = blockMetaKeysRaw
    .split(',')
    .map((key) => key.trim())
    .filter((key) => key !== '')

  return { sourceDir, sourceLabel, notesDir, blockMetaKeys, host, port, staticDir: STATIC_DIR }
}
