/**
 * SSOT の entity 一覧。ここに列挙されたものが ER モデル（framework-agnostic な
 * Entity Definition）の全体であり、codegen はこれだけを入力に取る。
 *
 * **entity にしないもの**（判定は「CRUD エンドポイントを生成すべきか」）:
 *   - Block / Node / Note … Segment が持つ値。ブロック単体の CRUD API は存在しない
 *   - ResolvedDocument / LabelIndex … 版と採番方針から導出される投影。永続化しない
 */

export { Account, Operator, Requester, User } from './actors.ts'
export {
  DOCUMENT_VISIBILITIES,
  Document,
  DocumentInvitation,
  DocumentLocale,
  Revision,
  Segment,
  Translation,
} from './document.ts'
export { Artifact, RENDER_TARGETS, Subscription, Theme } from './output.ts'

import { Account, Operator, Requester, User } from './actors.ts'
import { Document, DocumentInvitation, DocumentLocale, Revision, Segment, Translation } from './document.ts'
import { Artifact, Subscription, Theme } from './output.ts'

/** 生成器の入力。**全 entity を過不足なく列挙する**（漏れは storage 解決でエラーになる）。 */
export const allEntities = [
  User,
  Account,
  Operator,
  Requester,
  Document,
  DocumentInvitation,
  DocumentLocale,
  Revision,
  Segment,
  Translation,
  Theme,
  Artifact,
  Subscription,
]
