import path from 'node:path'
import { fileURLToPath } from 'node:url'

/**
 * サーバ設定。入力ソース dir は CLI 引数 / 環境変数で差し替え可能（F-7）。
 * 既定はリファレンス入力ソース（structured-latex/content）。
 */
export type ServerConfig = {
  sourceDir: string
  sourceLabel: string
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

  return { sourceDir, sourceLabel, host, port, staticDir: STATIC_DIR }
}
