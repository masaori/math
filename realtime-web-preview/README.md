# realtime-web-preview

ローカル（Mac）で編集した「tex 入り構造化テキスト」のレンダー結果を、同一 LAN の別 PC /
スマホのブラウザからリアルタイムに閲覧（read-only + ライブリロード）するための、
**特定の研究ドメインに依存しない**汎用プレビューアプリ。

リポジトリ内の各プロジェクトが生成する構造化テキスト（例:
`exact-solution-of-2d-ising-model/structured-latex/`）を入力ソースとして受け取る。

## ドキュメント

- 要件定義: [docs/requirements.md](docs/requirements.md)
- アーキテクチャ設計（テンプレート準拠・逸脱根拠）: [docs/architecture.md](docs/architecture.md)
- 設計原則テンプレート（submodule）: [docs/_template/](docs/_template/)

## 構成（pnpm workspace）

| パッケージ | 役割 |
|---|---|
| `domain-model/` | Block/Node の Zod schema と api-contract（SSOT） |
| `backend/` | Fastify。Clean Architecture（gateway のみ）。API + SSE + 静的配信 |
| `frontend/` | React + Vite + Tailwind + TanStack Query。FSD 単一ページ。KaTeX 描画 |

## セットアップと起動

```sh
# 依存インストール（初回のみ。ビルドスクリプト承認込み）
pnpm install

# ビルド（domain-model → backend → frontend）
pnpm build

# 起動（既定: 0.0.0.0:4321。frontend/dist と API/SSE を同一ポートで配信）
pnpm start
```

起動後、Mac のブラウザで `http://localhost:4321/`、同一 LAN の別端末からは
`http://<Mac の LAN IP>:4321/` を開く。入力ソースを保存するたびに表示が自動更新される。

### 入力ソースの差し替え

既定はリファレンス入力（`exact-solution-of-2d-ising-model/structured-latex/content`）。
環境変数または CLI 引数で差し替えられる。

```sh
RWP_SOURCE_DIR=/path/to/content RWP_PORT=4321 pnpm start
# または
node backend/dist/entrypoint/server.js --source /path/to/content --port 4321 --host 0.0.0.0
```

| 設定 | env | CLI | 既定 |
|---|---|---|---|
| 入力ソース dir | `RWP_SOURCE_DIR` | `--source` | structured-latex/content |
| ポート | `RWP_PORT` | `--port` | 4321 |
| バインド host | `RWP_HOST` | `--host` | 0.0.0.0 |

## 開発

```sh
pnpm typecheck   # 全パッケージ tsc --noEmit
pnpm lint        # Biome
pnpm format      # Biome 整形
```

dev サーバ（Vite HMR）を使う場合は `pnpm --filter @rwp/backend start`（API）と
`pnpm --filter @rwp/frontend dev`（`/api` を 4321 にプロキシ）を併用する。
通常の LAN プレビューはビルド + `pnpm start` で足りる（コンテンツ更新は SSE で反映される）。
