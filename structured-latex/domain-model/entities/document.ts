/**
 * Context `document` の entity（docs/domain-model.md §5.1, §5.7）。
 *
 * ER entity にするかどうかの判定は「その概念に CRUD エンドポイントを生成すべきか」で行う。
 * したがって **Block / Node / Note は entity ではない**。ブロック単体を更新する API は存在せず
 * （更新の単位はセグメント）、Node は同一性を持たない。これらは Segment が持つ**値**であり、
 * 型と実行時スキーマは `domain-model/structured-text/` が正本である。
 */

import { entity } from '@masaori/zod-to-entity-definitions'
import { z } from 'zod'

import { User } from './actors.ts'

/**
 * 文書の可視性（論点 C-2 の確定に対応）。
 * `public` は誰でも読める。`invited` は所有者と招待された閲覧者だけが読める。
 */
export const DOCUMENT_VISIBILITIES = ['public', 'invited'] as const

/** 集約ルート。ラベル一意性・参照解決の効力範囲。 */
export const Document = entity({
  name: 'Document',
  description: '論文・書籍 1 本。正本の単位であり、不変条件 I1-I3 の効力範囲',
  columns: {
    id: z.string().pk(),
    ownerUserId: z.string().ref(User),
    title: z.string(),
    /** 公開範囲。論点 C-2（文書ごとに公開／限定を選べる）の確定による。 */
    visibility: z.enum(DOCUMENT_VISIBILITIES),
    /** 現在公開中の版番号。未公開なら null。 */
    publishedRevisionNumber: z.number().int().nullable(),
  },
})

/**
 * 限定公開の文書に招待された閲覧者（論点 C-2）。
 *
 * この entity は owner subject（User）へ至る FK パスが 2 本ある
 * （`documentId → Document.ownerUserId → User` と `inviteeUserId → User`）。
 * 認可戦略 §4.2 により、パスが一意でない entity の owner は generator がエラーにする。
 * したがって **policy 側で経路を明示する**（docs/domain-model.md §12）。
 */
export const DocumentInvitation = entity({
  name: 'DocumentInvitation',
  description: '限定公開の文書へ招待された閲覧者',
  columns: {
    id: z.string().pk(),
    documentId: z.string().ref(Document),
    inviteeUserId: z.string().ref(User),
  },
})

/**
 * 版。ある時点の文書全体の確定スナップショット。
 * 確定後は不変。番号は 1 始まりの単調増加（順序比較で収束を判定するため文字列にしない）。
 */
export const Revision = entity({
  name: 'Revision',
  description: '文書全体の確定スナップショット。不変条件 I1-I3 を満たすことが確定している',
  columns: {
    id: z.string().pk(),
    documentId: z.string().ref(Document),
    number: z.number().int(),
    publishedAt: z.date(),
  },
})

/**
 * セグメント。**部分アップロードの単位**であり、`key` が文書順のキー。
 *
 * ブロック列とノート列はここが持つ値だが、**ER の列としては JSON 文字列**にしてある。
 * 理由: ブロックは再帰構造（ノードがノードを含む）で、ER のプロパティ型
 * （primitive / struct / 参照）では表現できないため。実測でも
 * `z.array(z.unknown())` / `z.record(z.unknown())` は "Unsupported schema type" になる。
 * 形の正本は `domain-model/structured-text/` の型と Zod スキーマであり、
 * 境界（アップロード受け入れ時）で `createRuntimeSchema` により検証する。
 */
export const Segment = entity({
  name: 'Segment',
  description: 'アップロードの単位。key が文書順のキー。内容は構造化テキストの JSON',
  columns: {
    id: z.string().pk(),
    revisionId: z.string().ref(Revision),
    key: z.string(),
    /** 内容ハッシュ。マニフェストで「変わったセグメントだけ取り直す」ために使う。 */
    contentHash: z.string(),
    /** ブロック列の JSON。形の正本は structured-text の Zod スキーマ。 */
    blocksJson: z.string(),
    /** 参照用ノート列の JSON。出版ターゲットでは読まれない（I5）。 */
    notesJson: z.string(),
  },
})
