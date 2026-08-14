/-
「分配多項式の 1 での値は配位の個数である」の必要十分版。

具体版の証明で使う性質だけを残す。

  使っている性質                         なぜ削れないか
  `Fintype α`                            水準集合と全体の元の個数を数えるため。
  `∀ a, weight a ≤ total`                すべての元がいずれかの水準集合に入る
                                         （和の範囲が全体を覆う）ため。
  係数環が `Semiring R`                   多項式環と `ℕ` からの係数の埋め込み、
                                         `1 ^ m = 1` と和の評価に加法・乗法・単位が要るため。
                                         減法は使わないので `ℤ` は本質的でない。

証明手順は具体版と同じ（多項式へ 1 を代入して係数の有限和にし、
重みによる水準集合の分割で和を全体の個数へ等置する）。
具体版の最終行 `#Σ_L = 2^(#V_L)` は配位の定義そのものの数え上げであり、
この抽象では全体の個数 `Fintype.card α` のまま述べる（導出側で特殊化する）。

住処: 任意の有限型・自然数・任意の半環上の多項式のみ。ℝ / ℂ は現れない。
-/
import Mathlib.Algebra.Polynomial.Eval.Defs
import Mathlib.Data.Fintype.BigOperators
import Ising3DCut.NecSuf.NullModel.MultiplicityPalindrome

namespace Ising3DCut.NecSuf.NullModel

variable {α : Type*} [Fintype α] {R : Type*} [Semiring R]

noncomputable section

/-- 重みの水準集合の元の個数を係数とする多項式
`P(X) = Σ_{m=0}^{total} #(weight⁻¹ m) X^m`。 -/
def levelPolynomial (weight : α → ℕ) (total : ℕ) : Polynomial R :=
  ∑ m ∈ Finset.range (total + 1),
    Polynomial.monomial m ((Fintype.card (Fiber weight m) : R))

/-- 具体版の最初の二行と同じ。多項式へ 1 を代入すると水準集合の個数の有限和になる。 -/
lemma levelPolynomial_eval_one (weight : α → ℕ) (total : ℕ) :
    (levelPolynomial (R := R) weight total).eval 1 =
      ∑ m ∈ Finset.range (total + 1), (Fintype.card (Fiber weight m) : R) := by
  rw [levelPolynomial, Polynomial.eval_finsetSum]
  simp only [Polynomial.eval_monomial, one_pow, mul_one]

/-- 具体版の三行目と同じ。重みが `total` 以下なら、水準集合は全体を重複なく分割する。 -/
lemma sum_card_fiber_eq_card (weight : α → ℕ) (total : ℕ)
    (hw : ∀ a, weight a ≤ total) :
    ∑ m ∈ Finset.range (total + 1), Fintype.card (Fiber weight m) =
      Fintype.card α := by
  have hmaps :
      Set.MapsTo weight
        (↑(Finset.univ : Finset α) : Set α)
        (↑(Finset.range (total + 1)) : Set ℕ) := by
    intro a _
    rw [Finset.mem_coe, Finset.mem_range]
    exact Nat.lt_succ_of_le (hw a)
  have hpartition := Finset.card_eq_sum_card_fiberwise
    (f := weight) (s := (Finset.univ : Finset α))
    (t := Finset.range (total + 1)) hmaps
  have hlevel (m : ℕ) :
      Fintype.card (Fiber weight m) = (fiberFinset weight m).card :=
    Fintype.card_of_subtype (fiberFinset weight m) (fun _ => Iff.rfl)
  simp_rw [hlevel]
  simpa [fiberFinset] using hpartition.symm

/-- 必要十分版の主定理。水準多項式の 1 での値は全体の元の個数である。 -/
theorem levelPolynomial_value_at_one (weight : α → ℕ) (total : ℕ)
    (hw : ∀ a, weight a ≤ total) :
    (levelPolynomial (R := R) weight total).eval 1 = (Fintype.card α : R) := by
  rw [levelPolynomial_eval_one, ← Nat.cast_sum]
  rw [sum_card_fiber_eq_card weight total hw]

end

end Ising3DCut.NecSuf.NullModel
