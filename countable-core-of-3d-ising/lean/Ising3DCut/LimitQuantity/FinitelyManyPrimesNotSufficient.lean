/-
「有限個の素数での指数だけを見る粗視化は箱サイズ極限の一致に十分でない」の Lean 具体版。

人手証明と 1 対 1 に対応させる。すなわち素数からなる有限集合 `S` に対し
`S` に属さない素数 `r` を取り（人手証明の「素数は無限に多く存在する」の段）、
`N L = 1`, `A L = 1`, `B L = r` と置き、`S` のすべての素数で素指数が一致すること、
両方の乗根列がそれぞれ定数列として収束すること、そして二つの極限値 `1` と `r` が
異なることを示す。
-/
import Ising3DCut.LimitQuantity.PositiveRealRootUnique
import Mathlib.Topology.Instances.Real.Lemmas
import Mathlib.NumberTheory.Padics.PadicVal.Basic

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- 人手証明の「`S` は有限集合なので `S` に属さない素数 `r` が存在する」の段。 -/
theorem exists_prime_not_mem (S : Finset ℕ) : ∃ r : ℕ, r.Prime ∧ r ∉ S := by
  obtain ⟨r, hr, hrp⟩ := Nat.exists_infinite_primes (S.sup id + 1)
  refine ⟨r, hrp, fun hmem => ?_⟩
  have hle : r ≤ S.sup id := Finset.le_sup (f := id) hmem
  omega

/-- 人手証明の「`p ∈ S` では `v_p(A L) = v_p(B L) = 0`」の段。 -/
theorem padicValRat_prime_ne (p r : ℕ) (hp : p.Prime) (hr : r.Prime) (hne : p ≠ r) :
    padicValRat p (r : ℚ) = 0 := by
  have : padicValNat p r = 0 :=
    padicValNat.eq_zero_of_not_dvd (fun hdvd => hne ((Nat.prime_dvd_prime_iff_eq hp hr).1 hdvd))
  simpa [padicValRat.of_nat] using congrArg (fun n : ℕ => (n : ℤ)) this

/-- 素数からなる任意の有限集合 `S` について、`S` での素指数が全ての添字で一致するのに
二つの乗根列の極限が異なる例がある。 -/
theorem finitely_many_primes_are_not_sufficient_for_limit_quantity (S : Finset ℕ)
    (hS : ∀ p ∈ S, p.Prime) :
    ∃ (A B : ℕ → ℚ) (N : ℕ → ℕ) (r : ℕ) (ℓ ℓ' : ℝ),
      r.Prime ∧ r ∉ S ∧
      (∀ L, 0 < A L) ∧ (∀ L, 0 < B L) ∧ (∀ L, N L ≠ 0) ∧
      (∀ L, ∀ p ∈ S, padicValRat p (A L) = padicValRat p (B L)) ∧
      (∀ L, padicValRat r (A L) ≠ padicValRat r (B L)) ∧
      Tendsto (fun L => posRoot ((A L : ℝ)) (N L)) atTop (𝓝 ℓ) ∧
      Tendsto (fun L => posRoot ((B L : ℝ)) (N L)) atTop (𝓝 ℓ') ∧ ℓ ≠ ℓ' := by
  obtain ⟨r, hrp, hrS⟩ := exists_prime_not_mem S
  have hr1 : (1 : ℝ) < (r : ℝ) := by
    have : (1 : ℕ) < r := hrp.one_lt
    exact_mod_cast this
  have hrpos : (0 : ℚ) < (r : ℚ) := by
    have : (0 : ℕ) < r := hrp.pos
    exact_mod_cast this
  refine ⟨fun _ => 1, fun _ => (r : ℚ), fun _ => 1, r, 1, (r : ℝ),
    hrp, hrS, fun _ => one_pos, fun _ => hrpos, fun _ => one_ne_zero, ?_, ?_, ?_, ?_,
    ne_of_lt hr1⟩
  · -- 人手証明の「`p ∈ S` では両方の素指数が 0 で一致する」の段。
    intro _ p hp
    rw [padicValRat.one, padicValRat_prime_ne p r (hS p hp) hrp (fun h => hrS (h ▸ hp))]
  · -- 人手証明の「`r` での素指数は一致しない（落ちる情報の所在）」の段。
    intro _
    rw [padicValRat.one]
    have : padicValNat r r = 1 := padicValNat.self hrp.one_lt
    simp [padicValRat.of_nat, this]
  · -- 人手証明の「`a` は定数列 1 なので箱サイズ極限は 1」の段。
    have hfun : (fun _ : ℕ => posRoot ((1 : ℚ) : ℝ) 1) = fun _ : ℕ => (1 : ℝ) := by
      funext L
      have hcast : (((1 : ℚ) : ℝ)) = (1 : ℝ) := by norm_num
      rw [hcast]
      exact (eq_posRoot_of_pow_eq 1 1 one_pos one_pos 1 one_ne_zero (by norm_num)).symm
    rw [hfun]
    exact tendsto_const_nhds
  · -- 人手証明の「`b` は定数列 r なので箱サイズ極限は r」の段。
    have hrR : (0 : ℝ) < (r : ℝ) := lt_trans one_pos hr1
    have hfun : (fun _ : ℕ => posRoot (((r : ℚ) : ℝ)) 1) = fun _ : ℕ => (r : ℝ) := by
      funext L
      have hcast : (((r : ℚ) : ℝ)) = (r : ℝ) := by push_cast; ring
      rw [hcast]
      exact (eq_posRoot_of_pow_eq (r : ℝ) (r : ℝ) hrR hrR 1 one_ne_zero (by norm_num)).symm
    rw [hfun]
    exact tendsto_const_nhds

end Ising3DCut.LimitQuantity
