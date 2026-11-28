import Ising2DLambda.RealEscape.CutRealizationFiniteProduct
import Ising2DLambda.ThermodynamicLimit.LogOrderGroupRealizationRealLog

namespace Ising2DLambda.RealEscape

open Ising2DLambda.FisherZero
open Ising2DLambda.ThermodynamicLimit

/-- 正の元の有限積を実現すると、その実対数は実現した各元の実対数の和になる。
`claim_dispersion_product_real_log_sum` の式鎖の最後の二行。有限積への実現写像の適用は
`cutRealization_finiteProduct`（`claim_cut_realization_preserves_multiplication`、空積は
`claim_cut_realization_agrees_on_rationals`）、和への移し替えは `def_real_logarithm` の乗法法則
`realLog_mul` を有限集合の元の個数についての帰納法で当てる。空積の `log_ℝ 1 = 0` も同じ法則から出す。 -/
theorem cutRealization_realLog_finiteProduct {α : Type*} [DecidableEq α]
    (data : RealClosedSubfieldData) (S : Finset α) (u : α → data.carrier)
    (hpos : ∀ i, 0 < realAlgebraicCutRealization data (u i)) :
    realLog ⟨realAlgebraicCutRealization data (∏ i ∈ S, u i), by
      rw [cutRealization_finiteProduct]
      exact Finset.prod_pos (fun i _ => hpos i)⟩ =
      ∑ i ∈ S, realLog ⟨realAlgebraicCutRealization data (u i), hpos i⟩ := by
  calc
    realLog ⟨realAlgebraicCutRealization data (∏ i ∈ S, u i), _⟩ =
        realLog ⟨∏ i ∈ S, realAlgebraicCutRealization data (u i),
          Finset.prod_pos (fun i _ => hpos i)⟩ :=
          realLog_congr _ _ (cutRealization_finiteProduct data S u)
    _ = ∑ i ∈ S, realLog ⟨realAlgebraicCutRealization data (u i), hpos i⟩ := by
      induction S using Finset.induction_on with
      | empty =>
          -- 空積は 1。log_ℝ(1) = log_ℝ(1·1) = log_ℝ(1) + log_ℝ(1) から log_ℝ(1) = 0
          rw [Finset.sum_empty, realLog_congr _ one_pos Finset.prod_empty]
          have h11 := realLog_mul ⟨1, one_pos⟩ ⟨1, one_pos⟩
          rw [realLog_congr (mul_pos one_pos one_pos) one_pos (one_mul 1)] at h11
          linarith
      | insert p S hp ih =>
          -- S ∪ {p} の積は ρ(u_p)·(S の積)。乗法を加法へ移し、帰納法の仮定
          rw [Finset.sum_insert hp,
            realLog_congr _ (mul_pos (hpos p) (Finset.prod_pos fun i _ => hpos i))
              (Finset.prod_insert hp),
            realLog_mul ⟨realAlgebraicCutRealization data (u p), hpos p⟩
              ⟨∏ i ∈ S, realAlgebraicCutRealization data (u i),
                Finset.prod_pos fun i _ => hpos i⟩,
            ih]

end Ising2DLambda.RealEscape
