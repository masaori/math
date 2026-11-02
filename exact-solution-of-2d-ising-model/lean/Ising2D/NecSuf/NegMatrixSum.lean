/-
# 行列の和・有限和の符号反転は符号反転の和・有限和に等しい（必要十分版）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimNegationDistributesOverMatrixSum.lean`
（人手 `negation_distributes_over_matrix_sum`・`finite_sum_of_negated_matrices`）。
具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimNegationDistributesOverMatrixSumFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `neg_add_matrix_apply`（符号反転の定義 → 和の定義 → `-x = (-1)x` → 左分配則 → `-x = (-1)x` を 2 か所 → 符号反転の定義を 2 か所 → 和の定義） | `neg_add_matrix_apply'`（同じ並び） |
| `neg_finite_sum_of_matrices`（`r + 1` 項の帰納法。有限和の定義 → 帰納法の仮定 → 和の符号反転 → 有限和の定義） | `neg_finite_sum_matrix'`（同じ並び） |

## 何が効いているか / 効いていないか

- 係数の符号反転と積のつながりは、仮定 `hneg : ∀ x, -x = (-1) * x`（人手の `multiply_by_minus_one` はこの形の定義である）で渡す。
  `HasDistribNeg` や環を取ると `-(x + y) = -x + -y` が型クラスの側に入ってしまい、何が効いているかが見えなくなるので取らない。
- 和の符号反転で効いているのは `hneg` と係数の**左分配則**（`LeftDistribClass`）の 2 つだけである。
  `hneg` を外すと `Neg` は任意の写像になり、`-(x + y) = -x + -y` は一般には成り立たない。
  左分配則を外すと `(-1)(x + y) = (-1)x + (-1)y` の段が通らない。
- **加法の結合則・交換則・零、乗法の結合則・単位元・可換則は、和の符号反転では効いていない**（`Add`・`Mul`・`Neg`・`One` だけを取る）。
  `(-1)(-1) = 1` のような `-1` の性質も使わない。
- 有限和の符号反転で効いているのは、上の和の符号反転と有限和の定義（左から足す）だけである。`AddCommMonoid` は、mathlib の `Finset.sum` を
  人手の左から足す有限和の定義の代わりに使うために要る（`Fin.sum_univ_one`・`Fin.sum_univ_castSucc` の証明は加法の結合則・交換則に依る）。
  人手の定義どおりに左から足した和なら、`r + 1 ≥ 1` 項の帰納法の段に加法の結合則・交換則・零は現れない。
- 添字の有限性も、`Fin m`・`Fin n` の順序も、和の符号反転では効いていない（添字の型は任意）。複素数であること、体であることは効いていない。
-/
import Mathlib.Data.Matrix.Basic
import Mathlib.Algebra.BigOperators.Fin

namespace Ising2D.NecSuf

open Matrix

variable {ι κ : Type*}

/-- **`(-(A + B))_{ij} = ((-A) + (-B))_{ij}`**（具体版 `neg_add_matrix_apply`）。 -/
theorem neg_add_matrix_apply' {R : Type*} [Add R] [Mul R] [Neg R] [One R] [LeftDistribClass R]
    (hneg : ∀ x : R, -x = (-1) * x) (A B : Matrix ι κ R) (i : ι) (j : κ) :
    (-(A + B)) i j = ((-A) + (-B)) i j :=
  calc (-(A + B)) i j
      = -((A + B) i j) := rfl                                                -- 符号反転の定義
    _ = -(A i j + B i j) := rfl                                              -- 和の定義
    _ = (-1) * (A i j + B i j) := hneg _                                     -- `-x = (-1)x`
    _ = (-1) * A i j + (-1) * B i j := left_distrib _ _ _                    -- 左分配則
    _ = (-A i j) + (-B i j) := by rw [hneg (A i j), hneg (B i j)]            -- `-x = (-1)x`（2 か所へ同時適用）
    _ = (-A) i j + (-B) i j := rfl                                           -- 符号反転の定義（2 か所へ同時適用）
    _ = ((-A) + (-B)) i j := rfl                                             -- 和の定義

/-- **`-(A + B) = (-A) + (-B)`**（具体版 `neg_add_matrix`）。 -/
theorem neg_add_matrix' {R : Type*} [Add R] [Mul R] [Neg R] [One R] [LeftDistribClass R]
    (hneg : ∀ x : R, -x = (-1) * x) (A B : Matrix ι κ R) :
    -(A + B) = (-A) + (-B) :=
  Matrix.ext (neg_add_matrix_apply' hneg A B)   -- 全ての成分が一致する

/-- **`Σ_{j=1}^{r+1} (-X_j) = -Σ_{j=1}^{r+1} X_j`**（具体版 `neg_finite_sum_of_matrices`）。`r` についての帰納法。 -/
theorem neg_finite_sum_matrix' {R : Type*} [AddCommMonoid R] [Mul R] [Neg R] [One R] [LeftDistribClass R]
    (hneg : ∀ x : R, -x = (-1) * x) :
    ∀ (r : ℕ) (X : Fin (r + 1) → Matrix ι κ R), ∑ j, -X j = -∑ j, X j
  | 0, X =>
    calc ∑ j : Fin 1, -X j
        = -X 0 := Fin.sum_univ_one (fun j => -X j)                           -- 有限和の定義（1 項）
      _ = -∑ j : Fin 1, X j := by rw [Fin.sum_univ_one]                      -- 有限和の定義（1 項）
  | r + 1, X =>
    calc ∑ j : Fin (r + 2), -X j
        = (∑ j : Fin (r + 1), -X j.castSucc) + -X (Fin.last _) :=
          Fin.sum_univ_castSucc (fun j => -X j)                              -- 有限和の定義（項を 1 つ足す）
      _ = (-∑ j : Fin (r + 1), X j.castSucc) + -X (Fin.last _) := by
          rw [neg_finite_sum_matrix' hneg r (fun j => X j.castSucc)]         -- 帰納法の仮定
      _ = -((∑ j : Fin (r + 1), X j.castSucc) + X (Fin.last _)) :=
          (neg_add_matrix' hneg _ _).symm                                    -- 和の符号反転
      _ = -∑ j : Fin (r + 2), X j := by rw [Fin.sum_univ_castSucc X]          -- 有限和の定義（項を 1 つ足す）

end Ising2D.NecSuf
