/-
有限積の各因子が「偶数なら一定値、奇数なら零」という二択を持つときの必要十分版。
物理固有の頂点・辺・スピンを外し、有限集合と可換半環だけを残す。

`claim_even_subgraph_spin_sum` の分配後の三段と対応する:
- `Fintype.prod_sum` で配位和を局所和の積へ分配する。
- `hlocal` で各局所和を偶奇による二択値へ置き換える。
- 全指数が偶数か否かで、一定値の積または零因子を含む積を得る。

有限和・有限積・自然数冪を使うため可換半環で足りる。体、減法、行列、スピン、格子は使わない。
-/
import Mathlib.Algebra.BigOperators.Ring.Finset

namespace Ising2DLambda.NecSuf.FisherZero

open Finset

/-- `claim_even_subgraph_spin_sum` と同じ手順から物理固有の対象を除いた必要十分版。 -/
theorem sum_product_piecewise_even_necSuf
    {V S R : Type*} [Fintype V] [DecidableEq V] [Fintype S] [CommSemiring R]
    (degree : V → ℕ) (term : V → S → R) (c : R)
    (hlocal : ∀ v : V, ∑ s : S, term v s = if Even (degree v) then c else 0) :
    (∑ σ : V → S, ∏ v : V, term v (σ v)) =
      if (∀ v : V, Even (degree v)) then c ^ Fintype.card V else 0 := by
  classical
  rw [← Fintype.prod_sum]
  simp_rw [hlocal]
  by_cases hEven : ∀ v : V, Even (degree v)
  · rw [if_pos hEven]
    simp_rw [if_pos (hEven _)]
    rw [Finset.prod_const, card_univ]
  · rw [if_neg hEven]
    push Not at hEven
    obtain ⟨v, hv⟩ := hEven
    apply Finset.prod_eq_zero (mem_univ v)
    rw [if_neg hv]

end Ising2DLambda.NecSuf.FisherZero
