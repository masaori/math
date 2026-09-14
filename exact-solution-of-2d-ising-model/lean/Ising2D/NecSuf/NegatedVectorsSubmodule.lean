import Mathlib.Data.Matrix.Mul
import Mathlib.Algebra.Module.Submodule.Basic

/-!
# 行列が符号を反転するベクトル全体が部分加群をなすための必要十分な構造

人手本文ラベル **`odd_eigenspace_is_complex_subspace`** の必要十分版。
具体版と同じく、行列と数ベクトルの積を成分ごとの有限和へ展開し、零・和・
スカラー倍の順に証明する。

証明に使うのは有限添字、可換環の演算、および行列成分とスカラーを交換する
可換性だけである。順序、ノルム、有限次元性は使わない。負号を使うため、
固定ベクトルの場合の可換半環ではなく可換環を要する。
-/

namespace Ising2D.NecSuf

open Matrix

variable {R ι : Type*} [CommRing R] [Fintype ι]

/-- 行列 `A` が符号を反転する数ベクトル全体。 -/
def negatedVectors (A : Matrix ι ι R) : Set (ι → R) :=
  {f | A *ᵥ f = -f}

/-- 人手本文の零ベクトルの場合と同じ四段。 -/
theorem zero_mem_negatedVectors (A : Matrix ι ι R) :
    (0 : ι → R) ∈ negatedVectors A := by
  simp only [negatedVectors, Set.mem_setOf_eq]
  funext r
  calc
    (A *ᵥ (0 : ι → R)) r = ∑ s, A r s * 0 := rfl
    _ = ∑ _s : ι, 0 := by
      apply Finset.sum_congr rfl
      intro s _hs
      exact mul_zero (A r s)
    _ = 0 := Finset.sum_const_zero
    _ = -0 := (neg_zero : -(0 : R) = 0).symm

/-- 人手本文の和の場合と同じ七段。 -/
theorem add_mem_negatedVectors (A : Matrix ι ι R) {f g : ι → R}
    (hf : f ∈ negatedVectors A) (hg : g ∈ negatedVectors A) :
    f + g ∈ negatedVectors A := by
  simp only [negatedVectors, Set.mem_setOf_eq] at hf hg ⊢
  funext r
  calc
    (A *ᵥ (f + g)) r = ∑ s, A r s * (f s + g s) := rfl
    _ = ∑ s, (A r s * f s + A r s * g s) := by
      apply Finset.sum_congr rfl
      intro s _hs
      exact mul_add (A r s) (f s) (g s)
    _ = (∑ s, A r s * f s) + ∑ s, A r s * g s := Finset.sum_add_distrib
    _ = (A *ᵥ f) r + (A *ᵥ g) r := rfl
    _ = -f r + -g r := by
      rw [congrFun hf r, congrFun hg r]
      rfl
    _ = -(f r + g r) := (neg_add (f r) (g r)).symm
    _ = (-(f + g)) r := by
      change -(f r + g r) = -(f r + g r)
      rfl

/-- 人手本文のスカラー倍の場合と同じ九段。可換性を使うのは第三段だけである。 -/
theorem smul_mem_negatedVectors (A : Matrix ι ι R) (a : R) {f : ι → R}
    (hf : f ∈ negatedVectors A) : a • f ∈ negatedVectors A := by
  simp only [negatedVectors, Set.mem_setOf_eq] at hf ⊢
  funext r
  calc
    (A *ᵥ (a • f)) r = ∑ s, A r s * (a * f s) := rfl
    _ = ∑ s, (A r s * a) * f s := by
      apply Finset.sum_congr rfl
      intro s _hs
      exact (mul_assoc (A r s) a (f s)).symm
    _ = ∑ s, (a * A r s) * f s := by
      apply Finset.sum_congr rfl
      intro s _hs
      rw [mul_comm (A r s) a]
    _ = ∑ s, a * (A r s * f s) := by
      apply Finset.sum_congr rfl
      intro s _hs
      exact mul_assoc a (A r s) (f s)
    _ = a * ∑ s, A r s * f s := by rw [Finset.mul_sum]
    _ = a * (A *ᵥ f) r := rfl
    _ = a * (-f r) := by
      rw [congrFun hf r]
      rfl
    _ = -(a * f r) := mul_neg a (f r)
    _ = (-(a • f)) r := by
      change -(a * f r) = -(a * f r)
      rfl

/-- `negatedVectors A` を台集合とする部分加群。 -/
def negatedSubmodule (A : Matrix ι ι R) : Submodule R (ι → R) where
  carrier := negatedVectors A
  zero_mem' := zero_mem_negatedVectors A
  add_mem' := add_mem_negatedVectors A
  smul_mem' := smul_mem_negatedVectors A

end Ising2D.NecSuf
