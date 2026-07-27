# バックエンドアーキテクチャ

## 概要

バックエンドは **Clean Architecture（依存性逆転を中核に据えた亜種）** に基づいて設計する。

このアーキテクチャの本懐は、**依存性逆転（Dependency Inversion）を用いて、複数 domain の知識の相互依存をコントロールすること**である。一般に「インフラ」と呼ばれるものは、実体としては **外部 domain**（外部の関心領域）にほかならない。したがって設計の出発点は、「我々のアプリケーション domain が、どの外部 domain に、どの程度依存してよいか」を厳密に記述することにある。

### 外部 domain の2分類

外部 domain は、それがユーザーの関心の対象かどうかで扱いが分かれる。

| 種別 | 例 | 扱い |
|---|---|---|
| 技術の詳細 | MySQL / OS / ファイルシステム | アプリケーション domain は一切知識を持ってはならない。adapter に隔離する |
| ユーザーの関心ごと | Stripe / Google Analytics / LLM | 依存していること自体がドメインの一部。domain-model（entities / api-contract）に明示的に記述し、「依存している」ことを可視化する |

> 「DB を一切知らない」ことと「Stripe への依存を明示する」ことは矛盾しない。前者は技術詳細としての隠蔽、後者は関心事としての明示であり、いずれも「外部 domain への依存を意図どおりに制御する」という同一目的の表れである。

プロダクトが複数の [Bounded Context](./architecture-overview.md) を持つ場合、各 Context は独立したディレクトリを持ち、それぞれに domain / adapter 層を持つ。他 Context もまた、その Context から見れば外部 domain であり、後述の gateway を介して依存を明示する。

## レイヤー設計

### 各レイヤの役割

- **domain**: 外部 domain への依存は domain-model に明示済み、という前提で、**他レイヤに一切依存しない**。usecase と interface（repository / gateway）を定義する。
- **adapter**: アプリケーション domain と外部 domain の**双方に依存してよい唯一のレイヤ**。domain の interface を実装し、外部 domain を呼ぶ。外部 domain への依存はプログラム上、基本的に**プロセス境界を跨ぐ処理**として現れる。
- **entrypoint**: 依存の方向としては adapter と同じ（domain と adapter の双方を知る）。異なるのは**「外界から呼び出される」起点である**点のみ。DI で adapter の実装を domain の interface に注入し、usecase を呼ぶ。repository 等は usecase から呼ばれる。

### 制御フロー と 依存の方向 は別物

ありがちな `entrypoint → adapter → domain` という単一の矢印は、**制御フロー（実行時に誰が誰を呼ぶか）** と **依存の方向（コンパイル時に誰が誰の知識を持つか）** を混同しており、正確でない。この2つは特に domain と adapter の間で**逆転**する。両者を分けて示す。

| 参加者 | 制御フロー（実行時に呼ぶ相手） | 依存（知識）として参照してよい相手 |
|---|---|---|
| 外界・呼び出し側<br>（HTTP クライアント / スケジューラ / トリガー） | entrypoint を呼ぶ | 我々のコードに依存しない（契約は api-contract のみ） |
| **entrypoint** | domain の usecase を呼ぶ | domain ＋ adapter（DI のため実装を生成）＋ 呼び出しプロトコル（HTTP framework 等） |
| **domain** | usecase が interface を呼ぶ（実体は注入された adapter） | 何にも依存しない（domain-model のみ） |
| **adapter** | interface の実装が外部 domain を呼ぶ（プロセス境界を跨ぐ） | domain（interface を実装）＋ 外部 domain（SDK 等） |
| 外部 domain・被依存側<br>（MySQL / Stripe / LLM ...） | 我々から呼ばれる側 | 我々に依存しない |

- **制御フロー**は `外界 → entrypoint → domain(usecase) → adapter(実装) → 外部 domain` と一方向に流れる。
- **依存の方向**は domain と adapter の間で逆転する。制御フローでは usecase が repository を呼ぶが、知識としては **adapter が domain の interface に依存する**側になる。
- この逆転（依存性逆転）こそが、外部 domain への依存度を **domain 側の interface 定義で制御する**仕組みそのものである。

> この分離により、domain は外部 domain の差し替え（DB 変更、決済プロバイダ変更、デプロイ先変更等）から独立し、テスト時は interface をモックするだけでよくなる。

### ディレクトリ構成（1 Context あたり）

```
<context>/
├── domain/
│   ├── interfaces/
│   │   ├── repositories/   # 自 domain が所有する entity の永続化（CRUD + pub/sub）
│   │   └── gateways/       # 外部 domain（他 Context / 認証 / 決済 / LLM 等）へのインターフェース
│   └── usecases/           # ビジネスロジック
└── adapter/
    ├── repositories/       # repositories インターフェースの具体実装
    └── gateways/           # gateways インターフェースの具体実装

entrypoint/                 # 最外層（全 Context 共通）
├── handlers/               # HTTP ハンドラ（DI + ルーティング）
└── middleware/             # 認証等のミドルウェア
```

