/-
具体版が必要十分版の特殊化として得られることの明示。

共通データを一辺 2 の分配多項式、二点データを隣接点対と対角点対の
符号付き多項式、係数写像を多項式の係数に取る。四つの有限な数え上げと
係数の差の等式だけを必要十分版へ渡す。

住処: `Fin 2`、`Bool`、`Nat`、`Int`、整数係数多項式、有限型のみ。ℝ / ℂ は現れない。
-/
import Ising3DCut.NullModel.SamePartitionDifferentPairData
import Ising3DCut.NecSuf.NullModel.SamePartitionDifferentPairData

namespace Ising3DCut.NullModel

/-- `claim_same_partition_different_pair_data` の具体版を必要十分版から導いたもの。 -/
theorem same_partition_different_pairData_from_necSuf :
    cubeTwoPartitionPolynomial = cubeTwoPartitionPolynomial ∧
    (cubeTwoPairPolynomial adjacentAgree).coeff 4 = 10 ∧
    (cubeTwoPairPolynomial diagonalAgree).coeff 4 = -6 ∧
    cubeTwoPairPolynomial adjacentAgree ≠ cubeTwoPairPolynomial diagonalAgree := by
  exact NecSuf.NullModel.same_partition_different_pairData
    cubeTwoPartitionPolynomial
    (cubeTwoPairPolynomial adjacentAgree)
    (cubeTwoPairPolynomial diagonalAgree)
    (fun polynomial degree ↦ polynomial.coeff degree)
    (pairAgreeCount adjacentAgree 4)
    (pairDisagreeCount adjacentAgree 4)
    (pairAgreeCount diagonalAgree 4)
    (pairDisagreeCount diagonalAgree 4)
    adjacent_counts_at_four.1
    adjacent_counts_at_four.2
    diagonal_counts_at_four.1
    diagonal_counts_at_four.2
    (cubeTwoPairPolynomial_coeff adjacentAgree 4 (by omega))
    (cubeTwoPairPolynomial_coeff diagonalAgree 4 (by omega))

end Ising3DCut.NullModel
