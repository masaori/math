/-
「開境界正方形の密度の下組の元は密度の上からの評価以下である」の具体版を、必要十分版
`le_bound_of_mem_lowerSetOfSequence_necSuf` の特殊化として導く。渡すのは推移律（`rationalLogOrderLE_trans`）・
加法単調性（`rationalLogOrderLE_add_right`）・単位元（`zero_add`）・交換則（`add_comm`）と、列の項の上界
（`rationalLogOrderLE_openScaledFreeEntropy_upperBound`）だけである。具体版の下組は必要十分版の下組と `rfl` で一致する。
-/
import Ising2DLambda.ThermodynamicLimit.OpenSquareDensityLowerSetLeUpperBound
import Ising2DLambda.NecSuf.ThermodynamicLimit.OpenSquareDensityLowerSetLeUpperBound

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

theorem rationalLogOrderLE_upperBound_of_mem_openSquareDensityLowerSet_from_necSuf {q : ℚ} (hq : 0 < q)
    {μ : RationalLogOrderGroup} (hμ : μ ∈ openSquareDensityLowerSet q) :
    rationalLogOrderLE μ
      (toRational (generator ⟨2, Nat.prime_two⟩) + (2 : ℚ) • toRational (logRat (1 + q))) := by
  refine NecSuf.ThermodynamicLimit.le_bound_of_mem_lowerSetOfSequence_necSuf rationalLogOrderLE
    (fun h1 h2 => rationalLogOrderLE_trans h1 h2) (fun z h => rationalLogOrderLE_add_right h z)
    zero_add add_comm (openSquareDensitySequence q) _ ?_ hμ
  intro L hL
  haveI : NeZero L := ⟨by omega⟩
  rw [openSquareDensitySequence_of_ne_zero]
  exact rationalLogOrderLE_openScaledFreeEntropy_upperBound L hq

end Ising2DLambda.ThermodynamicLimit
