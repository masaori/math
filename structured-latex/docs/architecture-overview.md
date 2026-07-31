# アーキテクチャ概要

BE / FE に共通する全体方針。個別の詳細は以下を参照:

- [バックエンドアーキテクチャ](./architecture-backend.md)
- [フロントエンドアーキテクチャ](./architecture-frontend.md)

## モノレポ構成

言語・技術要素にかかわらず、**必ず monorepo（単一リポジトリ）** で domain-model / backend / frontend を一元管理する。SSOT である domain-model から BE / FE の成果物を生成する以上、これらを別リポジトリに分割すると一貫性が崩れるためである（BE と FE が別言語であっても同じ）。

```
<repo>/
├── domain-model/        # Entity 定義 & API Contract (SSOT)
├── codegen/             # SSOT から各成果物を生成する generator 群
├── backend/             # API (Clean Architecture)
├── frontend/
│   ├── _shared/         # Web/Mobile 共通ロジック
│   ├── web/             # React Web アプリ
│   └── mobile/          # bare React Native アプリ
├── infra/               # Terraform によるインフラ定義（IaC、既定は Google Cloud）
└── docs/
```

## Bounded Context（関心領域の分割）

**Bounded Context** とは、プロダクトを構成する **独立した1つの関心領域** である。「ドメインの境界をどこに引くか」＝ Context をどう切るかは、このアーキテクチャにおける **最上位の設計判断** であり、BE / FE 双方の構造を規定する。

