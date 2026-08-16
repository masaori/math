/-
人手証明「埋め込んだ対数の順序は正の有理数の順序と一致する」
（`claim_rational_embedded_log_order_iff`）の具体版。

`q, q' ∈ ℚ_{>0}` について `q ≤ q' ⟺ ι(log q) ≤_{Λ_ℚ} ι(log q')`。
同値の鎖: `q ≤ q' ⟺ log q ≤_Λ log q'`（`claim_rational_log_order_iff`）
`⟺ (1/1^2)·ι(log q) ≤_{Λ_ℚ} (1/1^2)·ι(log q')`（`claim_scaled_embedding_order_transfer` を `L := 1` で）
`⟺ 1·ι(log q) ≤_{Λ_ℚ} 1·ι(log q')`（`1/1^2 = 1`）`⟺ ι(log q) ≤_{Λ_ℚ} ι(log q')`（`1·λ = λ`）。
住処は ℚ・Λ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.FreeEntropy.RationalLogOrderIff
import Ising2DLambda.ThermodynamicLimit.ScaledEmbeddingOrderTransfer

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- 主張。`q ≤ q' ⟺ ι(log q) ≤_{Λ_ℚ} ι(log q')`。 -/
theorem rationalLogOrderLE_toRational_logRat_iff {q q' : ℚ} (hq : 0 < q) (hq' : 0 < q') :
    q ≤ q' ↔ rationalLogOrderLE (toRational (logRat q)) (toRational (logRat q')) := by
  -- 二段目: claim_scaled_embedding_order_transfer を L := 1、λ := log q、μ := log q' で読む
  have h := rationalLogOrderLE_scaled_toRational_iff 1 (logRat q) (logRat q')
  -- 三段目: 1/1^2 = 1（ℚ の四則）。四段目: 1·λ = λ を両辺へ
  rw [Nat.cast_one, one_pow, div_one, one_smul, one_smul] at h
  -- 一段目: claim_rational_log_order_iff、そのあと二〜四段目を逆向きに読む
  exact (logRat_le_iff hq hq').trans h.symm

end Ising2DLambda.ThermodynamicLimit
