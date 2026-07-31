import { z } from 'zod'
import { type Result, err, ok } from './result.js'
import { createPreviewRuntimeSchema } from './structured-text.js'
import type { Block, Note, ValidationIssue } from './structured-text.js'

/**
 * BE / FE 間の API 契約（共通語彙）。
 * operation ごとに error code を網羅定義する（error-handling-strategy.md §3）。
 *
 * ブロック・ノードの形はここでは定義しない。入力言語の正本はシステム（`structured-latex/`）が
 * 持ち、検証はその実行時スキーマ（`createRuntimeSchema`）で行う。
 */

/** Zod 検証で失敗した1件（FE は path とともに画面表示する; F-9）。型はシステムのものを使う。 */
export const validationIssueSchema: z.ZodType<ValidationIssue> = z.object({
  path: z.string(),
  message: z.string(),
})

/** ドキュメント取得 operation のエラー（網羅）。 */
export const loadDocumentErrorSchema = z.discriminatedUnion('code', [
  z.object({ code: z.literal('source_not_found') }),
  z.object({ code: z.literal('source_empty') }),
  z.object({ code: z.literal('validation_error'), issues: z.array(validationIssueSchema) }),
  z.object({ code: z.literal('source_read_error'), message: z.string() }),
])
export type LoadDocumentError = z.infer<typeof loadDocumentErrorSchema>
export type LoadDocumentErrorCode = LoadDocumentError['code']

/**
 * GET /api/document 成功レスポンスの外枠。
 * `blocks` / `notes` の中身はここでは見ない（入力言語の検証はシステムの実行時スキーマの責務）。
 */
const documentEnvelopeSchema = z.object({
  blocks: z.array(z.unknown()),
  /**
   * 参照用ノート（文書本体ではない）。ソースに notes が無ければ空配列。
   * 本体（blocks）と別フィールドで運び、FE 側でも本文と区別して描画する。
   */
  notes: z.array(z.unknown()).default([]),
  /** サーバが応答を生成した時刻（ISO 8601）。 */
  generatedAt: z.string(),
  /** 入力ソースの表示名（例: ソース dir の相対パス）。 */
  sourceLabel: z.string(),
})

/** GET /api/document の成功レスポンス。 */
export type DocumentResponseBody = {
  blocks: readonly Block[]
  notes: readonly Note[]
  generatedAt: string
  sourceLabel: string
}

/** エラーレスポンスの body。 */
export const errorResponseSchema = z.object({ error: loadDocumentErrorSchema })
export type ErrorResponseBody = z.infer<typeof errorResponseSchema>

const issuesOfZodError = (error: z.ZodError): ValidationIssue[] =>
  error.issues.map((issue) => ({ path: issue.path.join('.'), message: issue.message }))

/**
 * GET /api/document のレスポンスを検証する境界。throw せず Result で返す。
 *
 * 外枠 → 入力言語（システムの実行時スキーマ）の 2 段で検証する。
 * 入力言語側の検証は Zod schema ではなく Result を返す関数なので、1 つの schema では書けない。
 * よって schema ではなく関数として提供する。
 */
export const parseDocumentResponse = (
  value: unknown,
): Result<DocumentResponseBody, LoadDocumentError> => {
  const envelope = documentEnvelopeSchema.safeParse(value)
  if (!envelope.success) {
    return err({ code: 'validation_error', issues: issuesOfZodError(envelope.error) })
  }

  const schema = createPreviewRuntimeSchema()
  const blocks = schema.validateBlocks(envelope.data.blocks, 'blocks')
  if (!blocks.success) {
    return err({ code: 'validation_error', issues: blocks.error })
  }
  const notes = schema.validateNotes(envelope.data.notes, 'notes')
  if (!notes.success) {
    return err({ code: 'validation_error', issues: notes.error })
  }

  return ok({
    blocks: blocks.data,
    notes: notes.data,
    generatedAt: envelope.data.generatedAt,
    sourceLabel: envelope.data.sourceLabel,
  })
}

/** SSE: ソース変更時に push されるイベント名。 */
export const RELOAD_EVENT = 'reload' as const
