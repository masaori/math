/-
# 零行列を左から掛けると零行列・自分自身との和が零行列なら零行列・和の等式から右の項を差で表す（必要十分版）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimZeroMatrixProductAndSumEquations.lean`
（人手 `zero_matrix_is_left_zero_of_mat_mult`・`matrix_sum_with_itself_zero_implies_zero`・`matrix_summand_from_sum_equation`）。
具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimZeroMatrixProductAndSumEquationsFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `zero_matrix_mul_apply`（積の定義 → 零行列の定義 → `0·z = 0` → 零の有限和 → 零行列の定義） | `zero_mul_matrix_apply'`（同じ並び） |
| `matrix_eq_zero_of_add_self_eq_zero_apply`（`1·x = x` → `h·t = 1` → 積の結合律 → `1 + 1 = t` を右辺から左辺へ → 右分配律 → `1·x = x` → 和の定義 → 仮定 → 零行列の定義 → `h·0 = 0` → 零行列の定義） | `eq_zero_of_add_self_eq_zero_matrix_apply'`（同じ並び。`1 + 1 = t` の段は `t` を `1 + 1` そのものに取るので現れない） |
| `matrix_eq_sub_of_add_eq_apply`（`0 + b = b` → `(-a) + a = 0` → 加法の結合律 → 和の定義 → 仮定 → 加法の交換律 → `x - y = x + (-y)` → 差の定義） | `eq_sub_of_add_eq_matrix_apply'`（同じ並び） |

## 何が効いているか / 効いていないか

- `O B = O` に効くのは、係数の `0·x = 0`（仮定 `hz`）と、零の有限和が零であること（`Finset.sum_const_zero`。加法の可換モノイドの公理だけで出る）だけである。
  積の定義が `Finset.sum` を使うので、係数は `AddCommMonoid` と `Mul`、中の添字は有限型である。積の結合則・単位元・分配則、`x·0 = 0` は効いていない。
  `hz` を外すと、`0·x` が `0` と限らない演算では主張は一般に成り立たない。
- `X + X = O ⇒ X = O` に効くのは、`1·x = x`（`hone`）、`(1 + 1)` の左逆元 `h` の存在（`hinv`）、積の結合律（`hassoc`）、右分配律
  （`RightDistribClass`）、`h·0 = 0`（`hz`）だけである。**加法の結合則・可換則・逆元、積の可換則、`h` が右逆元でもあることは効いていない。**
  `1 + 1` が左逆元を持つこと（`2` が可逆）が本質で、標数 2 では `1 + 1 = 0` なので逆元が無く、主張は実際に破れる。
- `A + B = C ⇒ B = C - A` に効くのは、係数の加法が可換群であること（`AddCommGroup`）の公理のうち、`0 + b = b`・`(-a) + a = 0`・
  加法の結合律・可換律・`x - y = x + (-y)` だけである。`AddCommGroup` はちょうどこれらを公理（またはその直接の帰結）として持つので、
  型クラスはそれにした。乗法は効いていない。
- 行列の添字の集合は任意で、有限であることは `O B = O` の積の定義のためだけに要る。複素数であること、体であることは効いていない。
-/
import Mathlib.Data.Matrix.Mul
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace Ising2D.NecSuf

open Matrix

variable {ι κ ν : Type*}

/-- **`(O B)_{ik} = O_{ik}`**（具体版 `zero_matrix_mul_apply`）。 -/
theorem zero_mul_matrix_apply' {R : Type*} [AddCommMonoid R] [Mul R] [Fintype κ]
    (hz : ∀ x : R, 0 * x = 0) (B : Matrix κ ν R) (i : ι) (k : ν) :
    ((0 : Matrix ι κ R) * B) i k = (0 : Matrix ι ν R) i k :=
  calc ((0 : Matrix ι κ R) * B) i k
      = ∑ j, (0 : Matrix ι κ R) i j * B j k := Matrix.mul_apply          -- 積の定義
    _ = ∑ j, (0 : R) * B j k := rfl                                      -- 零行列の定義を各項へ
    _ = ∑ _j : κ, (0 : R) := Finset.sum_congr rfl fun j _ => hz (B j k)  -- `0·x = 0` を各項へ
    _ = 0 := Finset.sum_const_zero                                       -- 零の有限和
    _ = (0 : Matrix ι ν R) i k := rfl                                    -- 零行列の定義

