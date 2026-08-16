/-
人手証明「開境界正方形の自由エントロピー密度の上からの評価」
（`claim_open_square_free_entropy_density_upper_bound`）の具体版。

`L ≥ 1`、`q ∈ ℚ_{>0}` について `Ψ^op_L(q) ≤_{Λ_ℚ} ι(ℓ_2) + 2·ι(log(1+q))`。
準備の第一: `Z^op_{L,L}(q) ∈ ℚ_{>0}`（`openPartitionValueRat_pos`）、`Z^op_{L,L}(q) ≤ 2^{L²}(1+q)^{2L²}`
            （`openPartitionValueRat_le_upperBound` を `a := L`、`b := L` で）。
準備の第二: `log 2 = ℓ_2`（`logRat_two`）。
準備の第三: `n·ι(ν) = ι(nν)`（`toRational_intSmul`）。
Λ の鎖（`logOrderLE_logRat_openPartitionValueRat_upperBound`。上界の対数を開く三段は周期境界の
`logRat_upperBound_eq` をそのまま共有する。上界の式は L と q だけで決まり、格子の境界条件に依らない）:
  log Z^op_{L,L}(q) ≤_Λ log(2^{L²}·(1+q)^{2L²})              （`logRat_le_iff` の →。準備の第一を移す）
                    = log 2^{L²} + log (1+q)^{2L²}            （`logRat_mul`）
                    = L²·log 2 + 2L²·log(1+q)                 （`logRat_pow` を二項へ）
                    = L²·ℓ_2 + 2L²·log(1+q)                   （準備の第二）
Λ_ℚ の鎖（`rationalLogOrderLE_openScaledFreeEntropy_upperBound`。第三〜八段は周期境界の
`scaled_toRational_upperBound_eq` をそのまま共有する）:
  Ψ^op_L(q) = (1/L²)·ι(log Z^op_{L,L}(q))                    （定義 `openScaledFreeEntropy`）
            ≤_{Λ_ℚ} (1/L²)·ι(L²ℓ_2 + 2L² log(1+q))            （`rationalLogOrderLE_scaled_toRational_iff` の ←）
            = ι(ℓ_2) + 2·ι(log(1+q))                          （`scaled_toRational_upperBound_eq`）
周期境界の `FiniteFreeEntropyDensityUpperBound.lean` と同じ手順で、`freeEntropy L q` の代わりに
`logRat (openPartitionValueRat L L q)` を、値の上界を開境界のものへ置いたものである。
住処は ℕ・ℚ・Λ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.FreeEntropy.RationalLogOrderIff
import Ising2DLambda.ThermodynamicLimit.ScaledEmbeddingOrderTransfer
import Ising2DLambda.ThermodynamicLimit.FiniteFreeEntropyDensityUpperBound
import Ising2DLambda.ThermodynamicLimit.OpenSquareFreeEntropyDensity
import Ising2DLambda.ThermodynamicLimit.OpenRectangleValueUpperBoundRational

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- Λ の鎖: `log Z^op_{L,L}(q) ≤_Λ L²·ℓ_2 + 2L²·log(1+q)`。 -/
theorem logOrderLE_logRat_openPartitionValueRat_upperBound (L : ℕ) {q : ℚ} (hq : 0 < q) :
    logOrderLE (logRat (openPartitionValueRat L L q))
      ((L ^ 2) • generator ⟨2, Nat.prime_two⟩ + (2 * L ^ 2) • logRat (1 + q)) := by
  have h1q : 0 < 1 + q := by linarith
  -- 準備の第一（a := L、b := L。上界の指数 2·(L·L) を L² の形へ読み替える）
  have hZpos : 0 < openPartitionValueRat L L q := openPartitionValueRat_pos L L hq
  have hBpos : 0 < ((2 ^ L ^ 2 : ℕ) : ℚ) * (1 + q) ^ (2 * L ^ 2) :=
    mul_pos (by positivity) (pow_pos h1q _)
  have hZle : openPartitionValueRat L L q ≤ ((2 ^ L ^ 2 : ℕ) : ℚ) * (1 + q) ^ (2 * L ^ 2) := by
    have h := openPartitionValueRat_le_upperBound L L hq
    simpa [sq] using h
  -- log Z^op_{L,L}(q) ≤_Λ log(2^{L²}(1+q)^{2L²})（対数は順序を保つ）
  have h := (logRat_le_iff hZpos hBpos).mp hZle
  -- 上界の対数を二項へ開く（周期境界と共有）
  rw [logRat_upperBound_eq L hq] at h
  exact h

/-- `claim_open_square_free_entropy_density_upper_bound`。`Ψ^op_L(q) ≤_{Λ_ℚ} ι(ℓ_2) + 2·ι(log(1+q))`。 -/
theorem rationalLogOrderLE_openScaledFreeEntropy_upperBound (L : ℕ) [NeZero L] {q : ℚ} (hq : 0 < q) :
    rationalLogOrderLE (openScaledFreeEntropy L q)
      (toRational (generator ⟨2, Nat.prime_two⟩) + (2 : ℚ) • toRational (logRat (1 + q))) := by
  -- (1/L²)·ι(log Z^op_{L,L}(q)) ≤_{Λ_ℚ} (1/L²)·ι(L²ℓ_2 + 2L² log(1+q))（順序の移送の ←）
  have h : rationalLogOrderLE
      (((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational (logRat (openPartitionValueRat L L q)))
      (((1 : ℚ) / ((L : ℚ) ^ 2)) •
        toRational ((L ^ 2) • generator ⟨2, Nat.prime_two⟩ + (2 * L ^ 2) • logRat (1 + q))) :=
    (rationalLogOrderLE_scaled_toRational_iff L _ _).mpr
      (logOrderLE_logRat_openPartitionValueRat_upperBound L hq)
  -- 右辺を ι(ℓ_2) + 2·ι(log(1+q)) へ（周期境界と共有）
  rw [scaled_toRational_upperBound_eq] at h
  exact h

end Ising2DLambda.ThermodynamicLimit
