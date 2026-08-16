/-
「有理係数の対数順序群の Archimedes 性」の具体版が、必要十分版 `archimedean_of_bernoulli_necSuf`
（順序体＋非負元を自然数で追い越せること）の `K := ℚ`、`A := rat_Λ(μ_N)`、`B := rat_Λ(ε_N)` への
特殊化として得られることを明示する。ℚ の Archimedes 性（hArch）は具体版の準備の第四
`rat_le_num_toNat`（分子で追い越す）で与え、得た `A ≤ B^n` を
`rat_Λ(nε_N) = rat_Λ(ε_N)^n` と共通分母の証人（`commonDenominator_natSmul`）で `Λ_ℚ` の順序へ持ち上げる。
-/
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupArchimedean
import Ising2DLambda.NecSuf.ThermodynamicLimit.RationalLogOrderGroupArchimedean

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- 具体版を必要十分版から導く（`K := ℚ`）。 -/
theorem rationalLogOrderLE_natSmul_of_pos_from_necSuf (μ ε : RationalLogOrderGroup)
    (hμ : rationalLogOrderLE 0 μ) (hε : rationalLogOrderLE 0 ε) (hne : ε ≠ 0) :
    ∃ n : ℕ, rationalLogOrderLE μ (((n : ℚ)) • ε) := by
  -- 準備の第一〜第三は具体版と同じ
  obtain ⟨hμN, hεN⟩ := commonCommonDenominator_exists μ ε
  have hN : 1 ≤ denominatorProduct μ * denominatorProduct ε :=
    Nat.one_le_iff_ne_zero.mpr
      (Nat.mul_ne_zero (Nat.one_le_iff_ne_zero.mp (denominatorProduct_pos μ))
        (Nat.one_le_iff_ne_zero.mp (denominatorProduct_pos ε)))
  generalize hμw : ((denominatorProduct ε : ℤ)) • commonDenominatorWitness μ = μN at hμN
  generalize hεw : ((denominatorProduct μ : ℤ)) • commonDenominatorWitness ε = εN at hεN
  generalize hNw : denominatorProduct μ * denominatorProduct ε = N at hμN hεN hN
  have hA : 1 ≤ rationalOfLog μN := one_le_rationalOfLog_witness_of_nonneg N hN μ μN hμN hμ
  have hB : 1 < rationalOfLog εN := one_lt_rationalOfLog_witness_of_pos N hN ε εN hεN hε hne
  -- 必要十分版: ℚ の Archimedes 性は分子で与える
  obtain ⟨n, hn⟩ := NecSuf.ThermodynamicLimit.archimedean_of_bernoulli_necSuf (K := ℚ)
    (fun r hr => ⟨r.num.toNat, rat_le_num_toNat r hr⟩) hA hB
  refine ⟨n, ?_⟩
  -- rat_Λ(μ_N) ≤ rat_Λ(ε_N)^n = rat_Λ(nε_N)、証人を通して Λ_ℚ の順序へ
  have hchain : logOrderLE μN (((n : ℤ)) • εN) := by
    unfold logOrderLE
    rw [natCast_zsmul, rationalOfLog_natSmul]
    exact hn
  exact ⟨N, μN, ((n : ℤ)) • εN, hN, hμN, commonDenominator_natSmul N n ε εN hεN, hchain⟩

end Ising2DLambda.ThermodynamicLimit
