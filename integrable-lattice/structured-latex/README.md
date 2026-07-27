# structured-latex（integrable-lattice の証明の正本）

このディレクトリが **integrable-lattice の証明本体の正本**である。
Typst で新規に証明を書かない（リポジトリ直下 CLAUDE.md「証明の記述形式（全プロジェクト共通）」）。

実装の土台は `exact-solution-of-2d-ising-model/structured-latex/` を複製したものだが、
**本プロジェクト固有の要件**（可算／非可算の分別、ℝ 脱出の明示、SageMath・Lean との紐づけ）を
スキーマへ追加してある。共有ライブラリとして切り出していないのは、生成物
（`labels.generated.ts` / `document.generated.ts`）が各プロジェクトの `content/` に強く
結びついており、実質的に共有できるのはスキーマとツールだけだからである（複製の方が安全）。

## 最終成果物の生成（LaTeX / PDF）

`content/` だけを入力に LaTeX を組み、PDF まで作る（`tools/build-latex.ts`）。
`notes/` は読まない（混入していないことは `tools/verify-no-notes-in-output.ts` が 3 重に検査する）。

```sh
npm run build:tex   # build/document.tex を生成
npm run build:pdf   # 生成 → PDF ビルド → ノート混入の検査
```

PDF 化には tectonic が要る（未導入なら `brew install tectonic`）。日本語は xeCJK ＋ ヒラギノ。
出力は `build/`（git 管理外）。**住処（`habitat`）と ℝ 脱出（`realEscape`）は PDF にも印字する**
——「ℝ へ脱出した箇所を必ず明示する」という要求は、データに持つだけでは読者に伝わらないため。

現在の実測: 5 ページ / ブロック 20 件 / 相互参照 9 件すべて解決 / 未解決参照 0 /
組めない文字 0 / 版面外へ出た行 0。

なお散文中の Unicode 数学記号（ℝ, Λ, ∞ など）は `tools/unicode-math.ts` が LaTeX へ写す。
欧文フォントに無い字は PDF から**無言で消える**ため（実測で ℝ/ℤ/ℚ/μ が消えた）、
生成器側で変換している。`content/` のデータは書き換えない。

## この基盤は複製である（共有ライブラリではない）

判断の根拠と、複製が腐らないようにする同期検査は
[docs/structured-latex-decision.md](../docs/structured-latex-decision.md) に記録した。
`npm run check` に含まれる `tools/verify-shared-tools-in-sync.ts` が、
土台 4 ファイルが複製元とバイト一致していることと、固有化した 6 ファイルが
複製元と一致して**いない**ことを検査する。

## いま置いてあるのは「足場」であって論文本体ではない

`content/000_scaffold.ts` と `notes/000_scaffold.ts` は、**基盤が動くことを示すための最小の足場**
であり、数学的な主張の正本ではない。論文本体の移設は `content/001_setup.ts` / `002_lambda_side_finite.ts` /
`003_towers_and_graphs.ts` として着手済みである（企画書 `outputs/paper-plans/002_R_Lambda_duality.md`
のうち、確定済みと明記された命題の**主張文**を転記した）。
何を移し、何を数学的判断のために移していないかは
[docs/paper-001-migration-status.md](../docs/paper-001-migration-status.md) に記録した。
ただし `content/` が空になると `tools/generate-index.ts` が「ラベルを 1 件も抽出できない」で
落ちるので、実ブロックを入れるまでは足場を残しておくこと。

## 本プロジェクト固有: 可算／非可算の分別と ℝ 脱出の明示

README（`integrable-lattice/README.md`）とリポジトリ直下 CLAUDE.md の要求は
「できる限り Λ の言葉で証明を書き、可算（ℕ/ℤ/ℚ/Λ/ℚ̄）と非可算（ℝ/ℂ）を分別しながら証明する。
**ℝ へ脱出した箇所を必ず明示する**」である。これを散文の約束事にせず、
**本文ブロックの必須フィールドとして型で強制する**。

