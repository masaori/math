/-
# 行列の共役は和・スカラー倍・有限和を保つ（必要十分版）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimMatrixConjugationPreservesSums.lean`
（人手 `mat_conj`・`matrix_conjugation_preserves_finite_sum`）。
具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimMatrixConjugationPreservesSumsFromNecSuf.lean`。

共役 `T_B(A) = (BA)B^{-1}` の `B^{-1}` を、ここでは任意の行列 `B'` に置き換えて `(BA)B'` について述べる。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `conj_add_matrix`（`T_B` の定義 → 右の因子の和への分配 → 左の因子の和への分配 → `T_B` の定義を 2 か所） | `conj_add_matrix'`（同じ並び） |
| `conj_smul_matrix`（`T_B` の定義 → スカラー倍を右の因子から出す → 左の因子から出す → `T_B` の定義） | `conj_smul_matrix'`（同じ並び） |
| `conj_finite_sum_of_matrices`（`r + 1` 項の帰納法。有限和の定義 → 和を保つこと → 帰納法の仮定 → 有限和の定義） | `conj_finite_sum_matrix'`（同じ並び） |

## 何が効いているか / 効いていないか

- **`B` が可逆であること、`B'` が `B` の逆元であることは効いていない。** 和・スカラー倍・有限和を保つことは、
  左から `B` を掛け右から `B'` を掛ける操作の性質であり、`B'B = I` はどの段にも現れない。
- **行列の積の結合則は効いていない**（`(BA)B'` の括弧のまま変形する）。
- 和を保つことで効いているのは、行列の積の左右の分配（`NecSuf.mul_add_matrix'`・`NecSuf.add_mul_matrix'`）、
  すなわち係数の**左右の分配則**と加法の結合則・交換則（`AddCommMonoid`）だけである。係数の乗法の結合則・単位元は効いていない（`Mul` だけ）。
- スカラー倍を保つことで効いているのは、スカラー倍を積の外へ出す 2 つ（`NecSuf.mul_smul_matrix'`・`NecSuf.smul_mul_matrix'`）である。
  どちらも成分の鎖で係数の**乗法の結合則**と**左分配則**を使う（`(aA)B = a(AB)` は `NonUnitalSemiring`）。
  右の因子から出す段 `B(aA) = a(BA)` はさらに係数の**乗法の可換則**を使う（`NonUnitalCommSemiring`。成分で `B_{ij}(aA_{jk}) = a(B_{ij}A_{jk})`）。
  可換則を削ると `B(aA) = a(BA)` が一般には成り立たない（`NecSuf.mul_comm_of_mul_smul_matrix`）。係数の乗法の単位元は効いていない。
- 有限和を保つことで効いているのは、上の和を保つことと有限和の定義（左から足す）だけである。加法の零は `Finset.sum` の型に要るだけで、
  `r + 1 ≥ 1` 項の帰納法の段には現れない。
- 行列が正方であることは効いていない（`B : ι × κ`、`A : κ × κ'`、`B' : κ' × μ` の形で述べる）。
-/
import Ising2D.NecSuf.MatMulDistribSum
import Ising2D.NecSuf.MatrixProductIdentityAndScalar
import Mathlib.Algebra.BigOperators.Fin

namespace Ising2D.NecSuf

open Matrix

variable {R : Type*} {ι κ κ' μ : Type*}

/-- **和を保つ**（具体版 `conj_add_matrix`）: `(B(A + C))B' = (BA)B' + (BC)B'`。 -/
theorem conj_add_matrix' [AddCommMonoid R] [Mul R] [LeftDistribClass R] [RightDistribClass R]
    [Fintype κ] [Fintype κ'] (B : Matrix ι κ R) (B' : Matrix κ' μ R) (A C : Matrix κ κ' R) :
    (B * (A + C)) * B' = (B * A) * B' + (B * C) * B' :=
  calc (B * (A + C)) * B'
      = (B * A + B * C) * B' := by rw [mul_add_matrix' B A C]                -- 右の因子の和への分配
    _ = (B * A) * B' + (B * C) * B' := add_mul_matrix' _ _ _                  -- 左の因子の和への分配

/-- **スカラー倍を保つ**（具体版 `conj_smul_matrix`）: `(B(aA))B' = a((BA)B')`。 -/
theorem conj_smul_matrix' [NonUnitalCommSemiring R] [Fintype κ] [Fintype κ']
    (a : R) (B : Matrix ι κ R) (B' : Matrix κ' μ R) (A : Matrix κ κ' R) :
    (B * (a • A)) * B' = a • ((B * A) * B') :=
  calc (B * (a • A)) * B'
      = (a • (B * A)) * B' := by rw [mul_smul_matrix' a B A]                 -- スカラー倍を右の因子から出す
    _ = a • ((B * A) * B') := smul_mul_matrix' a _ _                          -- スカラー倍を左の因子から出す

/-- **有限和を保つ**（具体版 `conj_finite_sum_of_matrices`）: `(B(Σ_{j=1}^{r+1} X_j))B' = Σ_{j=1}^{r+1} (BX_j)B'`。
`r` についての帰納法。 -/
theorem conj_finite_sum_matrix' [AddCommMonoid R] [Mul R] [LeftDistribClass R] [RightDistribClass R]
    [Fintype κ] [Fintype κ'] (B : Matrix ι κ R) (B' : Matrix κ' μ R) :
    ∀ (r : ℕ) (X : Fin (r + 1) → Matrix κ κ' R),
      (B * (∑ j, X j)) * B' = ∑ j, (B * X j) * B'
  | 0, X =>
    calc (B * (∑ j : Fin 1, X j)) * B'
        = (B * X 0) * B' := by rw [Fin.sum_univ_one]                          -- 有限和の定義（1 項）
      _ = ∑ j : Fin 1, (B * X j) * B' := (Fin.sum_univ_one (fun j => (B * X j) * B')).symm            -- 有限和の定義（1 項）
  | r + 1, X =>
    calc (B * (∑ j : Fin (r + 2), X j)) * B'
        = (B * ((∑ j : Fin (r + 1), X j.castSucc) + X (Fin.last _))) * B' := by
          rw [Fin.sum_univ_castSucc]                                          -- 有限和の定義（項を 1 つ足す）
      _ = (B * (∑ j : Fin (r + 1), X j.castSucc)) * B' + (B * X (Fin.last _)) * B' :=
          conj_add_matrix' _ _ _ _                                            -- 和を保つ
      _ = (∑ j : Fin (r + 1), (B * X j.castSucc) * B') + (B * X (Fin.last _)) * B' := by
          rw [conj_finite_sum_matrix' B B' r (fun j => X j.castSucc)]         -- 帰納法の仮定
      _ = ∑ j : Fin (r + 2), (B * X j) * B' :=
          (Fin.sum_univ_castSucc (fun j => (B * X j) * B')).symm              -- 有限和の定義（項を 1 つ足す）

end Ising2D.NecSuf
