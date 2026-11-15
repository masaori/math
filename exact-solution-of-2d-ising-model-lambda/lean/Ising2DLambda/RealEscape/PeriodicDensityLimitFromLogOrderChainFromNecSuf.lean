import Ising2DLambda.RealEscape.PeriodicDensityLimitFromLogOrderChain
import Ising2DLambda.NecSuf.RealEscape.PeriodicDensityLimitFromLogOrderChain

/-!
具体版 `periodicFreeEnergyDensity_eq_of_logOrderChain`（`theorem_periodic_density_onsager_integral` の、
対数順序群の鎖と `w_L → I` から `f^per(q) = I` を得る段）を、必要十分版から得る導出版。

`G = Λ`、`H = Λ_ℚ`、`leG = ≤_Λ`、`leH = ≤_{Λ_ℚ}`、`lg = log`、`rat = rat_Λ`、`rlog = log_ℝ ∘ ι_{ℚ→ℝ}`、
`emb_L(λ) = L^{-2}·ι(λ)`、`ρ = ρ_ℝ`、`e_L = L^{-2}`、`F(l) = sup ρ_ℝ(A(l))`、`M_L = M^abs_L(q)`、`Φ_L = Φ_L(q)`、
`x_L = Ψ_L(q)` に特殊化する。`hemb` は `claim_scaled_embedding_order_transfer`、`hρemb` は実現の二段、
`hsup` は `claim_sequence_lower_set_sup_eq_real_limit` から取る。
-/

namespace Ising2DLambda.RealEscape

open Ising2DLambda.ThermodynamicLimit Ising2DLambda.FreeEntropy Ising2DLambda.KacWard Filter Topology

/-- 列 `L ↦ Φ_L(q)`（`L = 0` では `0`）。 -/
noncomputable def freeEntropySequence (q : ℚ) : ℕ → LogOrderGroup :=
  fun L => if h : L = 0 then 0 else
    haveI : NeZero L := ⟨h⟩
    freeEntropy L q

theorem periodicFreeEnergyDensity_eq_of_logOrderChain_from_necSuf (q : ℚ) (I : ℝ)
    (hM : ∀ (L : ℕ) [NeZero L], 0 < signedEvenSubgraphAbsMax L q)
    (hchain : ∀ (L : ℕ) [NeZero L],
      logOrderLE (logRat (signedEvenSubgraphAbsMax L q) - 2 • logRat 2) (freeEntropy L q) ∧
        logOrderLE (freeEntropy L q) (logRat (signedEvenSubgraphAbsMax L q) + logRat 2))
    (hlim : Tendsto (scaledLogAbsMax q) atTop (𝓝 I)) :
    periodicFreeEnergyDensity q = I := by
  show sSup (realizeRational '' rationalLogOrderSequenceLowerSet (periodicDensitySequence q)) = I
  refine Ising2DLambda.NecSuf.RealEscape.sup_eq_of_logOrderChain_necSuf
    logOrderLE rationalLogOrderLE logRat rationalOfLog (fun a => Real.log ((a : ℚ) : ℝ))
    (fun L l => if L = 0 then 0 else ((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational l) realizeRational
    (fun L : ℕ => 1 / ((L : ℝ) ^ 2))
    (fun l => sSup (realizeRational '' rationalLogOrderSequenceLowerSet l))
    (fun ha hb => logRat_mul ha hb) (fun ha => rationalOfLog_logRat ha)
    (fun ha hb => by
      rw [Rat.cast_mul]
      exact Real.log_mul (ne_of_gt (Rat.cast_pos.mpr ha)) (ne_of_gt (Rat.cast_pos.mpr hb)))
    (fun L hL x y h => by
      haveI : NeZero L := ⟨by omega⟩
      simp only [if_neg (NeZero.ne L)]
      exact (rationalLogOrderLE_scaled_toRational_iff L x y).2 h)
    (fun h => realizeRational_le_of_rationalLogOrderLE _ _ h)
    (fun L hL l => by
      haveI : NeZero L := ⟨by omega⟩
      simp only [if_neg (NeZero.ne L)]
      exact realizeRational_scaled_toRational L l)
    ?_ (fun l J h => (sequence_lowerSet_sup_eq_realLimit l J h).2.2)
    (absMaxSequence q) (freeEntropySequence q) (periodicDensitySequence q) I
    (fun L hL => by
      haveI : NeZero L := ⟨by omega⟩
      rw [absMaxSequence_of_ne_zero]; exact hM L)
    (fun L hL => by
      haveI : NeZero L := ⟨by omega⟩
      have hf : freeEntropySequence q L = freeEntropy L q := by
        unfold freeEntropySequence; rw [dif_neg (NeZero.ne L)]
      rw [absMaxSequence_of_ne_zero, hf]
      have h2 : ((2 : ℚ) : ℝ) = 2 := by norm_num
      exact hchain L)
    (fun L hL => by
      haveI : NeZero L := ⟨by omega⟩
      have hf : freeEntropySequence q L = freeEntropy L q := by
        unfold freeEntropySequence; rw [dif_neg (NeZero.ne L)]
      simp only [if_neg (NeZero.ne L), hf]
      rw [periodicDensitySequence_of_ne_zero]
      rfl)
    hlim
  · have h0 : Tendsto (fun L : ℕ => 1 / (L : ℝ)) atTop (𝓝 (0 : ℝ)) :=
      tendsto_one_div_atTop_nhds_zero_nat
    have h := h0.pow 2
    rw [zero_pow two_ne_zero] at h
    exact h.congr fun L => by rw [one_div_pow]

end Ising2DLambda.RealEscape
