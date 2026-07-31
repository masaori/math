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
| `domain-model/` | 入力言語（リポジトリ直下 `structured-latex/` が持つ正本）の再輸出、api-contract、ビューア固有のラベル解決／ノート配置 |
| `backend/` | Fastify。Clean Architecture（gateway のみ）。API + SSE + 静的配信 |
| `frontend/` | React + Vite + Tailwind + TanStack Query。FSD 単一ページ。KaTeX 描画 |

## 入力言語の正本はここに無い

ブロック・ノード・ノートの型と実行時検証は、リポジトリ直下の
[`structured-latex/`](../structured-latex/)（システム）が 1 つだけ持つ。本ツールはその
**利用者**であり、`domain-model/` に入力言語を再定義しない。依存は pnpm の
`link:../../structured-latex` で繋いでいる（`domain-model/package.json`）。

システムは Node 22.18+ の型ストリップ前提で `dist` を持たないため、**本ツールを使う前に
`structured-latex/` 側でも一度 `pnpm install` しておく必要がある**（システムの `zod` を
そこから解決するため）。

## セットアップと起動

```sh
# 入力言語の正本（システム）の依存（初回のみ）
(cd ../structured-latex && pnpm install)

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

既定はリファレンス入力（`exact-solution-of-2d-ising-model/structured-latex/content`、
参照用ノートは同 `structured-latex/notes`）。環境変数または CLI 引数で差し替えられる。

```sh
RWP_SOURCE_DIR=/path/to/content RWP_PORT=4321 pnpm start
# または
node backend/dist/entrypoint/server.js --source /path/to/content --notes /path/to/notes --port 4321 --host 0.0.0.0
```

| 設定 | env | CLI | 既定 |
|---|---|---|---|
| 入力ソース dir | `RWP_SOURCE_DIR` | `--source` | structured-latex/content |
| 参照用ノート dir | `RWP_NOTES_DIR` | `--notes` | structured-latex/notes（`--source` 指定時はその隣の `notes`） |
| ポート | `RWP_PORT` | `--port` | 4321 |
| バインド host | `RWP_HOST` | `--host` | 0.0.0.0 |

プロジェクト固有メタデータ（integrable-lattice の `habitat` 等）の設定は要らない。
本ビューアは入力言語の語彙を所有しないので、システムの実行時スキーマを
「未知のメタデータキーはそのまま通す」モードで使う（値は落とさない）。

入力ソースのファイル形式は **TypeScript（`.ts`）**。Node 22.18 以降の型ストリップで
そのまま実行されるため、入力ソース側にビルド工程は要らない
（実例: `exact-solution-of-2d-ising-model/structured-latex/`）。

参照用ノート dir は**任意**で、無ければノート 0 件として動く。ノートは文書本体ではないため、
画面では紐づけ先ブロックの中に折りたたみで表示し、「参照用ノート・最終成果物には載りません」と明示する。

## 開発

```sh
pnpm typecheck   # 全パッケージ tsc --noEmit
pnpm lint        # Biome
pnpm format      # Biome 整形
```

dev サーバ（Vite HMR）を使う場合は `pnpm --filter @rwp/backend start`（API）と
`pnpm --filter @rwp/frontend dev`（`/api` を 4321 にプロキシ）を併用する。
通常の LAN プレビューはビルド + `pnpm start` で足りる（コンテンツ更新は SSE で反映される）。
