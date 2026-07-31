/**
 * 出力側の entity（テーマ・成果物）と、配信側の entity（購読）。
 *
 * テーマは**解決済み文書より後段でだけ効く**。テーマの中身（プリアンブル・見出し語・採番方針・
 * コンポーネント差し替え）は ER の列ではなく宣言の JSON として持つ。中身の型は M4 で
 * `domain-model/theme/` に定める（論点 B-2: 閉じた役割ユニオンに限って差し替えを許す）。
 */

import { entity } from '@masaori/zod-to-entity-definitions'
import { z } from 'zod'

import { User } from './actors.ts'
import { Document, Revision } from './document.ts'

/** 出力ターゲット。増やせるのはこのシステムだけ（利用者側からは増やせない）。 */
export const RENDER_TARGETS = ['latex', 'pdf', 'web', 'book'] as const

export const Theme = entity({
  name: 'Theme',
  description: '体裁の宣言。組み込み開発者が所有し、解決済み文書より後段でだけ効く',
  columns: {
    id: z.string().pk(),
    ownerUserId: z.string().ref(User),
    name: z.string(),
    target: z.enum(RENDER_TARGETS),
    /** 宣言の JSON。形の正本は M4 で定める theme の型。 */
    declarationJson: z.string(),
  },
})

export const Artifact = entity({
  name: 'Artifact',
  description: 'ある版・あるターゲット・あるテーマから生成された出力',
  columns: {
    id: z.string().pk(),
    revisionId: z.string().ref(Revision),
    themeId: z.string().ref(Theme),
    target: z.enum(RENDER_TARGETS),
    /** 実体の所在（オブジェクトストレージのキー）。 */
    location: z.string(),
  },
})

/**
 * 購読。公開サイトを閲覧中のクライアント 1 接続（Context `live-site`）。
 * 永続化しない（storage: in-memory）が、自 domain が所有する entity なので repository が持つ。
 */
export const Subscription = entity({
  name: 'Subscription',
  description: '公開サイトの閲覧接続 1 本。版の公開通知を受け取る',
  columns: {
    id: z.string().pk(),
    documentId: z.string().ref(Document),
    /** 閲覧者が既に取得している版番号。通知された版がこれより新しければ取り直す。 */
    knownRevisionNumber: z.number().int().nullable(),
    connectedAt: z.date(),
  },
})
