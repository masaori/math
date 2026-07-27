# フロントエンドアーキテクチャ

## 概要

フロントエンドは **Feature Sliced Design (FSD)** をカスタマイズしたアーキテクチャを採用する。
Web（React）と Mobile（bare React Native）を、共通パッケージ（`_shared`）で共通化しながら開発する。

採用言語・フレームワークは [言語選択](./language-selection.md) に従う。

## FSD レイヤー

### レイヤー階層

```
app → pages → widgets → features → shared → frontend-shared (共通パッケージ)
```

上位レイヤーは下位レイヤーに依存できるが、逆は禁止。

### セグメント構成

各スライス（pages, widgets, features）は **model / fetch / ui** の3セグメント ＋ `index` で構成する。これは FSD の改良版であり、本懐は **2種の複雑性を分離し、その相互依存を `model` を介してのみ許す** ことにある。

| セグメント | 引き受ける複雑性 |
|---|---|
| `ui/` | 画面要素のレンダーと、ユーザーアクションのハンドルに伴う複雑性 |
| `fetch/` | 外界プロトコルへのアクセス（プロセス境界を跨ぐ）に伴う複雑性 |
| `model/` | 上記2つの間の契約。どちらの複雑性にも依存しない |

```
<slice-name>/        # 主に page（「実装方針」を参照）
├── model/     # PageDomainModel（表示物 + 許容 Action）と validation
├── fetch/     # 外界アクセス hooks。PageDomainModel を返す
├── ui/        # PageDomainModel を Props で受け取る React コンポーネント
└── index.tsx  # router option → fetch → ui を繋ぐだけのグルーコード
```

#### 依存ルール

```
fetch → model ← ui
```

`fetch` と `ui` は **`model` にのみ依存** し、**互いには一切依存しない**（直接 import しない）。これにより `ui`（画面の複雑性）と `fetch`（外界の複雑性）が独立して育てられ、`ui` は外界を知らないままでいられる。

#### model/

`model/` を「Props 型を置く場所」とは説明しない。「Props」は React 固有の用語である上に粒度が粗く、結局何を書くべきかが決まらないからだ。`model/` は次の2つを定義する場所であり、そのうち `ui` に渡る部分が結果的に Props になる。

**1. PageDomainModel** — `domain-model/entities` だけに依存する ts type。ページが扱う情報を、表示物と操作の両面から「ドメインの言葉」で宣言する。

*このページが何を表示するか:*

- **単品の entity** は、ロード中・失敗・不在（`null`）まで型で表す。「まだ無いかもしれない」を呼び出し側に強制したいので、生の `Company` ではなく `Loadable<Company | null>` のような形で持つ。
- **entity の集合** は、どんなスコープの集合なのかが分かる形で持つ（例:「この会社に所属するメンバー」）。
- **entity 同士の入れ子** は、フラットに潰さず型として表す。

*このページでユーザーに許す操作は何か:*

- 「どの entity への何の操作か」が名前だけで分かるハンドラとして列挙する。目安は `on{操作}{Entity}{要素}{動作}`（例: `onRemoveMemberButtonClick`）。
- 載せるのは **外界に影響する操作だけ**。ダイアログの開閉やアコーディオンの展開のように画面内で完結する操作は `model` に出さず、`ui` が自分で抱える（線引きは後述の Storybook 基準による）。

```typescript
// pages/company-detail/model/page-domain-model.ts
import type { Company, User, Role } from 'domain-model/entities'

// 入れ子は型として明示する（「メンバー = User に Role がぶら下がる」を潰さない）
type CompanyMember = {
  user: User
  role: Role
}

export type CompanyDetailPageDomainModel = {
  // 表示物
  company: Loadable<Company | null>     // 不在(null)・ロード中・失敗を型で強制する
  members: Loadable<CompanyMember[]>    // 「この会社に所属するメンバー」というスコープ

  // 許容する操作（外界に影響するものだけ）
  onRenameCompanySubmit: (input: { name: string }) => void
  onRemoveMemberButtonClick: (memberId: User['id']) => void
}
```

