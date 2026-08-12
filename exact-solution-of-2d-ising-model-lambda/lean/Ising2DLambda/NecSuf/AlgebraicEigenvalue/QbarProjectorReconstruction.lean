/-
固有空間へ落とす写像からの復元の必要十分版。

根の冪、行列、列ベクトルという具体的な作り方を外し、係数の有限和が
一つの番号でだけ非零になることと、その値が零でないことだけを要求する。
住処: 一般の体上の加法可換群。ここに ℝ / ℂ は現れない。
-/
import Mathlib.Algebra.Module.BigOperators

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset BigOperators

/-- 係数の和が `k₀` でだけ `c` なら、`c⁻¹` を掛けた線形結合は `u k₀` に戻る。 -/
theorem finite_orthogonal_reconstruction_necSuf
    {ι κ K V : Type*} [Fintype ι] [Field K] [AddCommGroup V] [Module K V]
    [DecidableEq κ] (s : Finset κ) (k₀ : κ) (hk₀ : k₀ ∈ s)
    (c : K) (hc : c ≠ 0) (α : ι → κ → K) (u : κ → V)
    (hcoeff : ∀ k ∈ s, (∑ i : ι, α i k) = if k = k₀ then c else 0) :
    c⁻¹ • (∑ k ∈ s, (∑ i : ι, α i k) • u k) = u k₀ := by
  calc
    c⁻¹ • (∑ k ∈ s, (∑ i : ι, α i k) • u k)
        = c⁻¹ • (∑ k ∈ s, (if k = k₀ then c else 0) • u k) := by
          apply congrArg (fun w => c⁻¹ • w)
          apply Finset.sum_congr rfl
          intro k hk
          rw [hcoeff k hk]
    _ = c⁻¹ • (c • u k₀) := by
          rw [Finset.sum_eq_single k₀]
          · simp
          · intro b hb hne
            rw [if_neg hne, zero_smul]
          · intro hnot
            exact (hnot hk₀).elim
    _ = u k₀ := by
          rw [smul_smul, inv_mul_cancel₀ hc, one_smul]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
