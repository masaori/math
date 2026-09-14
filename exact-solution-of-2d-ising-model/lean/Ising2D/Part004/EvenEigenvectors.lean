/-
# 全スピン反転行列の固有値 +1 の固有ベクトル全体

対応する人手本文は `structured-latex/content/004_transfer_matrix.ts` の
`transfer_matrix_004_definition_eigenspace_even_of_epsilon`
（ラベル **`def_even_eigenvectors_of_epsilon`**）。

本文と同じく、抽象線型写像を経由せず、具体的な複素行列 `epsilon M` の
数ベクトルへの作用だけで定義する。続いて本文ラベル
`even_eigenspace_is_complex_subspace` の零・和・複素スカラー倍に関する三つの計算を
同じ順で形式化し、その集合を台集合とする複素部分加群を構成する。
-/
import Ising2D.Part004.Definition000_TransferMatrixSymbols
import Ising2D.NecSuf.FixedVectorsSubmodule

namespace Ising2D

open Matrix

/-- **人手本文 `def_even_eigenvectors_of_epsilon`**:
全スピン反転行列を左から掛けても変わらない複素数ベクトルの集合 `𝓕⁽⁺⁾`。 -/
def evenEigenvectors (M : ℕ) (_hM : 1 ≤ M) : Set (Conf M → ℂ) :=
  {f | epsilon M *ᵥ f = f}

/-- **人手本文 `even_eigenspace_is_complex_subspace` の零ベクトルの場合**。 -/
theorem zero_mem_evenEigenvectors (M : ℕ) (hM : 1 ≤ M) :
    (0 : Conf M → ℂ) ∈ evenEigenvectors M hM := by
  simp only [evenEigenvectors, Set.mem_setOf_eq]
  funext r
  calc
    (epsilon M *ᵥ (0 : Conf M → ℂ)) r = ∑ s, epsilon M r s * 0 := rfl
    _ = ∑ _s : Conf M, 0 := by
      apply Finset.sum_congr rfl
      intro s _hs
      exact mul_zero (epsilon M r s)
    _ = 0 := Finset.sum_const_zero

/-- **人手本文 `even_eigenspace_is_complex_subspace` の和の場合**。 -/
theorem add_mem_evenEigenvectors (M : ℕ) (hM : 1 ≤ M)
    {f g : Conf M → ℂ} (hf : f ∈ evenEigenvectors M hM)
    (hg : g ∈ evenEigenvectors M hM) :
    f + g ∈ evenEigenvectors M hM := by
  simp only [evenEigenvectors, Set.mem_setOf_eq] at hf hg ⊢
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
    _ = f r + g r := by rw [congrFun hf r, congrFun hg r]
    _ = (f + g) r := rfl

/-- **人手本文 `even_eigenspace_is_complex_subspace` の複素スカラー倍の場合**。 -/
theorem smul_mem_evenEigenvectors (M : ℕ) (hM : 1 ≤ M)
    (a : ℂ) {f : Conf M → ℂ} (hf : f ∈ evenEigenvectors M hM) :
    a • f ∈ evenEigenvectors M hM := by
  simp only [evenEigenvectors, Set.mem_setOf_eq] at hf ⊢
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
    _ = a * f r := by rw [congrFun hf r]
    _ = (a • f) r := rfl

/-- **人手本文 `even_eigenspace_is_complex_subspace`**:
`evenEigenvectors M hM` を台集合とする `ℂ`-部分加群。 -/
def evenEigenspace (M : ℕ) (hM : 1 ≤ M) : Submodule ℂ (Conf M → ℂ) where
  carrier := evenEigenvectors M hM
  zero_mem' := zero_mem_evenEigenvectors M hM
  add_mem' := add_mem_evenEigenvectors M hM
  smul_mem' := smul_mem_evenEigenvectors M hM

/-- 具体版は必要十分版を `R=ℂ`、`ι=Conf M`、`A=epsilon M` とした特殊化である。 -/
theorem evenEigenspace_eq_fixedSubmodule (M : ℕ) (hM : 1 ≤ M) :
    evenEigenspace M hM = NecSuf.fixedSubmodule (epsilon M) := by
  apply Submodule.ext
  intro f
  rfl

end Ising2D
