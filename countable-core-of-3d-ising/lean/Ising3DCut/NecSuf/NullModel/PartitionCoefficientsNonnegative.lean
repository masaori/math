/-
「分配多項式の各係数は非負である」の必要十分版。

具体版の証明で使う性質だけを残す。

  使っている性質                         なぜ削れないか
  `Fintype α`                            水準集合の元の個数を係数にするため。
  `weight : α → ℕ` と自然数 `total`      有限個の水準を添字づけるため。
  `m ≤ total`                            係数を取る次数が有限和の範囲内にあるため。
  係数環が `Semiring R`                   係数写像の有限和への加法性と
                                         自然数からの係数の埋め込みに要るため。
  係数環を `ℤ` に特殊化した順序           「非負」という結論を述べるため。

点・辺・値 ±1・破れ数の定義は使わない。証明手順は具体版と同じ
（係数写像を有限和へ適用し、単項式の係数をクロネッカーのデルタへ直し、
範囲内の一項だけを残す）。

住処: 任意の有限型・自然数・任意の半環上の多項式、および非負性を述べる行だけ整数。
ℝ / ℂ は現れない。
-/
import Mathlib.Algebra.Polynomial.Coeff
import Ising3DCut.NecSuf.NullModel.PartitionValueAtOne

namespace Ising3DCut.NecSuf.NullModel

variable {α : Type*} [Fintype α]

noncomputable section

/-- 具体版の最初の二行と同じ。係数写像を有限和の各単項式へ適用する。 -/
lemma levelPolynomial_coeff_eq_delta_sum {R : Type*} [Semiring R]
    (weight : α → ℕ) (total m : ℕ) :
    (levelPolynomial (R := R) weight total).coeff m =
      ∑ r ∈ Finset.range (total + 1),
        if r = m then (Fintype.card (Fiber weight r) : R) else 0 := by
  rw [levelPolynomial]
  rw [Polynomial.finsetSum_coeff]
  simp only [Polynomial.coeff_monomial]

/-- 具体版の三行目と同じ。範囲内の次数では一つの水準集合の個数だけが残る。 -/
lemma levelPolynomial_coeff_eq_card {R : Type*} [Semiring R]
    (weight : α → ℕ) (total m : ℕ) (hm : m ≤ total) :
    (levelPolynomial (R := R) weight total).coeff m =
      (Fintype.card (Fiber weight m) : R) := by
  rw [levelPolynomial_coeff_eq_delta_sum]
  simp [Finset.sum_ite_eq', Finset.mem_range, hm]

/-- 必要十分版の主定理。水準多項式の範囲内の各係数は非負である。 -/
theorem levelPolynomial_coeff_nonnegative (weight : α → ℕ) (total m : ℕ)
    (hm : m ≤ total) :
    0 ≤ (levelPolynomial (R := ℤ) weight total).coeff m := by
  rw [levelPolynomial_coeff_eq_card weight total m hm]
  exact Int.natCast_nonneg (Fintype.card (Fiber weight m))

end

end Ising3DCut.NecSuf.NullModel
