# Lean 4 + mathlib4 による機械的証明

複素行列環とクリフォード代数の同型の論文（`structured-latex/content/`）の人手証明を、Lean 4 で検証する。
規約の正本は、リポジトリ直下の `docs/context/証明の書き方.md` の「Lean 具体版」「Lean 必要十分版」と、
このプロジェクトの `docs/tasks/proof-runbook.md` の「Lean」の節である。

## セットアップとビルド

```bash
cd isomorphism-between-complex-matrix-algebra-and-clifford-algebra/lean
lake exe cache get          # mathlib のビルド済み .olean を取得する（省くと mathlib 全体をビルドする）
lake build
bash scripts/check-no-sorry.sh
```

`lean-toolchain`（`leanprover/lean4:v4.32.1`）と `lakefile.toml` の mathlib の `rev`（`v4.32.1`）は
`exact-solution-of-2d-ising-model/lean/` と同じ版に揃えてある。更新するときは両方を同じタグにする。

`scripts/check-no-sorry.sh` は三つを確かめる。どの `.lean` も入口 `CliffordMatrixIsomorphism.lean` から
import されていること、字面に `sorry`・`admit` が無いこと、名前空間 `CliffordMatrixIsomorphism` の
すべての宣言の依存する公理に `sorryAx` が無いこと（宣言の一覧は環境から拾うので、定理を足しても
スクリプトを直す必要は無い）。

## 置き場と名前空間

| 版 | フォルダ | 名前空間 |
| --- | --- | --- |
| 具体版 | `CliffordMatrixIsomorphism/<章>/<節>/` | `CliffordMatrixIsomorphism` |
| 必要十分版 | `CliffordMatrixIsomorphism/NecSuf/<章>/<節>/` | `CliffordMatrixIsomorphism.NecSuf` |
| 導出版 | 具体版と同じフォルダの `…FromNecSuf.lean` | 具体版と同じ |

- **具体版**は、本文が自分で定義した構造（環・ℂ-線型空間・線型写像・線型形式・双対空間など）を、
  本文の定義どおりの Lean の `structure` と `def` で書く。mathlib の `Module`・`LinearMap`・`Basis`・
  `DirectSum` などの一般論では置き換えない。ℂ の四則とその補題（`add_assoc`・`mul_add` など）は使う。
  証明は `calc` の一行を本文の式変形の一行に対応させ、本文が「定義による」とする行は `rfl`、
  公理を一つ当てる行はその公理を引数を明示して一回 `rw` する。具体版のファイルは必要十分版を引かない。
- **必要十分版**は、具体版と同じ `structure` と同じ `calc` の行のまま、係数 ℂ を型の変数 `K` に替え、
  証明が実際に使う `K` の性質だけを仮定に置く。`K` には演算の記号（`Add`・`Mul`・`Zero`・`One`）だけを
  与え、公理は仮定として明示的に渡す（mathlib の代数の型クラスの階層は使わない）。
- **導出版**は、具体版の主張と同じ形の主張 `…_of_necSuf` を、必要十分版の主張に ℂ の性質を渡して示す。
  構造を作る主張（双対空間・直和・ℂ^vec が線型空間であること）は、必要十分版から作った構造が
  具体版の構造と同じであること（`…_eq_of_necSuf`、`rfl`）も示す。
- 各宣言の docstring に、対応する本文のラベルを書く。各ファイルの冒頭に、本文のラベルと宣言の対応表を置く。

## 表し方の約束

- 番号付けた族 `b:{1,…,n}→V` は `ℕ → V` で表し、1,…,n の外の値は使わない。線型結合・一次独立・
  張ること・番号順の和は、どれも 1,…,n での値だけを見る形に書いてある。
- 線型結合 Σ_{k=1}^{n} λ_k ·_V x_k は、本文の定義の部分和 L_m を `partialLinearCombination` として書き、
  その m = n を `linearCombination` とする。本文の m についての帰納法は `partialLinearCombination` についての
  `induction` になる。ℂ の中の番号順の和も同じ（`partialOrderedSum`・`orderedSum`）。
- 座標の写像 β^b_k は、張ることから存在する係数を `Classical.choose` で一つ選んで定め、それが一つしか
  ないことを本文の二つ目の性質として示す。

## 形式化済みの節

| 本文の節 | 具体版 | 必要十分版 | 導出版 |
| --- | --- | --- | --- |
| 環 | `MathematicalToolkit/Ring/UnitalRing.lean` | 置かない（二つの定義はどちらも ℂ を含まず、具体版がそのまま必要十分） | なし |
| ℂ-線型空間 | `MathematicalToolkit/ComplexVectorSpace/` の 7 ファイル | `NecSuf/MathematicalToolkit/ComplexVectorSpace/` の 7 ファイル | `ComplexVectorSpaceFromNecSuf.lean` |

## 必要十分版が示したこと（節「ℂ-線型空間」）

- 双対空間のスカラー倍が定まるには、係数の乗法の交換法則が要る（`pointwiseScalarMultiple_isLinearForm`。
  (μλ)f(x) = (λμ)f(x) の行）。乗法が可換でない係数では、線型形式の各点ごとのスカラー倍は線型形式にならない。
- 零のスカラー倍が零ベクトルであることに要る係数の性質は 0 + 0 = 0 だけである（`zero_smul_eq_zero`）。
- 線型結合の和・項ごとの比較・分割は、係数の公理を一つも使わない。係数の一意性は、加法の結合法則・交換法則、
  0 の左右の単位性、1 + n = 0 となる n の存在、1 · a = a、右分配法則、a · 0 = 0、0 · a = 0 を使い、
  乗法の結合法則・交換法則・左分配法則を使わない。
- 二つの線型空間の直和が線型空間であることは、係数の性質を一つも使わない。
