/-
「開境界正方形の密度の下組は空でない」の具体版を、必要十分版 `neg_mem_lowerSetOfSequence_of_nonneg_necSuf` の
特殊化として導く。渡すのは ε := ι(ℓ_2) の非負（`rationalLogOrderLE_zero_toRational_generator_two`）・非零
（`toRational_generator_two_ne_zero`）・逆元律（`neg_add_cancel`）と、列の項の非負
（`rationalLogOrderLE_zero_openScaledFreeEntropy`）だけである。具体版の下組は必要十分版の下組と `rfl` で一致する。
-/
import Ising2DLambda.ThermodynamicLimit.OpenSquareDensityLowerSetNonempty
import Ising2DLambda.NecSuf.ThermodynamicLimit.OpenSquareDensityLowerSetNonempty

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

theorem neg_toRational_generator_two_mem_openSquareDensityLowerSet_from_necSuf {q : ℚ} (hq : 0 < q) :
    -(toRational (generator ⟨2, Nat.prime_two⟩)) ∈ openSquareDensityLowerSet q := by
  show -(toRational (generator ⟨2, Nat.prime_two⟩)) ∈
    NecSuf.ThermodynamicLimit.lowerSetOfSequence rationalLogOrderLE (openSquareDensitySequence q)
  refine NecSuf.ThermodynamicLimit.neg_mem_lowerSetOfSequence_of_nonneg_necSuf rationalLogOrderLE
    (openSquareDensitySequence q) _ rationalLogOrderLE_zero_toRational_generator_two
    toRational_generator_two_ne_zero (neg_add_cancel _) ?_
  intro L hL
  haveI : NeZero L := ⟨by omega⟩
  rw [openSquareDensitySequence_of_ne_zero]
  exact rationalLogOrderLE_zero_openScaledFreeEntropy L hq

end Ising2DLambda.ThermodynamicLimit
