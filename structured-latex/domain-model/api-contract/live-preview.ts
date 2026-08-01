/**
 * L2: **ローカルのライブプレビュー**（`live-preview/`）の配信契約。
 *
 * 同じ `api-contract/` にある [`live-site.ts`](./live-site.ts) とは**別物であり、統合しない**。
 * 違いは次のとおりで、統合すると片方の前提がもう片方を壊す:
 *
 * | | `live-site.ts`（公開サイト） | `live-preview.ts`（このファイル） |
 * | --- | --- | --- |
 * | 誰が書き手か | 遠隔のサーバへ**アップロードする**（`UploadSegmentsInput`） | 書き手のローカル FS を**サーバが読むだけ**（アップロードが無い） |
 * | 運ぶもの | マニフェスト + Web 成果物の断片。**Block / Node を知らない** | 入力言語そのもの（`Block` / `Note`）を丸ごと運ぶ |
 * | 取得の単位 | 版とセグメント（`contentHash` が変わった分だけ取り直す） | 文書全体を毎回取り直す（ローカル 1 プロセス・1 閲覧者のため差分の必要が無い） |
 * | 壊れた文書 | 受け入れない（`UploadSegmentsError` で拒否する） | **受け入れて画面に出す**（執筆中は壊れているのが普通。要件 F-9） |
 * | 版番号 | 楽観ロックの基準として必須 | 持たない（唯一の書き手がローカルにいるので競合が起きない） |
 *
 * throw しない。境界の検証は `.safeParse()` → Result（docs/error-handling-strategy.md §1, §5）。
 */

import { z } from 'zod'

import { err, ok, type Result } from '../result.ts'
import type { Block, Note } from '../structured-text/block.ts'
import { localeRuntimeSchema, type Locale } from '../structured-text/locale.ts'
import { createRuntimeSchema } from '../structured-text/validate.ts'
import type { RuntimeSchema, ValidationIssue } from '../structured-text/validate.ts'
import {
  availableLocalesOf,
  type LocalizedRevisionSnapshot,
  type LocalizationValidationError,
  validateLocalizedRevisionSnapshot,
} from '../resolved/localized-revision.ts'

/**
 * ライブプレビューが入力ソースを読むときの実行時スキーマ。
 *
 * プレビューは**入力言語の語彙を所有しない**（どのプロジェクトの文書でも読む立場）。
 * プロジェクト固有メタデータのキー名（integrable-lattice の `habitat` など）は知りようがないので、
 * 未知のキーを拒否しても打ち間違いの検出にはならず、正しい文書を読めなくするだけになる。
 * よって `unknownBlockMeta: 'passthrough'` を使い、**値を落とさずそのまま通す**
 * （strip すると画面に出す前にメタデータが黙って消える）。
 *
 * 意味を解釈する検証は、語彙を所有する各プロジェクトの検証ツールが行う。
 */
export const createLivePreviewRuntimeSchema = (): RuntimeSchema<string, unknown> =>
  createRuntimeSchema<string, unknown>({ unknownBlockMeta: 'passthrough' })

/** Zod 検証で失敗した 1 件（画面に path とともに表示する。要件 F-9）。 */
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
 * `GET /api/document` 成功レスポンスの外枠。
 * `blocks` / `notes` の中身はここでは見ない（入力言語の検証は実行時スキーマの責務）。
 */
const documentEnvelopeSchema = z.object({
  blocks: z.array(z.unknown()),
  /**
   * 参照用ノート（文書本体ではない）。ソースに notes が無ければ空配列。
   * 本体（blocks）と別フィールドで運び、画面側でも本文と区別して描画する。
   */
  notes: z.array(z.unknown()).default([]),
  /** サーバが応答を生成した時刻（ISO 8601）。 */
  generatedAt: z.string(),
  /** 入力ソースの表示名（例: ソース dir の相対パス）。 */
  sourceLabel: z.string(),
})

/**
 * `GET /api/document` の成功レスポンス。
 *
 * **解決前の入力言語をそのまま運ぶ。** 解決（採番・参照解決・ノート配置）は
 * `resolved/resolve.ts` の `resolveTolerantly` が受け取り側で行う。
 * サーバ側で解決してから送ると、解決済み文書の実行時スキーマがもう 1 つ要る一方、
 * 検証の関門は結局入力言語の側にあるので、契約を 1 つ増やすだけで何も得られない。
 */
export type DocumentResponseBody = {
  blocks: readonly Block[]
  notes: readonly Note[]
  generatedAt: string
  sourceLabel: string
}

/**
 * ローカライズされた文書を取得するために、クライアントが明示する locale。
 *
 * 従来の `GET /api/document` は日本語単一ロケールを含む既存ソースをそのまま運ぶ
 * 互換入口として残す。locale を必要とするクライアントだけが、この別入口（たとえば
 * `GET /api/localized-document?locale=en`）を使う。
 */
