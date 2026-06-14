# realtime-web-preview アーキテクチャ設計

本ドキュメントは [`_template/docs`](./_template/docs/)（submodule: `software-development-docs-template`）の
技術非依存な設計原則を、本ツール `realtime-web-preview` の具体要件
（[requirements.md](./requirements.md)）へ適用した**プロジェクト固有の設計判断**を記す。

テンプレートは「コピーして各プロダクトの事情に合わせて拡張する」前提であり、
かつ「早すぎる分割・早すぎる共通化はしない」ことを原則とする
（[programming-philosophy](./_template/docs/programming-philosophy.md),
[architecture-frontend](./_template/docs/architecture-frontend.md)）。
本ツールは **read-only・永続化なし・LAN ローカル・単一関心領域**という素性のため、
テンプレートの一部機構（codegen / DB・CRUD / Terraform / mobile / web-mobile 共通化）は
**適用対象が存在しない**。以下、各原則への準拠と逸脱を根拠付きで明示する。

## 1. テンプレート各原則へのマッピング

| テンプレートの規定 | 本ツールの判断 | 根拠 |
|---|---|---|
| monorepo（domain-model/codegen/backend/frontend/infra/docs） | 既存 `math` monorepo 内の 1 アプリ `realtime-web-preview/`。内部を pnpm workspace 化し `domain-model/` `backend/` `frontend/` `docs/` のサブパッケージに分割 | monorepo 原則は踏襲。`codegen/` `infra/` `frontend/mobile` `frontend/_shared` は下記理由で不採用 |
| SSOT（zod-to-entity-definitions で ER 定義 → repository/DB/CRUD/クライアントを生成） | `domain-model/` に **Block/Node の Zod schema** と **api-contract 型**を唯一の定義として置く。ER・DB・CRUD 生成はしない | 本ツールは**所有 entity を永続化しない**。入力は外部の read-only ソース。ER/DB/Repository/CRUD という生成ターゲットが存在しない。SSOT の**思想**（単一の正準スキーマ＋境界での実行時 validation）だけ採用し、**機構**（codegen）は対象が無いため持たない |
| `codegen/` generator パッケージ | 不採用 | 生成すべき CRUD/DB 成果物が無い。ターゲット不在の generator を作らない（[programming-philosophy](./_template/docs/programming-philosophy.md) のエントロピー最小化に反する） |
| backend: Clean Architecture（domain/adapter/entrypoint、repository と gateway の2 interface） | **採用**。所有 entity が無いので **repository は持たない**。gateway を2つ持つ: ①構造化テキストソース読込 ②ソース変更監視。usecase: ドキュメント取得 / 変更購読。entrypoint: Fastify ハンドラ＋静的配信＋DI | 入力ソース（ファイルシステム＋`.mjs` ソース形式）は **技術詳細としての外部 domain** → adapter に隔離（[architecture-backend](./_template/docs/architecture-backend.md)）。「永続化でない外部依存はすべて gateway」原則どおり |
| frontend: FSD（app→pages→widgets→features→shared→frontend-shared） | **単一ページ** `pages/document-view/` を model/fetch/ui/index の4セグメントで実装。widgets/features は作らない | 「デフォルトは pages に実装、再利用が確認されるまで抽出しない」（[architecture-frontend](./_template/docs/architecture-frontend.md)）。表示対象は 1 ドキュメントのみ |
| frontend: Web + Mobile を `_shared` で共通化 | **Web のみ**。`frontend/mobile` と web/mobile 共通の `_shared` は作らない | ユーザー指示により **mobile 対象外**。クライアントが1つの段階で共通化層を立てるのは早すぎる共通化 |
| デザイン: Tailwind CSS + shadcn/ui | **Tailwind は採用、shadcn/ui は不採用** | shadcn/ui はフォーム/ダイアログ等**操作系コンポーネント**のためのもの。本ツールは read-only ドキュメント表示で操作系がほぼ無く、導入は早すぎる依存。要件次第で後から導入可（テンプレートも「デザインFWは要件に応じ選定」と明記） |
| routing: TanStack Router | 不採用 | 単一ビューでルーティング不要 |
| data fetch: TanStack Query | **採用** | サーバ状態（ドキュメント）のフェッチ・キャッシュ・再取得に最適。SSE 受信時に invalidate して再取得する |
| エラー: Result 型 / 境界のみ try/catch / api-contract で error code 網羅 / Zod safeParse | **全面採用** | 要件 F-9（validation エラーで画面を落とさず内容表示）と完全に整合（[error-handling-strategy](./_template/docs/error-handling-strategy.md)） |
| インフラ: Terraform / 既定 Google Cloud | **不採用**（`infra/` を作らない） | 本ツールは Mac ローカルで動く 1 プロセスで LAN 配信する（[requirements.md](./requirements.md) §1,§7）。コード化すべきクラウドリソースが存在しない。将来の外出先閲覧（トンネリング）は要件上 out of scope |
| 型安全 First / `any` 禁止 / 抑制コメント禁止 / Biome / lint・format を CI 強制 | **全面採用** | [architecture-overview](./_template/docs/architecture-overview.md) §設計原則。`strict: true`, Biome 導入 |