## Domain 層

domain 層が定義する interface は **repository** と **gateway** の2種のみ。判定はひとつだけ: **自 domain が所有する entity の出し入れか（→ repository）、それ以外の外部 domain へのアクセスか（→ gateway）**。

### interfaces/repositories/

**自 domain が所有する entity** の CRUD と、その変更イベントの pub/sub を担う。裏側のストア（MySQL 等）は技術詳細として隠蔽され、domain は自身の entity しか見ない。

> **判定基準は「自 domain が所有する entity の CRUD（+ pub/sub）か」であって、永続化されているかではない。**「永続化」は定義が曖昧で（どの時間軸で存続すれば永続なのか一意に決まらない）、repository か否かの境目にはできない。backing store が RDB でも KVS でも **in-memory でも**、それは adapter の実装詳細にすぎず domain の分類を変えない。たとえば「ライブ状態を保持し pub/sub する in-memory の read model」も、自 domain の entity を CRUD/pub-sub する以上 repository である（pub/sub に必要なライフタイムのあいだ entity が存続するなら、その時間軸では永続化されているとも言える）。永続化の有無で repository か gateway かを分けてはならない。

```typescript
export interface UserRepository {
  findById(id: string): Promise<User | undefined>
  findAll(query: ListQuery): Promise<PaginatedResult<User>>
  create(input: CreateUserInput): Promise<User>
  update(id: string, input: UpdateUserInput): Promise<User>
  delete(id: string): Promise<void>
  // CRUD に加え、entity 変更イベントの publish / subscribe もここに属する
}
```

### interfaces/gateways/

**自 domain の外側にある別 domain** へのアクセス。相手のモデルを自 domain の言語へ変換する anti-corruption layer であり、プロセス境界を跨ぐ。他 Context、認証 / ID 基盤、決済、LLM、メール送信、外部ストレージ等、**entity の永続化でない外部依存はすべてここに属する**。

```typescript
// 認証基盤（外部 domain）へのゲートウェイ
export interface AuthGateway {
  verifyToken(token: string): Promise<AuthUser>
  createUser(email: string, password: string): Promise<string>
}
```

> **「service」を設けない理由**
>
> 「外部システムにアクセスするが、翻訳すべきモデルを持たないステートレスなケイパビリティ」を `service` として独立させる案を検討したが、repository でも gateway でもない非自明な具体例が存在しなかった。
>
> - 認証 / 決済 / メール送信 / LLM / 外部ストレージ → 相手に明確なモデルがあり翻訳を要する → **gateway**
> - ID 採番 → 永続化時に entity の identity を確定する責務 → **repository.create に内包**
> - 現在時刻 / 乱数 → domain が依存する「別 domain」ではなく非決定性のシーム。値として渡すか trivial な seam で足り、層を立てる対象ではない
> - ハッシュ等 → プロセス境界を跨がない純粋関数。外部 domain アクセスですらなく、domain 内の純粋関数 / 共有ユーティリティ
>
> よって **repository に入らない外部依存はすべて gateway** とし、`service` は設けない。

### usecases/

ビジネスロジック。Repository / Gateway インターフェースを引数で受け取る（DI）。throw せず Result 型で返す（[エラーハンドリング戦略](./error-handling-strategy.md)）。認可が要る操作は冒頭で生成済みの `authorize`（[認可戦略](./authorization-strategy.md)）を呼び、手書きの権限 `if` を散らさない。

```typescript
export const getCurrentUser = async (
  authGateway: AuthGateway,
  userRepository: UserRepository,
  token: string,
): Promise<Result<User, GetCurrentUserError>> => {
  const authUser = await authGateway.verifyToken(token)
  const user = await userRepository.findById(authUser.uid)
  if (!user) {
    return { success: false, error: { code: 'not_found' } }
  }
  return { success: true, data: user }
}
```

## Adapter 層

