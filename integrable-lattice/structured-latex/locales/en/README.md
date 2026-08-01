# locales/en（論文 001 の英語版）

論文 001「ℝ/Λ 双対」を **Expositiones Mathematicae の Survey Article** として投稿できる形にした
英語版である。**日本語版 [`../../content/`](../../content/) が正本であり、英語版はそれを一切
変更せずに並置する**（内容を失わない可逆な構成にするため）。

**これは別プロジェクトではない。** cycle 24 step 2 までは `integrable-lattice/structured-latex-en/`
という独立プロジェクトで、`schema.ts` / `labels.generated.ts` / `document.generated.ts` /
`package.json` / `tsconfig.json` / 生成器 / 検査ツールを**すべて複製**していた。その二重管理を
やめ、システム（リポジトリ直下 `structured-latex/`）のローカライズモデルへ移した。いまは
`../../locales.config.ts` が宣言する**翻訳ロケール `en`** であり、ラベル型・スキーマ・生成器・
検査はすべて日本語版と共有する。撤去したものと移管先の対応表は
[`../../../outputs/reports/cycle24_ops_localize_english_edition.md`](../../../outputs/reports/cycle24_ops_localize_english_edition.md)。

投稿先の根拠は
[`../../../outputs/reports/paper001_submission_venue_survey.md`](../../../outputs/reports/paper001_submission_venue_survey.md)。
Survey Article は**ページ数上限なし**、言語は**英語**、採否は「解説の明快さ・細部の正確さ・
研究結果の質・主題の関連性と興味深さ」で決まる（同誌公式サイト。2026-08-01 取得）。

## この中にあるもの

| ファイル | 役割 |
| --- | --- |
| `content/` | 英語版の本文（ブロック列。**配列の並びが文書順**） |
| `frontmatter.ts` | 表題・著者・要旨・キーワード・MSC 2020 |
| `allowance.ts` | 原文と食い違ってよい箇所の**宣言**（比較の実装は持たない） |
| `translation-only-blocks.ts` | 英語版にしか無いファイル・ブロックと、その理由 |
| `structure-exceptions.ts` | 骨格の差を許すブロックと、理由・許す規則 |
| `diff-rules.ts` | 許す差の**種類**の定義（どの規則が何を検査するか） |

## 日本語版との対応（この構成の要）

英語版のブロック id・ラベル・`habitat`・`verification`・`lean`・**数式**・参照先・引用キーは、
日本語版と一致していなければならない。訳されるのは地の文と題名、および `realEscape` の**文言**だけ
である（`realEscape` は宣言の**有無**が一致していなければならない）。

これを散文の約束にせず、**システムの構造照合**が機械検証する。自前の比較器は持たない。

```sh
npm run verify:localization   # 原文と全ロケールの構造照合 ＋ 免除の登録が腐っていないかの監査
npm run test:localization     # 壊した版を作り、上の検査が実際に落ちることの実証
npm run check                 # 上を含む一式（生成物・型・実行時・PDF・負テスト・転記検査）
```

正当な差は**理由つきで**宣言したものだけ許す。**免除の単位はブロックではなく差分 1 つである**
（ブロック単位の免除は cycle 21 で実際に検査の穴になり、英語版のインライン数式 11 個の脱落を
隠した）。理由が空文字の登録は違反として報告される。使われなくなった登録も「腐った登録」として
報告される。

## 訳語

**[`../../../docs/paper001-en-glossary.md`](../../../docs/paper001-en-glossary.md) が訳語の正本である。**
そこに無い語で迷ったら、まずその表へ追記してから訳す。

## 最終成果物の生成（LaTeX / PDF）

生成器は**日本語版と同じ 1 本**（`../../tools/build-latex.ts`）である。版で変わるものは
`../../tools/editions.ts` が持つ。

```sh
npm run build:tex:en   # build/en/document.tex を生成
npm run build:pdf:en   # 生成 → PDF ビルド → ノート混入の検査
```

日本語版との組版の差（`../../tools/editions.ts` に理由つきで書いてある）:

- xeCJK と和文フォントを**外した**。★ は pifont の `\ding{72}` で組む
- 定理環境・`cleveref`・住処の枠の文言を**英語**にした（**住処と ℝ 脱出の印字は落としていない**）
- **フロントマター**（表題・著者・要旨・キーワード・MSC 2020）を出す。中身は `frontmatter.ts`
- **参考文献**を BibTeX で出す。書誌の正本は
  [`../../../outputs/papers/001_R_Lambda_duality/refs.bib`](../../../outputs/papers/001_R_Lambda_duality/refs.bib)
  **1 つだけ**で、リポジトリへ複製は作らない。ビルド時に `build/en/refs.generated.bib` を導出する
  （正本の `note` は日本語の内部来歴メモなので落とす。落とさないと投稿稿に内部メモが載り、
  かつ和字が PDF から無言で消える）
- 目次を**出さない**（投稿稿の目次は出版社の組版が決める）
- 地の文の `**強調**` を `\textbf{...}` へ落とす（日本語版はアスタリスクがそのまま PDF に出ている）

**検査は生成器が全版に同じものを掛ける**（未解決参照 0 / ラベル重複 0 / 組めない文字 0 /
版面外へ出た行 0 / ページ数の取得）。書誌に関する検査（未定義の引用キー 0・BibTeX が実際に走ったこと）
だけは、書誌を出す版にのみ効く。

## 入力言語（`cite` ノード）

引用は入力言語の `cite` ノードで書く。

```typescript
cite(["Monsky1981"])                                  // \cite{Monsky1981}
cite(["Monsky1981", "CuocoMonsky1981"], "Theorem 5.6") // \cite[Theorem 5.6]{Monsky1981,CuocoMonsky1981}
```

`.bib` に無いキーを書くと**生成の時点で落ちる**（PDF に `[?]` が出ることはない）。
日本語版は書誌を地の文へ直に書く方針なので `cite` を使わない（渡すと生成器が落とす）。

## ラベル型

英語版の本文は `defineTranslatedBlocks` / `refInTranslation` を使う。受け口が
`AnyLocaleLabel`（原文のラベル ＋ 英語版限定ブロックのラベル）に広がるだけで、
**存在しないラベルはコンパイル時に落ちる**（`../../tools/negative-type-test.ts` が実証する）。
原文はこの型を使わない。