/-- **`O B = O`**（具体版 `zero_matrix_mul`）。 -/
theorem zero_mul_matrix' {R : Type*} [AddCommMonoid R] [Mul R] [Fintype κ]
    (hz : ∀ x : R, 0 * x = 0) (B : Matrix κ ν R) : (0 : Matrix ι κ R) * B = 0 :=
  Matrix.ext (zero_mul_matrix_apply' hz B)   -- 全ての成分が一致する

/-- **`X + X = O` なら `X_{ik} = O_{ik}`**（具体版 `matrix_eq_zero_of_add_self_eq_zero_apply`）。 -/
theorem eq_zero_of_add_self_eq_zero_matrix_apply' {R : Type*} [Add R] [Mul R] [Zero R] [One R]
    [RightDistribClass R] (h : R) (hinv : h * (1 + 1) = 1) (hone : ∀ x : R, 1 * x = x)
    (hassoc : ∀ a b c : R, (a * b) * c = a * (b * c)) (hz : h * 0 = 0)
    (X : Matrix ι κ R) (hX : X + X = 0) (i : ι) (k : κ) : X i k = (0 : Matrix ι κ R) i k :=
  calc X i k
      = 1 * X i k := (hone _).symm                                       -- `1·x = x`
    _ = (h * (1 + 1)) * X i k := by rw [hinv]                            -- `h` は `1 + 1` の左逆元
    _ = h * ((1 + 1) * X i k) := hassoc _ _ _                            -- 積の結合律
    _ = h * (1 * X i k + 1 * X i k) := by rw [add_mul]                   -- 右分配律
    _ = h * (X i k + X i k) := by rw [hone]                              -- `1·x = x`（2 か所）
    _ = h * (X + X) i k := rfl                                           -- 和の定義
    _ = h * (0 : Matrix ι κ R) i k := by rw [hX]                         -- 仮定 `X + X = O`
    _ = h * 0 := rfl                                                     -- 零行列の定義
    _ = 0 := hz                                                          -- `h·0 = 0`
    _ = (0 : Matrix ι κ R) i k := rfl                                    -- 零行列の定義

/-- **`X + X = O` なら `X = O`**（具体版 `matrix_eq_zero_of_add_self_eq_zero`）。 -/
theorem eq_zero_of_add_self_eq_zero_matrix' {R : Type*} [Add R] [Mul R] [Zero R] [One R]
    [RightDistribClass R] (h : R) (hinv : h * (1 + 1) = 1) (hone : ∀ x : R, 1 * x = x)
    (hassoc : ∀ a b c : R, (a * b) * c = a * (b * c)) (hz : h * 0 = 0)
    (X : Matrix ι κ R) (hX : X + X = 0) : X = 0 :=
  Matrix.ext (eq_zero_of_add_self_eq_zero_matrix_apply' h hinv hone hassoc hz X hX)   -- 全ての成分が一致する

/-- **`A + B = C` なら `B_{ik} = (C - A)_{ik}`**（具体版 `matrix_eq_sub_of_add_eq_apply`）。 -/
theorem eq_sub_of_add_eq_matrix_apply' {R : Type*} [AddCommGroup R]
    (A B C : Matrix ι κ R) (hABC : A + B = C) (i : ι) (k : κ) : B i k = (C - A) i k :=
  calc B i k
      = 0 + B i k := (zero_add _).symm                                   -- `0 + b = b`
    _ = (-A i k + A i k) + B i k := by rw [neg_add_cancel]               -- `(-a) + a = 0`
    _ = -A i k + (A i k + B i k) := add_assoc _ _ _                      -- 加法の結合律
    _ = -A i k + (A + B) i k := rfl                                      -- 和の定義
    _ = -A i k + C i k := by rw [hABC]                                   -- 仮定 `A + B = C`
    _ = C i k + -A i k := add_comm _ _                                   -- 加法の交換律
    _ = C i k - A i k := (sub_eq_add_neg _ _).symm                       -- `x - y = x + (-y)`
    _ = (C - A) i k := rfl                                               -- 差の定義

/-- **`A + B = C` なら `B = C - A`**（具体版 `matrix_eq_sub_of_add_eq`）。 -/
theorem eq_sub_of_add_eq_matrix' {R : Type*} [AddCommGroup R]
    (A B C : Matrix ι κ R) (hABC : A + B = C) : B = C - A :=
  Matrix.ext (eq_sub_of_add_eq_matrix_apply' A B C hABC)   -- 全ての成分が一致する

end Ising2D.NecSuf
