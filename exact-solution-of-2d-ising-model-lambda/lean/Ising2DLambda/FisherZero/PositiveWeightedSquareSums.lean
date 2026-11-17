/-
人手証明の定義「正錐の元を係数とする平方和」（ラベル `def_positive_weighted_square_sums`）と、
主張「正錐の元を係数とする平方和の全体は前錐である」
（ラベル `claim_positive_weighted_square_sums_is_precone`）の具体版。

添字の有限集合は、本文と同じく任意の有限集合（Lean では `Fintype` を持つ型）で取る。
住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.SubfieldPrecone
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.BigOperators.Fin

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `def_positive_weighted_square_sums` の具体版。有限集合 `ι` と写像 `c : ι → CF`、`y : ι → E` による
`∑ i, c i * (y i * y i)` の形の元の全体。`ι` が空なら和は零元である。 -/
def positiveWeightedSquareSums (E : Subfield Qbar) (CF : Set Qbar) : Set Qbar :=
  {z | ∃ (ι : Type) (_ : Fintype ι) (c : ι → Qbar) (y : ι → Qbar),
    (∀ i, c i ∈ CF) ∧ (∀ i, y i ∈ E) ∧ z = ∑ i, c i * (y i * y i)}

/-- 本文の証明の最初の段: 部分体の正錐は単位元を含む（三分法と積の条件から）。 -/
theorem one_mem_of_isSubfieldPositiveCone (F : Subfield Qbar) (CF : Set Qbar)
    (hCF : IsSubfieldPositiveCone F CF) : (1 : Qbar) ∈ CF := by
  obtain ⟨hone, _⟩ := hCF.trichotomy 1 F.one_mem
  rcases hone with h0 | h1 | hm1
  · exact absurd h0 one_ne_zero
  · exact h1
  · -- 1 = (-1)·(-1) ∈ CF（積の条件）
    have h := hCF.mul_mem _ _ hm1 hm1
    rw [neg_mul_neg, mul_one] at h
    exact h

/-- `claim_positive_weighted_square_sums_is_precone` の具体版。本文の段
（単位元の所属、`E` への包含、和、積、平方、正錐の包含）の順に示す。 -/
theorem positiveWeightedSquareSums_isSubfieldPrecone (F E : Subfield Qbar) (CF : Set Qbar)
    (hFE : ∀ z : Qbar, z ∈ F → z ∈ E) (hCF : IsSubfieldPositiveCone F CF) :
    IsSubfieldPrecone F E CF (positiveWeightedSquareSums E CF) := by
  have h1 : (1 : Qbar) ∈ CF := one_mem_of_isSubfieldPositiveCone F CF hCF
  refine ⟨hFE, hCF, ?_, ?_, ?_, ?_, ?_⟩
  · -- E への包含: 各項 c i * (y i * y i) が E の元（本文の三行）で、
    -- E は零元を含み和で閉じるので、添字の有限集合の元の個数についての帰納法で和も E の元
    rintro z ⟨ι, _, c, y, hc, hy, rfl⟩
    have hterm : ∀ i, c i * (y i * y i) ∈ E := fun i =>
      E.mul_mem (hFE _ (hCF.subset _ (hc i))) (E.mul_mem (hy i) (hy i))
    have key : ∀ s : Finset ι, ∑ i ∈ s, c i * (y i * y i) ∈ E := by
      intro s
      classical
      induction s using Finset.induction_on with
      | empty => rw [Finset.sum_empty]; exact E.zero_mem
      | insert a s ha ih =>
        rw [Finset.sum_insert ha]
        exact E.add_mem (hterm a) ih
    exact key Finset.univ
  · -- 和で閉じること: 添字集合を互いに素な和 ι ⊕ κ に取る
    rintro z1 z2 ⟨ι, _, c, y, hc, hy, rfl⟩ ⟨κ, _, d, w, hd, hw, rfl⟩
    refine ⟨ι ⊕ κ, inferInstance, Sum.elim c d, Sum.elim y w, ?_, ?_, ?_⟩
    · rintro (i | j)
      · exact hc i
      · exact hd j
    · rintro (i | j)
      · exact hy i
      · exact hw j
    · rw [Fintype.sum_sum_type]
      rfl
  · -- 積で閉じること: 添字集合を直積 ι × κ に取る
    rintro z1 z2 ⟨ι, _, c, y, hc, hy, rfl⟩ ⟨κ, _, d, w, hd, hw, rfl⟩
    refine ⟨ι × κ, inferInstance, fun p => c p.1 * d p.2, fun p => y p.1 * w p.2,
      fun p => hCF.mul_mem _ _ (hc p.1) (hd p.2), fun p => E.mul_mem (hy p.1) (hw p.2), ?_⟩
    calc (∑ i, c i * (y i * y i)) * (∑ j, d j * (w j * w j))
        = ∑ i, ∑ j, (c i * (y i * y i)) * (d j * (w j * w j)) := Finset.sum_mul_sum _ _ _ _
      _ = ∑ p : ι × κ, (c p.1 * (y p.1 * y p.1)) * (d p.2 * (w p.2 * w p.2)) :=
          (Fintype.sum_prod_type' _).symm
      _ = ∑ p : ι × κ, (c p.1 * d p.2) * ((y p.1 * w p.2) * (y p.1 * w p.2)) := by
          refine Finset.sum_congr rfl fun p _ => ?_
          ring
  · -- 平方の条件: 一元の添字集合、係数 1
    intro y hy
    refine ⟨Unit, inferInstance, fun _ => 1, fun _ => y, fun _ => h1, fun _ => hy, ?_⟩
    rw [Fintype.sum_unique, one_mul]
  · -- 正錐を含むこと: 一元の添字集合、平方する元 1
    intro c hc
    refine ⟨Unit, inferInstance, fun _ => c, fun _ => 1, fun _ => hc, fun _ => E.one_mem, ?_⟩
    rw [Fintype.sum_unique, mul_one, mul_one]

end Ising2DLambda.FisherZero
