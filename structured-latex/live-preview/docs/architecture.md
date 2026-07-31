# live-preview アーキテクチャ設計

本ドキュメントは、structured-latex システムが持つ技術非依存な設計原則
（[`../../docs/`](../../docs/)）を、本モジュール `live-preview` の具体要件
（[requirements.md](./requirements.md)）へ適用した**モジュール固有の設計判断**を記す。

原則側は「早すぎる分割・早すぎる共通化はしない」ことを前提とする
（[programming-philosophy](../../docs/programming-philosophy.md),
[architecture-frontend](../../docs/architecture-frontend.md)）。
本モジュールは **read-only・永続化なし・LAN ローカル・単一関心領域**という素性のため、
原則が想定する一部の機構（codegen / DB・CRUD / Terraform / mobile / web-mobile 共通化）は
**適用対象が存在しない**。以下、各原則への準拠と逸脱を根拠付きで明示する。

## 0. システムの中での位置

本モジュールは **structured-latex システムの中のモジュール**である
（リポジトリ直下 `structured-latex/live-preview/`）。以前は独立したトップレベルの
アプリ（`realtime-web-preview/`）だったが、次の 3 つがシステム側へ吸収されたため、
モジュールとして中へ移した。

| 吸収したもの | 移した先 | 以前の場所（削除済み） |
|---|---|---|
| 寛容なラベル解決・ノート配置 | `../../domain-model/resolved/resolve.ts` の `resolveTolerantly` | `realtime-web-preview/domain-model/src/note-placement.ts` と `frontend/.../ui/ref-resolver.ts` |
| 配信契約（DocumentResponse / LoadDocumentError / SSE イベント） | `../../domain-model/api-contract/live-preview.ts` | `realtime-web-preview/domain-model/src/api-contract.ts` |
| 型検査の水準（共有コンパイラ設定） | `../../tsconfig.base.json` | `realtime-web-preview/tsconfig.base.json` |

結果として、**ビューア固有の `domain-model` パッケージ（`@rwp/domain-model`）は消えた。**
中身はシステムの再輸出と上記 2 つだけで、吸収後に残るものが無かったためである。
backend / frontend はシステムの `domain-model` を直接 import する。

依存方向は `システム(domain-model) ← live-preview(backend / frontend)` の一方向で、逆流・循環は無い。
システム側の `npm run check:deps` は `domain-model` が何にも依存しないことを実際の import で検査しており、
本モジュールを足してもその関係は変わらない（システムは live-preview を知らない）。

## 1. 設計原則へのマッピング

