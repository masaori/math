# 認可（Authorization）戦略

**設定（policy）から BE / FE 双方の認可チェックを機械生成する**ための方針。手書きの `if` を usecase やコンポーネントに散らさず、SSOT（[domain-model](./architecture-overview.md#2-single-source-of-truth-ssot)）から生成した単一ルールで判定する。これも「できるだけ多くを自動生成し、エントロピーを最小化する」という思想（[プログラミング哲学](./programming-philosophy.md)）の一適用である。

- **BE**: 各 usecase の冒頭で `authorize(actor, action, resource)` を呼ぶ。
- **FE**: UI の表示/非表示を `can(action, resource, actor)` で判定する。
- 両者は**同じ policy から生成**されるため、サーバとクライアントで判定がズレない。

> ここでのコード例は TypeScript / Zod / Go を用いるが、述べている原則（認可を relation graph から機械導出する）は言語・技術非依存である。生成先が別言語でも同じ policy から各言語の判定コードを吐ける。

## 1. 認証と認可を分離する

混乱の元は「認証（誰か）」と「認可（何をしてよいか）」の混同にある。まず分ける。

| | 認証 authn | 認可 authz |
|---|---|---|
| 問い | このリクエストは誰から？ | この人はこの操作をしてよい？ |
| 担当 | **IdP（OIDC プロバイダ）** | **domain-model（SSOT）** |
| 出力 | 外部 ID（例: `userId`）＝誰か | allow / deny |

原則:

- **認証は IdP に委譲する。** ログイン・パスワード・MFA・メール確認・トークン発行を自前実装しない。認証は gateway（[バックエンドアーキテクチャ](./architecture-backend.md)の `auth-gateway`）で抽象化し、特定 IdP に固有依存しない。IdP からは「外部 ID（誰か）」だけを受け取る。
- **認可は 100% domain-model が持つ。** IdP の role / grant 機能は使わない。使うと認可の SSOT が IdP と domain に分裂する。actor の区分・状態・owner・admin はすべて domain の entity / relation で表現する。

## 2. actor モデルと「認可の主体」= projected entity

認可の主体（principal）を **projected entity**（永続化しない投影型。[storage 設定](./architecture-overview.md#generator-の設定-storage-と-index)参照）として domain-model に定義する。認証ミドルウェアが外部 ID を解決して組み立てる。

```typescript
// domain-model/entities/*.ts — 認可の実行主体（永続化しない projected 型）
export const Requester = entity({
  name: 'Requester',
  columns: {
    // 所有判定の主体（owner subject）への参照。匿名含む
    userId: z.string().ref(User).nullable(),
    // 認証済みであることを表す参照（authenticated 判定に使う）
    accountId: z.string().ref(Account).nullable(),
    // 運営側の参照（admin 判定に使う）
    operatorId: z.string().ref(Operator).nullable(),
  },
})
```

- **主体を野良型（`AuthzActor` 等）で作らない。** SSOT に projected entity として定義し、BE（Go struct）/ FE（TS type）を生成する。認可判定はこの型を主体に評価する。
- 派生述語（`isAuthenticated` / `isAdmin`）は**参照の有無から導出**する。冗長な bool を野良で持たない（`accountId != null` ⇒ authenticated、`operatorId != null` ⇒ admin）。
- 顧客側 actor と運営側 actor は**別 entity**として分ける（両方 IdP で認証されるが役割が違う）。認可時、外部 ID がどちらの entity にあるかで分岐する。

## 3. 権限の2軸: 属性(ABAC) × 関係(ReBAC)

| | ABAC（属性ベース） | ReBAC（関係ベース）= owner |
|---|---|---|
| 何で決まる | **actor の役割・状態**（誰であるか） | **データとの関係**（その resource が自分に紐づくか） |
| resource 依存 | しない（役割で全体） | インスタンスごとに変わる |
| 判定 | actor 属性（参照の有無） | relation path を辿る |
| 属する側 | 主に運営側（admin） | ユーザー側（owner） |

actor 種別は OR で結合する（いずれか満たせば許可）。代表例:

- `public` — 誰でも（未認証含む）
- `authenticated` — 認証済み（`accountId` を持つ）
- `owner` — その resource が actor（owner subject）のもの。**relation graph の FK パスで判定**
- `admin` — 運営（`operatorId` を持つ）

例: `read Order = owner ∨ admin`（本人は自分の注文だけ、admin は全部）。

## 4. owner を relation graph から機械解決する（本戦略の核）

owner ルールは、**resource entity から owner subject entity へ至る FK パス**を relation graph から辿って機械的に導出する。これが「認可が domain-model/entities の構造に依存する」中身であり、手で owner 判定を書かない根拠である。

### 4.1 owner subject への FK パス

entity 定義の `.ref()`（FK）が relation graph の辺になる。owner subject（例では `User`）へ至るパスを全列挙し、**一意に定まるパスだけを owner path として採用**する。

```
Order.userId → User                          (owner, 1ホップ)
OrderItem.orderId → Order.userId → User      (owner, 2ホップ = 親経由)
Payment.orderId → Order → User               (owner, 多ホップ)
Address.userId → User                        (owner, 1ホップ)
```

- **self**（entity 自身が owner subject）はパス長 0。resource の id と `actor.userId` を照合する。
- **多ホップ**は親 entity をロードしながら FK を辿り、終端の FK を `actor.userId` と照合する。
- 子 entity（`OrderItem` 等）に owner を付けると、親（`Order`）経由の多ホップパスで自動的に所有判定される。手で書く必要がない。

### 4.2 パスが一意でないときはエラーにする

owner subject へ至る FK パスが **複数存在する** entity は、どの経路で「所有」を判定すべきか一意に決まらない。これは deny-by-default では隠せない設計上の曖昧さなので、generator が**エラーで落とす**。

```
// owner subject への経路が2つある（どちらで所有判定すべきか不明）
ShipmentItem.shipmentId → Shipment → ... → User
ShipmentItem.orderItemId → OrderItem → Order → User
→ owner が ambiguous。明示的に経路を指定するか、admin へ退避する。
```

- パスが 0 本（owner を使うのに owner subject へ到達できない）→ エラー。
- パスが 2 本以上 → エラー。呼び出し側で経路を明示するか、当該 resource の owner を諦めて admin にする。

> resolver の考え方は storage / index 設定と共通で、「SSOT と突合し、曖昧・抜け漏れは既定で埋めずエラーにする」（[generator の設定](./architecture-overview.md#generator-の設定-storage-と-index)）。

### 4.3 owner path 解決のエッセンス（擬似コード）

```typescript
// resource entity から owner subject へ至る referTo(FK) パスを全列挙
function findOwnerPaths(ssot, entity, visited): Step[][] {
  if (entity === OWNER_SUBJECT) return [[]]           // self / 終端
  const paths = []
  for (const fk of ssot.getRelation(entity).referTos) { // .ref() が張った辺
    if (visited.has(fk.entityName)) continue            // 循環を避ける
    for (const sub of findOwnerPaths(ssot, fk.entityName, visited.add(entity))) {
      paths.push([{ from: entity, fk: fk.propertyName, to: fk.entityName }, ...sub])
    }
  }
  return paths
}

function resolveOwnerPath(ssot, entity): Step[] {
  if (entity === OWNER_SUBJECT) return []
  const paths = findOwnerPaths(ssot, entity, new Set())
  if (paths.length === 0) throw new Error(`${entity}: owner を使うが owner subject への FK パスが無い`)
  if (paths.length > 1)  throw new Error(`${entity}: owner subject への FK パスが一意でない（ambiguous）`)
  return paths[0]
}
```

## 5. policy の宣言（API アクセス契約 = SSOT に置く）

policy は「誰が resource に何をしてよいか」という **API の契約**なので、SSOT 側（`domain-model/api-contract/`）に本籍を置く。storage / index が backend の関心事として generator 設定に置かれるのと対照的である（[置き場の区別](#7-宣言の置き場policy-と-storage-と-index)）。

```typescript
// domain-model/api-contract/policies.ts
export type PolicyActor = 'public' | 'authenticated' | 'owner' | 'admin'

export type ResourcePolicy = {
  entity: string
  read?: PolicyActor[]
  create?: PolicyActor[]
  update?: PolicyActor[]
  delete?: PolicyActor[]
}

export const policies: ResourcePolicy[] = [
  { entity: 'User',    read: ['owner', 'admin'], create: ['public'],  update: ['owner', 'admin'] },
  { entity: 'Account', read: ['owner', 'admin'], create: ['authenticated'] },
  { entity: 'Order',   read: ['owner', 'admin'], create: ['owner'] },   // update/delete 省略 ⇒ admin のみ
  { entity: 'OrderItem', read: ['owner', 'admin'] },                     // owner は Order 経由で解決
  { entity: 'Address', read: ['owner'], create: ['owner'], update: ['owner'], delete: ['owner'] },
  { entity: 'Product', read: ['public'] },                               // create/update/delete ⇒ admin のみ
  // ...全 resource entity を明示（下記ルール）
]
```

宣言ルール:

- **action 省略時は deny-by-default**（`['admin']` = 運営のみ）。明示しない操作を暗黙に開けない。
- **全 resource entity の policy を明示必須**にする。SSOT の（projected を除く）全 entity が過不足なく1回ずつ宣言されていることを resolver が検証し、未登録・不明・重複・二重宣言をすべてエラーにする。「書き忘れ」を検出するためであり、deny-by-default でも省略を許さない。
- **projected entity は resource ではない**ので policy を持たない（持つとエラー）。DDL/handler が生成されず API リソースにならないため。

## 6. 生成物: 同一 policy から BE と FE

同じ `policies` から、BE の `authorize`（実権威）と FE の `can`（表示判定）を生成する。判定がズレない。

- **BE `Authorize<Action><Entity>(actor, resource) (bool, error)`** — usecase 冒頭で呼ぶ。owner は 4 で解決した FK パスを **repository で辿って**（多ホップは親をロード）`actor.userId` と照合。属性系は参照の有無で判定。
- **FE `can<Action><Entity>(actor, ownerId?) bool`** — UI の表示/非表示に使う。FE は relation を辿れないため、owner 判定は**呼び出し側が resource の所有者 id（`ownerId`）を渡す契約**とする（1ホップは `resource.userId`、self は `resource.id`、多ホップは表示中の親コンテキストが持つ id）。
- **最終的な認可は必ず BE が行う。** FE の `can` は体験向上のための先行判定であり、権威ではない。

> `create` の owner は「自分のものとして作る」なので resource インスタンスが無い。actor が owner subject を持つ（`userId != null`）ことをもって許可する。

## 7. 宣言の置き場（policy と storage と index）

認可・保存・インデックスは、どれも「entity に対して付随情報を宣言し、SSOT と突合して生成する」点で同型だが、**本籍が違う**。何の関心事かで決まる。

| 宣言 | 本籍 | 理由 |
|---|---|---|
| policy（誰が何をしてよいか） | `domain-model/api-contract/` | **API の契約**。クライアントとの取り決めであり SSOT の一部 |
| aggregate（[応答に何を巻き込むか](./api-contract-aggregates.md)） | `domain-model/api-contract/` | **API の契約**（応答の形）。policy と同じく SSOT の一部 |
| storage（どこに保存するか） | `codegen/config/` | **backend の関心事**。framework 非依存の SSOT に持たせない |
| index（DB 固有の索引/制約） | `codegen/config/` | **DB 固有**。SSOT では表現できない |

いずれの resolver も検証方針は共通:「明示宣言のみを正とし、既定で埋めない。SSOT と突合して、不明・重複・抜け漏れ・曖昧をすべてエラーにする。」

## 8. 将来耐性: relation path で owner 範囲が自然に広がる

owner を relation path で判定しておくと、モデルが育っても認可ロジックを書き換えずに済む。個人 → 組織への拡張例:

```
今:    Account → User(個人)   → 自分の Order
将来:  Account → User(組織)   → 組織の全 Order（同僚の注文も見える）
```

owner の範囲が **パス延長で自然に広がる**。これが「認可を relation graph から生成する」最大の利点であり、最初から relation ベースで作る根拠である。

## 9. 設計エッセンスまとめ

1. **authn と authz を分離**し、authz は 100% domain-model に置く（IdP の role を使わない）。
2. 認可の主体を **projected entity**（`Requester`）として SSOT に定義し、野良型を作らない。
3. 権限は **ABAC（属性）× ReBAC（owner = relation path）** の2軸。actor は OR 結合。
4. **owner は entity の FK（`.ref()`）が張る relation graph から機械解決**する。多ホップ可。**一意に決まらなければエラー**（曖昧さを黙って埋めない）。
5. policy は **API 契約として SSOT に宣言**。action 省略は deny-by-default、全 resource entity 明示必須。
6. **同一 policy から BE `authorize`（権威）と FE `can`（表示）を生成**し、判定のズレをなくす。