| フィールド | 意味 | 制約 |
|---|---|---|
| `habitat` | そのブロックが扱う量の住処 | **本文ブロックでは必須**。可算側 `"N"` / `"Z"` / `"Q"` / `"Lambda"` / `"Qbar"` / `"none"`、非可算側 `"R"` / `"C"` / `"mixed"`。見出しには書けない |
| `realEscape` | ℝ/ℂ をどこで・なぜ使ったか | 非可算側の `habitat` では**必須**、可算側では**書けない**（判別共用体で型が強制する） |
| `verification` | 対応する SageMath 検証ディレクトリのパス（`integrable-lattice/` からの相対）の配列 | 省略可。**実在しないパスは実行時検証が落とす** |
| `lean` | 対応する Lean 定理名の配列 | 省略可（後段の形式検証との紐づけ用） |

`"none"` は「数量を扱わないブロック」（方法論的な但し書きなど）を表す。可算側と同じく
`realEscape` を書けない。

## 型検査で何を捕まえるか

`content/` に実在するラベルは `tools/generate-index.ts` が集めて `labels.generated.ts`
（ラベル文字列のユニオン型 `Label`）へ書き出し、同時に `document.generated.ts`
（全ファイルを 1 本のタプル型へ連結する集約モジュール）を作る。`schema.ts` はこの型で参照を縛り、
集約モジュールはファイルを跨いだ一意性を主張するので、次の誤りは
**実行時の検証を待たずコンパイル時に落ちる**。

| 誤り | 検出 | 実測した診断 |
|---|---|---|
| `ref("存在しないラベル")` | 型検査 | 実在ラベルのユニオンへ代入不可（近い綴りの候補付き） |
| ノートの `targets` が存在しないラベル | 型検査 | 同上 |
| ノートの `targets` が空 | 型検査 | `Type '[]' is not assignable to type 'readonly [...]'` |
| ブロックが未登録のラベルを宣言（生成物の再生成漏れ） | 型検査 | 同上 |
| 見出しブロックに本文（`statement`/`proof`）を書く | 型検査 | `not assignable to type 'ConvertedBlock'` |
| 本文ブロックに `notes` を書く | 型検査＋実行時 | `notes?: never` |
| フィールド名の打ち間違い（`proof` → `proofs` 等） | 型検査（余剰プロパティ検査）＋実行時 | 交差型への代入不可 |
| 定理型ブロックに `level`（見出し用フィールド）を書く | 型検査＋実行時 | `not assignable to type 'HeadingLevel｜undefined'` |
| 見出しの `level` が 1〜6 の範囲外 | 型検査 | `Type '7' is not assignable` |
| タイトルが `text` も `tex` も持たない | 型検査 | `Type '{}' is not assignable` |
| `conversion.status` の綴り違い | 型検査 | `not assignable to type 'ConversionStatus'`（候補付き） |
| ブロック id・ノート id・ラベルの重複（同一ファイル内／**ファイル跨ぎ**とも） | 型検査 | `__ブロックidが重複している` / `does not satisfy the constraint 'never'` |
| ノート id とブロック id の衝突 | 型検査 | 同上 |
| `sourceOrdinal` が正の整数でない | 型検査 | `__sourceOrdinalが正の整数でない` |
| **本文ブロックが `habitat` を宣言していない** | 型検査 | `not assignable to type 'ConvertedBlock'` |
| **`habitat` の綴り違い** | 型検査 | `not assignable to type 'CountableHabitat｜EscapingHabitat｜undefined'`（候補付き） |
| **可算 `habitat` なのに `realEscape` を書く** | 型検査＋実行時 | `not assignable to type 'ConvertedBlock'` |
| **非可算 `habitat`（`R`/`C`/`mixed`）なのに `realEscape` が無い** | 型検査＋実行時 | 同上 |
| **見出しに `habitat` を書く** | 型検査＋実行時 | `not assignable to type 'CountableHabitat｜…｜undefined'` |
| **`verification` / `lean` が文字列の配列でない** | 型検査＋実行時 | `not assignable to type 'readonly string[]'` |

