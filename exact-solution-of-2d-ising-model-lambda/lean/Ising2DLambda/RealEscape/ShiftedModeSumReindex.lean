/-
章「実数体への脱出と熱力学極限」の「半格子ずれた四つのモード和は同じ積分へ収束する」
（`claim_shifted_mode_riemann_sums`）の証明のうち、`claim_dispersion_product_real_log_sum` を使わない段の具体版。

  人手証明                                                          このファイル
  最初の式鎖の二〜四行目:
    Σ_{(ϖ,ς) ∈ U_a × W_b} log_ℝ ρ_R(Δ(q;ϖ,ς))
      = Σ_{k,l=0}^{L-1} log_ℝ ρ_R(Δ(q;ϖ_{k,l},ς_{k,l}))   （rt_{L,a} × rt_{L,b} と Θ_{L,a,b} の全単射の合成による再添字付け）
      = Σ_{k,l=0}^{L-1} log_ℝ B_q(t^{a,b}_{L,k,l})          （claim_dispersion_angle_realization）
      = Σ_{k,l=0}^{L-1} f_q(t^{a,b}_{L,k,l})                 （f_q の定義）       `modeSum_realizedDispersionLog_eq_sampleSum`
  (ϖ_{k,l},ς_{k,l}) := Θ_{L,a,b} の (e_{L,a,k}, e_{L,b,l}) の唯一の逆像       `shiftedModeOf`
  θ := 2π(k + c/2)/L は t^{a,b}_{L,k,l} の成分 h_L(k + c/2) に等しい          `modeAngle_eq_angleStep_mul`
  最後の式鎖の二・三行目:
    (1/(2L²)) Σ f_q(t) = (1/(8π²)) h_L² Σ f_q(t) → I/(8π²)                    `halfInvSq_sampleSum_tendsto`

`Σ_{(ϖ,ς)}` は `FourierModePair L s`（U_a × W_b の元の組）の上の有限和で、`claim_dispersion_mode_product`
の具体版 `dispersion_mode_product` と同じ添字である。和の項は「ϖ, ς の分散因子の値を R の元 D として
実現写像で実数へ送った値の実対数」であり、`hφ` はこの項の定め方（主張の前提）だけを受ける。
D が在ることは `claim_dispersion_positive_at_rational_point` の具体版から引く。
最初の式鎖の一行目（`claim_dispersion_product_real_log_sum`）との合成は、主経路がその具体版を示した後に行う。

脱出理由: 指数評価（モードを複素指数関数で角表示する）と連続極限（辺長を無限大へ送る）。
必要十分版の定理・定義は使わない。
-/
import Ising2DLambda.RealEscape.ShiftedModeRiemannSumErrorEstimate
import Ising2DLambda.RealEscape.DispersionAngleRealization
import Ising2DLambda.RealEscape.DispersionRealizedPositive
import Ising2DLambda.KacWard.FourierModePairIndex

namespace Ising2DLambda.RealEscape

open Filter Topology
open Ising2DLambda.FisherZero
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.CriticalExponent
open Ising2DLambda.KacWard

/-- 角の書き換え: `2π(k + c/2)/L = h_L (k + c/2)`。 -/
theorem modeAngle_eq_angleStep_mul (L : ℕ) (c : Bool) (k : ℕ) :
    modeAngle L c k = angleStep L * ((k : ℝ) + spinHalfOffset c) := by
  rw [modeAngle, angleStep, spinHalfOffset]
  ring

/-- `(e_{L,a,k}, e_{L,b,l}) ∈ E_{L,a} × E_{L,b}`（`claim_twisted_modes_complex_roots_bijection` の候補の冪）。 -/
theorem complexRootCandidate_pair_mem (L : ℕ) (hL : 0 < L) (s : SpinStructure) (k l : ℕ) :
    (complexRootCandidate L s.1 k, complexRootCandidate L s.2 l) ∈
      complexRootSet L s.1 ×ˢ complexRootSet L s.2 :=
  ⟨complexRootCandidate_pow L hL s.1 k, complexRootCandidate_pow L hL s.2 l⟩

/-- 本文の `(ϖ^{a,b}_{L,k,l}, ς^{a,b}_{L,k,l})`: `claim_twisted_mode_product_bijection` の全射性による
`(e_{L,a,k}, e_{L,b,l})` の逆像。 -/
noncomputable def shiftedModeOf (data : RealClosedSubfieldData) (L : ℕ) [NeZero L]
    (s : SpinStructure) (k l : ℕ) : FourierModePair L s :=
  have hL : 0 < L := Nat.pos_of_ne_zero (NeZero.ne L)
  let h := (twistedModeProductRealization_bijOn data L hL s).surjOn
    (complexRootCandidate_pair_mem L hL s k l)
  ⟨Classical.choose h, (Classical.choose_spec h).1⟩

