/-
臨界点で非自明なねじれの各分散因子が零でないこと。
本文 `claim_signed_even_subgraph_duality_sign` の前半に対応する。

  人手証明                                                   このファイル・引く具体版
  ϖ, ς ∈ μ_{2L}（claim_twisted_modes_are_double_roots）       `twistedModes_subset_doubleRoots`
  ϖ = α + βω の一意表示（def_real_closed_subfield）          `data.unique_decomposition`
  α²+β² = 1、ϖ⁻¹ = α − βω
    （claim_root_of_unity_inverse_is_real_closed_conjugate） `rootOfUnity_inverse_realClosedConj`
  (1−α)²+β² = c_ϖ·c_ϖ
    （claim_real_closed_sum_of_two_squares_is_square）       `realClosed_sum_of_two_squares_is_square`
  2 − ϖ − ϖ⁻¹ = (1−α)²+β² の式鎖                             `two_sub_eq_realClosed_square`
  平方和表示（claim_dispersion_positive_decomposition）       `dispersion_positive_decomposition`
  c_ϖ = c_ς = 0、次に 1−α = β = 0
    （claim_real_closed_sum_of_two_squares_zero）            `realClosed_sq_add_sq_eq_zero`
  (1,1) ∉ 𝒰_a × 𝒲_b（def_horizontal_twisted_modes・
    def_vertical_twisted_modes・def_spin_structures）        `spin_eq_trivial_of_one_one_mem`
-/
import Ising2DLambda.KacWard.DispersionPositiveAtRationalPoint
import Ising2DLambda.KacWard.SignedEvenSubgraphRationalSignMembership
import Ising2DLambda.FisherZero.RealClosedSumOfTwoSquaresZero

namespace Ising2DLambda.KacWard

open Polynomial
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero

/-- 本文の式鎖: `ϖ = α + βω`、`ϖ⁻¹ = α − βω`、`α²+β² = 1` なら
`2 − ϖ − ϖ⁻¹ = (1−α)² + β²`。 -/
private theorem two_sub_eq_realClosed_square (data : RealClosedSubfieldData) (z : Qbar)
    (a b : data.carrier) (h : z = (a : Qbar) + (b : Qbar) * data.omega)
    (hinv : z⁻¹ = (a : Qbar) - (b : Qbar) * data.omega)
    (hN : (a : Qbar) * (a : Qbar) + (b : Qbar) * (b : Qbar) = 1) :
    2 - z - z⁻¹ = (((1 - a : data.carrier) : Qbar) * ((1 - a : data.carrier) : Qbar) +
      (b : Qbar) * (b : Qbar)) := by
  calc 2 - z - z⁻¹
      = 2 - ((a : Qbar) + (b : Qbar) * data.omega) - ((a : Qbar) - (b : Qbar) * data.omega) := by
        -- ϖ の表示と claim_root_of_unity_inverse_is_real_closed_conjugate
        rw [hinv]; nth_rewrite 1 [h]; rfl
    _ = 2 - 2 * (a : Qbar) := by
        -- Qbar の加法
        ring
    _ = 1 - 2 * (a : Qbar) + ((a : Qbar) * (a : Qbar) + (b : Qbar) * (b : Qbar)) := by
        -- α² + β² = 1
        rw [hN]; ring
    _ = (((1 - a : data.carrier) : Qbar) * ((1 - a : data.carrier) : Qbar) +
          (b : Qbar) * (b : Qbar)) := by
        -- R の分配律
        push_cast; ring

/-- 本文: モードの一方が根ならその R の表示で `2 − z − z⁻¹ = c·c`、
`c = 0` なら `z = 1`。 -/
private theorem rootOfUnity_two_sub_square (data : RealClosedSubfieldData) (n : ℕ) (hn : 0 < n)
    (z : Qbar) (hz : z ∈ RootOfUnity n) :
    ∃ c : data.carrier, 2 - z - z⁻¹ = ((c : Qbar) * (c : Qbar)) ∧ (c = 0 → z = 1) := by
  obtain ⟨⟨a, b⟩, h, _⟩ := data.unique_decomposition z
  obtain ⟨hN, hinv, hconj⟩ := rootOfUnity_inverse_realClosedConj data n hn z hz a b h
  obtain ⟨c, hc⟩ := realClosed_sum_of_two_squares_is_square data (1 - a) b
  have hNq : (a : Qbar) * (a : Qbar) + (b : Qbar) * (b : Qbar) = 1 := by
    have hcast := congrArg (fun t : data.carrier => (t : Qbar)) hN
    push_cast at hcast
    exact hcast
  have hsq := two_sub_eq_realClosed_square data z a b h (hinv.trans hconj) hNq
  have hcq : ((1 - a : data.carrier) : Qbar) * ((1 - a : data.carrier) : Qbar) +
      (b : Qbar) * (b : Qbar) = (c : Qbar) * (c : Qbar) := by
    have hcast := congrArg (fun t : data.carrier => (t : Qbar)) hc
    push_cast at hcast ⊢
    exact hcast
  refine ⟨c, hsq.trans hcq, ?_⟩
  intro hc0
  -- (1−α)² + β² = c·c = 0 なので claim_real_closed_sum_of_two_squares_zero で 1−α = β = 0
  have hzero : ((1 - a : data.carrier) : Qbar) * ((1 - a : data.carrier) : Qbar) +
      (b : Qbar) * (b : Qbar) = 0 := by
    rw [hcq, hc0]; simp
  obtain ⟨ha, hb⟩ := realClosed_sq_add_sq_eq_zero data (1 - a) b hzero
  have ha1 : (a : Qbar) = 1 := by
    have hcast := congrArg (fun t : data.carrier => (t : Qbar)) ha
    push_cast at hcast
    linear_combination -hcast
  have hb0 : (b : Qbar) = 0 := by rw [hb]; rfl
  rw [h, ha1, hb0]
  ring

