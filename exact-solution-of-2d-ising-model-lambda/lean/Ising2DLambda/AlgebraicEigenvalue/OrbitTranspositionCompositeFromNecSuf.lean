/-
具体版が必要十分版の特殊化として得られることを示す（導出）。

具体版 `orbitTranspositionComposite` は、必要十分版 `compositeUpTo` の族 `f` に
「`k` 番目が互換 `t^O_{τ₀,S^[k](τ₀)}` の制限であるもの」を取ったものである。
したがって具体版の全単射性は、必要十分版へ「各段が全単射であること」を渡すだけで出る。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitTranspositionComposite
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.OrbitTranspositionComposite

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 具体版が合成している写像の族。`k` 番目は `t^O_{τ₀,S^[k](τ₀)}` の `O` への制限である。 -/
noncomputable def orbitTranspositionFamily {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) {τ₀ : RowConfig L} (hτ₀ : τ₀ ∈ O) :
    ℕ → ({τ : RowConfig L // τ ∈ O} → {τ : RowConfig L // τ ∈ O}) :=
  fun k τ =>
    orbitTranspositionRestriction O hτ₀ (rowShiftIterate_mem_of_mem_orbitSet hO hτ₀ k) τ

/-- 具体版の `Ψ^{O,τ₀}_k` は、必要十分版の `compositeUpTo` にこの族を取ったものである。 -/
theorem orbitTranspositionComposite_eq_compositeUpTo {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) {τ₀ : RowConfig L} (hτ₀ : τ₀ ∈ O) (k : ℕ) :
    orbitTranspositionComposite hO hτ₀ k
      = NecSuf.AlgebraicEigenvalue.compositeUpTo (orbitTranspositionFamily hO hτ₀) k := by
  induction k with
  | zero => rfl
  | succ k ih =>
      funext τ
      show orbitTranspositionRestriction O hτ₀ _ (orbitTranspositionComposite hO hτ₀ k τ)
        = orbitTranspositionFamily hO hτ₀ (k + 1)
            (NecSuf.AlgebraicEigenvalue.compositeUpTo (orbitTranspositionFamily hO hτ₀) k τ)
      rw [ih]
      rfl

/-- 具体版の主張が、必要十分版の特殊化として得られること。 -/
theorem orbitTranspositionComposite_bijective_from_necSuf {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) {τ₀ : RowConfig L} (hτ₀ : τ₀ ∈ O) (k : ℕ) :
    Function.Bijective (orbitTranspositionComposite hO hτ₀ k) := by
  rw [orbitTranspositionComposite_eq_compositeUpTo hO hτ₀ k]
  refine NecSuf.AlgebraicEigenvalue.compositeUpTo_bijective _ (fun j => ?_) k
  exact (orbitTranspositionRestriction O hτ₀
    (rowShiftIterate_mem_of_mem_orbitSet hO hτ₀ j)).bijective

end Ising2DLambda.AlgebraicEigenvalue