export type LoadLocalizedDocumentInput = { locale: Locale }

/** locale 指定の取得要求を受け入れる境界。クエリ文字列等の unknown をそのまま使わない。 */
export const parseLoadLocalizedDocumentInput = (
  value: unknown,
): Result<LoadLocalizedDocumentInput, LoadDocumentError> => {
  const parsed = z.object({ locale: localeRuntimeSchema }).strict().safeParse(value)
  return parsed.success
    ? ok(parsed.data)
    : err({ code: 'validation_error', issues: issuesOfZodError(parsed.error) })
}

export type LocalizedDocumentResponseBody = {
  /** この応答でクライアントが読む locale。 */
  locale: Locale
  /** 同じ document / revision の、利用可能な全ロケール。 */
  localizedRevision: LocalizedRevisionSnapshot
  generatedAt: string
  sourceLabel: string
}

export type LoadLocalizedDocumentError =
  | LoadDocumentError
  | LocalizationValidationError
  | { code: 'response_locale_not_available'; locale: Locale; availableLocales: readonly Locale[] }

/** エラーレスポンスの body。 */
export const errorResponseSchema = z.object({ error: loadDocumentErrorSchema })
export type ErrorResponseBody = z.infer<typeof errorResponseSchema>

/** locale 集約の検査から返るエラーを HTTP 応答でも失わないための形。 */
const localizationErrorSchema = z.union([
  z.object({ code: z.literal('localization_validation_error'), issues: z.array(validationIssueSchema) }),
  // issue の詳細な判別共用体は domain-model/resolved が正本。HTTP は Result をそのまま包む。
  z.object({ code: z.literal('invalid_localization'), issues: z.array(z.object({ code: z.string() }).passthrough()) }),
])

export const localizedLoadDocumentErrorSchema = z.union([
  loadDocumentErrorSchema,
  localizationErrorSchema,
  z.object({
    code: z.literal('response_locale_not_available'),
    locale: localeRuntimeSchema,
    availableLocales: z.array(localeRuntimeSchema),
  }),
])

/** locale 指定 endpoint のエラー応答。従来 endpoint の schema を狭めない別契約。 */
export const localizedErrorResponseSchema = z.object({ error: localizedLoadDocumentErrorSchema })
export type LocalizedErrorResponseBody = z.infer<typeof localizedErrorResponseSchema>

const issuesOfZodError = (error: z.ZodError): ValidationIssue[] =>
  error.issues.map((issue) => ({ path: issue.path.join('.'), message: issue.message }))

/**
 * `GET /api/document` のレスポンスを検証する境界。throw せず Result で返す。
 *
 * 外枠 → 入力言語（実行時スキーマ）の 2 段で検証する。
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

  const schema = createLivePreviewRuntimeSchema()
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

const localizedDocumentEnvelopeSchema = z
  .object({
    locale: localeRuntimeSchema,
    localizedRevision: z.unknown(),
    generatedAt: z.string(),
    sourceLabel: z.string(),
  })
  .strict()

/**
 * locale 指定のライブプレビュー応答を検証する境界。
 *
 * 既存の `parseDocumentResponse` と意図的に統合しない。旧応答には `blocks` / `notes`
 * しか無く、locale / revision を後から推測すると、単一ロケール文書の互換性と
 * 「原文ロケールを明示する」不変条件のどちらも弱くなるためである。
 */
export const parseLocalizedDocumentResponse = (
  value: unknown,
): Result<LocalizedDocumentResponseBody, LoadLocalizedDocumentError> => {
  const envelope = localizedDocumentEnvelopeSchema.safeParse(value)
  if (!envelope.success) {
    return err({ code: 'validation_error', issues: issuesOfZodError(envelope.error) })
  }

  const localized = validateLocalizedRevisionSnapshot(
    envelope.data.localizedRevision,
    createLivePreviewRuntimeSchema(),
    'localizedRevision',
  )
  if (!localized.success) return err(localized.error)
  const availableLocales = availableLocalesOf(localized.data)
  if (!availableLocales.includes(envelope.data.locale)) {
    return err({
      code: 'response_locale_not_available',
      locale: envelope.data.locale,
      availableLocales,
    })
  }
  return ok({
    locale: envelope.data.locale,
    localizedRevision: localized.data,
    generatedAt: envelope.data.generatedAt,
    sourceLabel: envelope.data.sourceLabel,
  })
}

/**
 * SSE: 入力ソースが変わったときに push されるイベント名。
 * 差分は含めない（公開サイトの `LiveEvent` と同じ思想で、通知だけを送り取得は閲覧側が行う）。
 */
export const PREVIEW_RELOAD_EVENT = 'reload' as const
