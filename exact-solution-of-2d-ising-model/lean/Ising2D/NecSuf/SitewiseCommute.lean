/-
# 必要十分版: サイトごとに可換な族の積は可換、相異なるサイトに置いた元は可換

**このファイルには必要十分版だけを置く。必要十分版は Lean の中だけの道具であり、
人手証明の本文にも参照用ノートにも持ち込まない**
（`exact-solution-of-2d-ising-model/README.md` 4 節）。

対応する人手証明のラベルと具体版:

| 人手証明のラベル | 具体版 | 必要十分版 |
| --- | --- | --- |
| `tensor_commutation_from_all_sites` | `Ising2D.siteProd_commute_of_sitewise_commute`（`MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimTensorCommutationFromAllSites.lean`） | `commute_of_sitewise_commute` |
| `distinct_site_pauli_matrices_commute` | `Ising2D.siteOp_mul_comm`（`PartitionFunction/ProjectionAndJordanWigner/DefinitionTransferMatrixSymbols.lean`） | `update_mul_comm_of_ne` |

具体版をこの必要十分版の特殊化として導くのは
`MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimTensorCommutationFromAllSitesFromNecSuf.lean` と
`PartitionFunction/ProjectionAndJordanWigner/ClaimDistinctSitePauliMatricesCommuteFromNecSuf.lean`。

## 必要十分版が何を明らかにするか

* `tensor_commutation_from_all_sites` の 3 段（`kronecker_product_rule` (1)・仮定・`kronecker_product_rule` (1)）に効くのは、
  族から 1 つの元を作る写像 `P` が**積を保つこと**（`hP : P (x * y) = P x * P y`）だけである。
  台が行列であること、`2×2` であること、係数が `ℂ` であること、`P` の多重線型性・単位元の保存は効いていない。
  `hP` を外すと、`P x * P y` を族の積へ書き換える段が無くなり、通らない。
* `distinct_site_pauli_matrices_commute` の場合分けに効くのは、各サイトの台で**単位元が左右の単位元であること**
  （`one_mul`・`mul_one`）だけである。サイトに置く元が Pauli 行列であること（`σσ = I` や反可換性）は使っていない。
  サイトの添字は等号が判定できればよく（`DecidableEq`）、有限であることも順序も使わない。
-/
import Mathlib.Algebra.Group.Pi.Basic

namespace Ising2D.NecSuf

variable {ι R S : Type*}

/-- **必要十分版 `tensor_commutation_from_all_sites`**: 積を保つ `P` について、全てのサイトで `y_i x_i = x_i y_i` なら
`P x * P y = P y * P x`。具体版と同じ 3 段。 -/
theorem commute_of_sitewise_commute [Mul R] [Mul S] (P : (ι → R) → S)
    (hP : ∀ x y : ι → R, P (x * y) = P x * P y) (x y : ι → R)
    (h : ∀ i, y i * x i = x i * y i) :
    P x * P y = P y * P x :=
  calc P x * P y
      = P (x * y) := (hP x y).symm                               -- `kronecker_product_rule` (1)
    _ = P (y * x) := congrArg P (funext fun i => (h i).symm)      -- 仮定 `y_ix_i = x_iy_i` を右辺から左辺へ、全てのサイトへ同時に適用
    _ = P y * P x := hP y x                                       -- `kronecker_product_rule` (1) を右辺から左辺へ

/-- **必要十分版 `distinct_site_pauli_matrices_commute` の場合分け**: `j ≠ k` なら、
`j` だけに `a` を置いた族 `x` と `k` だけに `b` を置いた族 `y` は、全てのサイトで `y_i x_i = x_i y_i`。
具体版と同じ 3 つの場合（`i = j`・`i = k`・どちらでもない）。 -/
theorem update_sitewise_commute_of_ne [DecidableEq ι] [MulOneClass R] {j k : ι} (hjk : j ≠ k) (a b : R) (i : ι) :
    Function.update (1 : ι → R) k b i * Function.update (1 : ι → R) j a i
      = Function.update (1 : ι → R) j a i * Function.update (1 : ι → R) k b i := by
  by_cases hij : i = j
  · have hik : i ≠ k := by rw [hij]; exact hjk
    rw [Function.update_of_ne hik, hij, Function.update_self]
    calc (1 : ι → R) j * a
        = a := one_mul a                                          -- `identity_matrix_is_left_unit_of_mat_mult`
      _ = a * (1 : ι → R) j := (mul_one a).symm                   -- `identity_matrix_is_right_unit_of_mat_mult` を右辺から左辺へ
  · by_cases hik : i = k
    · rw [Function.update_of_ne hij, hik, Function.update_self]
      calc b * (1 : ι → R) k
          = b := mul_one b                                        -- `identity_matrix_is_right_unit_of_mat_mult`
        _ = (1 : ι → R) k * b := (one_mul b).symm                 -- `identity_matrix_is_left_unit_of_mat_mult` を右辺から左辺へ
    · rw [Function.update_of_ne hij, Function.update_of_ne hik]   -- 両方とも単位元

/-- **必要十分版 `distinct_site_pauli_matrices_commute`**: 積を保つ `P` について、`j ≠ k` なら
`P(j だけに a) * P(k だけに b) = P(k だけに b) * P(j だけに a)`。 -/
theorem update_mul_comm_of_ne [DecidableEq ι] [MulOneClass R] [Mul S] (P : (ι → R) → S)
    (hP : ∀ x y : ι → R, P (x * y) = P x * P y) {j k : ι} (hjk : j ≠ k) (a b : R) :
    P (Function.update 1 j a) * P (Function.update 1 k b)
      = P (Function.update 1 k b) * P (Function.update 1 j a) :=
  commute_of_sitewise_commute P hP _ _ (update_sitewise_commute_of_ne hjk a b)

end Ising2D.NecSuf
