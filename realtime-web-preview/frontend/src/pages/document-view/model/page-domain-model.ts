import type { Block, LoadDocumentError } from '@rwp/domain-model'

/** ロード中・失敗・取得済みを型で強制する（fetch/ui はこの形だけを介してやり取りする）。 */
export type Loadable<T> =
  | { status: 'loading' }
  | { status: 'error'; error: LoadDocumentError }
  | { status: 'ready'; value: T }

/** SSE 接続の状態。 */
export type ConnectionStatus = 'connecting' | 'live' | 'disconnected'

export type DocumentMeta = {
  generatedAt: string
  sourceLabel: string
}

export type DocumentContent = {
  blocks: Block[]
  meta: DocumentMeta
}

/**
 * document-view ページのドメインモデル。
 * 表示物と「外界に影響する操作」だけを宣言する（architecture-frontend.md）。
 * read-only ツールのため操作は手動再読込のみ。
 */
export type DocumentViewPageDomainModel = {
  document: Loadable<DocumentContent>
  connection: ConnectionStatus
  onManualReloadClick: () => void
}
