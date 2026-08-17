/-
「周期境界の密度の下組と開境界正方形の密度の下組は等しい（q は 1 以下）」の具体版を、
必要十分版 `lowerSetOfSequence_eq_of_pointwise_le_and_eventually_le_add_error_necSuf` の特殊化として導く。
渡すものは二つの包含の導出版と同じ（推移律・右加法単調性・証人の半分・誤差の列 `L ↦ (2/L)·ι(log q)` の評価・
`L ≥ 1` での項ごとの比較の右と左）。具体版の二つの下組は必要十分版の下組と `rfl` で一致する。
-/
import Ising2DLambda.ThermodynamicLimit.PeriodicDensityLowerSetEqOpenSquare
import Ising2DLambda.NecSuf.ThermodynamicLimit.PeriodicDensityLowerSetEqOpenSquare

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

theorem periodicDensityLowerSet_eq_openSquareDensityLowerSet_of_le_one_from_necSuf
    {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    periodicDensityLowerSet q = openSquareDensityLowerSet q := by
  show NecSuf.ThermodynamicLimit.lowerSetOfSequence rationalLogOrderLE (periodicDensitySequence q) =
    NecSuf.ThermodynamicLimit.lowerSetOfSequence rationalLogOrderLE (openSquareDensitySequence q)
  refine NecSuf.ThermodynamicLimit.lowerSetOfSequence_eq_of_pointwise_le_and_eventually_le_add_error_necSuf
    rationalLogOrderLE
    (fun hxy hyz => rationalLogOrderLE_trans hxy hyz)
    (fun z hxy => rationalLogOrderLE_add_right hxy z)
    ?_ _ _ (fun L => ((2 : ℚ) / (L : ℚ)) • toRational (logRat q)) ?_ ?_ ?_
  · -- 証人の半分（準備の第一）
    intro ε hε0 hεne
    exact ⟨((1 : ℚ) / 2) • ε, rationalLogOrderLE_zero_half_of_nonneg hε0,
      half_ne_zero_of_ne_zero hεne, half_add_half_eq ε⟩
  · -- 誤差は正の元の逆元をやがて下回らない（準備の第二〜第四）
    intro ε' hε'0 hε'ne
    have hδ := rationalLogOrderLE_zero_neg_toRational_logRat_of_le_one hq0 hq1
    have h2δ : rationalLogOrderLE 0 ((2 : ℚ) • (-toRational (logRat q))) := by
      have h : rationalLogOrderLE ((0 : ℚ) • (-toRational (logRat q)))
          ((2 : ℚ) • (-toRational (logRat q))) :=
        rationalLogOrderLE_ratSmul_le_ratSmul_of_le (by norm_num) hδ
      rw [zero_smul] at h
      exact h
    obtain ⟨n, hn⟩ := rationalLogOrderLE_natSmul_of_pos _ ε' h2δ hε'0 hε'ne
    exact ⟨n, fun L hnL hL1 => rationalLogOrderLE_neg_le_scaled_toRational_logRat hε'0 hL1 hnL hn⟩
  · -- L ≥ 1 での項ごとの比較（右）
    intro L hL
    haveI : NeZero L := ⟨by omega⟩
    rw [periodicDensitySequence_of_ne_zero, openSquareDensitySequence_of_ne_zero]
    exact (rationalLogOrderLE_periodicOpenDensity_bounds_of_le_one L hq0 hq1).2
  · -- L ≥ 1 での項ごとの比較（左）
    intro L hL
    haveI : NeZero L := ⟨by omega⟩
    rw [periodicDensitySequence_of_ne_zero, openSquareDensitySequence_of_ne_zero]
    exact (rationalLogOrderLE_periodicOpenDensity_bounds_of_le_one L hq0 hq1).1

end Ising2DLambda.ThermodynamicLimit