上表の診断はすべて `node tools/negative-type-test.ts`（26 ケース）が**実際に tsc を落として**
確認したものである。各ケースは対で回す（正しい版が通ること／壊した版が落ちて期待する診断が出ること）ので、
「型検査は通っているが実は何も検出していない」状態と区別できる。
回帰テストは `type-tests/label-typing.test-d.ts`（`@ts-expect-error` の並び）と
`tools/schema-runtime-test.ts`（型を回避した値を実行時検証が拒むこと。18 ケース）。

**型が守るのは参照側**である点に注意する。`Label` はブロックの `labels` から生成されるので、
ラベル自体の綴り間違いは、再生成した時点で「実在するラベル」として正当化される。
ラベルを直すときは、それを指す `ref` が一斉に型エラーになることで改名漏れが分かる、という守り方になる。

## 型では落とせないもの（実行時検査として残す）

`tools/validate-content.ts` だけが検出できるもの:

1. **未変換の Typst 記法の混入**（`dot.op` / `mat(` / `cases(` など）。数式は `String.raw` の
   戻り値で型は `string`（リテラル型ではない）なので、テンプレートリテラル型の制約を掛けられない。
2. **可算 `habitat` を宣言したブロックの数式に ℝ/ℂ が現れていること。** `habitat` / `realEscape` の
   **要否**は型で守れるが、「可算だと宣言したのに中身に `\mathbb{R}` がある」という**宣言と中身の
   食い違い**は、上と同じ理由（数式がリテラル型でない）で型では見られない。
   これを検出したときの正しい直し方は、検査を緩めることではなく、`habitat` を `"mixed"`
   （または `"R"` / `"C"`）にして `realEscape` を書くことである。
3. **`verification` が指す SageMath 検証ディレクトリの実在。** 型システムはファイルシステムを
   読めない。実在しないパスを黙って通すと、証明↔数値検証の対応が切れたまま「紐づいている」ように見える。
4. **生成物とディレクトリの実状の一致**（`node tools/generate-index.ts --check`）。
   ディレクトリに増えたファイルが生成物の列挙から漏れていることは型では検出できない。

より詳しい根拠（なぜ型で書けないかの実測）は Ising 側の
[docs/type-coverage.md](../../exact-solution-of-2d-ising-model/docs/type-coverage.md) を参照する。
基盤の土台が同じなので、そこの議論はこのプロジェクトにもそのまま当てはまる
（`habitat` / `realEscape` の追加分は、上の表とこの節が本プロジェクト側の記録である）。

## `verify-no-lost-proofs.ts` を移植していない理由

Ising 側の `tools/verify-no-lost-proofs.ts` は、「旧 Typst の原本に証明があるのに構造化側が
TODO のままである」移行漏れを検出するツールである。本プロジェクトには**移行元の Typst 証明が
実質存在しない**ため移植していない。確認した事実は次のとおり（`_old/typst/README.md` にも記録した）。

- 旧 `main.typ` は 17 行で、`#set document(title: ...)` と見出し 3 つ
  （「Integrable Lattice Statement Mining」「目的」「出力目標」）と説明文・箇条書きだけからなる。
  **定理・定義・主張・証明を 1 つも含まない。**
- 旧 `parts/` は空ディレクトリだった（`.gitkeep` のみ）。

将来 Typst 原本から移行する対象が生じたら、Ising 側の実装を複製して有効化すること
（そのときは `sourcePath` の実在検査も一緒に入る）。

## ソース形式は TypeScript に統一する

`schema` / `content` / `notes` / `tools` はすべて `.ts` である。**`.mjs` は使わない**
（書き方が 2 種類あると、片方が型検査の網から漏れる）。`content/` `notes/` に `.mjs` が現れたら
`tools/content-modules.ts` がエラーで落とす。

