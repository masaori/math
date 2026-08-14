/-
具体版が必要十分版の特殊化として得られることの明示。

有限型を配位、重みを破れ数、全体数を辺の個数、係数環を ℤ に取る。
分配多項式と水準多項式の一致は「分配多項式の 1 での値」の導出で示した等式を使い、
破れ数の上界だけを必要十分版へ渡す。

住処: `Fin`、`Nat`、`Int`、整数係数多項式、有限型のみ。ℝ / ℂ は現れない。
-/
import Ising3DCut.NullModel.PartitionCoefficientsNonnegative
import Ising3DCut.NullModel.PartitionValueAtOneFromNecSuf
import Ising3DCut.NecSuf.NullModel.PartitionCoefficientsNonnegative

namespace Ising3DCut.NullModel

noncomputable section

/-- `claim_partition_coefficients_nonnegative` の具体版を必要十分版から導いたもの。 -/
theorem partitionPolynomial_coeff_nonnegative_from_necSuf (L m : ℕ)
    (hm : m ≤ Fintype.card (Edge L)) :
    0 ≤ (partitionPolynomial L).coeff m := by
  rw [partitionPolynomial_eq_levelPolynomial]
  exact NecSuf.NullModel.levelPolynomial_coeff_nonnegative
    (brokenCount (L := L)) (Fintype.card (Edge L)) m hm

end

end Ising3DCut.NullModel
