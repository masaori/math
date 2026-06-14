import { existsSync } from 'node:fs'
import { readdir } from 'node:fs/promises'
import path from 'node:path'
import { pathToFileURL } from 'node:url'
import {
  type Block,
  type LoadDocumentError,
  type Result,
  type ValidationIssue,
  blocksSchema,
  err,
  ok,
} from '@rwp/domain-model'
import type {
  BlockSourceGateway,
  LoadedDocument,
} from '../../domain/interfaces/gateways/block-source-gateway.js'

/**
 * `.mjs` 形式の構造化テキストソースを読む adapter。
 * 外部 domain（ファイルシステム + ESM ソース形式）への依存を、この層に隔離する。
 * 各ファイルの default export を Zod safeParse で検証し（境界の try/catch）、Result に変換する。
 */
export class MjsBlockSourceGateway implements BlockSourceGateway {
  private importVersion = 0

  constructor(
    private readonly sourceDir: string,
    private readonly sourceLabel: string,
  ) {}

  async load(): Promise<Result<LoadedDocument, LoadDocumentError>> {
    if (!existsSync(this.sourceDir)) {
      return err({ code: 'source_not_found' })
    }

    let fileNames: string[]
    try {
      const entries = await readdir(this.sourceDir, { withFileTypes: true })
      fileNames = entries
        .filter((entry) => entry.isFile() && entry.name.endsWith('.mjs'))
        .map((entry) => entry.name)
        .sort()
    } catch (cause) {
      return err({ code: 'source_read_error', message: messageOf(cause) })
    }

    if (fileNames.length === 0) {
      return err({ code: 'source_empty' })
    }

    // 動的 import のモジュールキャッシュを跨ぐため、読み込みごとにバージョンを進める。
    this.importVersion += 1
    const blocks: Block[] = []
    const issues: ValidationIssue[] = []

    for (const fileName of fileNames) {
      const absolutePath = path.join(this.sourceDir, fileName)
      const moduleUrl = `${pathToFileURL(absolutePath).href}?v=${this.importVersion}`

      let defaultExport: unknown
      try {
        const imported = (await import(moduleUrl)) as { default?: unknown }
        defaultExport = imported.default
      } catch (cause) {
        return err({ code: 'source_read_error', message: `${fileName}: ${messageOf(cause)}` })
      }

      const parsed = blocksSchema.safeParse(defaultExport)
      if (!parsed.success) {
        for (const issue of parsed.error.issues) {
          issues.push({ path: `${fileName}:${issue.path.join('.')}`, message: issue.message })
        }
        continue
      }
      blocks.push(...parsed.data)
    }

    if (issues.length > 0) {
      return err({ code: 'validation_error', issues })
    }
    if (blocks.length === 0) {
      return err({ code: 'source_empty' })
    }
    return ok({ blocks, sourceLabel: this.sourceLabel })
  }
}

const messageOf = (cause: unknown): string =>
  cause instanceof Error ? cause.message : String(cause)
