/-
「有限個の添字でしか成り立たない交差べき等式は箱サイズ極限の一致に十分でない」の
Lean 具体版。

人手証明と 1 対 1 に対応させる。すなわち `A L = 1`, `N L = M L = 1`,
`B 0 = 1`, `B L = 2`（`L ≠ 0`）と置き、交差べき等式が成り立つ添字が `{0}` に限ること
（空でない有限集合であり共終でないこと）を場合分けで確かめ、両方の乗根列が
それぞれ定数列・添字 1 以降の定数列として収束すること、そして二つの極限値が
異なることを示す。共終性の仮定を「成り立つ添字が空でない」へ弱められないことの反例である。
-/
import Ising3DCut.LimitQuantity.PositiveRealRootUnique
import Mathlib.Topology.Instances.Real.Lemmas

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- 人手証明の `a(L)=1^{1/1}=1` の段。 -/
theorem posRoot_one_one : posRoot (1 : ℝ) 1 = 1 :=
  (eq_posRoot_of_pow_eq 1 1 one_pos one_pos 1 one_ne_zero (by norm_num)).symm

/-- 人手証明の `b(L)=2^{1/1}=2` の段。 -/
theorem posRoot_two_one : posRoot (2 : ℝ) 1 = 2 :=
  (eq_posRoot_of_pow_eq 2 2 two_pos two_pos 1 one_ne_zero (by norm_num)).symm

/-- 交差べき等式が成り立つ添字が空でない有限集合（ここでは `{0}`）でしかないとき、
二つの乗根列の極限がともに存在しても一致しないことがある。 -/
theorem finitely_many_cross_power_equalities_are_not_sufficient_for_limit_quantity :
    ∃ (A B : ℕ → ℝ) (N M : ℕ → ℕ) (ℓ ℓ' : ℝ),
      (∀ L, 0 < A L) ∧ (∀ L, 0 < B L) ∧ (∀ L, N L ≠ 0) ∧ (∀ L, M L ≠ 0) ∧
      (∃ L, A L ^ M L = B L ^ N L) ∧
      (¬ ∀ L1 : ℕ, ∃ L : ℕ, L1 ≤ L ∧ A L ^ M L = B L ^ N L) ∧
      Tendsto (fun L => posRoot (A L) (N L)) atTop (𝓝 ℓ) ∧
      Tendsto (fun L => posRoot (B L) (M L)) atTop (𝓝 ℓ') ∧ ℓ ≠ ℓ' := by
  refine ⟨fun _ => 1, fun L => if L = 0 then 1 else 2, fun _ => 1, fun _ => 1, 1, 2,
    fun _ => one_pos, ?_, fun _ => one_ne_zero, fun _ => one_ne_zero, ⟨0, by norm_num⟩,
    ?_, ?_, ?_, by norm_num⟩
  · -- 人手証明の「いずれの値も正である」の段。
    intro L
    by_cases hL : L = 0 <;> simp [hL]
  · -- 人手証明の「`L ≥ 2`（Lean では `L ≥ 1`）では交差べき等式が成り立たない」の段。
    intro h
    obtain ⟨L, hL, hEq⟩ := h 1
    have hL0 : L ≠ 0 := Nat.one_le_iff_ne_zero.mp hL
    simp [hL0] at hEq
  · -- 人手証明の「`a` は定数列 1 なので箱サイズ極限は 1」の段。
    have hfun : (fun L : ℕ => posRoot (1 : ℝ) 1) = fun _ : ℕ => (1 : ℝ) := by
      funext L
      exact posRoot_one_one
    rw [hfun]
    exact tendsto_const_nhds
  · -- 人手証明の「`b` は添字 1 以降で定数 2 なので箱サイズ極限は 2」の段。
    have hev : (fun _ : ℕ => (2 : ℝ))
        =ᶠ[atTop] fun L : ℕ => posRoot (if L = 0 then 1 else 2) 1 := by
      filter_upwards [eventually_ge_atTop 1] with L hL
      have hL0 : L ≠ 0 := Nat.one_le_iff_ne_zero.mp hL
      simp [hL0, posRoot_two_one]
    exact Tendsto.congr' hev tendsto_const_nhds

end Ising3DCut.LimitQuantity
