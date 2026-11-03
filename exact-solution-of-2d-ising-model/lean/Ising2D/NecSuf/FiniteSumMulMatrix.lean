/-
# 行列の有限和を左の因子とする積は各項の積の有限和（必要十分版）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimFiniteSumOfMatricesDistributesInLeftFactor.lean`
（人手 `finite_sum_of_matrices_distributes_in_left_factor`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimFiniteSumOfMatricesDistributesInLeftFactorFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `finite_sum_mul_of_matrices`（`r + 1` 項の帰納法。`r = 0` は有限和の定義 → 有限和の定義（項 `X_jC`）を右辺から左辺へ。帰納の段は有限和の定義 → 積の和への右分配 → 帰納法の仮定 → 有限和の定義（項 `X_jC`）を右辺から左辺へ） | `finite_sum_mul_matrix'`（同じ並び） |

## 何が効いているか / 効いていないか

- 効いているのは、行列の積が左の因子の和に分配すること（`add_mul_matrix'`。係数の**右分配則** `RightDistribClass` と、積の中の
  有限和を二つに分けるための加法の結合則・交換則）と、有限和の定義（左から足す）だけである。
- `AddCommMonoid` は、積の中の有限和（`Matrix` の積の定義）と、mathlib の `Finset.sum` を人手の左から足す有限和の定義の代わりに
  使うために要る（`Fin.sum_univ_one`・`Fin.sum_univ_castSucc` の証明は加法の結合則・交換則に依る）。
- **乗法の結合則・単位元・可換則、加法の逆元、`0 * x = 0` は効いていない**（`Mul` だけを仮定した）。
- 縮める添字が有限であること（`Fintype κ`）だけが積の定義のために効く。複素数であること、体であることは効いていない。
-/
import Ising2D.NecSuf.MatMulDistribSum

namespace Ising2D.NecSuf

open Matrix

variable {ι κ μ : Type*}

/-- **`(Σ_{j=1}^{r+1} X_j)C = Σ_{j=1}^{r+1} (X_jC)`**（具体版 `finite_sum_mul_of_matrices`）。`r` についての帰納法。 -/
theorem finite_sum_mul_matrix' {R : Type*} [AddCommMonoid R] [Mul R] [RightDistribClass R] [Fintype κ]
    (C : Matrix κ μ R) :
    ∀ (r : ℕ) (X : Fin (r + 1) → Matrix ι κ R), (∑ j, X j) * C = ∑ j, X j * C
  | 0, X =>
    calc (∑ j : Fin 1, X j) * C
        = X 0 * C := by rw [Fin.sum_univ_one]                                 -- 有限和の定義（1 項）
      _ = ∑ j : Fin 1, X j * C := (Fin.sum_univ_one (fun j => X j * C)).symm  -- 有限和の定義（項 `X_jC`）を右辺から左辺へ
  | r + 1, X =>
    calc (∑ j : Fin (r + 2), X j) * C
        = ((∑ j : Fin (r + 1), X j.castSucc) + X (Fin.last _)) * C := by
          rw [Fin.sum_univ_castSucc X]                                        -- 有限和の定義（項を 1 つ足す）
      _ = (∑ j : Fin (r + 1), X j.castSucc) * C + X (Fin.last _) * C :=
          add_mul_matrix' _ _ _                                               -- 積は左の因子の和に分配する
      _ = (∑ j : Fin (r + 1), X j.castSucc * C) + X (Fin.last _) * C := by
          rw [finite_sum_mul_matrix' C r (fun j => X j.castSucc)]             -- 帰納法の仮定
      _ = ∑ j : Fin (r + 2), X j * C :=
          (Fin.sum_univ_castSucc (fun j => X j * C)).symm                     -- 有限和の定義（項 `X_jC`）を右辺から左辺へ

end Ising2D.NecSuf
