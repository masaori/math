# structured-latex（integrable-lattice の証明の正本）

このディレクトリが **integrable-lattice の証明本体の正本**である。
Typst で新規に証明を書かない（リポジトリ直下 CLAUDE.md「証明の記述形式（全プロジェクト共通）」）。

**入力言語（ブロック・ノード・ラベル・ノートの語彙）の定義はここには無い。**
正本はリポジトリ直下の [`structured-latex/`](../../structured-latex/)（システム）が 1 つだけ持つ。
本プロジェクトはそれを**具体化して使う側**であり、`schema.ts` がやるのは次の 3 つだけである。

1. 生成された `Label`（`content/` に実在するラベルのユニオン型）を受け取る
2. **本プロジェクト固有メタデータ**を宣言する（`habitat` / `realEscape` / `verification` / `lean`）
3. `createStructuredTextSchema` / `createRuntimeSchema` を具体化して再エクスポートする

以前はここに Ising 版から複製した入力言語の定義そのものが置かれていた
（同じ言語が複数箇所で定義される状態）。それを解消したのが現在の形である。

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

現在の実測: 10 ページ / ブロック 30 件 / 相互参照 17 件すべて解決 / 未解決参照 0 /
組めない文字 0 / 版面外へ出た行 0。

なお散文中の Unicode 数学記号（ℝ, Λ, ∞, ℚ̄ など）と、数式中の ★ は `tools/unicode-math.ts` が
LaTeX へ写す。欧文フォントに無い字は PDF から**無言で消える**ため（実測で ℝ/ℤ/ℚ/μ/★ が消え、
ℚ̄ は ℚ に化けた）、生成器側で変換している。`content/` のデータは書き換えない。
長いパスの `\texttt{...}` は `\path{...}` で組み、版面からはみ出さないようにしている。

## この基盤は複製ではない（システムを使う側である）

かつてこのディレクトリは Ising 側の複製で、複製が腐らないよう同期検査
（`tools/verify-shared-tools-in-sync.ts`）を置いていた。入力言語の正本をシステムへ一本化した
時点で複製そのものが無くなったので、その検査は削除した。判断の経緯は
[docs/structured-latex-decision.md](../docs/structured-latex-decision.md) に残っている（履歴として読む）。

論文本体は `content/001_intro.ts` 〜 `007_asymmetry_scope.ts` に執筆済みである。
生成器を適用した結果と、その過程で見つかった表示上の不具合は
[docs/paper-001-migration-status.md](../docs/paper-001-migration-status.md) に記録した。

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

`content/` に実在するラベルはシステムの生成器が集めて `labels.generated.ts`
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
| ブロック id・ノート id・ラベルの重複（同一ファイル内／**ファイル跨ぎ**とも） | 型検査 | `__ブロックidが重複している` / `does not satisfy the constraint 'never'` |
| ノート id とブロック id の衝突 | 型検査 | 同上 |
| **本文ブロックが `habitat` を宣言していない** | 型検査 | `not assignable to type 'ConvertedBlock'` |
| **`habitat` の綴り違い** | 型検査 | `not assignable to type 'CountableHabitat｜EscapingHabitat'`（候補付き） |
| **可算 `habitat` なのに `realEscape` を書く** | 型検査＋実行時 | `Type 'string' is not assignable to type 'undefined'`（可算側は `realEscape?: never`） |
| **非可算 `habitat`（`R`/`C`/`mixed`）なのに `realEscape` が無い** | 型検査＋実行時 | 同上 |
| **見出しに `habitat` を書く** | 型検査＋実行時 | `Type 'string' is not assignable to type 'undefined'` |
| **`verification` / `lean` が文字列の配列でない** | 型検査＋実行時 | `not assignable to type 'readonly string[]'` |

上表のうち**太字の行（本プロジェクト固有メタデータの型強制）**は
`node tools/negative-type-test.ts`（9 ケース）が**実際に tsc を落として**確認している。
各ケースは対で回す（正しい版が通ること／壊した版が落ちて期待する診断が出ること）ので、
「型検査は通っているが実は何も検出していない」状態と区別できる。
**太字でない行（入力言語一般）はシステム側の負テストが持つ**ので、ここには複製していない。
回帰テストは `type-tests/label-typing.test-d.ts`（`@ts-expect-error` の並び）と
`tools/schema-runtime-test.ts`（型を回避した値を具体化した実行時スキーマが拒むこと。13 ケース）。

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
4. **生成物とディレクトリの実状の一致**（`npm run check:generated`）。
   ディレクトリに増えたファイルが生成物の列挙から漏れていることは型では検出できない。

