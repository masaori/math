/**
 * 配信と受け入れの契約（docs/domain-model.md §6, §9）。
 *
 * 要点:
 *   - **アップロードの単位はセグメント、公開の単位は文書全体の版**。
 *   - 差分は push しない。「版 N が公開された」という無効化通知だけを送り、取得は閲覧者が行う。
 *   - `live-site` が受け取るのはマニフェストと Web 成果物の断片だけで、Block / Node を知らない。
 */

import type { RevisionNumber } from '../resolved/resolved-document.ts'
import type { SegmentKey } from '../resolved/resolve.ts'
import type { ValidationIssue } from '../structured-text/validate.ts'
import type { Block, Note } from '../structured-text/block.ts'

export type { RevisionNumber, SegmentKey }

export type DocumentManifest = {
  documentId: string
  revision: RevisionNumber
  publishedAt: string
  /** 文書順に並ぶ。`contentHash` が変わったセグメントだけ取り直せばよい。 */
  segments: readonly { key: SegmentKey; contentHash: string }[]
}

/** SSE で push するイベント。**差分は含めない**（サーバが持つ状態を増やさないため）。 */
export type LiveEvent =
  | { type: 'revision-published'; documentId: string; revision: RevisionNumber }
  | { type: 'heartbeat' }

/**
 * セグメントのアップロード。
 *
 * `upserts` は**キー単位の全置換**である。部分マージの規則を持たない
 * （持つと「同じ結果を作る書き方」が複数生まれ、エントロピーが増える）。
 *
 * `baseRevision` は楽観ロック（論点 E-1 の確定）。書き手は単一という前提だが、
 * lost update を検出して拒否できるようにこの契約は型に残す。
 *
 * **将来要求（ゼミ形式の共同執筆）との関係**: 複数著者が 1 本を書き、同時に編集できるのは
 * 常に 1 人（編集権の受け渡し）という拡張は、この契約を**壊さずに加算だけ**で満たせる。
 * 入力の形も全置換という規則も変わらず、増えるのは
 *   (1) 編集権を持たない者のアップロードを拒む `editing_right_not_held` エラー 1 種
 *   (2) 編集権そのものを表す entity
 * だけである。編集が直列化されるためマージ規則は依然として不要で、
 * 楽観ロックは「編集権を受け渡した後に、前の保持者が古い版を基準に投げてきた」場合の
 * 検出器としてそのまま働く。詳細は docs/domain-model.md §16。
 */
export type UploadSegmentsInput = {
  documentId: string
  baseRevision: RevisionNumber
  upserts: readonly {
    key: SegmentKey
    blocks: readonly Block[]
    notes?: readonly Note[]
  }[]
  deletes: readonly SegmentKey[]
}

/** operation ごとに code を網羅する（docs/error-handling-strategy.md §3）。 */
export type UploadSegmentsError =
  | { code: 'document_not_found' }
  | { code: 'forbidden' }
  | { code: 'revision_conflict'; currentRevision: RevisionNumber }
  | { code: 'validation_error'; issues: readonly ValidationIssue[] }
  | { code: 'duplicate_label'; labels: readonly string[] }
  | { code: 'duplicate_block_id'; blockIds: readonly string[] }
  | { code: 'duplicate_note_id'; noteIds: readonly string[] }
  | { code: 'duplicate_segment_key'; keys: readonly SegmentKey[] }
  | { code: 'unresolved_reference'; references: readonly { fromBlockId: string; target: string }[] }
  | { code: 'orphan_note'; noteIds: readonly string[] }
  | { code: 'empty_document' }
  | { code: 'unknown_segment_key'; keys: readonly SegmentKey[] }
  | { code: 'internal_error' }

export type GetManifestError =
  | { code: 'document_not_found' }
  | { code: 'forbidden' }
  | { code: 'not_published' }
  | { code: 'internal_error' }

export type GetFragmentError =
  | { code: 'document_not_found' }
  | { code: 'forbidden' }
  | { code: 'revision_not_found' }
  | { code: 'segment_not_found' }
  | { code: 'internal_error' }
