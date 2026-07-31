import { existsSync } from 'node:fs'
import {
  type Block,
  type LoadDocumentError,
  type Result,
  type RuntimeSchema,
  type ValidationIssue,
  err,
  ok,
} from '@structured-latex/system/domain-model'
import type {
  BlockSourceGateway,
  LoadedDocument,
} from '../../domain/interfaces/gateways/block-source-gateway.js'
import { loadMjsDefaultExports } from './mjs-module-loader.js'

/**
 * `.ts` 形式の構造化テキストソースを読む adapter。
 * 外部 domain（ファイルシステム + ESM ソース形式）への依存を、この層に隔離する。
 * 各ファイルの default export を**システムの実行時スキーマ**で検証し、Result に変換する
 * （入力言語の検証規則は `structured-latex/domain-model/structured-text/validate.ts` が持つ）。
 */
export class MjsBlockSourceGateway implements BlockSourceGateway {
  private importVersion = 0

  constructor(
    private readonly sourceDir: string,
    private readonly sourceLabel: string,
    private readonly schema: RuntimeSchema<string, unknown>,
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
      const parsed = this.schema.validateBlocks(defaultExport, fileName)
      if (!parsed.success) {
        issues.push(...parsed.error)
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
