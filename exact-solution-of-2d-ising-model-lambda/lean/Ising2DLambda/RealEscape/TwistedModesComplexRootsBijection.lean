/-
`claim_twisted_modes_complex_roots_bijection`
（横・縦モードの複素実現は複素根全体への全単射である）の具体版。

`Bool.false` と `Bool.true` は本文の 0 と 1 に対応し、(-1)^c は `if c then -1 else 1`、
c/2 は `(if c then 1 else 0) / 2` と書く（`KacWard/TwistedModeSets.lean` の規約）。

人手証明との対応:
  - E_{L,c} := {z ∈ ℂ | z^L = (-1)^c}: `complexRootSet`。
    e_{L,c,k} := exp(2πi(k + c/2)/L): `complexRootCandidate`。
  - e_{L,c,k}^L = exp(2πi(k + c/2)) = exp(2πik)exp(πic) = exp(πic) = (-1)^c の四行:
    `complexRootCandidate_pow`。
  - e_{L,c,j} = e_{L,c,k} から周期性で 2πi(j + c/2)/L = 2πi(k + c/2)/L + 2πin（n ∈ ℤ）、
    j - k = nL（`complexRootCandidate_period`）、-L < j - k < L、-1 < n < 1、n = 0、j = k
    （`natLt_eq_of_sub_eq_mul`）: `complexRootCandidate_injOn`。
  - X^L - (-1)^c は相異なる複素根を L 個より多く持たない: `complexRootSet_ncard_le`
    （ℂ の事実として本文が引く次数による根の個数の上界。ℂ 上の L 乗根の多重集合
    `Polynomial.nthRoots` の大きさが L 以下であることで書く）。
  - L 個の相異なる根 e_{L,c,k} が E_{L,c} に含まれ、E_{L,c} の元は L 個以下なので
    E_{L,c} = {e_{L,c,k} | 0 ≤ k < L}、|E_{L,c}| = L: `complexRootSet_eq_candidates`・
    `complexRootSet_ncard`。
  - 制限写像の像は E に含まれ（`claim_complex_realization_twisted_modes_are_complex_roots`）、
    単射で（`claim_complex_realization_injective`）、定義域は L 個の元を持つ
    （`claim_twisted_mode_sets_card`）ので、像は E と同じ L 個の元を持ち全射:
    `complexAlgebraicRealization_horizontal_bijOn`・`complexAlgebraicRealization_vertical_bijOn`。
-/
import Ising2DLambda.RealEscape.ComplexRealizationTwistedModeRoots
import Ising2DLambda.RealEscape.ComplexRealizationInjective
import Ising2DLambda.KacWard.TwistedModeCard
import Ising2DLambda.KacWard.AntiperiodicModeExists
import Mathlib.Analysis.SpecialFunctions.Complex.Log
import Mathlib.Algebra.Polynomial.Roots

namespace Ising2DLambda.RealEscape

open Ising2DLambda.FisherZero
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.CriticalExponent
open Ising2DLambda.KacWard

/-- 本文の複素根集合 E_{L,c} := {z ∈ ℂ | z^L = (-1)^c}。 -/
def complexRootSet (L : ℕ) (c : Bool) : Set ℂ :=
  {z : ℂ | z ^ L = if c then -1 else 1}

/-- 本文の e_{L,c,k} := exp(2πi(k + c/2)/L)。 -/
noncomputable def complexRootCandidate (L : ℕ) (c : Bool) (k : ℕ) : ℂ :=
  Complex.exp (2 * Real.pi * Complex.I * ((k : ℂ) + (if c then 1 else 0) / 2) / L)

/-- 本文の四行: e_{L,c,k}^L = (-1)^c。 -/
theorem complexRootCandidate_pow (L : ℕ) (hL : 0 < L) (c : Bool) (k : ℕ) :
    complexRootCandidate L c k ^ L = (if c then -1 else 1 : ℂ) := by
  have hL' : (L : ℂ) ≠ 0 := Nat.cast_ne_zero.mpr (Nat.pos_iff_ne_zero.mp hL)
  calc
    complexRootCandidate L c k ^ L
        = Complex.exp (2 * Real.pi * Complex.I * ((k : ℂ) + (if c then 1 else 0) / 2)) := by
      -- exp(t)^L = exp(Lt)
      rw [complexRootCandidate, ← Complex.exp_nat_mul]
      congr 1
      field_simp
    _ = Complex.exp (k * (2 * Real.pi * Complex.I)) *
          Complex.exp (Real.pi * Complex.I * (if c then 1 else 0)) := by
      -- exp(s + t) = exp(s)exp(t)
      rw [← Complex.exp_add]
      congr 1
      ring
    _ = Complex.exp (Real.pi * Complex.I * (if c then 1 else 0)) := by
      -- k ∈ ℤ、exp(2πik) = 1
      rw [Complex.exp_nat_mul_two_pi_mul_I, one_mul]
    _ = (if c then -1 else 1 : ℂ) := by
      -- c ∈ {0, 1}、exp(0) = 1、exp(πi) = -1
      cases c
      · simp
      · simp [Complex.exp_pi_mul_I]