- 各 Context は自分の domain-model（entities / api-contract）と実装を持つ。
- **Context 同士は互いのモデルに直接依存しない。** ある Context から見れば、他の Context もまた「外部 domain」である。
- Context 間のアクセスは、BE では gateway（[バックエンドアーキテクチャ](./architecture-backend.md#context-間の依存)）を介してのみ行い、依存を明示する。

#### 分割の判定基準は「関心領域が違うか」ではなく依存関係

「関心領域が別か」という曖昧なセマンティックで分割を決めてはならない。判定は **ドメイン知識の依存関係** で行う。このアーキテクチャの本懐は「複数 domain の知識の相互依存をコントロールすること」（[バックエンドアーキテクチャ](./architecture-backend.md)）であり、Context 分割はその最上位の適用にほかならない。

- **分割すべき場合**: 2 つの領域のドメイン知識を **相互に隔離しなければならない**とき。すなわち一方が他方のモデルを直接持つべきでなく、外部 domain として gateway（ACL）越しにのみ触れるべきとき。
- **1 つにまとめてよい場合**: 隔離すべきという要請が**論理的に確定できない**とき。領域どうしが同一のユビキタス言語を直接共有し、依存が一方向（DAG）で相互依存（循環）が無いなら、それらは同じ Context の直接参照でよい。無理に gateway を挟むのは不要な ACL を生むだけ。
- 判断できない・境界が曖昧なうちは、早すぎる分割を避けて **1 Context** にまとめる。分割は後からでも、依存が実際に隔離を要求し始めた時点で導入できる。
- なお、**別プロセス/サービスへ切り出す（deployment 起因の分割）**場合は、その物理境界により相手が外部 domain になるので gateway を挟む。これは上記の「ドメイン知識の隔離要請」とは別軸の分割理由である。

> 補足: tmux / 決済 / 認証 / LLM のような**外部 domain**への依存は、Context 分割ではなく gateway で扱う（[外部 domain の2分類](./architecture-backend.md)）。Context 分割はあくまで「**我々の domain** を複数に割るか」の判断である。

> 「Bounded Context」は DDD の戦略的設計の用語。本ドキュメント群で単に **Context** と書いた場合はこれを指す。FE の状態管理で使う React の Context（[フロントエンド](./architecture-frontend.md)）とは無関係なので注意。

## 設計原則

### 1. Type Safety First

- `strict: true` を全パッケージで有効化する（TypeScript の場合）
- `any` 型の使用は一切禁止
- `as` キャストは極力避け、ランタイムバリデーション（Zod 等）や Type Predicates を使用する
- Discriminated Union の網羅性は `assertNever` で保証する

### 2. Single Source of Truth (SSOT)

- `domain-model/entities/` に全ての Entity 定義を、`domain-model/api-contract/` に API の入出力型を、唯一の定義として記述する。
- **採用する技術要素にかかわらず、domain-model は必ず TypeScript + [`@masaori/zod-to-entity-definitions`](https://github.com/masaori/zod-to-entity-definitions) で記述する。** BE が Go / Rust、クライアントが C#（ゲーム）等であっても、SSOT の記述言語は TypeScript で固定する。理由は Zod がスキーマ記述 DSL として最も表現力が高く、`.pk()` / `.unique()` / `.ref()` 等のメタデータ拡張で Entity / Relation を宣言的に書けるためである。**多言語への変換は、記述側ではなく generator 側が一手に担う。**
- Zod にメタデータ拡張を加えて Entity / Relation を宣言し、そこから **framework-agnostic な Entity Definition（ER モデルの JSON）** を生成する。
- この framework-agnostic 定義を SSOT とし、BE / FE それぞれの言語・フレームワークが必要とするもの（型定義、DB スキーマ、Repository、API クライアント等）を、すべてここから自動生成する。

```
domain-model (zod + メタデータ拡張で記述)
  └─ generate ─→ framework-agnostic Entity Definition (ER モデル / JSON)  ← SSOT
                  ├─ generate ─→ BE: 型 / Repository / DB スキーマ ...
                  └─ generate ─→ FE: 型 / API クライアント ...
```

> 中間表現が言語非依存の JSON であるため、BE / FE が別言語（Go / Rust 等）であっても、ゲーム文脈（Unity / C# 等）であっても、同じ SSOT から各言語の成果物を生成でき、一貫性が崩れない。記述 DSL 自体は TypeScript（Zod）だが、生成される定義と各言語への展開は言語非依存である。

### 3. 明確な依存方向

```
domain-model     ← 何にも依存しない
backend          ← domain-model に依存
frontend/_shared ← domain-model に依存
frontend/web     ← domain-model, frontend/_shared に依存
frontend/mobile  ← domain-model, frontend/_shared に依存
```

- 逆方向の依存は禁止（backend が frontend に依存する等）
- 循環依存は禁止

### 4. コード品質

- Linter / Formatter を強制する（TypeScript では Biome を推奨）
- `eslint-disable` / `@ts-ignore` / `biome-ignore` 等の抑制コメントは一切禁止
- ビジネスロジックは純粋関数として実装し、テスタビリティを確保する
- 共有 UI コンポーネントは Storybook 等でカタログ化する

> **ツールは言語非依存の要件、具体物は各言語の実装例**
> 本ドキュメント中の Biome（lint / formatter）・Zod / zod-to-entity-definitions（スキーマ記述 DSL）・`assertNever` / Type Predicates（型安全を担保するヘルパ）は、いずれも TypeScript における実現手段の例にすぎない。
> **以下の各カテゴリに相当するものは、いかなる言語を採用する場合でも可能な限り用意する。**
>
> | カテゴリ | TypeScript の例 | 方針 |
> |---|---|---|
> | lint / formatter | Biome | 必ず導入し、CI で強制する |
> | スキーマ記述 DSL | Zod / zod-to-entity-definitions | SSOT を記述・生成できる手段を用意する |
> | 型安全を担保するヘルパ | `assertNever` / Type Predicates | 網羅性チェック・型絞り込みの手段を用意する |
>
> その言語に既存ツールが無い場合は、実現可能な最大限の代替手段を用いる。

## コード生成（generator）

SSOT（framework-agnostic Entity Definition）から各成果物を生成する generator について、**置き場**と**書き方**を定める。「できるだけ多くを自動生成する」という方針（[プログラミング哲学](./programming-philosophy.md)）の実装上の核となる。

### 置き場

| 対象 | 置き場 | 依存 |
|---|---|---|
| 生成の入力（SSOT 定義） | `domain-model/` | 何にも依存しない（zod-to-entity-definitions のみ） |
| generator 本体 | `codegen/`（トップレベル workspace） | `domain-model` に依存。各 target の規約（Clean Architecture / FSD）を知る |
| 生成された出力 | 各 package 内の `_gen/` ディレクトリ | — |

- **generator を `domain-model/` に置かない。** domain-model は target（backend / frontend）の規約を知ってはならず、「何にも依存しない」原則を保つ必要があるため。target の規約をコードとして持つのは generator の責務である。
- generator は複数 target（backend と frontend）へ出力するので、特定の target にも属さない。`codegen/` に集約し、生成ロジックを一望できるようにする。

#### `codegen/` の中身

1 成果物 = 1 generator モジュール。共通処理（定義の読込・ファイル出力・命名/整形）は `codegen/_shared/` に置く。

```
codegen/
├── _shared/                       # 定義の読込・ファイル出力・命名/整形、config の解決(storage/policy)
├── config/                        # SSOT で表せない backend/DB 固有の設定（storage / index）
├── backend-repository-interface/  # → backend の domain/interfaces/repositories/_gen/
├── backend-repository-impl/       # → backend の adapter/repositories/_gen/
├── backend-crud-usecase/          # → backend の domain/usecases/_gen/
├── backend-crud-handler/          # → backend の entrypoint/handlers/_gen/
├── backend-authz/                 # → backend の authz/_gen/（policy から authorize を生成）
├── db-schema/                     # → backend の migrations/_gen/（DDL。index config を反映）
├── frontend-api-crud-client/      # → frontend/_shared の backend-api-crud/_gen/
├── frontend-api-stream-client/    # → frontend/_shared の backend-api-stream/_gen/
└── frontend-authz/                # → frontend/_shared の authz/_gen/（policy から can を生成）
```

生成の順序は「SSOT 読込 → 宣言の解決（storage / policy / [aggregate](./api-contract-aggregates.md) を SSOT の relation graph と突合・検証）→ 各 generator」。解決を先に走らせ、抜け漏れ・曖昧をこの段で落としてから生成に入る。

#### `_gen/` は出力先ごとに分散する

`_gen/` は単一の置き場（`backend/_gen` のような1ディレクトリ）ではない。生成物は **それを wrap する手書きコードと同じ場所**（各レイヤ / セグメント）に co-locate し、出力先ごとに `_gen/` が現れる。

```
backend/src/<context>/domain/interfaces/repositories/_gen/
backend/src/<context>/domain/usecases/_gen/
backend/src/<context>/adapter/repositories/_gen/
backend/src/entrypoint/handlers/_gen/
frontend/_shared/fetch/backend-api-crud/_gen/
```

co-locate する理由: 手書きコードは隣の `_gen/` を import して wrap する。生成物をレイヤ内に置けば import がローカルに閉じ、各レイヤの規約も保たれる。単一の top-level `_gen/` はレイヤの局所性を壊す。

> FE の生成物は基本 `frontend/_shared` に出る（web / mobile 共通）。`frontend/web/_gen` のような package 固有の `_gen/` は、その package 専用の generator を足したときにだけできる。

### 書き方

- generator は、`domain-model` が出力する framework-agnostic Entity Definition を入力に取り、ファイルを書き出す **純粋なスクリプト** として実装する。
- **決定性・冪等性**: 同じ入力なら常に同じ出力（エントロピー 0）。時刻・乱数・実行順に依存させない。
- **出力は `_gen/` に隔離する**: 生成物は各 package の `_gen/` 配下にだけ書き込み、**手で編集しない**。修正は必ず generator 側で行い、再生成する。生成物の source of truth は常に generator である。
- **手書きは生成物を wrap する**: 個別要件は生成コードを直接書き換えず、それを import して wrap した手書きコードで足す。エントロピーが増える箇所を最小化する（[プログラミング哲学](./programming-philosophy.md)）。
- 1 generator = 1 成果物（例: BE の Repository 実装、FE の API クライアント）。

### generator の設定: storage と index

generator は、SSOT だけでは表現できない **backend / DB 固有の要件**を設定として受け取る。これらは framework 非依存の SSOT（domain-model）に持たせず、`codegen/config/` に宣言する。

いずれの設定も resolver の検証方針は共通:**明示宣言のみを正とし、既定で暗黙に埋めない。SSOT と突合して、不明 entity・重複宣言・抜け漏れ・曖昧をすべてエラーにする。**「書き忘れ」を静かに通さないことで、設定を load-bearing に保つ。

#### storage 設定（entity をどこに保存するか）

entity は「同一性とライフサイクルを持つ概念」であって「どこに保存するか」とは独立している。しかし生成物（永続化コード）は保存先ごとに異なる。どの entity をどこに置くかは **backend の関心事**なので、SSOT ではなく `codegen/config/storage.ts` で宣言する。

```typescript
// codegen/config/storage.ts
// 保存先の enum は「プロジェクト固有」。使うものだけ定義する（早すぎる共通化をしない）。
// 下記は例であり、enum 自体は各プロジェクトで決める。
export type StorageBackend = 'cloud-sql' | 'redis' | 'projected'

export const storageAssignments: EntityStorage[] = [
  { entity: 'User',      backend: 'cloud-sql' },
  { entity: 'Order',     backend: 'cloud-sql' },
  { entity: 'Session',   backend: 'redis' },       // 非永続の一時状態
  { entity: 'Requester', backend: 'projected' },   // 永続化しない投影型
  // ...SSOT の全 entity を過不足なく明示列挙する
]
```

- **保存先は全 entity について明示必須**。SSOT の全 entity が 1 回ずつ宣言されていることを resolver が検証し、未宣言・不明・重複をエラーにする。
- **`projected`（非永続な投影型）** は他 entity から算出される派生型で、DDL / repository / handler / CRUD クライアントを生成せず、**型（各言語の struct / type）だけ**を生成する（例: 認可の主体 `Requester`。[認可戦略](./authorization-strategy.md)参照）。
- **保存先の enum はプロジェクト固有**に定義する。`cloud-sql` / `redis` / `projected` は例にすぎない。**まだ使わない backend を先に具体化しない。** 実際に必要になった時点で、その backend のリテラルと設定型と generator を足す。
- **サポート外の backend はハードエラーにする。** ある backend の generator がまだ無い状態でその backend を entity に割り当てたら、silent skip せず生成を落とす。設定を load-bearing にし、「宣言したのに生成されない」を防ぐ。

#### index 設定（DB 固有の索引 / 制約）

部分ユニークインデックス、インデックス種別（btree / gin 等）のような **DB 固有の要件**は framework 非依存の SSOT では表現できない。これらを**手書きマイグレーションに逃がさず**、`codegen/config/indexes.ts` に宣言して DB スキーマ generator に DDL 化させる。

```typescript
// codegen/config/indexes.ts — 例: 「1注文につき成功決済は最大1件」を部分ユニークで表現
export const indexes: EntityIndexes[] = [
  {
    entity: 'Payment',
    indexes: [
      { columns: ['orderId'], unique: true, where: [{ column: 'status', operator: '=', value: 'succeeded' }] },
    ],
  },
]
```

- 単一列の完全ユニークは SSOT の `.unique()`、複合の完全ユニークは entity 定義の `uniques` を使う。ここ（config）は**条件付き / 種別指定など DDL 固有のもの**に限る。
- カラム名は entity のプロパティ名で書き、generator が DB の命名規約（snake_case 等）へ変換する。SSOT 側の記述と設定側の記述で命名を二重管理しない。

#### policy / aggregate（API 契約）は SSOT 側に置く

認可 policy と [集約 aggregate](./api-contract-aggregates.md) も「entity に付随情報を宣言し SSOT と突合して生成する」点で storage / index と同型だが、**本籍が異なる**。両者は「誰が resource に何をしてよいか」「応答にどの関連を巻き込むか」という **API の契約**なので、`codegen/config/` ではなく `domain-model/api-contract/` に置く。詳細は [認可戦略](./authorization-strategy.md) / [API 集約定義](./api-contract-aggregates.md) を参照。

## 新機能追加の標準フロー

1. **domain-model**: Entity スキーマを定義・更新する（TypeScript + zod-to-entity-definitions）
2. **domain-model**: API Contract・policy（[認可](./authorization-strategy.md)）・aggregate（[集約](./api-contract-aggregates.md)）を定義する
3. **codegen/config**: 新 entity の storage 割り当て（と必要なら index）を宣言する
4. **codegen**: 再生成する（CRUD / repository / handler / authz / DDL / API クライアント）
5. **backend**: 自動生成でカバーできない個別 UseCase を手書きで足す（生成物を wrap する）
6. **frontend/_shared**: API クライアント・共通 fetch hooks を実装する
7. **frontend/web** or **mobile**: ページ・コンポーネントを実装する（表示判定に生成 `can` を使う）