| 原則側の規定 | 本モジュールの判断 | 根拠 |
|---|---|---|
| monorepo（domain-model/codegen/backend/frontend/infra/docs） | システム内の 1 モジュール `structured-latex/live-preview/`。内部を pnpm workspace 化し `backend/` `frontend/` `docs/` に分割 | monorepo 原則は踏襲。`domain-model/` は**システムのものを使うので持たない**。`codegen/` `infra/` `frontend/mobile` `frontend/_shared` は下記理由で不採用 |
| SSOT（zod-to-entity-definitions で ER 定義 → repository/DB/CRUD/クライアントを生成） | 入力言語（Block/Node/Note）も配信契約もシステムが持つ。本モジュールが**唯一の定義として持つものは無い**。ER・DB・CRUD 生成はしない | 本モジュールは**所有 entity を永続化しない**。入力は外部の read-only ソース。ER/DB/Repository/CRUD という生成ターゲットが存在しない。SSOT の**思想**（単一の正準スキーマ＋境界での実行時 validation）だけ採用し、**機構**（codegen）は対象が無いため持たない |
| `codegen/` generator パッケージ | 不採用 | 生成すべき CRUD/DB 成果物が無い。ターゲット不在の generator を作らない（[programming-philosophy](../../docs/programming-philosophy.md) のエントロピー最小化に反する） |
| backend: Clean Architecture（domain/adapter/entrypoint、repository と gateway の 2 interface） | **採用**。所有 entity が無いので **repository は持たない**。gateway を 3 つ持つ: ①ブロック読込 ②ノート読込 ③ソース変更監視。usecase: ドキュメント取得 / 変更購読。entrypoint: Fastify ハンドラ＋静的配信＋DI | 入力ソース（ファイルシステム＋`.ts` ソース形式）は **技術詳細としての外部 domain** → adapter に隔離（[architecture-backend](../../docs/architecture-backend.md)）。「永続化でない外部依存はすべて gateway」原則どおり |
| frontend: FSD（app→pages→widgets→features→shared→frontend-shared） | **単一ページ** `pages/document-view/` を model/fetch/ui/index の 4 セグメントで実装。widgets/features は作らない | 「デフォルトは pages に実装、再利用が確認されるまで抽出しない」（[architecture-frontend](../../docs/architecture-frontend.md)）。表示対象は 1 ドキュメントのみ |
| frontend: Web + Mobile を `_shared` で共通化 | **Web のみ**。`frontend/mobile` と web/mobile 共通の `_shared` は作らない | mobile 対象外。クライアントが 1 つの段階で共通化層を立てるのは早すぎる共通化 |
| デザイン: Tailwind CSS + shadcn/ui | **Tailwind は採用、shadcn/ui は不採用** | shadcn/ui はフォーム/ダイアログ等**操作系コンポーネント**のためのもの。本モジュールは read-only ドキュメント表示で操作系がほぼ無く、導入は早すぎる依存 |
| routing: TanStack Router | 不採用 | 単一ビューでルーティング不要 |
| data fetch: TanStack Query | **採用** | サーバ状態（ドキュメント）のフェッチ・キャッシュ・再取得に最適。SSE 受信時に invalidate して再取得する |
| エラー: Result 型 / 境界のみ try/catch / api-contract で error code 網羅 / Zod safeParse | **全面採用** | 要件 F-9（validation エラーで画面を落とさず内容表示）と完全に整合（[error-handling-strategy](../../docs/error-handling-strategy.md)） |
| インフラ: Terraform / 既定 Google Cloud | **不採用**（`infra/` を作らない） | 本モジュールは Mac ローカルで動く 1 プロセスで LAN 配信する（[requirements.md](./requirements.md) §1, §7）。コード化すべきクラウドリソースが存在しない |
| 型安全 First / `any` 禁止 / 抑制コメント禁止 / Biome / lint・format を CI 強制 | **全面採用** | [architecture-overview](../../docs/architecture-overview.md) §設計原則。型検査の水準はシステムの `../../tsconfig.base.json` を継承。CI は `.github/workflows/structured-latex-check.yml` の `live-preview` ジョブで typecheck / lint / build を回す |

## 2. 確定した技術スタック（requirements.md §8 の確定）

- **言語**: TypeScript（`strict: true`、`any` 禁止）。[language-selection](../../docs/language-selection.md) の「型安全が無い言語は使わない」絶対条件に従う。
- **パッケージ管理 / workspace**: pnpm workspace（`backend` と `frontend` の 2 パッケージ）。
- **lint / format**: Biome（抑制コメント禁止）。
- **schema / validation**: Zod（境界で `safeParse` → Result 型）。スキーマの定義はシステム側。
- **backend HTTP**: Fastify（軽量ルーティングのみ。ビジネスロジックは非依存）。
- **frontend**: React + Vite + Tailwind CSS + TanStack Query。
- **数式描画**: KaTeX（npm 依存をバンドル。外部 CDN 不使用＝オフライン動作）。
- **ライブリロード**: SSE（Server-Sent Events）。ソース変更を `fs.watch` で検知し push、クライアントは再フェッチ。
- **配信**: ビルド済み frontend を backend が静的配信し、API/SSE と**同一ポート**（既定 4321、`0.0.0.0` バインド）で LAN 公開。起動はコマンド 1 つ。

