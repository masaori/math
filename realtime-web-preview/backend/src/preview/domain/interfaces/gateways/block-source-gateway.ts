import type { Block, LoadDocumentError, Result } from '@rwp/domain-model'

/** 入力ソースから読み込んだドキュメント。 */
export type LoadedDocument = {
  blocks: Block[]
  /** 入力ソースの表示名（例: ソース dir の相対パス）。 */
  sourceLabel: string
}

/**
 * 構造化テキストの入力ソース（外部 domain: ファイルシステム + ソース形式）への gateway。
 * 永続化する自 domain entity は持たないため repository ではなく gateway とする
 * （architecture-backend.md）。
 */
export interface BlockSourceGateway {
  load(): Promise<Result<LoadedDocument, LoadDocumentError>>
}
