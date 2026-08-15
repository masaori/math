/-
人手証明「正の有理数の対数は順序を保ちかつ反映する」（`claim_rational_log_order_iff`）の具体版。

補助等式 rat_Λ(log q) = q を、`logRat_rationalOfLog`（log ∘ rat_Λ = id）を λ := log q へ適用して
log(rat_Λ(log q)) = log q を得てから、`logRat_injective_of_pos`（正の有理数上での log の単射性）で
rat_Λ(log q) = q へ戻して示す。主張は
log q ≤_Λ log q' ⟺ rat_Λ(log q) ≤ rat_Λ(log q') ⟺ q ≤ q'
の二段の同値（順序の定義、補助等式を両辺へ）。
住処は ℕ・ℤ・ℚ・Λ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.FreeEntropy.LogOrderGroupOrder
import Ising2DLambda.FreeEntropy.RationalLogInjective

namespace Ising2DLambda.FreeEntropy

/-- 補助等式。正の有理数 `q` について `rat_Λ(log q) = q`。 -/
theorem rationalOfLog_logRat {q : ℚ} (hq : 0 < q) : rationalOfLog (logRat q) = q :=
  -- log(rat_Λ(log q)) = log q（全射性の主張を λ := log q へ）、単射性で戻す
  logRat_injective_of_pos (rationalOfLog_pos (logRat q)) hq (logRat_rationalOfLog (logRat q))

/-- `claim_rational_log_order_iff`。`q ≤ q' ⟺ log q ≤_Λ log q'`。 -/
theorem logRat_le_iff {q q' : ℚ} (hq : 0 < q) (hq' : 0 < q') :
    q ≤ q' ↔ logOrderLE (logRat q) (logRat q') := by
  unfold logOrderLE                                   -- 順序の定義
  rw [rationalOfLog_logRat hq, rationalOfLog_logRat hq']  -- 補助等式を両辺へ

end Ising2DLambda.FreeEntropy
