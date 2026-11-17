/-
「正錐の元を係数とする平方和の全体は前錐である」の必要十分版。

具体版の証明が係数の集合 `C` について使うのは、単位元を含むこと（平方の条件）と積で閉じること
（積の条件）と `E` に含まれること（`E` への包含）だけである。`C` の和の閉性と三分法は使わない
（具体版では三分法は単位元の所属を出すためだけに使う。導出版がその段を受け持つ）。
`E` については、零元（空の和）・単位元を含み和と積で閉じることだけを使い、逆元・符号反転は使わない。
積の並べ替えに乗法の交換則を使うので可換半環が要る。
-/
import Ising2DLambda.NecSuf.FisherZero.SubfieldPrecone
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.BigOperators.Fin

namespace Ising2DLambda.NecSuf.FisherZero

/-- 有限集合で添字付けた `∑ i, c i * (y i * y i)`（`c i ∈ C`、`y i ∈ E`）の全体。 -/
def weightedSquareSums {K : Type*} [CommSemiring K] (E C : Set K) : Set K :=
  {z | ∃ (ι : Type) (_ : Fintype ι) (c : ι → K) (y : ι → K),
    (∀ i, c i ∈ C) ∧ (∀ i, y i ∈ E) ∧ z = ∑ i, c i * (y i * y i)}

/-- 具体版と同じ段（`E` への包含、和、積、平方、`C` の包含）で示す。 -/
theorem weightedSquareSums_isPreconeOn_necSuf {K : Type*} [CommSemiring K] (E C : Set K)
    (hE0 : (0 : K) ∈ E) (hE1 : (1 : K) ∈ E)
    (hEadd : ∀ x y : K, x ∈ E → y ∈ E → x + y ∈ E)
    (hEmul : ∀ x y : K, x ∈ E → y ∈ E → x * y ∈ E)
    (hCE : ∀ c : K, c ∈ C → c ∈ E) (hC1 : (1 : K) ∈ C)
    (hCmul : ∀ x y : K, x ∈ C → y ∈ C → x * y ∈ C) :
    IsPreconeOn E C (weightedSquareSums E C) := by
  refine ⟨?_, ?_, ?_, ?_, ?_⟩
  · rintro z ⟨ι, _, c, y, hc, hy, rfl⟩
    -- 有限和が E に入ることを、添字の有限集合についての帰納法で示す
    have key : ∀ s : Finset ι, ∑ i ∈ s, c i * (y i * y i) ∈ E := by
      intro s
      classical
      induction s using Finset.induction_on with
      | empty => rw [Finset.sum_empty]; exact hE0
      | insert a s ha ih =>
        rw [Finset.sum_insert ha]
        exact hEadd _ _ (hEmul _ _ (hCE _ (hc a)) (hEmul _ _ (hy a) (hy a))) ih
    exact key Finset.univ
  · rintro z1 z2 ⟨ι, _, c, y, hc, hy, rfl⟩ ⟨κ, _, d, w, hd, hw, rfl⟩
    refine ⟨ι ⊕ κ, inferInstance, Sum.elim c d, Sum.elim y w, ?_, ?_, ?_⟩
    · rintro (i | j)
      · exact hc i
      · exact hd j
    · rintro (i | j)
      · exact hy i
      · exact hw j
    · rw [Fintype.sum_sum_type]
      rfl
  · rintro z1 z2 ⟨ι, _, c, y, hc, hy, rfl⟩ ⟨κ, _, d, w, hd, hw, rfl⟩
    refine ⟨ι × κ, inferInstance, fun p => c p.1 * d p.2, fun p => y p.1 * w p.2,
      fun p => hCmul _ _ (hc p.1) (hd p.2), fun p => hEmul _ _ (hy p.1) (hw p.2), ?_⟩
    calc (∑ i, c i * (y i * y i)) * (∑ j, d j * (w j * w j))
        = ∑ i, ∑ j, (c i * (y i * y i)) * (d j * (w j * w j)) := Finset.sum_mul_sum _ _ _ _
      _ = ∑ p : ι × κ, (c p.1 * (y p.1 * y p.1)) * (d p.2 * (w p.2 * w p.2)) :=
          (Fintype.sum_prod_type' _).symm
      _ = ∑ p : ι × κ, (c p.1 * d p.2) * ((y p.1 * w p.2) * (y p.1 * w p.2)) := by
          refine Finset.sum_congr rfl fun p _ => ?_
          ring
  · intro y hy
    refine ⟨Unit, inferInstance, fun _ => 1, fun _ => y, fun _ => hC1, fun _ => hy, ?_⟩
    rw [Fintype.sum_unique, one_mul]
  · intro c hc
    refine ⟨Unit, inferInstance, fun _ => c, fun _ => 1, fun _ => hc, fun _ => hE1, ?_⟩
    rw [Fintype.sum_unique, mul_one, mul_one]

end Ising2DLambda.NecSuf.FisherZero
