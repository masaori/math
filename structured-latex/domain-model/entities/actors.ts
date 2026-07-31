/**
 * 認可の主体まわりの entity（docs/authorization-strategy.md §1, §2）。
 *
 * 認証は IdP へ委譲し、domain-model が持つのは「誰か」を指す参照だけである。
 * 顧客側 actor（User / Account）と運営側 actor（Operator）は別 entity に分ける。
 */

import { entity } from '@masaori/zod-to-entity-definitions'
import { z } from 'zod'

/** 所有判定の主体（owner subject）。文書とテーマを所有する。 */
export const User = entity({
  name: 'User',
  description: '著者・組み込み開発者。文書とテーマの所有者',
  columns: {
    id: z.string().pk(),
    displayName: z.string(),
  },
})

/** 認証済みであることを表す entity。IdP の外部 ID をここで受ける。 */
export const Account = entity({
  name: 'Account',
  description: 'IdP で認証された利用者アカウント。externalId は IdP 側の識別子',
  columns: {
    id: z.string().pk(),
    userId: z.string().ref(User),
    externalId: z.string().unique(),
  },
})

/** 運営側 actor。admin 判定に使う。 */
export const Operator = entity({
  name: 'Operator',
  description: '運営。admin 判定の主体',
  columns: {
    id: z.string().pk(),
    externalId: z.string().unique(),
  },
})

/**
 * 認可の実行主体。**永続化しない projected entity**（storage: projected）。
 * 認証ミドルウェアが外部 ID を解決して組み立てる。
 * 派生述語は参照の有無から導出する（`accountId != null` ⇒ authenticated 等）。
 */
export const Requester = entity({
  name: 'Requester',
  description: '認可の実行主体（projected。永続化しない）',
  columns: {
    userId: z.string().ref(User).nullable(),
    accountId: z.string().ref(Account).nullable(),
    operatorId: z.string().ref(Operator).nullable(),
  },
})
