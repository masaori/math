import type { LoadDocumentError, Result } from '@rwp/domain-model'
import type {
  BlockSourceGateway,
  LoadedDocument,
} from '../interfaces/gateways/block-source-gateway.js'

/**
 * 入力ソースから現在のドキュメントを取得する。
 * gateway を DI で受け取り、Result をそのまま伝搬する（throw しない）。
 */
export const getDocument = (
  blockSource: BlockSourceGateway,
): Promise<Result<LoadedDocument, LoadDocumentError>> => blockSource.load()
