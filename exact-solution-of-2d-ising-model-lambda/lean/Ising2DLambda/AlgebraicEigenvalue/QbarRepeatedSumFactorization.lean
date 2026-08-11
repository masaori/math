/-
「同じ元の有限和は、単位元の有限和との積である」の具体版。
人手証明と 1 対 1 に対応させる。

  人手証明                                      このファイル
  空の有限和は 0                               `Finset.sum_empty`
  0 = 0 * a                                    `zero_mul`
  n+1 個の和から最後の項を分ける               `Finset.sum_range_succ`
  帰納法の仮定                                  `ih`
  a = 1 * a                                    `one_mul`
  右分配則                                      `add_mul`
  最後の 1 を有限和へ戻す                       `Finset.sum_range_succ`

有限和と積の分配をまとめた既製定理へは委ねない。
住処: Qbar。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnity

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 同じ代数的数の有限和は、1 の有限和との積である
（`claim_qbar_repeated_sum_factorization`）。 -/
theorem qbarRepeatedSumFactorization (a : Qbar) : ∀ n : ℕ,
    (∑ _i ∈ Finset.range n, a) = (∑ _i ∈ Finset.range n, (1 : Qbar)) * a := by
  intro n
  induction n with
  | zero =>
      calc
        (∑ _i ∈ Finset.range 0, a) = 0 := by rw [Finset.range_zero, Finset.sum_empty]
        _ = 0 * a := (zero_mul a).symm
        _ = (∑ _i ∈ Finset.range 0, (1 : Qbar)) * a := by
              rw [Finset.range_zero, Finset.sum_empty]
  | succ n ih =>
      calc
        (∑ _i ∈ Finset.range (n + 1), a) = (∑ _i ∈ Finset.range n, a) + a := by
              rw [Finset.sum_range_succ]
        _ = (∑ _i ∈ Finset.range n, (1 : Qbar)) * a + a := by rw [ih]
        _ = (∑ _i ∈ Finset.range n, (1 : Qbar)) * a + 1 * a := by rw [one_mul]
        _ = ((∑ _i ∈ Finset.range n, (1 : Qbar)) + 1) * a := (add_mul _ _ _).symm
        _ = (∑ _i ∈ Finset.range (n + 1), (1 : Qbar)) * a := by
              rw [Finset.sum_range_succ]

end Ising2DLambda.AlgebraicEigenvalue