`CompanyMember` のような入れ子が複数ページで再登場するなら、`pages/_shared/model/` に切り出して 1 箇所で定義する（例: 会社一覧ページと会社詳細ページが同じ「会社＋所属メンバー」を表示する場合）。

**2. validation** — フォーム入力などの検証ルールを zod で書く。これは `ui`（入力）と `fetch`（送信）の間のプロトコルにすぎないので、`domain-model/entities` を参照する必要はない。たとえば「会社名は 1〜50 文字」といった、その画面固有の入力規則をここに置く。

#### ui/

- **Props として `PageDomainModel` を受け取り**、React コンポーネントでそれを実現する。
- `fetch` との責務分担（state や処理をどちらに置くか）は、**「`ui` レイヤが Storybook プロセス上で mocking 無しに完結して動作する」ことだけ** を判定基準とする。これさえ満たせば、state・処理をどちらに置いてもよい。

#### fetch/

- **外界にアクセスしてデータを集め、`PageDomainModel` を Props オブジェクトとして返す hooks**。
- `ui` との責務分担は上記のとおり。ただし **外界アクセス（プロセス境界を跨ぐ処理）は絶対に `fetch` に置く**。
- 外界アクセスで生じたエラーの受け取りと `PageDomainModel` への反映（エラー state 化）もここで担う。`ui` はそれを表示するだけ、`index` は素通しするだけ（[エラーハンドリング戦略](./error-handling-strategy.md)）。

#### index.ts

- **純粋なグルーコード**。router からの option を hooks の引数としてそのまま渡し、返ってきた props をそのまま `ui` コンポーネントに渡して return するだけ。
- **エラーハンドル等の処理を一切入れてはならない。**

## 実装方針

- **デフォルトは `pages/` に実装する**
  - 新規機能はまず `pages/` 内に閉じた形で実装する
  - 再利用が確認されるまで `widgets/` / `features/` への抽出は行わない
- **「理解しやすさ」を「読みやすさ」に優先する**
  - 不要な抽象化・早すぎる共通化は禁止（[プログラミング哲学](./programming-philosophy.md)）
  - ドメインモデルに即した命名を使用する

## Web / Mobile の共通化

```
frontend/
├── _shared/   # Web/Mobile 共通パッケージ
│   └── fetch/
│       ├── backend-api-crud/_gen/    # CRUD API クライアント（generator 出力・手編集禁止）
│       ├── backend-api-stream/_gen/  # Stream API クライアント（generator 出力・手編集禁止）
│       └── auth/                     # 認証 hooks
├── web/
└── mobile/
```

- API クライアントは domain-model の API Contract から `codegen/` の generator で自動生成し、`_shared` の `_gen/` 配下に置く（手では編集しない。[コード生成](./architecture-overview.md) を参照）。
- 認証等のプラットフォーム非依存ロジックも `_shared` で共通化する。

## Web アプリケーション

### 技術スタック

- React + Vite
- TanStack Router（型安全ルーティング）
- TanStack Query（データフェッチ・キャッシュ）
- Tailwind CSS + shadcn/ui
- Storybook（UI カタログ）

### ルーティング

- ファイルベースルーティング
- 認証要否でレイアウトを分岐し、認証状態に応じて自動リダイレクトする

## Mobile アプリケーション

### 技術スタック

- bare React Native（Expo / EAS は使用しない）
- React Navigation
- StyleSheet（React Native 標準）
- Storybook（UI カタログ）

### ビルド・配布

- 署名済み native build は React Native CLI / Xcode / Gradle ベースで構成する
- ディープリンクは custom URL scheme を iOS / Android の native manifest に登録する

## コンポーネント設計

### 原則

1. **ドメインモデルに即した命名**: UI コンポーネント名は Entity や操作を反映する
2. **表示物と許容 Action は `model/`（PageDomainModel）に集約**: `ui` の Props はそこから導く
3. **データ取得はスライスレベルで行い、子コンポーネントには props で渡す**
4. **共有 UI は Storybook でカタログ化する**

### 状態管理

- **サーバー状態**: TanStack Query で管理（キャッシュ・再取得・楽観的更新）
- **認証状態**: 認証プロバイダ + React Context
- **ローカル UI 状態**: React useState / useReducer
