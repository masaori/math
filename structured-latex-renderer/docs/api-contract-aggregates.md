# API 集約（Aggregate）定義

**API 応答の形（どの関連 entity を巻き込んで1レスポンスにするか）を宣言し、BE の eager-load と FE の応答型を同一定義から生成する**ための方針。これも「SSOT から成果物を生成してエントロピーを最小化する」思想（[プログラミング哲学](./programming-philosophy.md)）の一適用である。

- 「`Order` を取ると `User` と `OrderItem` が付いてくる」といった巻き込みは **API 契約そのもの**なので、SSOT（`domain-model/api-contract/`）に本籍を置く（[認可 policy](./authorization-strategy.md) と同じ扱い）。
- この宣言が **BE（repository の eager-load）と FE（応答型）双方の生成を規定**する。両者が同一定義から出るので、巻き込み範囲と型がズレない。N+1 も過剰フェッチも設計段階で閉じる。

> コード例は TypeScript を用いるが、原則（応答の形を relation graph 上で宣言し双方向に生成する）は言語・技術非依存。生成先が別言語でも同じ集約定義から各言語の応答型を吐ける。

## 1. 集約は「index」と「detail」で巻き込みを宣言する

集約定義は entity ごとに、一覧取得（`GET /<entities>`）と詳細取得（`GET /<entities>/{id}`）で**それぞれ**巻き込む関連を宣言する。一覧では軽く、詳細では深く、が典型。

```typescript
// domain-model/api-contract/aggregates.ts
export type ChildInclude  = { child: string;  via?: string; as?: string; include?: Include[] }
export type ParentInclude = { parent: string; via?: string; as?: string; include?: Include[] }
export type Include = ChildInclude | ParentInclude

export type AggregateConfig = {
  entity: string
  index?: Include[]   // GET /<entities>（一覧）で巻き込む関連。省略時は root のみ
  detail?: Include[]  // GET /<entities>/{id}（詳細）で巻き込む関連。省略時は root のみ
}
```

- **`child`** — `referredBy`（他 entity がこの entity を `.ref()` で参照）。one-to-many（相手の FK が `unique` なら one-to-one）。
- **`parent`** — `referTo`（この entity が他 entity を `.ref()` で参照）。参照先を単一オブジェクトとして埋め込む。
- **`include`** — 再帰的にネストできる（子の子、親の親…）。
- **`via`** — 同一相手への関連が複数あるとき、FK プロパティ名で曖昧さを解消する（通常は不要）。
- **`as`** — 応答フィールド名の上書き（省略時は entity 名から機械導出）。
- **定義が無い entity は「集約なし」** ＝ index / detail とも root のみの単純 CRUD。

## 2. 定義例

```typescript
export const aggregates: AggregateConfig[] = [
  {
    entity: 'Product',
    index:  [{ parent: 'Category' }, { child: 'ProductImage' }],
    detail: [
      { parent: 'Category' },
      { child: 'ProductVariant', include: [{ child: 'PriceOffering' }] }, // 子の子までネスト
      { child: 'ProductImage' },
    ],
  },
  {
    entity: 'Order',
    index:  [{ parent: 'User' }],                                          // 一覧は買い手だけ
    detail: [
      { parent: 'User' },
      { child: 'OrderItem', include: [{ parent: 'Product' }] },           // 明細 + 各明細の商品
      { child: 'Payment' },
    ],
  },
]
```

## 3. relation graph と突合して解決する（storage / policy と同じ検証方針）

集約定義は entity 名の文字列でしかない。generator（`codegen/_shared/`）がこれを **SSOT の relation graph と突き合わせ**、次を確定させた「解決済み集約」に変換する。api-contract / repository 両ジェネレータはこの解決済みの形だけを見る。

| 解決される項目 | 内容 |
|---|---|
| `cardinality` | `child` は相手 FK が `unique` なら `one`、そうでなければ `many`。`parent` は常に `one` |
| `propertyName` | 巻き込みに使う FK プロパティ名（`child` は相手側の FK、`parent` はこの entity 側の FK） |
| `nullable` | `parent` は FK が nullable かで決まる。one-to-one の `child` は存在しないことがあるので nullable |
| `fieldName` | 応答フィールド名（`as` 指定、無ければ entity 名から導出。`many` は複数形） |

