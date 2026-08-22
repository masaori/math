/-
「有限個の添字でしか成り立たない交差べき等式は箱サイズ極限の一致に十分でない」の
Lean 必要十分版からの導出。

具体版が正の実数と乗根を使う理由は、交差べき等式を乗根列の一致へ翻訳する段だけである。
その翻訳を各添字で済ませたうえで、一致する添字が共終でないことと二つの列の収束は
必要十分版（位相空間と二点の相異だけを仮定する）へ渡す。
-/
import Ising3DCut.NecSuf.FinitelyManyAgreementsNotSufficient
import Ising3DCut.LimitQuantity.FinitelyManyCrossPowerEqualitiesNotSufficient

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- 具体版は、交差べき等式から乗根列の一致への各添字での翻訳を与えたうえで、
必要十分版へ渡す特殊化として導出できる。 -/
theorem finitely_many_cross_power_equalities_are_not_sufficient_for_limit_quantity_fromNecSuf :
    ∃ (A B : ℕ → ℝ) (N M : ℕ → ℕ) (ℓ ℓ' : ℝ),
      (∀ L, 0 < A L) ∧ (∀ L, 0 < B L) ∧ (∀ L, N L ≠ 0) ∧ (∀ L, M L ≠ 0) ∧
      (∃ L, A L ^ M L = B L ^ N L) ∧
      (¬ ∀ L1 : ℕ, ∃ L : ℕ, L1 ≤ L ∧ A L ^ M L = B L ^ N L) ∧
      Tendsto (fun L => posRoot (A L) (N L)) atTop (𝓝 ℓ) ∧
      Tendsto (fun L => posRoot (B L) (M L)) atTop (𝓝 ℓ') ∧ ℓ ≠ ℓ' := by
  -- 必要十分版へ渡す二つの列（具体版と同じ `A ≡ 1`, `B 0 = 1`, `B L = 2`）。
  set x : ℕ → ℝ := fun _ => posRoot (1 : ℝ) 1 with hx_def
  set y : ℕ → ℝ := fun L => posRoot (if L = 0 then (1 : ℝ) else 2) 1 with hy_def
  have hx : ∀ L, x L = 1 := fun _ => posRoot_one_one
  have hy0 : y 0 = 1 := by simp [hy_def, posRoot_one_one]
  have hy : ∀ L, L ≠ 0 → y L = 2 := by
    intro L hL
    simp [hy_def, hL, posRoot_two_one]
  obtain ⟨_, hNotCofinal, hTendstoX, hTendstoY⟩ :=
    NecSuf.finitely_many_agreements_are_not_sufficient_abstract
      (1 : ℝ) 2 (by norm_num) x y hx hy0 hy
  refine ⟨fun _ => 1, fun L => if L = 0 then 1 else 2, fun _ => 1, fun _ => 1, 1, 2,
    fun _ => one_pos, ?_, fun _ => one_ne_zero, fun _ => one_ne_zero, ⟨0, by norm_num⟩,
    ?_, hTendstoX, hTendstoY, by norm_num⟩
  · intro L
    by_cases hL : L = 0 <;> simp [hL]
  · -- 各添字で交差べき等式を乗根列の一致へ翻訳し、必要十分版の結論へ帰着する。
    intro h
    refine hNotCofinal ?_
    intro L1
    obtain ⟨L, hL, hEq⟩ := h L1
    refine ⟨L, hL, ?_⟩
    have hval : (1 : ℝ) = if L = 0 then (1 : ℝ) else 2 := by simpa using hEq
    rw [hx_def, hy_def]
    exact congrArg (fun t : ℝ => posRoot t 1) hval

end Ising3DCut.LimitQuantity