> dev サーバ（Vite HMR）ではなく **build + 単一サーバ配信**を採る理由: 本モジュールの「ライブリロード」は
> **コードの HMR ではなくコンテンツ（構造化テキスト）の変更反映**（F-5）であり、それは SSE で満たされる。
> 単一ポート配信により「1 コマンド起動・LAN・CDN 非依存」（§6）を最小構成で満たす。

## 3. ディレクトリ構成

```
structured-latex/                 # システム（入力言語・解決・契約の正本）
├── tsconfig.base.json            # 型検査の水準の正本。live-preview も各プロジェクトも継承する
├── domain-model/
│   ├── structured-text/          # 入力言語（Block / Node / Note）と実行時検証
│   ├── resolved/resolve.ts       # 採番・参照解決・ノート配置。resolve（厳格）/ resolveTolerantly（寛容）
│   └── api-contract/
│       ├── live-site.ts          # 公開サイトの契約（アップロード + 版の配信）
│       └── live-preview.ts       # ★本モジュールの契約（DocumentResponse / error code / SSE イベント）
└── live-preview/                 # ← 本モジュール
    ├── package.json              # pnpm workspace root（private）。build/start/typecheck/lint スクリプト
    ├── pnpm-workspace.yaml
    ├── biome.json
    ├── README.md
    ├── docs/
    │   ├── requirements.md
    │   └── architecture.md       # 本ファイル
    ├── backend/                  # @structured-latex/live-preview-backend
    │   └── src/
    │       ├── preview/          # 単一 Bounded Context
    │       │   ├── domain/
    │       │   │   ├── interfaces/gateways/
    │       │   │   │   ├── block-source-gateway.ts     # 構造化テキストソース読込 I/F
    │       │   │   │   ├── note-source-gateway.ts      # 参照用ノートソース読込 I/F（任意ソース）
    │       │   │   │   └── source-watcher-gateway.ts   # 変更監視 I/F
    │       │   │   └── usecases/
    │       │   │       ├── get-document.ts             # 本体 + 参照用ノートを束ねて返す
    │       │   │       └── subscribe-to-changes.ts
    │       │   └── adapter/gateways/
    │       │       ├── mjs-module-loader.ts            # .ts の動的 import（スキーマ非依存の共通処理）
    │       │       ├── mjs-block-source-gateway.ts     # .ts を動的 import + 実行時スキーマで検証
    │       │       ├── mjs-note-source-gateway.ts      # ノート dir（無くてもよい）を同様に読む
    │       │       └── fs-source-watcher-gateway.ts    # fs.watch（本体 dir とノート dir を監視）
    │       ├── entrypoint/
    │       │   ├── server.ts     # Fastify 構築・DI・静的配信
    │       │   └── handlers/
    │       │       ├── get-document-handler.ts
    │       │       └── events-handler.ts               # SSE
    │       └── config.ts         # 入力ソース dir / port の解決（env / CLI）
    └── frontend/                 # @structured-latex/live-preview-frontend
        └── src/
            ├── main.tsx
            ├── app/              # QueryClient 等の provider
            └── pages/document-view/
                ├── model/page-domain-model.ts   # Loadable<解決済み文書 + 迷子ノート + 診断> + 接続状態
                ├── fetch/use-document.ts        # GET /api/document + SSE 購読 + resolveTolerantly
                ├── ui/document-view.tsx         # 本文・診断パネル・迷子ノート
                ├── ui/block-card.tsx            # kind 別体裁
                ├── ui/heading-view.tsx
                ├── ui/figure-view.tsx
                ├── ui/note-view.tsx
                ├── ui/nodes.tsx                 # 解決済みノード描画（KaTeX）
                ├── ui/kind-labels.ts            # 種別の表示名（体裁なので画面が持つ）
                └── index.tsx                    # グルーコード
```

**`ui/ref-resolver.ts` は無い。** ラベル → アンカーの解決は `resolveTolerantly` が済ませており、
描画側は解決済みノード（`ref` / `unresolvedRef`）を見るだけだからである。