/-- 本文の周期性の段: e_{L,c,j} = e_{L,c,k} なら、ある n ∈ ℤ で j - k = nL。 -/
theorem complexRootCandidate_period (L : ℕ) (hL : 0 < L) (c : Bool) (j k : ℕ)
    (hjk : complexRootCandidate L c j = complexRootCandidate L c k) :
    ∃ n : ℤ, (j : ℤ) - k = n * L := by
  have hL' : (L : ℂ) ≠ 0 := Nat.cast_ne_zero.mpr (Nat.pos_iff_ne_zero.mp hL)
  have hpi : (2 * Real.pi * Complex.I : ℂ) ≠ 0 := by
    simp [Real.pi_ne_zero, Complex.I_ne_zero]
  -- 複素指数関数の周期性: 2πi(j + c/2)/L = 2πi(k + c/2)/L + 2πin（n ∈ ℤ）
  obtain ⟨n, hn⟩ := Complex.exp_eq_exp_iff_exists_int.mp hjk
  refine ⟨n, ?_⟩
  -- ℂ の四則: j = k + nL
  have hC : (j : ℂ) = k + n * L := by
    have h2 := congrArg (fun t : ℂ => t * L / (2 * Real.pi * Complex.I)) hn
    field_simp at h2
    linear_combination h2 / 2
  have : ((j : ℤ) : ℂ) = ((k + n * L : ℤ) : ℂ) := by push_cast; exact hC
  have := Int.cast_injective this
  linarith

/-- 本文の整数の段: 0 ≤ j, k < L かつ j - k = nL なら n = 0 で j = k。 -/
theorem natLt_eq_of_sub_eq_mul (L j k : ℕ) (hjL : j < L) (hkL : k < L) (n : ℤ)
    (hZ : (j : ℤ) - k = n * L) : j = k := by
  -- -L < j - k < L
  have hlow : -(L : ℤ) < (j : ℤ) - k := by omega
  have hhigh : (j : ℤ) - k < L := by omega
  -- -1 < n < 1 なので n = 0
  have hn0 : n = 0 := by
    rcases lt_trichotomy n 0 with h | h | h
    · have : n * (L : ℤ) ≤ -(L : ℤ) := by nlinarith
      omega
    · exact h
    · have : (L : ℤ) ≤ n * (L : ℤ) := by nlinarith
      omega
  rw [hn0, zero_mul] at hZ
  omega

/-- 本文の単射性: 0 ≤ j, k < L で e_{L,c,j} = e_{L,c,k} なら j = k。 -/
theorem complexRootCandidate_injOn (L : ℕ) (hL : 0 < L) (c : Bool) :
    Set.InjOn (complexRootCandidate L c) (Finset.range L : Set ℕ) := by
  intro j hj k hk hjk
  obtain ⟨n, hZ⟩ := complexRootCandidate_period L hL c j k hjk
  exact natLt_eq_of_sub_eq_mul L j k (Finset.mem_range.mp hj) (Finset.mem_range.mp hk) n hZ

/-- 本文の根の個数の上界: E_{L,c} は有限で、元は L 個以下である。 -/
theorem complexRootSet_eq_nthRoots (L : ℕ) (hL : 0 < L) (c : Bool) :
    complexRootSet L c =
      ((Polynomial.nthRoots L (if c then -1 else 1 : ℂ)).toFinset : Set ℂ) := by
  ext z
  simp [complexRootSet, Polynomial.mem_nthRoots hL]

theorem complexRootSet_finite (L : ℕ) (hL : 0 < L) (c : Bool) :
    (complexRootSet L c).Finite := by
  rw [complexRootSet_eq_nthRoots L hL c]
  exact Finset.finite_toSet _

theorem complexRootSet_ncard_le (L : ℕ) (hL : 0 < L) (c : Bool) :
    (complexRootSet L c).ncard ≤ L := by
  rw [complexRootSet_eq_nthRoots L hL c, Set.ncard_coe_finset]
  exact (Multiset.toFinset_card_le _).trans (Polynomial.card_nthRoots _ _)

/-- e_{L,c,0}, …, e_{L,c,L-1} は相異なる L 個の元である。 -/
theorem complexRootCandidates_ncard (L : ℕ) (hL : 0 < L) (c : Bool) :
    (complexRootCandidate L c '' (Finset.range L : Set ℕ)).ncard = L := by
  rw [(complexRootCandidate_injOn L hL c).ncard_image, Set.ncard_coe_finset,
    Finset.card_range]

