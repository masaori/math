/-
章「転送行列」の続きの具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは定義 3 件と主張 2 件に対応する。

  人手証明のラベル                 このファイル
  def_row_family                   RowFamily
  def_rows_map                     rowsOf / configOfRows
  def_matrix_over_row_configs      RowMatrix / rowMatrixProduct / rowMatrixPow / rowMatrixTrace
  def_transfer_matrix              transferMatrix
  claim_rows_bijection             configOfRows_rowsOf / rowsOf_configOfRows / rowsEquiv
  claim_transfer_weight_product    transfer_weight_product

行列は mathlib の `Matrix` を使わず、人手証明の定義（`R_L × R_L → ℤ[x]` の写像、
成分ごとの積・帰納的な冪・対角成分の和）をそのまま書く。人手証明が番号を付けずに
行配位で添字づけているので、Lean 側も `RowConfig L` で添字づける。

住処: 人手証明のこれらのブロックは可算側（ℕ および ℤ[x]）を宣言している。
したがってここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.TransferMatrix.RowDecomposition

namespace Ising2DLambda.TransferMatrix

open Finset PartitionPolynomial

variable (L : ℕ) [NeZero L]

/-- 行配位の族 `c : ℤ/Lℤ → R_L`（`def_row_family`）。 -/
def RowFamily : Type := ZMod L → RowConfig L

instance : Fintype (RowFamily L) := by unfold RowFamily RowConfig; infer_instance
instance : DecidableEq (RowFamily L) := by unfold RowFamily RowConfig; infer_instance

/-- 人手証明の `|C_L| = (2^L)^L = 2^{L²}`。 -/
lemma card_rowFamily : Fintype.card (RowFamily L) = 2 ^ L ^ 2 := by
  show Fintype.card (ZMod L → RowConfig L) = 2 ^ L ^ 2
  rw [Fintype.card_fun, card_rowConfig, ZMod.card, ← pow_mul, sq]

/-- 配位を行の並びとして読む写像 `rows(σ)(i) = ρ_i(σ)`（`def_rows_map`）。 -/
def rowsOf (σ : Config L) : RowFamily L := fun i => rowRestriction L σ i

/-- 行配位の族から配位を作る写像 `conf(c)((i,j)) = (c(i))(j)`（`def_rows_map`）。 -/
def configOfRows (c : RowFamily L) : Config L := fun v => c v.1 v.2

section Matrix

/-- 行と列を行配位で添字づけた行列 `R_L × R_L → ℤ[x]`（`def_matrix_over_row_configs`）。
mathlib の `Matrix` は使わず、人手証明の定義そのままの写像として書く。 -/
def RowMatrix : Type := RowConfig L → RowConfig L → Polynomial ℤ

/-- 行列の積 `(AB)_{τ,τ''} = Σ_{τ'} A_{τ,τ'} B_{τ',τ''}`。 -/
noncomputable def rowMatrixProduct (A B : RowMatrix L) : RowMatrix L :=
  fun τ τ'' => ∑ τ' : RowConfig L, A τ τ' * B τ' τ''

/-- 行列の冪。人手証明は `A¹ = A` と `A^{k+1} = A^k A` により `k ≥ 1` でだけ定めており、
`A⁰` を定めていない（単位行列を導入していない）。Lean の再帰は `0` から始まるので、
ここでは引数を 1 つずらし、`rowMatrixPow L A k` が人手証明の `A^{k+1}` を表すものとする。
すなわち引数 `0` は人手証明の指数 `1` にあたる。この約束のもとで人手証明の
`A^L` は `rowMatrixPow L A (L - 1)` である。 -/
noncomputable def rowMatrixPow (A : RowMatrix L) : ℕ → RowMatrix L
  | 0 => A
  | k + 1 => rowMatrixProduct L (rowMatrixPow A k) A

/-- 人手証明の `A¹ = A`（引数のずらしにより Lean 側の引数は `0`）。 -/
@[simp] lemma rowMatrixPow_one (A : RowMatrix L) : rowMatrixPow L A 0 = A := rfl

/-- 人手証明の `A^{k+1} = A^k A`（Lean 側では引数 `k` が指数 `k+1` を表すので、
この等式は引数 `k+1` と引数 `k` を結ぶ形になる）。 -/
lemma rowMatrixPow_succ (A : RowMatrix L) (k : ℕ) :
    rowMatrixPow L A (k + 1) = rowMatrixProduct L (rowMatrixPow L A k) A := rfl

/-- トレース `Tr A = Σ_τ A_{τ,τ}`。 -/
noncomputable def rowMatrixTrace (A : RowMatrix L) : Polynomial ℤ :=
  ∑ τ : RowConfig L, A τ τ

end Matrix

/-- 転送行列 `T_{τ,τ'} = x^{b_h(τ) + b_v(τ,τ')}`（`def_transfer_matrix`）。
指数関数を経由せず、破れの本数だけを指数に置く。 -/
noncomputable def transferMatrix : RowMatrix L :=
  fun τ τ' => Polynomial.X ^ (intraRowBrokenCount L τ + interRowBrokenCount L τ τ')

-- Step 1 と Step 2 は `L` が正であることを使わない（値を書き下すだけで出る）。
-- 必要十分版が「有限性を使っていない」と述べているのと同じことがここでも見える。
omit [NeZero L] in
/-- 人手証明の Step 1（`conf ∘ rows` が恒等写像）。値を書き下すと同じ式になる。 -/
lemma configOfRows_rowsOf (σ : Config L) : configOfRows L (rowsOf L σ) = σ := rfl

omit [NeZero L] in
/-- 人手証明の Step 2（`rows ∘ conf` が恒等写像）。 -/
lemma rowsOf_configOfRows (c : RowFamily L) : rowsOf L (configOfRows L c) = c := rfl

/-- 人手証明の Step 3（結論）。逆写像を持つので全単射である。 -/
def rowsEquiv : Config L ≃ RowFamily L where
  toFun := rowsOf L
  invFun := configOfRows L
  left_inv := configOfRows_rowsOf L
  right_inv := rowsOf_configOfRows L

/-- 主張「配位の重みは、行に沿った転送行列の成分の積である」の具体版。
`∏_i T_{ρ_i(σ), ρ_{i+1}(σ)} = x^{b(σ)}`。 -/
theorem transfer_weight_product (σ : Config L) :
    ∏ i : ZMod L, transferMatrix L (rowsOf L σ i) (rowsOf L σ (i + 1))
      = Polynomial.X ^ brokenBondCount L σ := by
  -- Step 1。各因子を `x` の冪として書き下す（`transferMatrix` の定義そのもの）。
  have h1 : ∀ i : ZMod L,
      transferMatrix L (rowsOf L σ i) (rowsOf L σ (i + 1))
        = (Polynomial.X : Polynomial ℤ) ^
            (intraRowBrokenCount L (rowRestriction L σ i)
              + interRowBrokenCount L (rowRestriction L σ i) (rowRestriction L σ (i + 1))) :=
    fun _ => rfl
  rw [prod_congr rfl fun i _ => h1 i]
  -- Step 2。指数法則で積をまとめる。
  rw [prod_pow_eq_pow_sum]
  -- Step 3。指数の和を 2 つに分ける。
  rw [sum_add_distrib]
  -- Step 4。破れボンド数の分解（claim_broken_bond_row_decomposition）を使う。
  rw [← brokenBondCount_eq_row_decomposition]

end Ising2DLambda.TransferMatrix
