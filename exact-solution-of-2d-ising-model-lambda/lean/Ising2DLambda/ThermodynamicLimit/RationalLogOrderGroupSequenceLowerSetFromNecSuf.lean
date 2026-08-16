/-
「列が定める下組は下に閉じている」の具体版を、必要十分版 `mem_lowerSetOfSequence_of_le_necSuf` の
特殊化として導く。渡すのは推移律 `rationalLogOrderLE_trans` と加法単調性 `rationalLogOrderLE_add_right`
だけである。具体版の下組は必要十分版の下組と定義どおり一致する（`rfl`）。
-/
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupSequenceLowerSet
import Ising2DLambda.NecSuf.ThermodynamicLimit.RationalLogOrderGroupSequenceLowerSet

namespace Ising2DLambda.ThermodynamicLimit

/-- 具体版の下組は必要十分版の下組の特殊化である。 -/
theorem rationalLogOrderSequenceLowerSet_eq_necSuf (l : ℕ → RationalLogOrderGroup) :
    rationalLogOrderSequenceLowerSet l =
      NecSuf.ThermodynamicLimit.lowerSetOfSequence rationalLogOrderLE l := rfl

theorem mem_rationalLogOrderSequenceLowerSet_of_le_from_necSuf (l : ℕ → RationalLogOrderGroup)
    {μ μ' : RationalLogOrderGroup} (hμ : μ ∈ rationalLogOrderSequenceLowerSet l)
    (hle : rationalLogOrderLE μ' μ) : μ' ∈ rationalLogOrderSequenceLowerSet l := by
  rw [rationalLogOrderSequenceLowerSet_eq_necSuf] at hμ ⊢
  exact NecSuf.ThermodynamicLimit.mem_lowerSetOfSequence_of_le_necSuf rationalLogOrderLE
    (fun h1 h2 => rationalLogOrderLE_trans h1 h2)
    (fun z h => rationalLogOrderLE_add_right h z) l hμ hle

end Ising2DLambda.ThermodynamicLimit