## 2. 確定した技術スタック（requirements.md §8 の確定）

- **言語**: TypeScript（`strict: true`、`any` 禁止）。[language-selection](./_template/docs/language-selection.md) の「型安全が無い言語は使わない」絶対条件に従う。
- **パッケージ管理 / workspace**: pnpm workspace。
- **lint / format**: Biome（抑制コメント禁止）。
- **schema / validation**: Zod（境界で `safeParse` → Result 型）。
- **backend HTTP**: Fastify（軽量ルーティングのみ。ビジネスロジックは非依存）。
- **frontend**: React + Vite + Tailwind CSS + TanStack Query。
- **数式描画**: KaTeX（npm 依存をバンドル。外部 CDN 不使用＝オフライン動作）。
- **ライブリロード**: SSE（Server-Sent Events）。ソース変更を `fs.watch` で検知し push、クライアントは再フェッチ。
- **配信**: ビルド済み frontend を backend が静的配信し、API/SSE と**同一ポート**（既定 4321、`0.0.0.0` バインド）で LAN 公開。起動はコマンド1つ。

> dev サーバ（Vite HMR）ではなく **build + 単一サーバ配信**を採る理由: 本ツールの「ライブリロード」は
> **コードのHMRではなくコンテンツ（構造化テキスト）の変更反映**（F-5）であり、それは SSE で満たされる。
> 単一ポート配信により「1コマンド起動・LAN・CDN非依存」（§6）を最小構成で満たす。

## 3. ディレクトリ構成

```
realtime-web-preview/
├── package.json              # pnpm workspace root（private）。build/start/typecheck/lint スクリプト
├── pnpm-workspace.yaml
├── biome.json
├── tsconfig.base.json
├── README.md
├── docs/
│   ├── _template/            # submodule: software-development-docs-template
│   ├── requirements.md
│   └── architecture.md       # 本ファイル
├── domain-model/             # @rwp/domain-model（SSOT。何にも依存しない）
│   └── src/
│       ├── block.ts          # Block / Node の Zod schema + 型（入力ソース契約）
│       ├── api-contract.ts   # DocumentResponse / error code / SSE event の型
│       ├── result.ts         # Result<T, E>
│       └── index.ts
├── backend/                  # @rwp/backend（domain-model に依存）
│   └── src/
│       ├── preview/          # 単一 Bounded Context
│       │   ├── domain/
│       │   │   ├── interfaces/gateways/
│       │   │   │   ├── block-source-gateway.ts     # 構造化テキストソース読込 I/F
│       │   │   │   └── source-watcher-gateway.ts   # 変更監視 I/F
│       │   │   └── usecases/
│       │   │       ├── get-document.ts
│       │   │       └── subscribe-to-changes.ts
│       │   └── adapter/gateways/
│       │       ├── mjs-block-source-gateway.ts     # .mjs を動的 import + Zod safeParse
│       │       └── fs-source-watcher-gateway.ts    # fs.watch
│       ├── entrypoint/
│       │   ├── server.ts     # Fastify 構築・DI・静的配信
│       │   └── handlers/
│       │       ├── get-document-handler.ts
│       │       └── events-handler.ts               # SSE
│       └── config.ts         # 入力ソース dir / port の解決（env / CLI）
└── frontend/                 # @rwp/frontend（domain-model に依存）
    └── src/
        ├── main.tsx
        ├── app/              # QueryClient 等の provider
        └── pages/document-view/
            ├── model/page-domain-model.ts          # Loadable<Block[]> + 接続状態
            ├── fetch/use-document.ts               # GET /api/document + SSE 購読
            ├── ui/document-view.tsx
            ├── ui/block-card.tsx                   # kind 別体裁
            ├── ui/nodes.tsx                        # Node 描画（KaTeX）
            └── index.tsx                           # グルーコード
```

依存方向（[architecture-overview](./_template/docs/architecture-overview.md) §3）:
`domain-model ← backend` / `domain-model ← frontend`。逆方向・循環は禁止。

## 4. Bounded Context

関心領域は「構造化テキストのプレビュー」**1つ**。よって Context は単一（`preview`）。
複数の関心領域が混ざった時点で分割を導入する（早すぎる分割はしない）。

