/-
「分配多項式の台の両端」の必要十分版。

具体版の証明で使う性質だけを残す。

  使っている性質                         なぜ削れないか
  `Fintype α`                            水準集合の元の個数を係数にするため。
  `weight : α → ℕ` と自然数 `total`      有限個の水準を添字づけるため。
  両端の水準集合の個数が 2 以上          両端係数が非零であるため。
  係数環を `ℤ` に特殊化                  具体版と同じ係数等式を述べるため。

点・辺・値 ±1・定数配位・二部性は仮定しない。それらは両端の水準集合に
二つの元を与える具体的な仕組みであり、必要十分版には個数の下界だけを渡す。
証明手順は具体版と同じ（両端では係数を水準集合の個数へ直し、範囲外では
有限和に該当項が無いことを使う）。

住処: 任意の有限型・自然数・整数係数多項式のみ。ℝ / ℂ は現れない。
-/
import Ising3DCut.NecSuf.NullModel.PartitionCoefficientsNonnegative

namespace Ising3DCut.NecSuf.NullModel

variable {α : Type*} [Fintype α]

noncomputable section

/-- 必要十分版の主定理。両端係数は水準集合の個数で 2 以上であり、
`total` より大きい次数の係数は 0。 -/
theorem levelPolynomial_support_endpoints (weight : α → ℕ) (total : ℕ)
    (hzero : 2 ≤ Fintype.card (Fiber weight 0))
    (hfull : 2 ≤ Fintype.card (Fiber weight total)) :
    (levelPolynomial (R := ℤ) weight total).coeff 0 =
      (Fintype.card (Fiber weight 0) : ℤ) ∧
    2 ≤ Fintype.card (Fiber weight 0) ∧
    (levelPolynomial (R := ℤ) weight total).coeff total =
      (Fintype.card (Fiber weight total) : ℤ) ∧
    2 ≤ Fintype.card (Fiber weight total) ∧
    ∀ m, total < m → (levelPolynomial (R := ℤ) weight total).coeff m = 0 := by
  refine ⟨levelPolynomial_coeff_eq_card weight total 0 (Nat.zero_le _), hzero,
    levelPolynomial_coeff_eq_card weight total total (Nat.le_refl _), hfull, ?_⟩
  intro m hm
  rw [levelPolynomial_coeff_eq_delta_sum]
  simp [Finset.sum_ite_eq', Finset.mem_range, Nat.not_lt_of_ge hm]

end

end Ising3DCut.NecSuf.NullModel
