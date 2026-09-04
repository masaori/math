# structured-latex

証明・論文の正本を**構造化テキスト**として 1 つだけ持ち、そこから用途の異なる成果物を生成するシステム。
正本が 1 つなので、出力形式ごとに内容が食い違う事故が構造的に起きない。

| 出力形式 | 用途 |
| --- | --- |
| 純粋な LaTeX | arXiv 等へ投稿できる形式 |
| PDF | 印刷・配布 |
| インタラクティブな Web サイト | Web 公開。閲覧者が操作できる |
| 書籍形式 | 段組・コラムを差し挟みながら読み物として提供する |

加えて次を満たす。

- **デザイン・レイアウトは利用者側でカスタマイズできる。** 出力の見た目を変えるのに本体を書き換えなくてよい。
- **インフラは Terraform で構築する。** インタラクティブサイトをホスティングできる状態にする。
- **構造化テキストを部分的にアップロードして画面を更新できる。**
  論文をリアルタイムに更新しながら、同じサイトを複数人が同時に見る使い方を想定する。

## このシステムが持つもの

**ドメインモデルが中心にあり、レンダラー（出力器）はその上に載るモジュールである。**
入力言語（構造化テキストの語彙）の正本は、このシステムが 1 つだけ持つ。
先行実装では同じ言語が 3 箇所で定義され、ラベル解決が 2 回書かれていた。それを 1 つにするのが存在理由。
**解決（採番・参照解決・ノート配置）の実装は `domain-model/resolved/resolve.ts` 1 つだけ**で、
出版物向けの厳格な `resolve` も、プレビュー向けの寛容な `resolveTolerantly` も同じ実装を通る。

```
structured-latex/
├── domain-model/          # 何にも依存しない。3 つの層を持つ
│   ├── structured-text/   #   L1 入力言語（ブロック・ノード・ラベル・ノート）
│   ├── entities/          #   L2 文書の集約（SSOT。zod-to-entity-definitions で記述）
│   ├── api-contract/      #   L2 配信と受け入れの契約
│   │                      #     live-site.ts（公開サイト）
│   ├── resolved/          #   L3 解決済み文書（採番・参照解決を終えた中間表現）
│   └── _gen/              #   生成物（ER 定義・relation・storage 割り当て）
├── codegen/               # 生成器。domain-model にだけ依存する
│   ├── structured-text-index/  #   ラベルのユニオン型・文書集約モジュール
│   ├── entity-definitions/     #   ER 定義
│   └── config/                 #   storage 宣言
├── renderers/html/        # 静的HTML出力で共有する既定UI
├── examples/              # 利用例（生成器と型検査の実証対象）
├── tools/                 # 負テスト・依存方向の検査
├── tsconfig.base.json     # 共有コンパイラ設定（システム自身・各プロジェクトが継承）
└── docs/                  # 設計ドキュメント
```

依存方向は一方向で、逆流・循環は禁止（`npm run check:deps` が実際の import を読んで検査する）。
各論文の `tools/build-html.ts` は `content/` から静的HTMLを生成し、既定UIを
`renderers/html/` から利用する。既定UIが持つのは、章ナビゲーション
（`chapter-navigation.ts`）と、主定理・サブ定理の見せ方（`theorem-standing.ts`）である。
章ナビゲーションは、画面が広いときは見出しどおりのサイドツリー、スマートフォン幅のときは
ハンバーガーで開閉する目次パネルになる。**どちらも入れ子を含む全階層の見出しを出す**
（モバイルだけ最上位に間引くと、節へ直接移動できない）。

## 主定理とサブ定理

定理・主張のブロックは、その文書での**身分**を宣言できる。

```typescript
{ id: '…', kind: 'theorem', standing: 'mainTheorem', labels: […], statement: […] }
```

- 宣言できるのは `theorem` / `claim` だけである。定義・注意・ノート・見出し・図表に書くと、
  型検査と実行時検証の両方で落ちる。
- **宣言が無ければサブ定理**として扱う。主定理は印を付けたものだけである。
- 身分は意味であって体裁ではない（[docs/domain-model.md](docs/domain-model.md) §7.2）。
  見せ方は出力器が決める: HTML の既定UIは、各見出しの冒頭にその見出しに属する主定理を列挙し、
  サブ定理のブロックを題名だけ見せて既定で閉じる（`details` / `summary` なので JavaScript に
  依存しない）。定義・注意は身分を持たないので閉じない。LaTeX / PDF の出力は身分で変わらない。

この `standing` は平坦な既存文書の互換入力である。新しい文書構造では、主従をブロック自身の
絶対的属性にせず、下記の節所属と要素グループから導出する。

## 節と要素グループ

章立て、要素の所属、主従を文書順から推測せず、入力の木として宣言できる。

```typescript
const structure = defineDocumentStructure({
  kind: 'documentStructure',
  sections: [{
    kind: 'section',
    id: 'transfer-matrix',
    labels: ['sec:transfer-matrix'],
    title: { text: '転送行列' },
    children: [{
      role: 'primary',
      element: {
        kind: 'elementGroup',
        id: 'transfer-matrix-definition-group',
        focus: {
          kind: 'definition',
          id: 'transfer-matrix-definition',
          labels: ['def:transfer-matrix'],
          statement: [],
        },
      },
    }],
  }],
})

const compiled = compileDocumentStructure(structure)
```

