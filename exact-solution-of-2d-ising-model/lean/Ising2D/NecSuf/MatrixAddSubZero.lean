/-
# 零行列を足す・引く・零行列の有限和（必要十分版）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimAddAndSubtractZeroMatrix.lean`
（人手 `matrix_plus_zero_matrix`・`zero_matrix_plus_matrix`・`matrix_minus_zero_matrix`・`finite_sum_of_zero_matrices`）。
具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimAddAndSubtractZeroMatrixFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `matrix_add_zero_matrix_apply`（和の定義 → 零行列の定義 → 成分を実数の組に開く → 組の和 → `ℝ` の `a + 0 = a` → 組を閉じる） | `add_zero_matrix_apply`（和の定義 → 零行列の定義 → `x + 0 = x`） |
| `zero_matrix_add_matrix_apply`（同じ並びで左から足す） | `zero_add_matrix_apply` |
| `matrix_sub_zero_matrix_apply`（差の定義 → 零行列の定義 → 複素数の差 → `-0 = (-1)·0` → 組に開く → 組の積 → `ℝ` の四則 → 組を閉じる → 零行列の定義 → 和の定義）と `matrix_sub_zero_matrix` | `sub_zero_matrix_apply`（差の定義 → 零行列の定義 → `x - y = x + (-y)` → `-0 = 0` → 零行列の定義 → 和の定義）と `sub_zero_matrix` |
| `finite_sum_of_zero_matrices`（有限和の定義の 2 式 → 帰納法の仮定 → `matrix_plus_zero_matrix`） | `sum_zero_matrices` |

## 何が効いているか / 効いていないか

- `X + O = X`・`O + X = X` に効くのは、係数の `x + 0 = x`・`0 + x = x` だけである（`AddZeroClass`）。
  具体版はこれを `ℂ` の和の定義（実数の組の成分ごとの和）と `ℝ` の `a + 0 = a` から出しているが、組であることも `ℝ` であることも効いていない。
- `X - O = X` に効くのは、差が `x - y = x + (-y)` であること・`-0 = 0`・`x + 0 = x` だけである。型クラスは、この 3 つを
  定理（`sub_eq_add_neg`・`neg_zero`・`add_zero`）として持つ最も弱い mathlib の型クラス `SubNegZeroMonoid` にした。
  `SubNegZeroMonoid` は加法の結合則も含むが、証明は使っていない。
  具体版の `-0 = (-1)·0` と積の計算は `-0 = 0` を出すためだけに使っていて、**乗法は効いていない**。加法の結合則・可換則・逆元の性質
  （`x + (-x) = 0`）も効いていない。
- `Σ_{j=1}^{r} O = O` に効くのは、有限和を左から 1 項ずつ足す定義と `O + O = O`（`x + 0 = x`）だけである。
  `Finset.sum` の定義が係数に加法の可換モノイド（`AddCommMonoid`）を要求するので型クラスはそれより弱くできないが、
  証明は加法の可換則を使っていない（`Fin.sum_univ_castSucc` で左から足す形へ読み替えたあとは `x + 0 = x` だけで進む）。
- 行列の添字の集合は任意で、有限であること・順序は効いていない（和の主張の和の項の添字は `Fin (r + 1)` で、左から足す順序を使う）。
  複素数であること、体であることは効いていない。
-/
import Mathlib.Data.Matrix.Basic
import Mathlib.Algebra.BigOperators.Fin

namespace Ising2D.NecSuf

open Matrix

variable {ι κ : Type*}

/-- **`(X + O)_{ik} = X_{ik}`**（具体版 `matrix_add_zero_matrix_apply`）。係数は `AddZeroClass`。 -/
theorem add_zero_matrix_apply {R : Type*} [AddZeroClass R] (X : Matrix ι κ R) (i : ι) (k : κ) :
    (X + 0) i k = X i k :=
  calc (X + 0) i k
      = X i k + (0 : Matrix ι κ R) i k := rfl   -- 和の定義
    _ = X i k + 0 := rfl                         -- 零行列の定義
    _ = X i k := add_zero _                      -- `x + 0 = x`

