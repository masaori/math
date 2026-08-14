/-
具体版が必要十分版の特殊化として得られることの明示。

有限型を配位、重みを破れ数、全体数を辺の個数、係数環を ℤ に取る。
分配多項式が水準多項式のこの特殊化と一致することを係数ごとに確かめ、
重みの上界（破れ数は辺の個数以下）だけを必要十分版へ渡す。
最終行の `#Σ_L = 2^(#V_L)` は具体版の数え上げ補題で特殊化する。

住処: `Fin`、`Nat`、`Int`、整数係数多項式、有限型のみ。ℝ / ℂ は現れない。
-/
import Ising3DCut.NullModel.PartitionValueAtOne
import Ising3DCut.NecSuf.NullModel.PartitionValueAtOne

namespace Ising3DCut.NullModel

noncomputable section

/-- 多重度は、破れ数を重みとする水準集合の元の個数である（定義の一致）。 -/
lemma multiplicity_eq_card_fiber (L m : ℕ) :
    multiplicity L m =
      Fintype.card (NecSuf.NullModel.Fiber (brokenCount (L := L)) m) := by
  rw [multiplicity]
  exact Fintype.card_congr (Equiv.refl _)

/-- 分配多項式は水準多項式の特殊化である（係数ごとに一致）。 -/
lemma partitionPolynomial_eq_levelPolynomial (L : ℕ) :
    partitionPolynomial L =
      NecSuf.NullModel.levelPolynomial (R := ℤ)
        (brokenCount (L := L)) (Fintype.card (Edge L)) := by
  rw [partitionPolynomial, NecSuf.NullModel.levelPolynomial]
  apply Finset.sum_congr rfl
  intro m _
  rw [multiplicity_eq_card_fiber]

/-- `claim_partition_value_at_one` の具体版を必要十分版から導いたもの。 -/
theorem partitionPolynomial_value_at_one_from_necSuf (L : ℕ) :
    (partitionPolynomial L).eval 1 = (2 ^ Fintype.card (Site L) : ℤ) := by
  rw [partitionPolynomial_eq_levelPolynomial]
  rw [NecSuf.NullModel.levelPolynomial_value_at_one
    (brokenCount (L := L)) (Fintype.card (Edge L))
    (fun σ => Finset.card_le_card (Finset.filter_subset _ _))]
  rw [config_card_eq_two_pow_site_card]
  norm_cast

end

end Ising3DCut.NullModel
