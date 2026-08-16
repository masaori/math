/-
「有理係数の対数順序群の実現写像は順序を保つ」の具体版を、必要十分版
`realize_monotone_of_common_denominator_necSuf` の特殊化として導く。

渡すのは `X := Λ_ℚ`、`L := Λ`、`Q0 := ℚ`、`R := ℝ`、`P := ℝ_{>0}`、`rat := rat_Λ`、
`le_L := ≤_Λ`（`logOrderLE` は `rat_Λ` の比較そのもの）、`ι := ι_{ℚ→ℝ}`（`Rat.cast_le`）、
`val := (·.1)`、`lg := log_ℝ`（`realLog_le_realLog`）、`pr := rationalOfLogPositiveReal`（`val` は定義そのもの）、
`emb := ι_{Λ→Λ_ℚ}`、`ρ := ρ_ℝ`（`realizeRational_toRational`）、`smul N x := (N:ℚ) • x`、
`c N := ι_{ℚ→ℝ}(N)`（`realizeRational_smul`、`natCast_real_pos`）である。
`λ ≤_{Λ_ℚ} μ` の `∃` を剥がして証人を渡すのはここで行う。
-/
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupRealizationMonotone
import Ising2DLambda.NecSuf.ThermodynamicLimit.RationalLogOrderGroupRealizationMonotone

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

theorem realizeRational_le_of_rationalLogOrderLE_from_necSuf (l m : RationalLogOrderGroup)
    (h : rationalLogOrderLE l m) : realizeRational l ≤ realizeRational m := by
  obtain ⟨N, lN, mN, hN, hl, hm, hle⟩ := h
  exact NecSuf.ThermodynamicLimit.realize_monotone_of_common_denominator_necSuf
    (R := ℝ) (X := RationalLogOrderGroup) (L := LogOrderGroup) (Q0 := ℚ) (P := PositiveReal)
    rationalOfLog logOrderLE (fun _ _ hab => hab)
    (fun q : ℚ => (q : ℝ)) (fun _ _ hq => Rat.cast_le.mpr hq)
    (fun t => t.1) realLog (fun u v huv => realLog_le_realLog u v huv)
    rationalOfLogPositiveReal (fun _ => rfl)
    toRational realizeRational realizeRational_toRational
    (fun N x => (N : ℚ) • x) (fun N => ((N : ℚ) : ℝ)) (fun N x => realizeRational_smul (N : ℚ) x)
    natCast_real_pos
    l m N lN mN hN hl hm hle

end Ising2DLambda.ThermodynamicLimit
