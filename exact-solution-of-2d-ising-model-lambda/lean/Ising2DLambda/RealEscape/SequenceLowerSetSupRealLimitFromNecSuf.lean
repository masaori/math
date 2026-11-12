import Ising2DLambda.RealEscape.SequenceLowerSetSupRealLimit
import Ising2DLambda.NecSuf.RealEscape.SequenceLowerSetSupRealLimit

namespace Ising2DLambda.RealEscape

open Ising2DLambda.ThermodynamicLimit Ising2DLambda.FreeEntropy Filter Topology

/-- 具体版の主張は、必要十分版を `G := Λ_ℚ`、`K := ℝ`、`le := ≤_{Λ_ℚ}`、`ρ := ρ_ℝ`、
`g := ȷ(ℓ_2)` に特殊化し、`ℝ` の `sSup` を最小上界から読んで得られる。 -/
theorem sequence_lowerSet_sup_eq_realLimit_from_necSuf (l : ℕ → RationalLogOrderGroup) (I : ℝ)
    (hlim : Tendsto (fun L => realizeRational (l L)) atTop (𝓝 I)) :
    (realizeRational '' rationalLogOrderSequenceLowerSet l).Nonempty ∧
      IsLUB (realizeRational '' rationalLogOrderSequenceLowerSet l) I ∧
      sSup (realizeRational '' rationalLogOrderSequenceLowerSet l) = I := by
  have h := Ising2DLambda.NecSuf.RealEscape.sequence_lowerSet_isLUB_necSuf
    rationalLogOrderLE rationalLogOrderLE_total (fun _ _ h n => rationalLogOrderLE_add_right h n)
    realizeRational realizeRational_le_of_rationalLogOrderLE realizeRational_smul
    (toRational (generator ⟨2, Nat.prime_two⟩)) realizeRational_generatorTwo_pos l I hlim
  exact ⟨h.1, h.2, h.2.csSup_eq h.1⟩

end Ising2DLambda.RealEscape
