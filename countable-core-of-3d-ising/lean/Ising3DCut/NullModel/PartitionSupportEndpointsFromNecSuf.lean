/-
具体版が必要十分版の特殊化として得られることの明示。

有限型を配位、重みを破れ数、全体数を辺の個数に取る。定数二配位と
その奇数側反転像から得た両端の多重度の下界だけを必要十分版へ渡す。

住処: `Fin`、`Nat`、`Int`、整数係数多項式、有限型のみ。ℝ / ℂ は現れない。
-/
import Ising3DCut.NullModel.PartitionSupportEndpoints
import Ising3DCut.NullModel.PartitionValueAtOneFromNecSuf
import Ising3DCut.NecSuf.NullModel.PartitionSupportEndpoints

namespace Ising3DCut.NullModel

noncomputable section

/-- `claim_partition_support_endpoints` の具体版を必要十分版から導いたもの。 -/
theorem partitionPolynomial_support_endpoints_from_necSuf {L : ℕ} (hL : 2 ≤ L) :
    (partitionPolynomial L).coeff 0 = (multiplicity L 0 : ℤ) ∧
    2 ≤ multiplicity L 0 ∧
    (partitionPolynomial L).coeff (Fintype.card (Edge L)) =
      (multiplicity L (Fintype.card (Edge L)) : ℤ) ∧
    2 ≤ multiplicity L (Fintype.card (Edge L)) ∧
    ∀ m, Fintype.card (Edge L) < m → (partitionPolynomial L).coeff m = 0 := by
  rw [partitionPolynomial_eq_levelPolynomial]
  exact NecSuf.NullModel.levelPolynomial_support_endpoints
    (brokenCount (L := L)) (Fintype.card (Edge L))
    (two_le_multiplicity_zero (Nat.zero_lt_of_lt hL))
    (two_le_multiplicity_full (Nat.zero_lt_of_lt hL))

end

end Ising3DCut.NullModel
