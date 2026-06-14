import {
  type DocumentResponseBody,
  type ErrorResponseBody,
  type LoadDocumentError,
  assertNever,
} from '@rwp/domain-model'
import type { FastifyReply, FastifyRequest } from 'fastify'
import type { BlockSourceGateway } from '../../preview/domain/interfaces/gateways/block-source-gateway.js'
import { getDocument } from '../../preview/domain/usecases/get-document.js'

const statusForError = (error: LoadDocumentError): number => {
  switch (error.code) {
    case 'source_not_found':
      return 404
    case 'source_empty':
      return 404
    case 'validation_error':
      return 422
    case 'source_read_error':
      return 500
    default:
      return assertNever(error)
  }
}

/**
 * GET /api/document ハンドラ。
 * usecase の Result を api-contract 準拠のレスポンスにシリアライズするだけ（薄く保つ）。
 */
export const makeGetDocumentHandler =
  (blockSource: BlockSourceGateway) =>
  async (_request: FastifyRequest, reply: FastifyReply): Promise<void> => {
    const result = await getDocument(blockSource)

    if (result.success) {
      const body: DocumentResponseBody = {
        blocks: result.data.blocks,
        generatedAt: new Date().toISOString(),
        sourceLabel: result.data.sourceLabel,
      }
      await reply.code(200).send(body)
      return
    }

    const body: ErrorResponseBody = { error: result.error }
    await reply.code(statusForError(result.error)).send(body)
  }