## 4. Bounded Context

関心領域は「構造化テキストのプレビュー」**1 つ**。よって Context は単一（`preview`）。
複数の関心領域が混ざった時点で分割を導入する（早すぎる分割はしない）。

## 5. backend レイヤ設計

[architecture-backend](../../docs/architecture-backend.md) に従う。本モジュールは
**所有 entity を持たず永続化しない**ため repository は無く、外部依存は gateway のみ。

- **domain / interfaces / gateways**
  - `BlockSourceGateway`: 設定された入力ソースから `Block[]` を読む。
  - `NoteSourceGateway`: 参照用ノートを読む。ソースが無い構成も正常系（空配列）。
  - `SourceWatcherGateway`: ソース変更を監視し、変更時にコールバックする（購読/解除）。
- **domain / usecases**（throw せず Result を返す）
  - `getDocument(blockSource, noteSource)`: 本体 + 参照用ノートを束ねて取得。
  - `subscribeToChanges(watcher, onChange)`: 変更購読を確立。
- **adapter / gateways**（外部 domain＝FS と `.ts` ソース形式に依存してよい唯一の層）
  - `MjsBlockSourceGateway`: ソース dir 配下の `*.ts` をファイル名順に動的 import し、
    default export を**システムの実行時スキーマ**（`createLivePreviewRuntimeSchema`。検証規則の正本は
    `../../domain-model/structured-text/validate.ts`）で検証して結合。
    失敗は Result のエラーに変換（境界の try/catch）。
  - `FsSourceWatcherGateway`: `fs.watch`（再帰）でソース dir を監視。デバウンスして onChange。
- **entrypoint**（薄く保つ: 認証無し→ DI → usecase → シリアライズ）
  - `GET /api/document`: `getDocument` の Result を契約準拠の JSON に。
  - `GET /api/events`: SSE。`subscribeToChanges` を購読し、変更時に `event: reload` を push。
  - 静的配信: `frontend/dist` を配信（SPA フォールバック）。

**backend は解決をしない。** 入力言語のまま送り、解決は受け取り側で行う（理由は §6.5）。

## 6. frontend レイヤ設計

[architecture-frontend](../../docs/architecture-frontend.md) の FSD（model/fetch/ui/index、`fetch → model ← ui`）に従う。

- **model**: `DocumentViewPageDomainModel`
  - 表示物: `document: Loadable<DocumentContent>`（`DocumentContent` は**解決済み文書 + 迷子ノート + 診断**）、
    `connection: 'connecting' | 'live' | 'disconnected'`。
  - 操作: read-only のため外界に影響する操作は無し（手動再読込ボタンのみ）。
- **fetch**: `useDocument()`
  - TanStack Query で `GET /api/document` を取得し、`resolveTolerantly` で解決して `PageDomainModel` を返す。
  - `EventSource` で `/api/events` を購読し、`reload` 受信で query を invalidate（外界アクセス＝SSE はここに閉じる）。
  - エラーは Result を受けて error state 化（`ui` は表示のみ、`index` は素通し）。
- **ui**: `DocumentView`
  - `PageDomainModel` を Props で受け取る。kind 別体裁、解決済みノード描画（`math`/`displayMath` を KaTeX）、
    `ref` リンク、`unresolvedRef` の赤字点線、`todo` 強調、診断パネル、迷子ノート警告。
- **index**: `useDocument` → `DocumentView` を繋ぐだけ（処理を入れない）。

### 6.5 解決を frontend で行う理由

`resolveTolerantly` は**純関数**なので、backend でも frontend でも同じ結果になる。frontend に置くのは:

- backend で解決して**解決済み文書**を送ると、境界で検証するために解決済み文書用の実行時スキーマが
  もう 1 つ要る。しかし検証の関門は結局入力言語の側（`validate.ts`）にあり、契約が 1 つ増えるだけで
  得るものが無い。