検証方針は [storage / index](./architecture-overview.md#generator-の設定-storage-と-index) や [policy](./authorization-strategy.md) と共通で、**曖昧・不整合を既定で埋めずエラーにする**:

- 宣言した `child` / `parent` が relation graph に**存在しない**（`.ref()` が無い）→ エラー。
- 同一相手への関連が**複数あって一意に決まらない** → エラー（`via` で FK プロパティ名を明示させる）。
- config が**未知の entity** を指している → エラー。

```typescript
// resolve のエッセンス（child の場合）
const candidates = rel.referredBys.filter(
  (rb) => rb.entityName === target && (via === undefined || rb.propertyName === via),
)
if (candidates.length === 0) throw new Error(`"${cur}" に child "${target}" が無い（.ref() が必要）`)
if (candidates.length > 1)  throw new Error(`"${cur}" の child "${target}" が複数。via で FK を明示せよ`)
const edge = candidates[0]
const cardinality = edge.isUnique ? 'one' : 'many'   // unique な子は one-to-one
```

## 4. 生成物: 同一定義から BE eager-load と FE 応答型

`Order` の detail 定義（§2）から、両サイドが生成される。

**FE 応答型**（root ＋ 解決済み include をネスト）:

```typescript
// generated: GET /orders/{id} の応答型（detail）
export type OrderDetail = Order & {
  user: User                                  // parent (one)
  orderItems: (OrderItem & { product: Product })[]  // child (many) + ネストした parent
  payments: Payment[]                         // child (many)
}
```

**BE repository** は、この集約が要求する関連だけを **eager-load**（JOIN / バッチ取得）する実装が生成される。宣言した範囲ちょうどを取るので、N+1（都度取得）にも過剰フェッチ（要らない関連まで取る）にもならない。

- **最終的な応答形の権威は BE。** FE 型は同じ定義から生成された投影であり、両者が食い違わないことが保証される。
- 巻き込み範囲を変えたいときは**この宣言を変えて再生成する**。repository も応答型も一括で追従する。手書きの eager-load や DTO を書かない。

## 5. api-contract の宣言群の位置づけ

`domain-model/api-contract/` に本籍を置く宣言は、いずれも「**API 契約**を SSOT として宣言し、relation graph と突合して BE / FE を生成する」点で同型。storage / index が backend の関心事として `codegen/config/` に置かれる（[置き場の区別](./authorization-strategy.md#7-宣言の置き場policy-と-storage-と-index)）のと対照的である。

| 宣言 | 何を規定するか | 生成物 |
|---|---|---|
| entities | entity と relation（`.ref()`） | 型 / repository / DDL / API クライアント … |
| policy（[認可](./authorization-strategy.md)） | 誰が resource に何をしてよいか | BE `authorize` / FE `can` |
| aggregate（本ドキュメント） | 応答にどの関連を巻き込むか | BE eager-load / FE 応答型 |

いずれの resolver も **SSOT の relation graph を唯一の真実**とし、宣言との不整合（存在しない関連・曖昧な経路・未知 entity）をエラーにする。

## 6. 設計エッセンスまとめ

1. 集約 ＝ **API 応答の形**。`index`（一覧）と `detail`（詳細）で巻き込む関連を宣言する。
2. 本籍は **api-contract（SSOT）**。framework 非依存（entity 名の文字列と型だけ）。
3. **`child`（referredBy）/ `parent`（referTo）** で relation を辿り、`include` で再帰ネスト。曖昧さは `via`、名前は `as`。
4. generator が **relation graph と突合**して基数・FK・nullable・フィールド名を解決。**存在しない/曖昧/未知はエラー**（storage・policy と同じ方針）。
5. **同一定義から BE eager-load と FE 応答型を生成**。N+1 と過剰フェッチと型ズレを設計段階で閉じる。
</content>
