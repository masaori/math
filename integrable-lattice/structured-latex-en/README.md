# structured-latex-en（論文 001 の英語版）

論文 001「ℝ/Λ 双対」を **Expositiones Mathematicae の Survey Article** として投稿できる形にした
英語版である。**日本語版 [`../structured-latex/`](../structured-latex/) が正本であり、
この英語版はそれを一切変更せずに並置する**（内容を失わない可逆な構成にするため）。

投稿先の根拠は [`../outputs/reports/paper001_submission_venue_survey.md`](../outputs/reports/paper001_submission_venue_survey.md)。
Survey Article は**ページ数上限なし**、言語は**英語**、採否は「解説の明快さ・細部の正確さ・
研究結果の質・主題の関連性と興味深さ」で決まる（同誌公式サイト。2026-08-01 取得）。

## 現状（重要）

**器だけができている。本文の英訳は 33 ブロック中 2 ブロックしか無い。**
残り 31 ブロックは後続の翻訳作業で足す。したがって
`npm run verify:correspondence` は**いま必ず落ちる。それが正しい状態である**
（何が欠けているかを列挙して落ちる）。

## 日本語版との対応（この構成の要）

英語版のブロック id・ラベル・`habitat`・`realEscape` の有無・`proof` の有無・`verification`・
`lean`・**数式**は、日本語版と一致していなければならない。訳されるのは地の文だけである。
これを散文の約束にせず、`tools/verify-ja-en-correspondence.ts` が機械検証する。

```sh
npm run verify:correspondence   # 日英の対応を検査（翻訳が終わるまで落ちる）
npm run check                   # 器の健全性（生成物・型・実行時・PDF・負テスト）
npm run check:full              # 上の 2 つ
```

`check` に対応検証を入れていないのは、**常に落ちる検査を `check` に入れると `check` 自体が
「無視するもの」になり、`check` が守っている他の不変条件まで一緒に無視されるからである。**
翻訳が完了して緑になったら `check` へ移してよい。

正当な差は 2 つの表で**理由つきで**許す（どちらも 0 件で始まる）。

- `tools/ja-en-exceptions.ts` … 数式の差を許すブロックと、その理由
- `tools/en-only-blocks.ts` … 英語版にしか無いブロックと、なぜ英語版だけに必要か

理由が空文字の登録は、検証ツールが違反として報告する。

## 訳語

**[`../docs/paper001-en-glossary.md`](../docs/paper001-en-glossary.md) が訳語の正本である。**
そこに無い語で迷ったら、まずその表へ追記してから訳す。

## 最終成果物の生成（LaTeX / PDF）

```sh
npm run build:tex   # build/document.tex を生成
npm run build:pdf   # 生成 → PDF ビルド → ノート混入の検査
```

日本語版との差（`tools/build-latex.ts` の冒頭に理由つきで書いてある）:

- xeCJK と和文フォントを**外した**。★ は pifont の `\ding{72}` で組む
- 定理環境・`cleveref`・住処の枠の文言を**英語**にした（**住処と ℝ 脱出の印字は落としていない**）
- **フロントマター**（表題・著者・要旨・キーワード・MSC 2020）を出す。中身は `frontmatter.ts`
- **参考文献**を BibTeX で出す。書誌の正本は
  [`../outputs/papers/001_R_Lambda_duality/refs.bib`](../outputs/papers/001_R_Lambda_duality/refs.bib) **1 つだけ**で、
  リポジトリへ複製は作らない。ビルド時に `build/refs.generated.bib` を導出する
  （正本の `note` は日本語の内部来歴メモなので落とす。落とさないと投稿稿に内部メモが載り、
  かつ和字が PDF から無言で消える）
- 目次を**出さない**（投稿稿の目次は出版社の組版が決める）
- 地の文の `**強調**` を `\textbf{...}` へ落とす（日本語版はアスタリスクがそのまま PDF に出ている）

日本語版から引き継いだ検査は 1 つも落としていない（未解決参照 0 / ラベル重複 0 / 組めない文字 0 /
版面外へ出た行 0 / ページ数の取得）。これに「未定義の引用キー 0」と「対応の取れない `**` 0」を足した。

## 入力言語（`cite` ノード）

引用は入力言語の `cite` ノードで書く（システム側に追加した語彙）。

```typescript
cite(["Monsky1981"])                                  // \cite{Monsky1981}
cite(["Monsky1981", "CuocoMonsky1981"], "Theorem 5.6") // \cite[Theorem 5.6]{Monsky1981,CuocoMonsky1981}
```

`.bib` に無いキーを書くと**生成の時点で落ちる**（PDF に `[?]` が出ることはない）。

## 固有メタデータの語彙は日本語版から import している

`habitat` / `realEscape` / `verification` / `lean` の**定義は日本語版 `../structured-latex/schema.ts`
が 1 つだけ持ち、この英語版はそれを import する**。これらは言語に依存せず、日英で同一でなければ
ならない値だからである（対応検証が `habitat` の文字列一致を見る）。書き写すと、片方だけ語彙が
増えたときに対応検証が意味を失う。
