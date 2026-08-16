/-
章「熱力学極限」の「開境界正方形の密度の下組の元は密度の上からの評価以下である」
（`claim_open_square_density_lower_set_le_upper_bound`）の具体版（人手証明と 1 対 1 に対応させる）。

  人手証明                                                       このファイル
  μ ∈ A^op(q) の証人 ε（0 ≤ ε、ε ≠ 0）、N ≥ 1 を取り固定する         `obtain ⟨ε, hε0, _, N, hN1, hN⟩`
  証人の性質を L := N で読む（N ≤ N）                               `hN N (le_refl N)`（`h4`）
  一段目・二段目: μ = 0 + μ（単位元）≤ ε + μ（加法単調性。0 ≤ ε）    `rationalLogOrderLE_add_right hε0 μ` と `zero_add`
  三段目: ε + μ = μ + ε（交換則）                                    `add_comm`
  四段目: μ + ε ≤ Ψ^op_N(q)（証人の性質）                            `h4`（列の第 N 項は Ψ^op_N(q)）
  五段目: Ψ^op_N(q) ≤ ι(ℓ_2) + 2·ι(log(1+q))（密度の上からの評価）    `rationalLogOrderLE_openScaledFreeEntropy_upperBound N hq`
  推移律で結ぶ                                                       `rationalLogOrderLE_trans`

`ε ≠ 0` と `q ≤ 1` は使わない。住処は ℕ・ℚ・Λ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.OpenSquareDensityLowerSetNonempty
import Ising2DLambda.ThermodynamicLimit.OpenSquareFreeEntropyDensityUpperBound

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- `claim_open_square_density_lower_set_le_upper_bound`。
`μ ∈ A^op(q)` なら `μ ≤_{Λ_ℚ} ι(ℓ_2) + 2·ι(log(1+q))`。 -/
theorem rationalLogOrderLE_upperBound_of_mem_openSquareDensityLowerSet {q : ℚ} (hq : 0 < q)
    {μ : RationalLogOrderGroup} (hμ : μ ∈ openSquareDensityLowerSet q) :
    rationalLogOrderLE μ
      (toRational (generator ⟨2, Nat.prime_two⟩) + (2 : ℚ) • toRational (logRat (1 + q))) := by
  -- 証人 ε, N を取り固定する（ε ≠ 0 は使わない）
  obtain ⟨ε, hε0, _, N, hN1, hN⟩ := hμ
  haveI : NeZero N := ⟨by omega⟩
  -- 一段目・二段目: μ = 0 + μ ≤ ε + μ（加法単調性を λ := 0、μ := ε、ν := μ で読む）
  have h12 : rationalLogOrderLE μ (ε + μ) := by
    have h := rationalLogOrderLE_add_right hε0 μ
    rwa [zero_add] at h
  -- 三段目: ε + μ = μ + ε（交換則）
  have h3 : ε + μ = μ + ε := add_comm ε μ
  -- 四段目: μ + ε ≤ Ψ^op_N(q)（証人の性質を L := N で読む。列の第 N 項は Ψ^op_N(q)）
  have h4 : rationalLogOrderLE (μ + ε) (openScaledFreeEntropy N q) := by
    have h := hN N (le_refl N)
    rwa [openSquareDensitySequence_of_ne_zero] at h
  -- 五段目: Ψ^op_N(q) ≤ ι(ℓ_2) + 2·ι(log(1+q))（密度の上からの評価。N ≥ 1）
  have h5 := rationalLogOrderLE_openScaledFreeEntropy_upperBound N hq
  -- 推移律で結ぶ
  rw [h3] at h12
  exact rationalLogOrderLE_trans (rationalLogOrderLE_trans h12 h4) h5

end Ising2DLambda.ThermodynamicLimit
