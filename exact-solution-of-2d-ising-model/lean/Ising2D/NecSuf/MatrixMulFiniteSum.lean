/-
# 行列の有限和を右の因子とする積は各項の積の有限和（必要十分版）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimFiniteSumOfMatricesDistributesInRightFactor.lean`
（人手 `finite_sum_of_matrices_distributes_in_right_factor`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimFiniteSumOfMatricesDistributesInRightFactorFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `mul_finite_sum_of_matrices`（`r + 1` 項の帰納法。`r = 0` は有限和の定義 → 有限和の定義（項 `CX_j`）を右辺から左辺へ。帰納の段は有限和の定義 → 積の右の因子の和への分配 → 帰納法の仮定 → 有限和の定義（項 `CX_j`）を右辺から左辺へ） | `mul_finite_sum_matrix'`（同じ並び） |

## 何が効いているか / 効いていないか

- 効いているのは、行列の積が右の因子の和に分配すること（`mul_add_matrix'`。係数の**左分配則** `LeftDistribClass` と、積の中の
  有限和を二つに分けるための加法の結合則・交換則）と、有限和の定義（左から足す）だけである。
- `AddCommMonoid` は、積の中の有限和（`Matrix` の積の定義）と、mathlib の `Finset.sum` を人手の左から足す有限和の定義の代わりに
  使うために要る（`Fin.sum_univ_one`・`Fin.sum_univ_castSucc` の証明は加法の結合則・交換則に依る）。
- **乗法の結合則・単位元・可換則、加法の逆元、`x * 0 = 0` は効いていない**（`Mul` だけを仮定した）。
- 縮める添字が有限であること（`Fintype κ`）だけが積の定義のために効く。複素数であること、体であることは効いていない。
- 左の因子の和への分配（`finite_sum_mul_matrix'`、`NecSuf/FiniteSumMulMatrix.lean`）とは、効く分配則が左右で入れ替わるだけである。
-/
import Ising2D.NecSuf.MatMulDistribSum

namespace Ising2D.NecSuf

open Matrix

variable {ι κ μ : Type*}

/-- **`C(Σ_{j=1}^{r+1} X_j) = Σ_{j=1}^{r+1} (CX_j)`**（具体版 `mul_finite_sum_of_matrices`）。`r` についての帰納法。 -/
theorem mul_finite_sum_matrix' {R : Type*} [AddCommMonoid R] [Mul R] [LeftDistribClass R] [Fintype κ]
    (C : Matrix ι κ R) :
    ∀ (r : ℕ) (X : Fin (r + 1) → Matrix κ μ R), C * (∑ j, X j) = ∑ j, C * X j
  | 0, X =>
    calc C * (∑ j : Fin 1, X j)
        = C * X 0 := by rw [Fin.sum_univ_one]                                 -- 有限和の定義（1 項）
      _ = ∑ j : Fin 1, C * X j := (Fin.sum_univ_one (fun j => C * X j)).symm  -- 有限和の定義（項 `CX_j`）を右辺から左辺へ
  | r + 1, X =>
    calc C * (∑ j : Fin (r + 2), X j)
        = C * ((∑ j : Fin (r + 1), X j.castSucc) + X (Fin.last _)) := by
          rw [Fin.sum_univ_castSucc X]                                        -- 有限和の定義（項を 1 つ足す）
      _ = C * (∑ j : Fin (r + 1), X j.castSucc) + C * X (Fin.last _) :=
          mul_add_matrix' _ _ _                                               -- 積は右の因子の和に分配する
      _ = (∑ j : Fin (r + 1), C * X j.castSucc) + C * X (Fin.last _) := by
          rw [mul_finite_sum_matrix' C r (fun j => X j.castSucc)]             -- 帰納法の仮定
      _ = ∑ j : Fin (r + 2), C * X j :=
          (Fin.sum_univ_castSucc (fun j => C * X j)).symm                     -- 有限和の定義（項 `CX_j`）を右辺から左辺へ

end Ising2D.NecSuf