/-- 逆像の性質: `Θ_{L,a,b}(ϖ_{k,l}, ς_{k,l}) = (e_{L,a,k}, e_{L,b,l})`。 -/
theorem shiftedModeOf_spec (data : RealClosedSubfieldData) (L : ℕ) [NeZero L]
    (s : SpinStructure) (k l : ℕ) :
    twistedModeProductRealization data (shiftedModeOf data L s k l).1 =
      (complexRootCandidate L s.1 k, complexRootCandidate L s.2 l) := by
  have hL : 0 < L := Nat.pos_of_ne_zero (NeZero.ne L)
  exact (Classical.choose_spec ((twistedModeProductRealization_bijOn data L hL s).surjOn
    (complexRootCandidate_pair_mem L hL s k l))).2

/-- 再添字付けの全単射: `(k, l) ↦ (ϖ_{k,l}, ς_{k,l})` は `{0,…,L-1}²` から `U_a × W_b` への全単射。
単射は Θ の値の成分と `rt_{L,c}` の単射性（`claim_complex_root_candidates_bijection`）から、
全射は Θ の値が `E_{L,a} × E_{L,b}` に属することと `rt_{L,c}` の全射性と Θ の単射性から。 -/
theorem shiftedModeOf_inj (data : RealClosedSubfieldData) (L : ℕ) [NeZero L]
    (s : SpinStructure) (k l k' l' : ℕ) (hk : k < L) (hl : l < L) (hk' : k' < L) (hl' : l' < L)
    (h : shiftedModeOf data L s k l = shiftedModeOf data L s k' l') : k = k' ∧ l = l' := by
  have hL : 0 < L := Nat.pos_of_ne_zero (NeZero.ne L)
  have hΘ : (complexRootCandidate L s.1 k, complexRootCandidate L s.2 l) =
      (complexRootCandidate L s.1 k', complexRootCandidate L s.2 l') := by
    rw [← shiftedModeOf_spec data L s k l, ← shiftedModeOf_spec data L s k' l', h]
  obtain ⟨h1, h2⟩ := Prod.mk.inj hΘ
  -- claim_complex_root_candidates_bijection の単射性
  exact ⟨(complexRootCandidate_bijOn L hL s.1).injOn (by simpa using hk) (by simpa using hk') h1,
    (complexRootCandidate_bijOn L hL s.2).injOn (by simpa using hl) (by simpa using hl') h2⟩

theorem shiftedModeOf_surj (data : RealClosedSubfieldData) (L : ℕ) [NeZero L]
    (s : SpinStructure) (m : FourierModePair L s) :
    ∃ k < L, ∃ l < L, shiftedModeOf data L s k l = m := by
  have hL : 0 < L := Nat.pos_of_ne_zero (NeZero.ne L)
  have hbij := twistedModeProductRealization_bijOn data L hL s
  -- Θ(m) ∈ E_{L,a} × E_{L,b}
  obtain ⟨h1, h2⟩ := hbij.mapsTo m.2
  -- claim_complex_root_candidates_bijection の全射性
  obtain ⟨k, hk, hk'⟩ := (complexRootCandidate_bijOn L hL s.1).surjOn h1
  obtain ⟨l, hl, hl'⟩ := (complexRootCandidate_bijOn L hL s.2).surjOn h2
  refine ⟨k, by simpa using hk, l, by simpa using hl, ?_⟩
  apply Subtype.ext
  -- Θ の単射性
  apply hbij.injOn (shiftedModeOf data L s k l).2 m.2
  rw [shiftedModeOf_spec data L s k l]
  exact Prod.ext hk' hl'

/-- 最初の式鎖の二〜四行目の具体版:
`Σ_{(ϖ,ς)} log_ℝ ρ_R(Δ(q;ϖ,ς)) = Σ_{k,l=0}^{L-1} f_q(t^{a,b}_{L,k,l})`。
`φ m` は和の項 `log_ℝ ρ_R(Δ(q;ϖ,ς))`（`hφ` がその定め方）。 -/
theorem modeSum_realizedDispersionLog_eq_sampleSum (data : RealClosedSubfieldData)
    (L : ℕ) [NeZero L] (s : SpinStructure) (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1)
    (φ : FourierModePair L s → ℝ)
    (hφ : ∀ (m : FourierModePair L s) (D : data.carrier),
      (D : Qbar) = (dispersionPolynomial m.1.1 m.1.2).eval (q : Qbar) →
        φ m = Real.log (realAlgebraicCutRealization data D)) :
    ∑ m : FourierModePair L s, φ m =
      ∑ k ∈ Finset.range L, ∑ l ∈ Finset.range L,
        dispersionAngleLog q hq0 hq1 (shiftedSamplePoint L s k l) := by
  have hL1 : 1 ≤ L := Nat.pos_of_ne_zero (NeZero.ne L)
  -- 各標本点の項: φ(ϖ_{k,l}, ς_{k,l}) = f_q(t^{a,b}_{L,k,l})
  have hterm : ∀ k l : ℕ,
      φ (shiftedModeOf data L s k l) = dispersionAngleLog q hq0 hq1 (shiftedSamplePoint L s k l) := by
    intro k l
    set m := shiftedModeOf data L s k l with hm
    -- claim_dispersion_positive_at_rational_point: Δ(q;ϖ,ς) は R の元 D
    obtain ⟨D, hD, -⟩ := dispersion_realized_positive data L hL1 s m.1.1 m.1.2 m.2.1 m.2.2 q hq0 hq1
    calc φ m
        -- 和の項の定め方
        = Real.log (realAlgebraicCutRealization data D) := hφ m D hD
      -- claim_dispersion_angle_realization
      _ = Real.log (dispersionAngleArgument q (modeAngle L s.1 k) (modeAngle L s.2 l)) := by
          rw [dispersion_angle_realization data L hL1 s m.1.1 m.1.2 m.2.1 m.2.2 k l
            (shiftedModeOf_spec data L s k l) q D hD, dispersionAngleArgument]
      -- θ = h_L(k + c/2)
      _ = Real.log (dispersionAngleArgument q (shiftedSamplePoint L s k l).1
            (shiftedSamplePoint L s k l).2) := by
          rw [modeAngle_eq_angleStep_mul, modeAngle_eq_angleStep_mul, shiftedSamplePoint]
      -- f_q の定義
      _ = dispersionAngleLog q hq0 hq1 (shiftedSamplePoint L s k l) := rfl
  calc ∑ m : FourierModePair L s, φ m
      -- claim_twisted_mode_product_bijection による再添字付け
      = ∑ kl ∈ Finset.range L ×ˢ Finset.range L, φ (shiftedModeOf data L s kl.1 kl.2) := by
        symm
        refine Finset.sum_bij (fun kl _ => shiftedModeOf data L s kl.1 kl.2)
          (fun _ _ => Finset.mem_univ _) ?_ ?_ (fun _ _ => rfl)
        · rintro ⟨k, l⟩ hkl ⟨k', l'⟩ hkl' h
          simp only [Finset.mem_product, Finset.mem_range] at hkl hkl'
          obtain ⟨rfl, rfl⟩ := shiftedModeOf_inj data L s k l k' l' hkl.1 hkl.2 hkl'.1 hkl'.2 h
          rfl
        · intro m _
          obtain ⟨k, hk, l, hl, hkl⟩ := shiftedModeOf_surj data L s m
          exact ⟨(k, l), by simp [hk, hl], hkl⟩
    -- 直積上の和を累次和へ
    _ = ∑ k ∈ Finset.range L, ∑ l ∈ Finset.range L, φ (shiftedModeOf data L s k l) :=
        Finset.sum_product _ _ _
    -- 各項の書き換え
    _ = ∑ k ∈ Finset.range L, ∑ l ∈ Finset.range L,
          dispersionAngleLog q hq0 hq1 (shiftedSamplePoint L s k l) := by
        simp_rw [hterm]

/-- 最後の式鎖の二・三行目の具体版:
`(1/(2L²)) Σ_{k,l} f_q(t^{a,b}_{L,k,l}) → I/(8π²)`。 -/
theorem halfInvSq_sampleSum_tendsto (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) (s : SpinStructure) :
    Tendsto (fun L : ℕ => 1 / (2 * (L : ℝ) ^ 2) * ∑ k ∈ Finset.range L, ∑ l ∈ Finset.range L,
        dispersionAngleLog q hq0 hq1 (shiftedSamplePoint L s k l)) atTop
      (𝓝 (dispersionAngleDoubleIntegral q hq0 hq1 / (8 * Real.pi ^ 2))) := by
  have hpi : Real.pi ≠ 0 := Real.pi_ne_zero
  -- 直前に示した小区画の誤差評価
  have hlim := (shiftedAngleRiemannSum_tendsto q hq0 hq1 s).const_mul (1 / (8 * Real.pi ^ 2))
  rw [show 1 / (8 * Real.pi ^ 2) * dispersionAngleDoubleIntegral q hq0 hq1 =
      dispersionAngleDoubleIntegral q hq0 hq1 / (8 * Real.pi ^ 2) by ring] at hlim
  refine hlim.congr' ?_
  filter_upwards [eventually_ge_atTop 1] with L hL
  have hL0 : (L : ℝ) ≠ 0 := by positivity
  -- h_L² = 4π²/L² を代入
  rw [shiftedAngleRiemannSum, angleStep]
  field_simp
  ring

end Ising2DLambda.RealEscape
