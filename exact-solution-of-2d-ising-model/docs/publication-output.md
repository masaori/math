# 最終成果物（論文・書籍）の生成

`structured-latex/content/` **だけ**を入力に LaTeX を組み立て、PDF まで作る。
実装は `structured-latex/tools/build-latex.ts`。README 7 節の
「証明の正本は content/。ここだけから最終成果物を生成する」を実行可能にしたもの。

## 使い方

```sh
cd exact-solution-of-2d-ising-model/structured-latex
pnpm install          # 初回のみ（Node 側の依存）
npm run build:tex     # build/document.tex を生成する
npm run build:pdf     # 生成 → PDF ビルド → ノート混入の検査
```

PDF 化には [tectonic](https://tectonic-typesetting.github.io/)（XeTeX 系。必要な TeX パッケージを
自動取得する）を使う。未導入なら `brew install tectonic`。日本語は `xeCJK` ＋ ヒラギノで組む。

生成物は `build/`（git 管理外）に出る。`document.tex` / `document.pdf` / `document.log`。

## 現在の出力（実測）

| 項目 | 値 |
|---|---|
| ページ数 | 175 |
| ブロック | 217（うち見出し 15、証明 141） |
| ラベル | 183 |
| 相互参照 | 945（**未解決 0**） |
| 数式ノード | 6,683（総計 366,329 文字、異なりマクロ 154 種） |
| ノートの混入 | 0（下記の 3 重検査） |

## 変換規則

| 構造化テキスト | LaTeX |
|---|---|
| content のファイル名昇順 × 配列順 | 文書順（**配列の並びが正準**。並べ替えはしない） |
| 見出し `level` 1 / 2 / 3 / 4 … | `\part` / `\section` / `\subsection` / `\subsubsection` … |
| `definition` / `claim` / `theorem` / `remark` / `note` | amsthm の各環境（定義 / 主張 / 定理 / 注意 / ノート）。番号は「章.通し番号」 |
| `proof` | `proof` 環境 |
| ブロックの `labels` | `\label{lab:<ラベル>}`（ブロック id も `\label{blk:<id>}` として持つ） |
| `ref(target)` | `\cref{lab:<target>}`（環境名つきの参照。`cleveref`） |
| `math` / `displayMath` | `$...$` / `\[...\]`（文字列はそのまま渡す） |
| `list` | `itemize` |
| `todo` | `\textbf{[TODO]}` つきの段落（現在 0 件） |
| 地の文（`text`） | LaTeX の特殊文字をエスケープして出力 |

見出しの階層について: content の最上位（`level` 1）は「部」に相当する 1 件だけで、章はすべて
`level` 2 である（原本 Typst の `=` / `==` に対応）。そのため `level` 1 を `\part`、`level` 2 を
`\section` へ写している。素直に `\section` / `\subsection` にすると、最初の `\part` より前に置かれた
章のブロックが「定義 0.4」のような番号になってしまう（実測して選んだ）。

## ノートが混入しないことの担保

`notes/` は参照用で、出版物には載らない。これを 3 つの独立した観点で検査する
（`tools/verify-no-notes-in-output.ts`。`npm run check` にも入っている）。

1. **構造**: 生成器のコードが `loadNoteFiles` / `notesDir` / `notes/` を参照していないこと。
2. **識別子**: 生成した `.tex` にノートの id が 1 件も現れないこと。
3. **本文**: 各ノートの地の文から取った 24 文字以上の特徴的な文字列（計 107 件）が
   `.tex` に現れないこと。id を書き換えただけで中身が入る経路を塞ぐ。

検査が実際に効くことは、生成物へノートの一文を注入して確認済み
（`ノート本文が生成物にある: note_calc_formulae_018_... —「は、例えば次のようになり、スカラー積とはならない。」` で落ちる）。

## 相互参照の検査

- ラベルの実在は**型**で保証済み（`ref()` は生成ユニオン型 `Label` しか受け付けない）。
- 生成時にもラベル → ブロックの対応表を作り、未解決の `ref` があれば**生成を中止**する。
- PDF ビルド後、LaTeX の警告（`Reference '...' on page ... undefined`）を検査し、
  1 件でもあれば失敗にする。**現在 0 件。**

## 数式は LaTeX でそのまま組めるか（実測結果）

数式は KaTeX 向けの LaTeX 文字列として保持されているが、**現時点で組めないものは 1 件も無い**。
6,683 個の数式ノードを含む文書全体が、エラー 0 件でコンパイルされる（`document.log` に
`Undefined control sequence` などのエラーは無い）。

使われているマクロは 154 種で、内訳は標準 LaTeX ＋ `amsmath` / `amssymb` / `mathtools` の範囲に収まる。
プリアンブルで読み込んでいるのはこの 3 つ（＋ `geometry` / `xeCJK` / `hyperref` / `cleveref`）だけである。
パッケージが要る主なものは次のとおり:

- `amssymb`: `\boxtimes`（949 回。クロネッカー積の記号）、`\because` / `\therefore`、`\ast`、`\flat`、`\ell`
- `amsmath`: `\text`、`\dfrac` / `\tfrac`、`\binom` / `\tbinom`、`\substack`、`\operatorname`、
  `\pmod` / `\bmod`、`\xrightarrow`、`\tag`、`\begin{aligned}` などの数式環境
- `mathtools`: `\middle` を伴う可変サイズ区切り（`\left\{ ... \middle| ... \right\}`）

日本語は数式内にも現れる（`\text{…}` の中）。`xeCJK` を入れているため数式内でも正しく組まれる
（PDF を目視で確認済み）。

**組めないものが出た場合の運用**: `npm run build:pdf` が失敗し、`build/tectonic-error.log` に
詳細が残る。その一覧をこの節へ追記し、本文側の記法を直す（本文の修正は生成器の責務ではない）。

## 目視確認

PDF の 1 / 5 / 40 / 120 ページ目を画像化して確認した（`pdftoppm`）。
定理環境の見出しと番号、証明の四角、相互参照のリンク（例:「主張 1.33」）、
数式・日本語の混植がいずれも意図どおりに組まれている。