## 5. backend レイヤ設計

[architecture-backend](./_template/docs/architecture-backend.md) に従う。本ツールは
**所有 entity を持たず永続化しない**ため repository は無く、外部依存は gateway のみ。

- **domain / interfaces / gateways**
  - `BlockSourceGateway`: 設定された入力ソースから `Block[]` を読む。`Promise<Result<Block[], LoadDocumentError>>`。
  - `SourceWatcherGateway`: ソース変更を監視し、変更時にコールバックする（購読/解除）。
- **domain / usecases**（throw せず Result を返す）
  - `getDocument(blockSource)`: ドキュメント（`Block[]`）を取得。
  - `subscribeToChanges(watcher, onChange)`: 変更購読を確立。
- **adapter / gateways**（外部 domain＝FS と `.mjs` ソース形式に依存してよい唯一の層）
  - `MjsBlockSourceGateway`: ソース dir 配下の `*.mjs` をファイル名順に動的 import し、
    default export を **Zod `safeParse`** で検証して結合。失敗は Result のエラーに変換（境界の try/catch）。
  - `FsSourceWatcherGateway`: `fs.watch`（再帰）でソース dir を監視。デバウンスして onChange。
- **entrypoint**（薄く保つ: 認証無し→ DI → usecase → シリアライズ）
  - `GET /api/document`: `getDocument` の Result を api-contract 準拠の JSON に。
  - `GET /api/events`: SSE。`subscribeToChanges` を購読し、変更時に `event: reload` を push。
  - 静的配信: `frontend/dist` を配信（SPA フォールバック）。

## 6. frontend レイヤ設計

[architecture-frontend](./_template/docs/architecture-frontend.md) の FSD（model/fetch/ui/index、`fetch → model ← ui`）に従う。

- **model**: `DocumentViewPageDomainModel`
  - 表示物: `document: Loadable<Block[]>`（ロード中・失敗・取得済みを型で強制）、`connection: 'connecting' | 'live' | 'disconnected'`。
  - 操作: read-only のため外界に影響する操作は無し（手動再読込ボタン程度に留める）。
- **fetch**: `useDocument()`
  - TanStack Query で `GET /api/document` を取得し `PageDomainModel` を返す。
  - `EventSource` で `/api/events` を購読し、`reload` 受信で query を invalidate（外界アクセス＝SSE はここに閉じる）。
  - エラーは Result を受けて error state 化（`ui` は表示のみ、`index` は素通し）。
- **ui**: `DocumentView`
  - `PageDomainModel` を Props で受け取る。Storybook 上で mocking 無しに動く粒度。
  - `kind` 別体裁、Node 描画（`math`/`displayMath` を KaTeX）、`ref` リンク、`todo` 強調、validation エラー表示。
- **index**: router/option → `useDocument` → `DocumentView` を繋ぐだけ（処理を入れない）。

## 7. エラーハンドリング（api-contract）

[error-handling-strategy](./_template/docs/error-handling-strategy.md) に従い、operation ごとに error code を網羅。

```
LoadDocumentError =
  | { code: 'source_not_found' }      // 入力ソース dir が無い
  | { code: 'source_empty' }          // ブロックが1つも無い
  | { code: 'validation_error'; issues: ValidationIssue[] }  // Zod 検証失敗（F-9: 画面に表示）
  | { code: 'source_read_error'; message: string }           // import/IO 失敗
```

- BE: ソース読込の例外を境界（adapter）の try/catch で捕捉し上記 code に変換。`internal_error` は設計漏れ。
- FE: code → ユーザー向けメッセージへ変換（`Record<code, string>` で網羅を型強制）。`validation_error` は
  該当ブロック/パスを画面に表示し、**画面は落とさない**（F-9）。

## 8. 受け入れ基準との対応

[requirements.md](./requirements.md) §9 の各項目を、上記 §5–§7 の構成で満たす。
入力ソースの差し替え（F-7）は §5 の `config.ts`（env/CLI で source dir 指定）で実現する。
リファレンス入力は `exact-solution-of-2d-ising-model/structured-latex/content/`。

## 9. 本ツールで「適用対象なし」とした機構（明示）

将来、要件が変わって対象が生じたら導入を再検討する。

- **codegen / SSOT 生成**: 永続 entity・CRUD・DB が生じたら導入。
- **infra/（Terraform/クラウド）**: クラウドへデプロイする要件が生じたら導入。当面は LAN ローカル。
- **mobile / frontend/_shared**: mobile クライアントを足す段階で導入。
- **shadcn/ui**: 操作系 UI（フォーム・ダイアログ等）が増えた段階で導入。
