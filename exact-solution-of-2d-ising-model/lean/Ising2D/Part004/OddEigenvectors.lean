/-
# 全スピン反転行列の固有値 -1 の固有ベクトル全体

対応する人手本文は `structured-latex/content/004_transfer_matrix.ts` の
`transfer_matrix_004_definition_eigenspace_odd_of_epsilon`
（ラベル **`def_odd_eigenvectors_of_epsilon`**）。

本文と同じく、抽象線型写像を経由せず、具体的な複素行列 `epsilon M` の
数ベクトルへの作用だけで定義する。続いて本文ラベル
`odd_eigenspace_is_complex_subspace` の零・和・複素スカラー倍に関する三つの計算を
同じ順で形式化し、その集合を台集合とする複素部分加群を構成する。
-/
import Ising2D.Part004.Definition000_TransferMatrixSymbols
import Ising2D.NecSuf.NegatedVectorsSubmodule

namespace Ising2D

open Matrix

/-- **人手本文 `def_odd_eigenvectors_of_epsilon`**:
全スピン反転行列を左から掛けると符号が反転する複素数ベクトルの集合 `𝓕⁽⁻⁾`。 -/
def oddEigenvectors (M : ℕ) (_hM : 1 ≤ M) : Set (Conf M → ℂ) :=
  {f | epsilon M *ᵥ f = -f}

/-- **人手本文 `odd_eigenspace_is_complex_subspace` の零ベクトルの場合**。 -/
theorem zero_mem_oddEigenvectors (M : ℕ) (hM : 1 ≤ M) :
    (0 : Conf M → ℂ) ∈ oddEigenvectors M hM := by
  simp only [oddEigenvectors, Set.mem_setOf_eq]
  funext r
  calc
    (epsilon M *ᵥ (0 : Conf M → ℂ)) r = ∑ s, epsilon M r s * 0 := rfl
    _ = ∑ _s : Conf M, 0 := by
      apply Finset.sum_congr rfl
      intro s _hs
      exact mul_zero (epsilon M r s)
    _ = 0 := Finset.sum_const_zero
    _ = -0 := (neg_zero : -(0 : ℂ) = 0).symm

/-- **人手本文 `odd_eigenspace_is_complex_subspace` の和の場合**。 -/
theorem add_mem_oddEigenvectors (M : ℕ) (hM : 1 ≤ M)
    {f g : Conf M → ℂ} (hf : f ∈ oddEigenvectors M hM)
    (hg : g ∈ oddEigenvectors M hM) :
    f + g ∈ oddEigenvectors M hM := by
  simp only [oddEigenvectors, Set.mem_setOf_eq] at hf hg ⊢
  funext r
  calc
    (epsilon M *ᵥ (f + g)) r = ∑ s, epsilon M r s * (f s + g s) := rfl
    _ = ∑ s, (epsilon M r s * f s + epsilon M r s * g s) := by
      apply Finset.sum_congr rfl
      intro s _hs
      exact mul_add (epsilon M r s) (f s) (g s)
    _ = (∑ s, epsilon M r s * f s) + ∑ s, epsilon M r s * g s :=
      Finset.sum_add_distrib
    _ = (epsilon M *ᵥ f) r + (epsilon M *ᵥ g) r := rfl
    _ = -f r + -g r := by
      rw [congrFun hf r, congrFun hg r]
      rfl
    _ = -(f r + g r) := (neg_add (f r) (g r)).symm
    _ = (-(f + g)) r := rfl

/-- **人手本文 `odd_eigenspace_is_complex_subspace` の複素スカラー倍の場合**。 -/
theorem smul_mem_oddEigenvectors (M : ℕ) (hM : 1 ≤ M)
    (a : ℂ) {f : Conf M → ℂ} (hf : f ∈ oddEigenvectors M hM) :
    a • f ∈ oddEigenvectors M hM := by
  simp only [oddEigenvectors, Set.mem_setOf_eq] at hf ⊢
  funext r
  calc
    (epsilon M *ᵥ (a • f)) r = ∑ s, epsilon M r s * (a * f s) := rfl
    _ = ∑ s, (epsilon M r s * a) * f s := by
      apply Finset.sum_congr rfl
      intro s _hs
      exact (mul_assoc (epsilon M r s) a (f s)).symm
    _ = ∑ s, (a * epsilon M r s) * f s := by
      apply Finset.sum_congr rfl
      intro s _hs
      rw [mul_comm (epsilon M r s) a]
    _ = ∑ s, a * (epsilon M r s * f s) := by
      apply Finset.sum_congr rfl
      intro s _hs
      exact mul_assoc a (epsilon M r s) (f s)
    _ = a * ∑ s, epsilon M r s * f s := by rw [Finset.mul_sum]
    _ = a * (epsilon M *ᵥ f) r := rfl
    _ = a * (-f r) := by
      rw [congrFun hf r]
      rfl
    _ = -(a * f r) := mul_neg a (f r)
    _ = (-(a • f)) r := rfl

/-- **人手本文 `odd_eigenspace_is_complex_subspace`**:
`oddEigenvectors M hM` を台集合とする `ℂ`-部分加群。 -/
def oddEigenspace (M : ℕ) (hM : 1 ≤ M) : Submodule ℂ (Conf M → ℂ) where
  carrier := oddEigenvectors M hM
  zero_mem' := zero_mem_oddEigenvectors M hM
  add_mem' := add_mem_oddEigenvectors M hM
  smul_mem' := smul_mem_oddEigenvectors M hM

/-- 具体版は必要十分版を `R=ℂ`、`ι=Conf M`、`A=epsilon M` とした特殊化である。 -/
theorem oddEigenspace_eq_negatedSubmodule (M : ℕ) (hM : 1 ≤ M) :
    oddEigenspace M hM = NecSuf.negatedSubmodule (epsilon M) := by
  apply Submodule.ext
  intro f
  rfl

end Ising2D
