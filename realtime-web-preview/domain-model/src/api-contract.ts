import { z } from 'zod'
import { blockSchema } from './block.js'

/**
 * BE / FE 間の API 契約（共通語彙）。
 * operation ごとに error code を網羅定義する（error-handling-strategy.md §3）。
 * 型は Zod schema から推論し、BE の送信と FE の境界検証で同一の定義を共有する。
 */

/** Zod 検証で失敗した1件（FE は path とともに画面表示する; F-9）。 */
export const validationIssueSchema = z.object({
  path: z.string(),
  message: z.string(),
})
export type ValidationIssue = z.infer<typeof validationIssueSchema>

/** ドキュメント取得 operation のエラー（網羅）。 */
export const loadDocumentErrorSchema = z.discriminatedUnion('code', [
  z.object({ code: z.literal('source_not_found') }),
  z.object({ code: z.literal('source_empty') }),
  z.object({ code: z.literal('validation_error'), issues: z.array(validationIssueSchema) }),
  z.object({ code: z.literal('source_read_error'), message: z.string() }),
])
export type LoadDocumentError = z.infer<typeof loadDocumentErrorSchema>
export type LoadDocumentErrorCode = LoadDocumentError['code']

/** GET /api/document の成功レスポンス。 */
export const documentResponseSchema = z.object({
  blocks: z.array(blockSchema),
  /** サーバが応答を生成した時刻（ISO 8601）。 */
  generatedAt: z.string(),
  /** 入力ソースの表示名（例: ソース dir の相対パス）。 */
  sourceLabel: z.string(),
})
export type DocumentResponseBody = z.infer<typeof documentResponseSchema>

/** エラーレスポンスの body。 */
export const errorResponseSchema = z.object({ error: loadDocumentErrorSchema })
export type ErrorResponseBody = z.infer<typeof errorResponseSchema>

/** SSE: ソース変更時に push されるイベント名。 */
export const RELOAD_EVENT = 'reload' as const