- 入力言語のまま送れば、既存の `parseDocumentResponse`（システムの契約）1 つで境界を守れる。

## 7. エラーハンドリング（api-contract）

[error-handling-strategy](../../docs/error-handling-strategy.md) に従い、operation ごとに error code を網羅。
定義は `../../domain-model/api-contract/live-preview.ts`。

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

**「文書は読めたが中身が壊れている」は上のエラーではなく診断**（`ResolveDiagnostic`）で扱う。
未解決参照・迷子ノート・id / ラベルの重複がこれにあたる。診断があっても本文の描画は続く。

## 8. 受け入れ基準との対応

[requirements.md](./requirements.md) §9 の各項目を、上記 §5–§7 の構成で満たす。
入力ソースの差し替え（F-7）は §5 の `config.ts`（env/CLI で source dir / notes dir 指定）で実現する。
リファレンス入力は `exact-solution-of-2d-ising-model/structured-latex/content/`、
参照用ノートは同 `structured-latex/notes/`（任意。無ければノート 0 件）。

参照用ノートは**文書本体ではない**（最終成果物は content 側だけから生成される）ため、
API でも `blocks` と別フィールド `notes` で運び、解決では `audience: 'working'` を指定して
`notesByBlockId` へ配置し、該当ブロック内に折りたたみ表示する。
`audience: 'publication'` ならノートは配置されない（システムの不変条件 I5）。
どのブロックにも解決できなかったノートは捨てずに `orphanNotes` として警告表示する。

## 8.5 システムへの依存の繋ぎ方

- 依存は pnpm の `link:../..`（`backend/package.json` と `frontend/package.json`）。
  pnpm が張る symlink を Node が realpath で解決するため、システムの `.ts` は
  **node_modules の外のパスとして読まれ、Node 22.18+ の型ストリップがそのまま効く**
  （node_modules 内の `.ts` は型ストリップの対象外なので、この点が成立の条件）。
- システムは `dist` を持たない（`tsconfig.json` が `noEmit` かつ `allowImportingTsExtensions`）。
  その `.ts` を本モジュールの `tsc` から読むため、`../../tsconfig.base.json` に
  `allowImportingTsExtensions` と `rewriteRelativeImportExtensions` を置く。後者が無いと
  前者は `noEmit` でしか使えず、`backend` の emit ができない。
- frontend は Vite が `.ts` をそのまま解決・トランスパイルするので、追加の設定は要らない。
- システム側の `zod` はシステム自身の `node_modules` から解決される。したがって
  `structured-latex/` でも一度 `pnpm install` しておく必要がある。
  同じ理由で、**表示する入力ソース側**（例: `exact-solution-of-2d-ising-model/structured-latex/`）でも
  `pnpm install` が要る。

## 8.6 プロジェクト固有メタデータ

本モジュールは**入力言語の語彙を所有しない**（どのプロジェクトの文書でも読む立場）。
プロジェクト固有メタデータのキー名（integrable-lattice の `habitat` 等）を内蔵できないので、
システムの実行時スキーマを `unknownBlockMeta: 'passthrough'` で使う
（`createLivePreviewRuntimeSchema`）。
未知のキーは**値を落とさずそのまま通る**（strip すると画面に出す前にメタデータが黙って消える）。
キー名を拒否しても打ち間違いの検出にはならず、正しい文書を読めなくするだけなので、
検査は語彙を所有する各プロジェクトの検証ツールに任せる。

## 9. 本モジュールで「適用対象なし」とした機構（明示）

将来、要件が変わって対象が生じたら導入を再検討する。

- **codegen / SSOT 生成**: 永続 entity・CRUD・DB が生じたら導入。
- **infra/（Terraform/クラウド）**: クラウドへデプロイする要件が生じたら導入。当面は LAN ローカル。
- **mobile / frontend/_shared**: mobile クライアントを足す段階で導入。
- **shadcn/ui**: 操作系 UI（フォーム・ダイアログ等）が増えた段階で導入。
