/-
# 必要十分版: 行列単位の族が基底であること

**このファイルには必要十分版だけを置く。必要十分版は Lean の中だけの道具であり、
人手証明の本文にも参照用ノートにも持ち込まない**
（`exact-solution-of-2d-ising-model/README.md` 4 節）。

対応する人手証明:
`parts/002_線型空間の一般論/000_theorem_テンソル積の基底は基底のテンソル積.typ` (`<tensor_basis>`)

具体版（人手証明と 1 対 1 に対応する主張）は `Ising2D/Representation.lean` の
`Ising2D.matrixUnitBasis`、特殊化による導出は
`Ising2D/Part002/Theorem000_TensorBasisFromNecSuf.lean`。

## この主張が本文で使われる形

本文は抽象テンソル積を使わず `Mat(2,ℂ)^{⊗M}` を Kronecker 表現で扱う（README 2 節）。
`<tensor_basis>` が引かれるのは
`parts/002_線型空間の一般論/003_lemma_全行列と可換な行列はスカラー.typ` Step 1 の
「`cal(E) = { E_{IJ} : I,J ∈ {1,2}^M }` は基底である」の 1 箇所だけであり、
人手証明がそこで使う論法は **成分比較**——
「任意の行列 `A` は `A = Σ_{IJ} A_{IJ} E_{IJ}` と書け、係数は成分そのものだから一意」——である。

本ファイルはその論法を**そのまま**、対象の抽象度だけを必要十分まで上げて書く。
mathlib の `Matrix.stdBasis` に置き換えて済ませることはしない
（それは論法を別のものに差し替えることであり、何が効いているかを示さない）。
mathlib の対応物との一致は最後に 1 本だけ確認する。

## 何が効いているか（下の証明が使う仮定がすべて）

* 係数が**可換環**であること（線型独立性を係数の一意性から言うため）。
  複素数であること・体であることは効いていない。
* 添字型が**有限**で**等号判定可能**であること。`2^M` であることも、
  添字が `{1,2}^M` の形であることも効いていない。
* 行列の**成分ごとの計算**（`Matrix.single` の値と有限和の成分）だけ。
  テンソル積の一般論・クロネッカー積の具体形・`2 × 2` であることは一切現れない。
-/
import Mathlib.Data.Matrix.Basis
import Mathlib.LinearAlgebra.Basis.Defs
import Mathlib.LinearAlgebra.Matrix.StdBasis

open Module

namespace Ising2D
namespace NecSuf

section MatrixUnitBasis

variable {K : Type*} [CommRing K] {n : Type*} [Fintype n] [DecidableEq n]

/-- **人手証明 Step 1 の成分比較（前半）**: 任意の行列は行列単位の線型結合で書ける。

  `A = Σ_{(i,j)} A_{ij} E_{ij}`

証明は成分ごとの計算だけで、係数体も次元も使わない。 -/
theorem matrix_eq_sum_smul_single (A : Matrix n n K) :
    A = ∑ p : n × n, A p.1 p.2 • Matrix.single p.1 p.2 (1 : K) := by
  ext i j
  rw [Matrix.sum_apply, Fintype.sum_prod_type]
  rw [Finset.sum_eq_single i]
  · rw [Finset.sum_eq_single j]
    · simp [Matrix.single_apply]
    · intro b _ hb
      simp [Matrix.single_apply, hb]
    · intro h
      exact absurd (Finset.mem_univ j) h
  · intro a _ ha
    refine Finset.sum_eq_zero fun b _ => ?_
    simp [Matrix.single_apply, ha]
  · intro h
    exact absurd (Finset.mem_univ i) h

/-- **人手証明 Step 1 の成分比較（後半）**: 行列単位の線型結合の成分は、その係数そのものである。

  `(Σ_{(i,j)} c_{ij} E_{ij})_{kl} = c_{kl}`

これが係数の一意性、すなわち線型独立性を与える。 -/
theorem sum_smul_single_apply (c : n × n → K) (k l : n) :
    (∑ p : n × n, c p • Matrix.single p.1 p.2 (1 : K)) k l = c (k, l) := by
  rw [Matrix.sum_apply, Fintype.sum_prod_type]
  rw [Finset.sum_eq_single k]
  · rw [Finset.sum_eq_single l]
    · simp [Matrix.single_apply]
    · intro b _ hb
      simp [Matrix.single_apply, hb]
    · intro h
      exact absurd (Finset.mem_univ l) h
  · intro a _ ha
    refine Finset.sum_eq_zero fun b _ => ?_
    simp [Matrix.single_apply, ha]
  · intro h
    exact absurd (Finset.mem_univ k) h

/-- 行列単位の族の線型独立性（人手証明の「係数は成分そのものだから一意」）。 -/
theorem linearIndependent_single :
    LinearIndependent K (fun p : n × n => Matrix.single p.1 p.2 (1 : K)) := by
  refine Fintype.linearIndependent_iff.2 fun c hc p => ?_
  have := congrFun (congrFun hc p.1) p.2
  rwa [sum_smul_single_apply c p.1 p.2, Matrix.zero_apply] at this

/-- **`<tensor_basis>` が本文で使われる形の必要十分版**:
行列単位の族 `{E_{ij}}` は行列環の基底である。

係数は任意の可換環、添字は任意の有限（等号判定可能な）型でよい。
証明は上の 2 本、すなわち人手証明 Step 1 の成分比較そのものだけを使う。 -/
noncomputable def matrixUnitBasis (K : Type*) [CommRing K] (n : Type*) [Fintype n]
    [DecidableEq n] : Basis (n × n) K (Matrix n n K) :=
  Basis.mk linearIndependent_single (by
    intro A _
    rw [matrix_eq_sum_smul_single A]
    exact Submodule.sum_mem _ fun p _ =>
      Submodule.smul_mem _ _ (Submodule.subset_span ⟨p, rfl⟩))

@[simp]
theorem matrixUnitBasis_apply (p : n × n) :
    matrixUnitBasis K n p = Matrix.single p.1 p.2 (1 : K) :=
  Basis.mk_apply _ _ _

/-- mathlib の `Matrix.stdBasis` と同じ族であることの確認（論法の差し替えではなく、
上で自前に作った基底が既存のものと一致することの検算）。 -/
theorem coe_matrixUnitBasis_eq_stdBasis :
    ⇑(matrixUnitBasis K n) = ⇑(Matrix.stdBasis K n n) := by
  funext p
  rw [matrixUnitBasis_apply, Matrix.stdBasis_eq_single]

end MatrixUnitBasis

section Transport

variable {K : Type*} [Semiring K] {κ : Type*}
variable {V W : Type*} [AddCommMonoid V] [Module K V] [AddCommMonoid W] [Module K W]

/-- 表現を取り替えても基底は基底のまま（人手証明が `Mat(2,ℂ)^{⊗M}` の 2 つの実現を
行き来するときに使う唯一の事実）。線型同型であること以外は何も要らない。 -/
noncomputable def basisOfLinearEquiv (b : Basis κ K V) (e : V ≃ₗ[K] W) : Basis κ K W :=
  b.map e

@[simp]
theorem basisOfLinearEquiv_apply (b : Basis κ K V) (e : V ≃ₗ[K] W) (i : κ) :
    basisOfLinearEquiv b e i = e (b i) :=
  Basis.map_apply _ _ _

end Transport

end NecSuf
end Ising2D