## Model

- 正本は TypeScript のオブジェクトデータ。`schema.ts` の型（コンパイル時）と
  同ファイルの検証関数（実行時）の二重で守る。
- 数式は KaTeX へ渡す LaTeX 文字列として持つ。
- **配列の並びが文書順の正準表現**（`content/*.ts` をファイル名昇順に並べ、各ファイル内は配列順）。
  `sourceOrdinal` は文書順ではなく、そのソースファイル内の通し番号である。

### ブロックの種類

- 定理型: `theorem` / `definition` / `claim` / `remark` / `note`。
  `statement` を持ち、`proof` を持てる。加えて `habitat`（必須）と、非可算側なら `realEscape`。
- 構造: `heading`。`level`（1 が最上位）と `title` を持ち、本文も `habitat` も持たない。

### 本文とノートの使い分け

`content/` は**出版物（論文）の本体**である。最終成果物の生成は `content/` だけを読むので、
`notes/` に置いたものは構造上いっさい出版物に混入しない。

- **正しさに必要ならそれは注記ではない。** 定義が意味をもつ条件、主張の適用範囲、well-defined 性、
  主張から従う数学的帰結は、注記ではなく `statement`（証明中の事柄なら `proof`）に書く。
- **`notes/` に置くのは参照用の素材だけ。** 補足計算、具体例、参考公式、物理的解釈、
  先行研究との比較など。各ノートは `targets` で紐づけ先を**ラベル**で参照する（パス非依存）。

## ファイル

- `schema.ts` — 型 + 実行時検証の正本（`defineBlocks` / `defineNotes` とノード生成ヘルパ）。
- `labels.generated.ts` — 自動生成。実在ラベルのユニオン型 `Label`（直接編集しない）。
- `document.generated.ts` — 自動生成。全 content / notes を連結し、ファイル跨ぎの一意性を型で主張する。
- `tools/generate-index.ts` — 生成物 2 種を作る（`--check` で鮮度検査のみ）。
- `tools/content-modules.ts` — `content/` `notes/` の読み込み（ファイル名昇順＝文書順）。
- `tools/validate-content.ts` — 実行時検証（Typst 記法・可算/非可算の食い違い・`verification` の実在ほか）。
- `tools/negative-type-test.ts` — 「誤った入力は tsc が拒否する」ことの実証テスト（26 ケース）。
- `tools/schema-runtime-test.ts` — 実行時検証のテスト（18 ケース）。
- `type-tests/label-typing.test-d.ts` — `@ts-expect-error` による型の回帰テスト。
- `content/` — 証明ブロック群（出版物の本体）。いまは足場のみ。
- `notes/` — 参照用ノート（ラベルで紐づく。最終成果物には載らない）。
- `logs/` — 検証コマンドの実行ログ。

## 検証（変更したら必ず通す）

初回のみ依存をインストールする（型検査に `typescript` を使う。lockfile は `pnpm-lock.yaml`）。

```sh
cd integrable-lattice/structured-latex && pnpm install
```

```sh
npm run check   # 生成物の鮮度 → 型検査 → 実行時検証 → 負テスト → 実行時検証テスト
```

個別に回す場合（プロジェクトディレクトリから）:

```sh
node structured-latex/tools/generate-index.ts    # 生成物（ラベル型・集約モジュール）を再生成
node structured-latex/tools/validate-content.ts  # 実行時検証
```

ラベル・ブロックを増減したら `node tools/generate-index.ts` で生成物を作り直す
（忘れると型検査が落ちるので、取りこぼしにはならない）。
Node は 22.18 以降が必要（`.ts` を型ストリップで直接実行するため）。

なお `tsconfig.json` の `include` に Ising 側のような `../sagemath/tools` は入れていない。
本プロジェクトの `sagemath/` にはまだ `tools/` が無いためである
（証明↔数値検証の対応検査を入れるときは、`verification` フィールドを情報源にできる）。
