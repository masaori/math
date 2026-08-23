/- 必要十分版を実際の Ising 有限箱データの族へ特殊化し、具体版と同じ結論を取り出す。 -/
import Ising3DCut.LimitQuantity.InsufficiencyWitnessOnIsingRealizableFamily
import Ising3DCut.NecSuf.InsufficiencyWitnessOnRealizableFamily

namespace Ising3DCut.LimitQuantity

open NullModel

/-- 具体版の十分性は、必要十分版の十分性を
点の型 `ℚ`・添字の型 `ℕ`・データ `q i ↦ evalAtRational q (partitionPolynomial i)` へ
特殊化したものにほかならない。 -/
theorem sufficientOnIsingRealizableFamily_iff_necSuf {S : Type*}
    (π : ℚ → S) (Domain : ℚ → Prop) (α : ℚ → ℝ) :
    SufficientOnIsingRealizableFamily π Domain α ↔
      Ising3DCut.NecSuf.SufficientOnRealizableFamily
        Domain (fun L : ℕ => 0 < L)
        (fun q L => evalAtRational q (partitionPolynomial L)) π α :=
  Iff.rfl

/-- 具体版と同じ形の結論を必要十分版から取り出す。 -/
theorem not_sufficient_on_ising_realizable_family_iff_exists_witness_viaNecSuf
    {S : Type*} (π : ℚ → S) (Domain : ℚ → Prop) (α : ℚ → ℝ) :
    ¬ SufficientOnIsingRealizableFamily π Domain α ↔
      ∃ q q' : ℚ, Domain q ∧ Domain q' ∧ α q ≠ α q' ∧
        ∀ L : ℕ, 0 < L →
          π (evalAtRational q (partitionPolynomial L)) =
            π (evalAtRational q' (partitionPolynomial L)) :=
  Ising3DCut.NecSuf.not_sufficient_on_realizable_family_iff_exists_witness
    Domain (fun L : ℕ => 0 < L)
    (fun q L => evalAtRational q (partitionPolynomial L)) π α

end Ising3DCut.LimitQuantity
