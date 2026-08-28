/-
人手証明「第二の極限量候補ではどの閾値の先にも交差冪等式の破れがある」
（ラベル `claim_second_limit_candidate_has_tail_cross_power_failure`）の Lean 必要十分版。

分配多項式・有理点・自然数乗根・実数・極限は本質ではない。証明が使うのは、
添字が自然数であること、関係が閾値以後で値の一致を導くこと、値域が有限でないことだけである。
-/
import Mathlib.Data.Set.Finite.Basic
import Mathlib.Order.Interval.Finset.Nat

namespace Ising3DCut.NecSuf

/-- 閾値以後の全ての対で関係が成り立つなら、その先で値は一定になる。 -/
theorem eq_of_forall_related_of_ge {β : Type*} (f : ℕ → β) (P : ℕ → ℕ → Prop) (T : ℕ)
    (hP : ∀ ⦃L M : ℕ⦄, T ≤ L → T ≤ M → P L M → f L = f M)
    (hall : ∀ ⦃L M : ℕ⦄, T ≤ L → T ≤ M → P L M) :
    ∀ ⦃L : ℕ⦄, T ≤ L → f L = f T :=
  fun _ hL => hP hL le_rfl (hall hL le_rfl)

/-- 閾値以後で一定な列の値域は有限である。 -/
theorem finite_range_of_eventually_constant {β : Type*} (f : ℕ → β) (T : ℕ)
    (hconstant : ∀ ⦃L : ℕ⦄, T ≤ L → f L = f T) :
    (Set.range f).Finite := by
  refine ((Set.finite_Iio T).image f |>.union (Set.finite_singleton (f T))).subset ?_
  rintro x ⟨L, rfl⟩
  by_cases hLT : L < T
  · exact Set.mem_union_left _ ⟨L, hLT, rfl⟩
  · exact Set.mem_union_right _ (by simp [hconstant (Nat.le_of_not_gt hLT)])

/-- 値域が有限でない列については、どの閾値の先にも関係を満たさない対がある。
`T0` は関係から値の一致を導けるようになる下限であり、結論の閾値はそこまで押し上げる。 -/
theorem exists_pair_not_related_of_infinite_range {β : Type*} (f : ℕ → β) (P : ℕ → ℕ → Prop)
    (T0 : ℕ) (hP : ∀ ⦃L M : ℕ⦄, T0 ≤ L → T0 ≤ M → P L M → f L = f M)
    (hinfinite : (Set.range f).Infinite) :
    ∀ K : ℕ, ∃ L M : ℕ, max K T0 ≤ L ∧ max K T0 ≤ M ∧ ¬ P L M := by
  intro K
  by_contra hfailure
  push_neg at hfailure
  have hall : ∀ ⦃L M : ℕ⦄, max K T0 ≤ L → max K T0 ≤ M → P L M := by
    intro L M hL hM
    exact hfailure L M hL hM
  have hT0 : T0 ≤ max K T0 := le_max_right _ _
  have hconstant := eq_of_forall_related_of_ge f P (max K T0)
    (fun _ _ hL hM hrel => hP (hT0.trans hL) (hT0.trans hM) hrel) hall
  exact hinfinite (finite_range_of_eventually_constant f (max K T0) hconstant)

end Ising3DCut.NecSuf
