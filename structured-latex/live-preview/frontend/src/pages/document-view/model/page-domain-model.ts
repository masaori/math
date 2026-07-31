import type {
  LoadDocumentError,
  ResolveDiagnostic,
  ResolvedDocument,
  ResolvedNote,
} from '@structured-latex/system/domain-model'

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
  /** 入力ソースにあった参照用ノートの件数（配置後の延べ数ではなく入力の件数）。 */
  noteCount: number
}

/**
 * 画面が描く文書。**解決済み（採番・参照解決・ノート配置が済んだ）状態**である。
 *
 * 解決はシステムの `resolveTolerantly` が行う。ビューアはラベル解決もノート配置も自前で持たない
 * （かつては持っていて、システムの `resolve` と同じことを 2 度実装していた）。
 */
export type DocumentContent = {
  document: ResolvedDocument
  /** 紐づけ先が見つからなかった参照用ノート。捨てずに警告として画面に出す。 */
  orphanNotes: readonly ResolvedNote[]
  /** 未解決参照・重複などの不備。壊れていても画面は落とさず、ここを見せる（F-9）。 */
  diagnostics: readonly ResolveDiagnostic[]
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