/-- 本文: `(1,1) ∈ 𝒰_a × 𝒲_b` なら `(a,b) = (0,0)`
（def_horizontal_twisted_modes・def_vertical_twisted_modes で `1^L = (−1)^a`、
`1^L = 1`、`(−1)^1 = −1 ≠ 1`、def_spin_structures）。 -/
private theorem spin_eq_trivial_of_one_one_mem (L : ℕ) (s : SpinStructure)
    (hv : (1 : Qbar) ∈ horizontalTwistedModes L s)
    (hw : (1 : Qbar) ∈ verticalTwistedModes L s) : s = (false, false) := by
  have hv' : (1 : Qbar) ^ L = if s.1 then -1 else 1 := hv
  have hw' : (1 : Qbar) ^ L = if s.2 then -1 else 1 := hw
  rw [one_pow] at hv' hw'
  obtain ⟨a, b⟩ := s
  have ha : a = false := by
    cases a
    · rfl
    · exact False.elim (qbar_one_ne_neg_one (by simpa using hv'))
  have hb : b = false := by
    cases b
    · rfl
    · exact False.elim (qbar_one_ne_neg_one (by simpa using hw'))
  rw [ha, hb]

/-- `x²+2x−1=0`、`x ≠ 0`、`x² ≠ 1` なら、非自明なねじれの各モード因子は零でない。 -/
theorem dispersion_critical_nonzero (data : RealClosedSubfieldData) (L : ℕ)
    (hL : 1 ≤ L) (s : SpinStructure) (hs : s ≠ (false, false))
    (varpi varsigma : Qbar)
    (hv : varpi ∈ horizontalTwistedModes L s)
    (hw : varsigma ∈ verticalTwistedModes L s)
    (x : Qbar) (hx : x ^ 2 + 2 * x - 1 = 0)
    (hx0 : x ≠ 0) (hx1 : x ^ 2 ≠ 1) :
    (dispersionPolynomial varpi varsigma).eval x ≠ 0 := by
  have hn : 0 < 2 * L := by omega
  -- claim_twisted_modes_are_double_roots
  have hvr : varpi ∈ RootOfUnity (2 * L) :=
    twistedModes_subset_doubleRoots L s (Or.inl hv)
  have hwr : varsigma ∈ RootOfUnity (2 * L) :=
    twistedModes_subset_doubleRoots L s (Or.inr hw)
  obtain ⟨cv, hcv, hcv1⟩ := rootOfUnity_two_sub_square data (2 * L) hn varpi hvr
  obtain ⟨cw, hcw, hcw1⟩ := rootOfUnity_two_sub_square data (2 * L) hn varsigma hwr
  -- claim_dispersion_positive_decomposition
  have hdec := congrArg (Polynomial.eval x)
    (dispersion_positive_decomposition varpi varsigma)
  simp only [eval_sub, eval_mul, eval_add, eval_pow, eval_X, eval_C,
    eval_ofNat, eval_one] at hdec
  intro hzero
  have hsum : (cv : Qbar) * (cv : Qbar) + (cw : Qbar) * (cw : Qbar) = 0 := by
    have hfac : x * (1 - x ^ 2) ≠ 0 :=
      mul_ne_zero hx0 (sub_ne_zero.mpr (Ne.symm hx1))
    have h' : x * (1 - x ^ 2) *
        ((2 - varpi - varpi⁻¹) + (2 - varsigma - varsigma⁻¹)) = 0 := by
      rw [← hdec, hzero, hx]
      ring
    rw [hcv, hcw] at h'
    exact (mul_eq_zero.mp h').resolve_left hfac
  -- claim_real_closed_sum_of_two_squares_zero
  obtain ⟨hcv0, hcw0⟩ := realClosed_sq_add_sq_eq_zero data cv cw hsum
  exact hs (spin_eq_trivial_of_one_one_mem L s (hcv1 hcv0 ▸ hv) (hcw1 hcw0 ▸ hw))

end Ising2DLambda.KacWard
