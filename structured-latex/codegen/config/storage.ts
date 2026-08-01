/**
 * storage 設定（docs/architecture-overview.md「generator の設定」）。
 *
 * entity は「同一性とライフサイクルを持つ概念」であって「どこに保存するか」とは独立している。
 * 保存先は backend の関心事なので SSOT ではなくここで宣言する。
 *
 * 規約: **SSOT の全 entity を過不足なく明示列挙する。** 未宣言・不明・重複は resolver が
 * エラーにする（`resolveStorage`）。「書き忘れ」を静かに通さないことで設定を load-bearing に保つ。
 * まだ使わない backend を先に具体化しない。
 */

/** 保存先。プロジェクト固有。実際に必要になったものだけを並べる。 */
export type StorageBackend = 'cloud-sql' | 'object-storage' | 'in-memory' | 'projected'

export type EntityStorage = { entity: string; backend: StorageBackend }

export const storageAssignments: readonly EntityStorage[] = [
  { entity: 'User', backend: 'cloud-sql' },
  { entity: 'Account', backend: 'cloud-sql' },
  { entity: 'Operator', backend: 'cloud-sql' },
  // 認可の主体は他 entity から算出される投影。DDL / repository / handler を生成しない。
  { entity: 'Requester', backend: 'projected' },
  { entity: 'Document', backend: 'cloud-sql' },
  { entity: 'DocumentInvitation', backend: 'cloud-sql' },
  { entity: 'DocumentLocale', backend: 'cloud-sql' },
  { entity: 'Revision', backend: 'cloud-sql' },
  { entity: 'Translation', backend: 'cloud-sql' },
  // ブロック列は JSON 列として持つ（形の正本は structured-text の Zod スキーマ）。
  { entity: 'Segment', backend: 'cloud-sql' },
  { entity: 'Theme', backend: 'cloud-sql' },
  // PDF / tex / 静的 Web 成果物の実体。
  { entity: 'Artifact', backend: 'object-storage' },
  // 非永続だが自 domain が所有する entity なので repository が持つ。
  { entity: 'Subscription', backend: 'in-memory' },
]