- **repositories/**: 具体的な DB（RDB / KVS / ドキュメント DB 等）を用いた Repository 実装。Entity ⇔ DB レコードの変換を含む。
- **gateways/**: 外部 domain（他 Context / 認証基盤 / 決済 / LLM / 外部ストレージ等）の API をラップし、自 domain の言語へ変換する実装。

## Entrypoint 層

最外層。HTTP ハンドラ（軽量フレームワーク、またはサーバレス関数）として実装し、以下を担う。

- 認証ミドルウェアによるトークン検証
- adapter 層の実装を domain 層のインターフェースに DI して usecase を呼び出す
- usecase の Result を api-contract 準拠のレスポンスにシリアライズ

```typescript
// DI 配線の例
app.get('/users/me', async (req, reply) => {
  const token = extractToken(req)
  if (!token) {
    return reply.code(401).send({ error: { code: 'unauthorized' } })
  }
  const result = await getCurrentUser(
    authGatewayImpl,    // adapter 層
    userRepositoryImpl, // adapter 層
    token,
  )
  return serialize(reply, result)
})
```

> entrypoint は薄く保つ。ビジネス分岐を持たせず、「認証 → DI → usecase 呼び出し → シリアライズ」だけに限定する。HTTP フレームワーク（Fastify 等）への依存はこの層のみに閉じ込める（[言語選択](./language-selection.md)）。

## API エンドポイント設計

**原則は RESTful**。entity をリソースとして扱い、その CRUD を標準エンドポイントとして提供する。RESTful の枠に収まらない操作（認証・集計など）のみ、個別エンドポイントを手書きする。

### 標準: entity の CRUD（自動生成）

domain-model の Entity Definition（[SSOT](./architecture-overview.md#2-single-source-of-truth-ssot)）から、各 entity の CRUD エンドポイントを自動生成する。これがエンドポイントの大半を占める。

| 操作 | メソッド | パス | 対応 UseCase |
|---|---|---|---|
| 一覧 | `GET` | `/users` | list（ページング / フィルタ / ソートはクエリ） |
| 取得 | `GET` | `/users/{id}` | get |
| 作成 | `POST` | `/users` | create |
| 更新 | `PUT` / `PATCH` | `/users/{id}` | update |
| 削除 | `DELETE` | `/users/{id}` | delete |

- リソース名は entity 名の複数形。
- 一覧 / 取得の**応答の形（関連 entity の巻き込み）は [集約定義](./api-contract-aggregates.md) が規定**する。repository の eager-load と FE 応答型が同一定義から生成される。
- 自動生成の範囲・置き場・編集禁止は [コード生成](#コード生成) に従う。

### 手書き: RESTful に収まらない操作

リソースの CRUD として表現できない操作は、個別エンドポイントとして手書きする。代表例:

- **認証 / セッション** — `POST /auth/login`、`POST /auth/token/refresh` 等。entity の CRUD ではなく、gateway を介した外部 domain（認証基盤）への操作。
- **集計 / レポート** — 複数 entity の横断集計、ランキング、ダッシュボード用データ等。単一リソースの状態ではなく導出値を返す。
- **その他のドメイン固有操作** — 状態遷移を伴うコマンド（例: `POST /orders/{id}/cancel`）など、CRUD の語彙で素直に表せないもの。

> 手書きエンドポイントも entrypoint 層の責務（認証 → DI → usecase 呼び出し → シリアライズ）と薄さの原則は変わらない。違いは「ハンドラと UseCase を自動生成でなく手で書く」点だけである。

## Context 間の依存

各 Context は互いに直接依存しない。他 Context や外部サービスへアクセスする場合は、**domain/interfaces/gateways/ にインターフェースを定義し、adapter/gateways/ に実装を置く**。

```
context-a/
  domain/interfaces/gateways/
    └── context-b-gateway.ts     # IContextBGateway
  adapter/gateways/
    └── context-b-gateway.ts     # ContextBGateway implements IContextBGateway
```

内部 Context も外部サービスも同じ構造で扱う。プロセス境界の有無に関わらず、ドメイン間の概念的な境界を表現するためのレイヤーである。これにより、後で Context を別サービスへ切り出す場合も gateway 実装の差し替えだけで済む。

## コード生成

domain-model の framework-agnostic な Entity Definition（[SSOT](./architecture-overview.md#2-single-source-of-truth-ssot)）から以下を自動生成し、エントロピーを最小化する（[プログラミング哲学](./programming-philosophy.md)）。

- Repository インターフェース（domain/interfaces/repositories/）
- CRUD UseCase（domain/usecases/）
- Repository 実装（adapter/repositories/）
- CRUD ハンドラ（entrypoint/）
- 認可判定 `authorize`（policy から生成。[認可戦略](./authorization-strategy.md)）
- DB スキーマ / DDL（storage・index 設定を反映。[generator の設定](./architecture-overview.md#generator-の設定-storage-と-index)）

シンプルな CRUD / RESTful API はほぼ全て自動生成でカバーし、個別の実装要件が出た箇所のみ手書きする。

generator の置き場・書き方は [アーキテクチャ概要のコード生成](./architecture-overview.md) を参照。生成物は各 package の `_gen/` に隔離し、手では編集しない。

## テスト戦略

- **単体テスト**: UseCase を Repository / Gateway のモックでテストする（domain 層が純粋なため容易）
- **統合テスト**: 実インフラ（またはエミュレータ）を用いたエンドツーエンドテスト