大きな文書では、各章を `defineSection(...)` で個別に型検査し、その章の配列を
`content/*.ts` の default export にする。生成器は構造を直接読み、実行時には平坦なブロック列へ
正規化し、型検査では `BlocksOfSections` により同じ順序のタプルへ平坦化する。これにより、文書全体を
一つの巨大なリテラルとして比較する TypeScript の型計算上限を避けながら、大域的な ID・ラベル検査を保つ。

- `section` の再帰が章・節・項の親子関係そのものであり、`level` は木の深さから生成される。
- `elementGroup.focus` はそのまとまりの中心で、定理・主張・定義を置ける。
- 節に `role: 'primary'` で属するグループの中心が、主定理・主な主張・主な定義になる。
- `role: 'supporting'` は節の主要要素を支えるグループである。
- グループ内の役割が、中心に対する定義・補助主張・下位グループ・説明・図表の関係を表す。
- `beforeFocus` / `afterFocus` により、中心が一つであることを保ったまま提示順も確定する。

`compileDocumentStructure` は既存のセグメント契約へ渡せる平坦な `blocks` と、節・グループ所属を
保持した索引を同時に返す。同じブロックの複数所属、構造 ID 重複、6 段を超える節は Result の
エラーになる。外部 JSON は `createRuntimeSchema().validateDocumentStructure` で同じ形を検査する。

HTML は `renderers/html/primary-elements.ts` を使う。`primaryElementEntriesOf` が明示された所属から
主要要素を取り出し、`renderPrimaryElementsLead` が「この節の主な定義」と
「この節の主定理・主張」を分けて節冒頭へ表示する。

## 使う側がやること

```typescript
// 1. 生成された Label（実在するラベルのユニオン型）を受け取り、
// 2. プロジェクト固有メタデータを宣言し（不要なら省略）、
// 3. ファクトリを具体化する
const { defineBlocks, defineNotes, defineDocumentStructure, defineSection, ref } = createStructuredTextSchema<Label, Meta>()
```

あとは `content/*.ts` にブロック列を書くだけで、次が**書いた瞬間に型で落ちる**。

- 存在しないラベルへの参照（近い綴りの候補付き）
- ブロック id・ラベル・ノート id の重複（ファイルを跨いでも）
- 種別ごとに許されないフィールド（見出しに本文、定理型に `level` 等）
- フィールド名の打ち間違い（`proof` → `proofs`。証明が黙って消える事故を塞ぐ）
- プロジェクト固有メタデータの条件違反

何が型で落ち、何が実行時検査に残るかは [docs/type-coverage.md](docs/type-coverage.md)（根拠つき）。

## 検査

```sh
pnpm install   # 初回のみ（Node 22.18 以降が必要）
npm run check  # ER 定義の鮮度 → 生成物の鮮度 → 型検査 → 依存方向 → 単体テスト → 負テスト
```

## ローカライズ

ローカライズは出力器の都合ではなく、文書集約の第一級概念である。**1 本の文書は言語中立な
構造を 1 つだけ持ち、原文ロケールをその構造の正本とする。** 翻訳は別文書・別ラベル集合ではなく、
同じセグメント・ブロック・参照関係に対するロケール別の表層である。

- 共有するもの: 文書 ID、セグメント順、ブロック／ノート ID、ラベル、ブロック種別、採番入力、
  数式ノードの LaTeX、参照先、引用キー、画像資産キー、プロジェクト固有の意味メタデータ。
- ロケールごとに変えられるもの: 文書・ブロック・ノートの題名、地の文、TODO の文言、参照表示、
  引用箇所、画像の代替文。
- 原文ロケールと利用可能ロケール、各翻訳の翻訳元は明示する。利用可能とは構造検査まで通って
  解決できるロケールを指し、予定中・欠落中の翻訳は含めない。

`resolveLocalized` は選択ロケールを解決済み文書へ運ぶとともに、原文と翻訳の構造を照合する。
ロケールタグ不正・非正準表記、原文不在、翻訳元の循環・不整合、要求ロケールの欠落、セグメント／ブロック／
ラベル／共有ノードの構造ドリフトは Result のエラーとして検出する。翻訳本文がまだ無いことを
黙って原文へフォールバックさせない。

既存の `content/` と `notes/` を持つプロジェクトは、無変更で原文ロケール `ja` だけを持つ
文書として扱える。したがって Ising と可解格子の日本語本文を移し替える必要はない。英語版を
追加するときだけ、同じラベル型を使うロケール別のスナップショットを `LocalizedRevisionSnapshot`
へ束ねる。翻訳本文の作成はこのシステム変更の範囲外である。

