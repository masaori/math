import type { LoadDocumentError, Note, Result } from '@rwp/domain-model'

/**
 * 参照用ノートの入力ソース（外部 domain: ファイルシステム + ソース形式）への gateway。
 * ノートは文書本体ではないため、ソースが存在しない構成も正常系として扱う（空配列を返す）。
 */
export interface NoteSourceGateway {
  load(): Promise<Result<Note[], LoadDocumentError>>
}