より詳しい根拠（なぜ型で書けないかの実測）はシステムの
[docs/type-coverage.md](../../structured-latex/docs/type-coverage.md) を参照する
（`habitat` / `realEscape` の追加分は、上の表とこの節が本プロジェクト側の記録である）。

## `verify-no-lost-proofs.ts` を移植していない理由

Ising 側の `tools/verify-no-lost-proofs.ts` は、「旧 Typst の原本に証明があるのに構造化側が
TODO のままである」移行漏れを検出するツールである。本プロジェクトには**移行元の Typst 証明が
実質存在しない**ため移植していない。確認した事実は次のとおり（`_old/typst/README.md` にも記録した）。

- 旧 `main.typ` は 17 行で、`#set document(title: ...)` と見出し 3 つ
  （「Integrable Lattice Statement Mining」「目的」「出力目標」）と説明文・箇条書きだけからなる。
  **定理・定義・主張・証明を 1 つも含まない。**
- 旧 `parts/` は空ディレクトリだった（`.gitkeep` のみ）。

将来 Typst 原本から移行する対象が生じたら、Ising 側の実装を参考に有効化すること
（そのときは `origin.path` の実在検査も一緒に入る）。

## ソース形式は TypeScript に統一する

`schema` / `content` / `notes` / `tools` はすべて `.ts` である。**`.mjs` は使わない**
（書き方が 2 種類あると、片方が型検査の網から漏れる）。

## Model

- 正本は TypeScript のオブジェクトデータ。システムの型（コンパイル時）と
  システムの実行時スキーマ（`createRuntimeSchema`。Result を返す）の二重で守る。
- 数式は KaTeX へ渡す LaTeX 文字列として持つ。
- **配列の並びが文書順の正準表現**（`content/*.ts` をファイル名昇順に並べ、各ファイル内は配列順）。
  由来は `origin: { path, ordinal }`（任意）。`ordinal` は文書順ではなく、
  そのソースファイル内の通し番号にすぎない。

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

- `schema.ts` — システムのファクトリを本プロジェクトのラベルと固有メタデータで具体化し、
  再エクスポートするだけの薄いモジュール（`defineBlocks` / `defineNotes` / `ref` / `runtimeSchema`）。
- `labels.generated.ts` — 自動生成。実在ラベルのユニオン型 `Label`（直接編集しない）。
- `document.generated.ts` — 自動生成。全 content / notes を連結し、ファイル跨ぎの一意性を型で主張する。
- `tools/content-modules.ts` — `content/` `notes/` の読み込み（システムの実装へ委譲）。
- `tools/codemod-origin.ts` — 由来フィールドをシステムの `origin` へ移すコードモッド（冪等。適用済み）。
- `tools/validate-content.ts` — 実行時検証（Typst 記法・可算/非可算の食い違い・`verification` の実在ほか）。
- `tools/negative-type-test.ts` — 固有メタデータの型強制の実証テスト（9 ケース）。
- `tools/schema-runtime-test.ts` — 具体化した実行時スキーマのテスト（13 ケース）。
- `type-tests/label-typing.test-d.ts` — `@ts-expect-error` による型の回帰テスト。
- `content/` — 証明ブロック群（出版物の本体）。
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
npm run gen                                      # 生成物（ラベル型・集約モジュール）を再生成
node structured-latex/tools/validate-content.ts  # 実行時検証
```

ラベル・ブロックを増減したら `npm run gen` で生成物を作り直す
（忘れると型検査が落ちるので、取りこぼしにはならない）。
Node は 22.18 以降が必要（`.ts` を型ストリップで直接実行するため）。

証明↔数値検証の対応検査は `node sagemath/tools/verify-check-linkage.ts` が別に持つ
（`verification` / `lean` フィールドを情報源にする）。
