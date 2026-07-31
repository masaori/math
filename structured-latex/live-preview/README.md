# live-preview

ローカル（Mac）で編集した「tex 入り構造化テキスト」のレンダー結果を、同一 LAN の別 PC /
スマホのブラウザからリアルタイムに閲覧（read-only + ライブリロード）するビューア。

**structured-latex システムの上に載るモジュール**である。入力言語（ブロック・ノード・ノート）も、
その解決（採番・参照解決・ノート配置）も、システム（`../domain-model/`）が 1 つだけ持ち、
ここはそれを使う側にすぎない。特定の研究ドメインには依存しないので、リポジトリ内のどの
プロジェクトが生成する構造化テキストでも入力ソースとして受け取れる
（例: `exact-solution-of-2d-ising-model/structured-latex/`）。

## ドキュメント

- 要件定義: [docs/requirements.md](docs/requirements.md)
- アーキテクチャ設計（システム側 docs の原則への適用と逸脱根拠）: [docs/architecture.md](docs/architecture.md)
- 設計原則の正本: [../docs/](../docs/)（`architecture-overview.md` ほか）

## 構成（pnpm workspace）

| パッケージ | 役割 |
|---|---|
| `backend/` | `@structured-latex/live-preview-backend`。Fastify。Clean Architecture（gateway のみ）。API + SSE + 静的配信 |
| `frontend/` | `@structured-latex/live-preview-frontend`。React + Vite + Tailwind + TanStack Query。FSD 単一ページ。KaTeX 描画 |

**ビューア固有の `domain-model` パッケージは無い。** かつては `@rwp/domain-model` があり、
システムの再輸出と、システムの `resolve` と同じことをするラベル解決・ノート配置を持っていた。
その解決はシステム側の `resolveTolerantly`（`../domain-model/resolved/resolve.ts`）へ、
API 契約は `../domain-model/api-contract/live-preview.ts` へ吸収したので、
backend / frontend はシステムの `domain-model` を直接使う。

## 入力言語も解決もここには無い

- 型と実行時検証: `../domain-model/structured-text/`
- 採番・参照解決・ノート配置: `../domain-model/resolved/resolve.ts`
  - 出版物向けの厳格な `resolve`（壊れていたら文書を返さない）と、
    このプレビューが使う `resolveTolerantly`（壊れていても文書 + 診断を返す）が同じ実装を通る。
- API 契約: `../domain-model/api-contract/live-preview.ts`

依存は pnpm の `link:../..`（`backend/package.json` と `frontend/package.json`）で繋ぐ。
システムは Node 22.18+ の型ストリップ前提で `dist` を持たないため、**本ツールを使う前に
システム側でも一度 `pnpm install` しておく必要がある**（システムの `zod` をそこから解決するため）。

## セットアップと起動

```sh
# 入力言語の正本（システム）の依存（初回のみ）
(cd .. && pnpm install)

# 依存インストール（初回のみ。ビルドスクリプト承認込み）
pnpm install

# ビルド（backend → frontend）
pnpm build

# 起動（既定: 0.0.0.0:4321。frontend/dist と API/SSE を同一ポートで配信）
pnpm start
```

起動後、Mac のブラウザで `http://localhost:4321/`、同一 LAN の別端末からは
`http://<Mac の LAN IP>:4321/` を開く。入力ソースを保存するたびに表示が自動更新される。

なお、表示する入力ソース側（例: `exact-solution-of-2d-ising-model/structured-latex/`）でも
`pnpm install` が済んでいる必要がある。入力ソースの `.ts` はシステムと `zod` を import しており、
その解決は入力ソースのディレクトリを起点に行われるため。

### 入力ソースの差し替え

既定はリファレンス入力（`exact-solution-of-2d-ising-model/structured-latex/content`、
参照用ノートは同 `structured-latex/notes`）。環境変数または CLI 引数で差し替えられる。

```sh
LIVE_PREVIEW_SOURCE_DIR=/path/to/content LIVE_PREVIEW_PORT=4321 pnpm start
# または
node backend/dist/entrypoint/server.js --source /path/to/content --notes /path/to/notes --port 4321 --host 0.0.0.0
```

| 設定 | env | CLI | 既定 |
|---|---|---|---|
| 入力ソース dir | `LIVE_PREVIEW_SOURCE_DIR` | `--source` | structured-latex/content |
| 参照用ノート dir | `LIVE_PREVIEW_NOTES_DIR` | `--notes` | structured-latex/notes（`--source` 指定時はその隣の `notes`） |
| ポート | `LIVE_PREVIEW_PORT` | `--port` | 4321 |
| バインド host | `LIVE_PREVIEW_HOST` | `--host` | 0.0.0.0 |

プロジェクト固有メタデータ（integrable-lattice の `habitat` 等）の設定は要らない。
本ビューアは入力言語の語彙を所有しないので、システムの実行時スキーマを
「未知のメタデータキーはそのまま通す」モードで使う（値は落とさない）。

入力ソースのファイル形式は **TypeScript（`.ts`）**。Node 22.18 以降の型ストリップで
そのまま実行されるため、入力ソース側にビルド工程は要らない
（実例: `exact-solution-of-2d-ising-model/structured-latex/`）。

参照用ノート dir は**任意**で、無ければノート 0 件として動く。ノートは文書本体ではないため、
画面では紐づけ先ブロックの中に折りたたみで表示し、「参照用ノート・最終成果物には載りません」と明示する。

### 壊れていても落ちない

未解決参照は赤字点線、紐づけ先の無いノートは警告パネル、id・ラベルの重複などは
画面上部の診断パネルに出る。**いずれの場合も本文の表示は続く**（要件 F-9）。
この「壊れていても解決を止めない」振る舞いはシステムの `resolveTolerantly` が担っており、
ビューア側に解決ロジックは無い。

## 開発

```sh
pnpm typecheck   # 全パッケージ tsc --noEmit
pnpm lint        # Biome
pnpm format      # Biome 整形
```

dev サーバ（Vite HMR）を使う場合は
`pnpm --filter @structured-latex/live-preview-backend start`（API）と
`pnpm --filter @structured-latex/live-preview-frontend dev`（`/api` を 4321 にプロキシ）を併用する。
通常の LAN プレビューはビルド + `pnpm start` で足りる（コンテンツ更新は SSE で反映される）。