/-- **`X + O = X`**（具体版 `matrix_add_zero_matrix`）。 -/
theorem add_zero_matrix {R : Type*} [AddZeroClass R] (X : Matrix ι κ R) : X + 0 = X :=
  Matrix.ext (add_zero_matrix_apply X)   -- 行列の等号は成分ごと

/-- **`(O + X)_{ik} = X_{ik}`**（具体版 `zero_matrix_add_matrix_apply`）。係数は `AddZeroClass`。 -/
theorem zero_add_matrix_apply {R : Type*} [AddZeroClass R] (X : Matrix ι κ R) (i : ι) (k : κ) :
    (0 + X) i k = X i k :=
  calc (0 + X) i k
      = (0 : Matrix ι κ R) i k + X i k := rfl   -- 和の定義
    _ = 0 + X i k := rfl                         -- 零行列の定義
    _ = X i k := zero_add _                      -- `0 + x = x`

/-- **`O + X = X`**（具体版 `zero_matrix_add_matrix`）。 -/
theorem zero_add_matrix {R : Type*} [AddZeroClass R] (X : Matrix ι κ R) : 0 + X = X :=
  Matrix.ext (zero_add_matrix_apply X)   -- 行列の等号は成分ごと

/-- **`(X - O)_{ik} = (X + O)_{ik}`**（具体版 `matrix_sub_zero_matrix_apply`）。係数は `SubNegZeroMonoid`。 -/
theorem sub_zero_matrix_apply {R : Type*} [SubNegZeroMonoid R] (X : Matrix ι κ R) (i : ι) (k : κ) :
    (X - 0) i k = (X + 0) i k :=
  calc (X - 0) i k
      = X i k - (0 : Matrix ι κ R) i k := rfl   -- 差の定義
    _ = X i k - 0 := rfl                         -- 零行列の定義
    _ = X i k + -0 := sub_eq_add_neg _ _         -- `x - y = x + (-y)`
    _ = X i k + 0 := by rw [neg_zero]            -- `-0 = 0`
    _ = X i k + (0 : Matrix ι κ R) i k := rfl   -- 零行列の定義
    _ = (X + 0) i k := rfl                       -- 和の定義

/-- **`X - O = X`**（具体版 `matrix_sub_zero_matrix`）。 -/
theorem sub_zero_matrix {R : Type*} [SubNegZeroMonoid R] (X : Matrix ι κ R) : X - 0 = X :=
  calc X - 0
      = X + 0 := Matrix.ext (sub_zero_matrix_apply X)   -- 成分ごとの等式
    _ = X := add_zero_matrix X                          -- `X + O = X`

/-- **`Σ_{j=1}^{r+1} O = O`**（具体版 `finite_sum_of_zero_matrices`）。係数は `AddCommMonoid`（`Finset.sum` の定義が要求する。可換則は使わない）。 -/
theorem sum_zero_matrices {R : Type*} [AddCommMonoid R] (r : ℕ) :
    ∑ _j : Fin (r + 1), (0 : Matrix ι κ R) = 0 := by
  induction r with
  | zero =>
    calc ∑ _j : Fin (0 + 1), (0 : Matrix ι κ R)
        = 0 := Fin.sum_univ_one _                        -- 有限和の定義（1 項）
  | succ r ih =>
    calc ∑ _j : Fin (r + 1 + 1), (0 : Matrix ι κ R)
        = (∑ _j : Fin (r + 1), (0 : Matrix ι κ R)) + 0 :=
          Fin.sum_univ_castSucc _                        -- 有限和の定義（左から足す）
      _ = 0 + 0 := by rw [ih]                            -- 帰納法の仮定
      _ = 0 := add_zero_matrix 0                         -- `X + O = X`（`X = O`）

end Ising2D.NecSuf
