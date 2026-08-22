/-
「素指数の符号だけを見る粗視化は箱サイズ極限の一致に十分でない」の Lean 具体版。

人手証明と 1 対 1 に対応させる。すなわち `M L = 1`, `A L = 2`, `B L = 4` と置き、
素数 2 では素指数が `1` と `2` で異なるのに符号はどちらも `1` であること、
2 以外の素数では両方の素指数が 0 で符号も 0 であること、
両方の乗根列がそれぞれ定数列として収束すること、そして二つの極限値 `2` と `4` が
異なることを示す。
-/
import Ising3DCut.LimitQuantity.PositiveRealRootUnique
import Ising3DCut.LimitQuantity.MagnitudeTruncatedPrimeExponentsNotSufficient
import Mathlib.Topology.Instances.Real.Lemmas
import Mathlib.NumberTheory.Padics.PadicVal.Basic

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- 人手証明の「`2 = 2^1` の素数 2 での素指数は 1」の段。 -/
theorem padicValRat_two_of_two : padicValRat 2 ((2 : ℚ)) = (1 : ℤ) := by
  haveI : Fact (Nat.Prime 2) := ⟨Nat.prime_two⟩
  have h : padicValRat 2 (((2 ^ 1 : ℕ) : ℚ)) = ((1 : ℕ) : ℤ) := padicValRat_two_pow 1
  norm_num at h
  exact h

/-- 人手証明の「`4 = 2^2` の素数 2 での素指数は 2」の段。 -/
theorem padicValRat_two_of_four : padicValRat 2 ((4 : ℚ)) = (2 : ℤ) := by
  haveI : Fact (Nat.Prime 2) := ⟨Nat.prime_two⟩
  have h : padicValRat 2 (((2 ^ 2 : ℕ) : ℚ)) = ((2 : ℕ) : ℤ) := padicValRat_two_pow 2
  norm_num at h
  exact h

/-- 人手証明の「2 以外の素数での `2` の素指数は 0」の段。 -/
theorem padicValRat_ne_two_of_two (p : ℕ) (hp : p.Prime) (hne : p ≠ 2) :
    padicValRat p ((2 : ℚ)) = 0 := by
  have h : padicValRat p (((2 ^ 1 : ℕ) : ℚ)) = 0 := padicValRat_ne_two_pow p 1 hp hne
  norm_num at h
  exact h

/-- 人手証明の「2 以外の素数での `4` の素指数は 0」の段。 -/
theorem padicValRat_ne_two_of_four (p : ℕ) (hp : p.Prime) (hne : p ≠ 2) :
    padicValRat p ((4 : ℚ)) = 0 := by
  have h : padicValRat p (((2 ^ 2 : ℕ) : ℚ)) = 0 := padicValRat_ne_two_pow p 2 hp hne
  norm_num at h
  exact h

/-- すべての素数で素指数の符号が一致するのに二つの乗根列の極限が異なる例がある。 -/
theorem sign_of_prime_exponents_is_not_sufficient_for_limit_quantity :
    ∃ (A B : ℕ → ℚ) (M : ℕ → ℕ) (ℓ ℓ' : ℝ),
      (∀ L, 0 < A L) ∧ (∀ L, 0 < B L) ∧ (∀ L, M L ≠ 0) ∧
      (∀ L, ∀ p : ℕ, p.Prime →
        Int.sign (padicValRat p (A L)) = Int.sign (padicValRat p (B L))) ∧
      (∀ L, padicValRat 2 (A L) ≠ padicValRat 2 (B L)) ∧
      Tendsto (fun L => posRoot ((A L : ℝ)) (M L)) atTop (𝓝 ℓ) ∧
      Tendsto (fun L => posRoot ((B L : ℝ)) (M L)) atTop (𝓝 ℓ') ∧ ℓ ≠ ℓ' := by
  have hposA : (0 : ℚ) < (2 : ℚ) := by norm_num
  have hposB : (0 : ℚ) < (4 : ℚ) := by norm_num
  have hposAR : (0 : ℝ) < (2 : ℝ) := by norm_num
  have hposBR : (0 : ℝ) < (4 : ℝ) := by norm_num
  refine ⟨fun _ => (2 : ℚ), fun _ => (4 : ℚ), fun _ => 1, (2 : ℝ), (4 : ℝ),
    fun _ => hposA, fun _ => hposB, fun _ => one_ne_zero, ?_, ?_, ?_, ?_, ?_⟩
  · -- 人手証明の「すべての素数で素指数の符号が一致する」の段。
    intro _ p hp
    by_cases h2 : p = 2
    · subst h2
      rw [padicValRat_two_of_two, padicValRat_two_of_four]
      decide
    · rw [padicValRat_ne_two_of_two p hp h2, padicValRat_ne_two_of_four p hp h2]
  · -- 人手証明の「素数 2 での素指数は一致しない（落ちる情報の所在）」の段。
    intro _
    rw [padicValRat_two_of_two, padicValRat_two_of_four]
    decide
  · -- 人手証明の「`a` は定数列 2 なので箱サイズ極限は 2」の段。
    have hfun : (fun _ : ℕ => posRoot (((2 : ℚ) : ℝ)) 1) = fun _ : ℕ => (2 : ℝ) := by
      funext L
      have hcast : (((2 : ℚ)) : ℝ) = (2 : ℝ) := by push_cast; ring
      rw [hcast]
      exact (eq_posRoot_of_pow_eq (2 : ℝ) (2 : ℝ) hposAR hposAR 1 one_ne_zero
        (by norm_num)).symm
    rw [hfun]
    exact tendsto_const_nhds
  · -- 人手証明の「`b` は定数列 4 なので箱サイズ極限は 4」の段。
    have hfun : (fun _ : ℕ => posRoot (((4 : ℚ) : ℝ)) 1) = fun _ : ℕ => (4 : ℝ) := by
      funext L
      have hcast : (((4 : ℚ)) : ℝ) = (4 : ℝ) := by push_cast; ring
      rw [hcast]
      exact (eq_posRoot_of_pow_eq (4 : ℝ) (4 : ℝ) hposBR hposBR 1 one_ne_zero
        (by norm_num)).symm
    rw [hfun]
    exact tendsto_const_nhds
  · -- 人手証明の「2 ≠ 4」の段。
    norm_num

end Ising3DCut.LimitQuantity