/-- 本文の E_{L,c} = {e_{L,c,k} | 0 ≤ k < L}。 -/
theorem complexRootSet_eq_candidates (L : ℕ) (hL : 0 < L) (c : Bool) :
    complexRootSet L c = complexRootCandidate L c '' (Finset.range L : Set ℕ) := by
  have hsub : complexRootCandidate L c '' (Finset.range L : Set ℕ) ⊆ complexRootSet L c := by
    rintro _ ⟨k, -, rfl⟩
    exact complexRootCandidate_pow L hL c k
  refine (Set.eq_of_subset_of_ncard_le hsub ?_ (complexRootSet_finite L hL c)).symm
  rw [complexRootCandidates_ncard L hL c]
  exact complexRootSet_ncard_le L hL c

/-- 本文の |E_{L,c}| = L。 -/
theorem complexRootSet_ncard (L : ℕ) (hL : 0 < L) (c : Bool) :
    (complexRootSet L c).ncard = L := by
  rw [complexRootSet_eq_candidates L hL c, complexRootCandidates_ncard L hL c]

/-- 横・縦のモード集合はどちらも L 個の元を持つ（`claim_twisted_mode_sets_card`。
ξ^L = -1 の ξ は `claim_antiperiodic_mode_exists` から取る）。 -/
theorem horizontalTwistedModes_ncard (L : ℕ) (hL : 0 < L) (s : SpinStructure) :
    (horizontalTwistedModes L s).ncard = L := by
  obtain ⟨ξ, -, hξ⟩ := antiperiodicMode_exists L hL
  obtain ⟨h0, h1, -, -⟩ := twistedModeSets_ncard L hL ξ hξ
  obtain ⟨a, b⟩ := s
  cases a
  · exact h0
  · exact h1

theorem verticalTwistedModes_ncard (L : ℕ) (hL : 0 < L) (s : SpinStructure) :
    (verticalTwistedModes L s).ncard = L := by
  obtain ⟨ξ, -, hξ⟩ := antiperiodicMode_exists L hL
  obtain ⟨-, -, h0, h1⟩ := twistedModeSets_ncard L hL ξ hξ
  obtain ⟨a, b⟩ := s
  cases b
  · exact h0
  · exact h1

/-- 本文の最後の段落: 像は E に含まれ、単射で、定義域と E は L 個の元を持つので全単射。 -/
theorem complexAlgebraicRealization_bijOn_of_mapsTo (data : RealClosedSubfieldData)
    (L : ℕ) (hL : 0 < L) (c : Bool) (U : Set Qbar) (hU : U.ncard = L)
    (hmaps : Set.MapsTo (complexAlgebraicRealization data) U (complexRootSet L c)) :
    Set.BijOn (complexAlgebraicRealization data) U (complexRootSet L c) := by
  -- claim_complex_realization_injective
  have hinj : Set.InjOn (complexAlgebraicRealization data) U :=
    (complexAlgebraicRealization_injective data).injOn
  refine ⟨hmaps, hinj, ?_⟩
  -- 像は E と同じ L 個の元を持つ
  have himage : (complexAlgebraicRealization data '' U).ncard = L := by
    rw [hinj.ncard_image, hU]
  have heq : complexAlgebraicRealization data '' U = complexRootSet L c :=
    Set.eq_of_subset_of_ncard_le hmaps.image_subset
      (by rw [complexRootSet_ncard L hL c, himage]) (complexRootSet_finite L hL c)
  exact heq.symm.subset

/-- 具体版（横）: ρ_C|_{U_a} : U_a → E_{L,a} は全単射。 -/
theorem complexAlgebraicRealization_horizontal_bijOn (data : RealClosedSubfieldData)
    (L : ℕ) (hL : 0 < L) (s : SpinStructure) :
    Set.BijOn (complexAlgebraicRealization data) (horizontalTwistedModes L s)
      (complexRootSet L s.1) :=
  complexAlgebraicRealization_bijOn_of_mapsTo data L hL s.1 _
    (horizontalTwistedModes_ncard L hL s)
    -- claim_complex_realization_twisted_modes_are_complex_roots
    (fun _ hw => complexAlgebraicRealization_horizontalMode_pow data L s hw)

/-- 具体版（縦）: ρ_C|_{W_b} : W_b → E_{L,b} は全単射。 -/
theorem complexAlgebraicRealization_vertical_bijOn (data : RealClosedSubfieldData)
    (L : ℕ) (hL : 0 < L) (s : SpinStructure) :
    Set.BijOn (complexAlgebraicRealization data) (verticalTwistedModes L s)
      (complexRootSet L s.2) :=
  complexAlgebraicRealization_bijOn_of_mapsTo data L hL s.2 _
    (verticalTwistedModes_ncard L hL s)
    -- claim_complex_realization_twisted_modes_are_complex_roots
    (fun _ hw => complexAlgebraicRealization_verticalMode_pow data L s hw)

end Ising2DLambda.RealEscape
