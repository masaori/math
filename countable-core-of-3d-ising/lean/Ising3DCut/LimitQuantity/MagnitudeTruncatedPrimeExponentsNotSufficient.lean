/-
「素指数を大きさで切り詰める粗視化は箱サイズ極限の一致に十分でない」の Lean 具体版。

人手証明と 1 対 1 に対応させる。すなわち切り詰めの高さ `N ≥ 1` に対し
`M L = 1`, `A L = 2^N`, `B L = 2^(N+1)` と置き、
素数 2 では素指数が `N` と `N+1` で異なるのに高さ `N` で切り詰めるとどちらも `N` になること、
2 以外の素数では両方の素指数が 0 であること、
両方の乗根列がそれぞれ定数列として収束すること、そして二つの極限値 `2^N` と `2^(N+1)` が
異なることを示す。
-/
import Ising3DCut.LimitQuantity.PositiveRealRootUnique
import Mathlib.Topology.Instances.Real.Lemmas
import Mathlib.NumberTheory.Padics.PadicVal.Basic

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- 人手証明の「2 のべきの素因数分解は 2 のみからなる」の段（素数 2 での素指数）。 -/
theorem padicValRat_two_pow (k : ℕ) : padicValRat 2 (((2 ^ k : ℕ) : ℚ)) = (k : ℤ) := by
  haveI : Fact (Nat.Prime 2) := ⟨Nat.prime_two⟩
  have h : padicValNat 2 (2 ^ k) = k := padicValNat.prime_pow k
  rw [padicValRat.of_nat, h]

/-- 人手証明の「2 のべきの素因数分解に 2 以外の素数は現れない」の段。 -/
theorem padicValRat_ne_two_pow (p k : ℕ) (hp : p.Prime) (hne : p ≠ 2) :
    padicValRat p (((2 ^ k : ℕ) : ℚ)) = 0 := by
  have hdvd : ¬ (p ∣ 2 ^ k) := by
    intro hdvd
    exact hne ((Nat.prime_dvd_prime_iff_eq hp Nat.prime_two).1 (hp.dvd_of_dvd_pow hdvd))
  have h : padicValNat p (2 ^ k) = 0 := padicValNat.eq_zero_of_not_dvd hdvd
  rw [padicValRat.of_nat, h]
  rfl

/-- 任意の切り詰めの高さ `N ≥ 1` について、すべての素数で高さ `N` の切り詰めが一致するのに
二つの乗根列の極限が異なる例がある。 -/
theorem magnitude_truncated_prime_exponents_are_not_sufficient_for_limit_quantity
    (N : ℕ) (_hN : N ≠ 0) :
    ∃ (A B : ℕ → ℚ) (M : ℕ → ℕ) (ℓ ℓ' : ℝ),
      (∀ L, 0 < A L) ∧ (∀ L, 0 < B L) ∧ (∀ L, M L ≠ 0) ∧
      (∀ L, ∀ p : ℕ, p.Prime →
        min (padicValRat p (A L)) (N : ℤ) = min (padicValRat p (B L)) (N : ℤ)) ∧
      (∀ L, padicValRat 2 (A L) ≠ padicValRat 2 (B L)) ∧
      Tendsto (fun L => posRoot ((A L : ℝ)) (M L)) atTop (𝓝 ℓ) ∧
      Tendsto (fun L => posRoot ((B L : ℝ)) (M L)) atTop (𝓝 ℓ') ∧ ℓ ≠ ℓ' := by
  have hposA : (0 : ℚ) < ((2 ^ N : ℕ) : ℚ) := by positivity
  have hposB : (0 : ℚ) < ((2 ^ (N + 1) : ℕ) : ℚ) := by positivity
  have hposAR : (0 : ℝ) < ((2 : ℝ) ^ N) := by positivity
  have hposBR : (0 : ℝ) < ((2 : ℝ) ^ (N + 1)) := by positivity
  refine ⟨fun _ => ((2 ^ N : ℕ) : ℚ), fun _ => ((2 ^ (N + 1) : ℕ) : ℚ), fun _ => 1,
    (2 : ℝ) ^ N, (2 : ℝ) ^ (N + 1),
    fun _ => hposA, fun _ => hposB, fun _ => one_ne_zero, ?_, ?_, ?_, ?_, ?_⟩
  · -- 人手証明の「切り詰めた素指数はすべての素数で一致する」の段。
    intro _ p hp
    by_cases h2 : p = 2
    · subst h2
      rw [padicValRat_two_pow N, padicValRat_two_pow (N + 1)]
      have h1 : min (N : ℤ) (N : ℤ) = (N : ℤ) := min_self _
      have h2 : min (((N + 1 : ℕ)) : ℤ) (N : ℤ) = (N : ℤ) := by
        rw [min_eq_right]
        push_cast
        omega
      rw [h1, h2]
    · rw [padicValRat_ne_two_pow p N hp h2, padicValRat_ne_two_pow p (N + 1) hp h2]
  · -- 人手証明の「素数 2 での素指数は一致しない（落ちる情報の所在）」の段。
    intro _
    rw [padicValRat_two_pow N, padicValRat_two_pow (N + 1)]
    push_cast
    omega
  · -- 人手証明の「`a` は定数列 2^N なので箱サイズ極限は 2^N」の段。
    have hfun : (fun _ : ℕ => posRoot ((((2 ^ N : ℕ) : ℚ) : ℝ)) 1)
        = fun _ : ℕ => ((2 : ℝ) ^ N) := by
      funext L
      have hcast : ((((2 ^ N : ℕ) : ℚ)) : ℝ) = ((2 : ℝ) ^ N) := by push_cast; ring
      rw [hcast]
      exact (eq_posRoot_of_pow_eq ((2 : ℝ) ^ N) ((2 : ℝ) ^ N) hposAR hposAR 1 one_ne_zero
        (by norm_num)).symm
    rw [hfun]
    exact tendsto_const_nhds
  · -- 人手証明の「`b` は定数列 2^{N+1} なので箱サイズ極限は 2^{N+1}」の段。
    have hfun : (fun _ : ℕ => posRoot ((((2 ^ (N + 1) : ℕ) : ℚ) : ℝ)) 1)
        = fun _ : ℕ => ((2 : ℝ) ^ (N + 1)) := by
      funext L
      have hcast : ((((2 ^ (N + 1) : ℕ) : ℚ)) : ℝ) = ((2 : ℝ) ^ (N + 1)) := by push_cast; ring
      rw [hcast]
      exact (eq_posRoot_of_pow_eq ((2 : ℝ) ^ (N + 1)) ((2 : ℝ) ^ (N + 1)) hposBR hposBR 1
        one_ne_zero (by norm_num)).symm
    rw [hfun]
    exact tendsto_const_nhds
  · -- 人手証明の「2^N ≠ 2^{N+1}」の段。
    have hlt : ((2 : ℝ) ^ N) < ((2 : ℝ) ^ (N + 1)) := by
      have : (1 : ℝ) < 2 := by norm_num
      exact pow_lt_pow_right₀ this (Nat.lt_succ_self N)
    exact ne_of_lt hlt

end Ising3DCut.LimitQuantity
