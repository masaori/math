import {
  type DocumentResponseBody,
  type LoadDocumentError,
  RELOAD_EVENT,
  documentResponseSchema,
  errorResponseSchema,
} from '@rwp/domain-model'
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

  const parsed = documentResponseSchema.safeParse(json)
  if (!parsed.success) {
    throw new DocumentFetchError({
      code: 'validation_error',
      issues: parsed.error.issues.map((issue) => ({
        path: issue.path.join('.'),
        message: issue.message,
      })),
    })
  }
  return parsed.data
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
  return {
    status: 'ready',
    value: {
      blocks: query.data.blocks,
      meta: { generatedAt: query.data.generatedAt, sourceLabel: query.data.sourceLabel },
    },
  }
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
    source.addEventListener(RELOAD_EVENT, () => {
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