```typescript
const localized = {
  documentId: 'example',
  sourceLocale: 'ja',
  localizations: [
    {
      locale: 'ja',
      translatedFrom: null,
      translatedFromRevision: null,
      revision: { documentId: 'example', revision: 1, segments: japaneseSegments },
    },
    {
      locale: 'en',
      translatedFrom: 'ja',
      translatedFromRevision: 1,
      revision: { documentId: 'example', revision: 1, segments: englishSegments },
    },
  ],
} as const

const result = resolveLocalized(localized, 'en', {
  numbering: DEFAULT_NUMBERING_POLICY,
  audience: 'publication',
})
```

翻訳側では文字列だけを変え、数式・参照先・画像資産・ブロック対応を変えない。入力が TypeScript
を経由しない場合にも、同じ規則を実行時スキーマとローカライゼーション検査が確認する。

生成器にも翻訳ソースを明示できる。設定が無い既存プロジェクトは暗黙に原文 `ja` だけとなる。

```typescript
// locales.config.ts
export default {
  sourceLocale: 'ja',
  translations: [
    {
      locale: 'en',
      translatedFrom: 'ja',
      contentDir: 'locales/en/content',
      notesDir: 'locales/en/notes',
    },
  ],
}
```

`npm run gen` / `--check` は原文のラベル型を生成し、設定された全翻訳を原文構造と
照合する。翻訳側も同じ生成済み `Label` を使うため、翻訳が未登録ラベルを宣言したり、
存在しないラベルを参照したりすれば型検査で止まる。翻訳にしか無いブロック（下記）の
ラベルだけは `TranslationOnlyLabel` として別に生成し、`AnyLocaleLabel = Label |
TranslationOnlyLabel` を翻訳側の受け口にする。**原文はこの型を使わない**
（原文が翻訳限定ラベルを指せば、原文の解決で未解決参照になる）。

### 意図した差の宣言（allowance）

既定は「翻訳は原文と同じ構造を持つ」であり、差はすべて違反である。しかし実在の投稿稿は
**意図した差**を持ちうる（原文に無い節を足す、リポジトリ内部のパス表記を落とす、
数式中の `\text{}` の中身を訳す、引用ノードを足す、など）。これを「検査を緩める」ことで
通すと、意図しない訳し落としまで一緒に通る。

そこで差は 1 件ずつ `LocalizationAllowance` へ渡し、**説明できなかったものだけ**を違反にする。

```typescript
// locales.config.ts
export default {
  sourceLocale: 'ja',
  translations: [
    {
      locale: 'en',
      translatedFrom: 'ja',
      contentDir: 'locales/en/content',
      allowance: {
        // 値は翻訳してよいが、**宣言の有無は一致していなければならない**メタデータ。
        localeSpecificMetaKeys: ['realEscape'],
        // 差 1 件ごとに呼ばれる。説明するなら空でない理由を必ず返す。
        explain: (divergence) => ({ explained: true, reason: '…なぜ訳し落としではないか…' }),
      },
    },
  ],
}
```

`explain` が受け取る差は 4 種類（`TranslationDivergence`）。

| 種類 | いつ上がるか |
| --- | --- |
| `translation_only_segment` | 翻訳にしか無いファイル。**認めても中のブロックは 1 件ずつ理由を要求する** |
| `translation_only_block` | 翻訳にしか無いブロック |
| `node_structure` | 数式・参照・引用・画像の骨格（値と位置と入れ子）が原文と違う |
| `block_meta` | 意味メタデータが原文と違う（`localeSpecificMetaKeys` を除く） |

原文にあるものが翻訳から消えた場合（`missing_translated_segment` /
`missing_translated_block`）は allowance へ渡さない。**喪失は宣言で正当化できない。**
「説明した」と答えたのに理由が空なら `empty_divergence_reason` として違反にする。

## 開発の思想

`docs/` は [software-development-docs-template](https://github.com/masaori/software-development-docs-template)
から複製したものであり、**開発はこれに厳密に従う**。

- エントロピー（選択肢の多さ）の最小化を最優先する（`docs/programming-philosophy.md`）
- 原理主義的な DDD。ドメインモデルを BE から FE の UI 構造まで一貫して貫く
- 依存関係のコントロール（Clean Architecture / FSD）を厳密に運用する
- 型安全を絶対条件とする（`docs/language-selection.md`）
- インフラは Terraform による IaC（`docs/infrastructure.md`）

## ドキュメント

| ドキュメント | 内容 |
| --- | --- |
| [docs/domain-model.md](docs/domain-model.md) | ドメインモデルの正本。概念・集約・不変条件・確定した設計判断 |
| [docs/type-coverage.md](docs/type-coverage.md) | 型で落とすもの／実行時に残すものの切り分けと根拠 |
| [docs/domain-model.md](docs/domain-model.md#532-ローカライズ) | 原文・翻訳・構造 SSOT・不変条件 |
| [docs/milestones.md](docs/milestones.md) | マイルストーン |
| [docs/authoring-notes.md](docs/authoring-notes.md) | 書き方の注意。利用側が踏んだ落とし穴と回避手順 |
| [docs/design-notes/](docs/design-notes/) | 個別の設計判断の詳細な根拠 |
| [MEMORY.md](MEMORY.md) | 引き継ぎメモ |
