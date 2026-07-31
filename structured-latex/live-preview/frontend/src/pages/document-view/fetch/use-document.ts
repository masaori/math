import {
  DEFAULT_NUMBERING_POLICY,
  type DocumentResponseBody,
  type LoadDocumentError,
  PREVIEW_RELOAD_EVENT,
  type ResolveOptions,
  errorResponseSchema,
  parseDocumentResponse,
  resolveTolerantly,
} from '@structured-latex/system/domain-model'
import { type UseQueryResult, useQuery, useQueryClient } from '@tanstack/react-query'
import { useEffect, useState } from 'react'
import type {
  ConnectionStatus,
  DocumentContent,
  DocumentViewPageDomainModel,
  Loadable,
} from '../model/page-domain-model'

const DOCUMENT_QUERY_KEY = ['document'] as const

/** 外界（fetch）のエラーを LoadDocumentError として運ぶための Error。 */
class DocumentFetchError extends Error {
  readonly loadError: LoadDocumentError
  constructor(loadError: LoadDocumentError) {
    super(loadError.code)
    this.name = 'DocumentFetchError'
    this.loadError = loadError
  }
}

const messageOf = (cause: unknown): string =>
  cause instanceof Error ? cause.message : String(cause)

const toLoadError = (cause: unknown): LoadDocumentError =>
  cause instanceof DocumentFetchError
    ? cause.loadError
    : { code: 'source_read_error', message: messageOf(cause) }

/** GET /api/document を Result 相当に変換する境界。失敗は DocumentFetchError で throw（TanStack Query が捕捉）。 */
const fetchDocument = async (): Promise<DocumentResponseBody> => {
  let response: Response
  try {
    response = await fetch('/api/document')
  } catch (cause) {
    throw new DocumentFetchError({ code: 'source_read_error', message: messageOf(cause) })
  }

  const json: unknown = await response.json().catch(() => undefined)

  if (!response.ok) {
    const parsedError = errorResponseSchema.safeParse(json)
    throw new DocumentFetchError(
      parsedError.success
        ? parsedError.data.error
        : { code: 'source_read_error', message: `HTTP ${response.status}` },
    )
  }

  // 入力言語（ブロック・ノート）の検証はシステムの実行時スキーマが行う（parseDocumentResponse）。
  const parsed = parseDocumentResponse(json)
  if (!parsed.success) {
    throw new DocumentFetchError(parsed.error)
  }
  return parsed.data
}

/**
 * 解決の方針。
 * `audience: 'working'` … 執筆中の画面なので参照用ノートを配置する（出版物では外れる。I5）。
 * 採番はシステムの既定方針（定理型は 1 本のカウンタを共有し、節ごとにリセット）をそのまま使う。
 */
const RESOLVE_OPTIONS: ResolveOptions = {
  numbering: DEFAULT_NUMBERING_POLICY,
  audience: 'working',
}

/**
 * 受け取った入力言語を解決済み文書へ写す。
 *
 * **ここが唯一の解決経路で、実装はシステム側にある**（`resolveTolerantly`）。
 * 未解決参照・迷子ノート・重複があっても解決を止めず、診断として持ち帰るので、
 * 壊れている文書でも画面は落ちない（F-9）。
 *
 * サーバが返すのはファイル名昇順で結合済みのブロック列なので、セグメントは 1 つでよい。
 */
const resolveResponse = (body: DocumentResponseBody): DocumentContent => {
  const { document, orphanNotes, diagnostics } = resolveTolerantly(
    {
      documentId: body.sourceLabel,
      revision: 1,
      segments: [{ key: 'preview', blocks: body.blocks, notes: body.notes }],
    },
    RESOLVE_OPTIONS,
  )
  return {
    document,
    orphanNotes,
    diagnostics,
    meta: {
      generatedAt: body.generatedAt,
      sourceLabel: body.sourceLabel,
      noteCount: body.notes.length,
    },
  }
}

const toLoadable = (
  query: UseQueryResult<DocumentResponseBody, Error>,
): Loadable<DocumentContent> => {
  if (query.status === 'pending') {
    return { status: 'loading' }
  }
  if (query.status === 'error') {
    return { status: 'error', error: toLoadError(query.error) }
  }
  return { status: 'ready', value: resolveResponse(query.data) }
}

/**
 * 外界アクセスを担う hook。GET /api/document を取得し、SSE /api/events で変更を購読して
 * 再取得する（F-5）。PageDomainModel を返し、ui は外界を一切知らない。
 */
export const useDocument = (): DocumentViewPageDomainModel => {
  const queryClient = useQueryClient()
  const [connection, setConnection] = useState<ConnectionStatus>('connecting')

  const query = useQuery({ queryKey: DOCUMENT_QUERY_KEY, queryFn: fetchDocument })

  useEffect(() => {
    const source = new EventSource('/api/events')
    const markLive = (): void => setConnection('live')

    source.addEventListener('open', markLive)
    source.addEventListener('connected', markLive)
    source.addEventListener(PREVIEW_RELOAD_EVENT, () => {
      void queryClient.invalidateQueries({ queryKey: DOCUMENT_QUERY_KEY })
    })
    source.addEventListener('error', () => setConnection('disconnected'))

    return () => {
      source.close()
    }
  }, [queryClient])

  return {
    document: toLoadable(query),
    connection,
    onManualReloadClick: () => {
      void queryClient.invalidateQueries({ queryKey: DOCUMENT_QUERY_KEY })
    },
  }
}
