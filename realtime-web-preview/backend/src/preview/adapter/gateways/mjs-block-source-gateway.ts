import { existsSync } from 'node:fs'
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
import { loadMjsDefaultExports } from './mjs-module-loader.js'

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

    // 動的 import のモジュールキャッシュを跨ぐため、読み込みごとにバージョンを進める。
    this.importVersion += 1
    const outcome = await loadMjsDefaultExports(this.sourceDir, this.importVersion)
    if (!outcome.ok) {
      const { failure } = outcome
      return err({
        code: 'source_read_error',
        message:
          failure.kind === 'read_error'
            ? failure.message
            : `${failure.fileName}: ${failure.message}`,
      })
    }
    if (outcome.modules.length === 0) {
      return err({ code: 'source_empty' })
    }

    const blocks: Block[] = []
    const issues: ValidationIssue[] = []

    for (const { fileName, defaultExport } of outcome.modules) {
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
