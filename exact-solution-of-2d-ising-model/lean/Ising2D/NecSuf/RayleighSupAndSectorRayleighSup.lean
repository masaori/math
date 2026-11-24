/-
# Rayleigh 商の上限 `c(M) := sup 𝓡` と偶セクターでの上限 `c_+(M) := sup 𝓡_+`（**必要十分版**の側の定義）

具体版の同じ定義と性質:

* `𝓡`・`c(M)`（人手 `def_rayleigh_sup`）は `Ising2D/ThermodynamicLimit/RowLimitAndMaxEigenvalue/DefinitionRayleighSup.lean` の
  `Ising2D.rayleighSet`・`rayleighSup`・`rayleighSet_bddAbove`（と、その段の `abs_component_le_one_of_unit`・
  `abs_bilinear_term_le_abs_entry`・`abs_bilinear_row_le_row_abs_sum`・`bilinear_le_abs_entry_sum`）・`vecNorm_single`・
  `rayleighSet_nonempty`・`quad_smul`。
* `𝓡_+`・`c_+(M)`（人手 `def_sector_rayleigh_sup`）は `Ising2D/ThermodynamicLimit/ColumnLimitAndClosedForm/DefinitionSectorRayleighSup.lean` の
  `Ising2D.evenSectorSet`・`evenSectorRayleighSup`・`evenSectorSet_subset`・`evenSectorSet_bddAbove`・`le_evenSectorRayleighSup`。
* 対称行列を双線型形式の因子の間で動かす `Ising2D.mulVec_dotProduct_selfadjoint` は
  `Ising2D/MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/RealMatrixBilinearFormAndNorm.lean`。

このファイルは、それらを具体版と同じ式・同じ手順で必要十分版の側に置く。具体版とこのファイルの定義が同じ値であることは、
導出 `ThermodynamicLimit/RowLimitAndMaxEigenvalue/DefinitionRayleighSupFromNecSuf.lean`・
`ThermodynamicLimit/ColumnLimitAndClosedForm/DefinitionSectorRayleighSupFromNecSuf.lean` だけが述べる。

## 何が効いているか / 効いていないか

| 具体版 | 必要十分版 | 仮定 |
| --- | --- | --- |
| `quad_smul`（`(cx)ᵀA(cx) = c²(xᵀAx)`） | `quad_smul'`（同じ手順） | 係数は可換半環（`c` を双線型形式の両側から外へ出すのに可換性が効く） |
| `mulVec_dotProduct_selfadjoint`（`xᵀ(Ay) = (Ax)ᵀy`） | `mulVec_dotProduct_selfadjoint'`（同じ手順） | 係数は可換半環（`xᵀA = (Aᵀx)ᵀ` の読み替えに可換性が効く）、`A` が対称であること |
| `abs_bilinear_term_le_abs_entry`（6 行） | `abs_bilinear_term_le_abs_entry'`（同じ 6 行） | 係数は順序環（積の絶対値・非負の数を掛けた大小・単位元） |
| `abs_bilinear_row_le_row_abs_sum`（2 行） | `abs_bilinear_row_of_unit_components_le_row_abs_sum'`（同じ 2 行） | 係数は順序環（有限和の三角不等式と単調性を足す） |
| `bilinear_le_abs_entry_sum`（4 行） | `bilinear_le_abs_entry_sum'`（同じ 4 行） | 係数は順序環 |
| `rayleighSet`・`rayleighSup` | `rayleighSet'`・`rayleighSup'`（同じ式） | `ℝ`（`sSup` と平方根のノルム） |
| `abs_component_le_one_of_unit`（`‖x‖ = 1` なら `\|x_i\| ≤ 1`。4 行の鎖と二乗の大小） | `abs_component_le_one_of_unit'`（同じ鎖） | `ℝ`（ノルムが `ℝ` の平方根） |
| `rayleighSet_bddAbove`（上界 `Σ_iΣ_j\|W_ij\|`） | `rayleighSet'_bddAbove`（同じ上界） | `ℝ`。`W` に仮定を置かない |
| `vecNorm_single`（3 行の鎖 2 本と 4 行の鎖） | `vecNorm'_single`（同じ鎖） | `ℝ` |
| `rayleighSet_nonempty`（`e_1ᵀWe_1 ∈ 𝓡`） | `rayleighSet'_nonempty`（同じ） | `n` が空でないこと（具体版と同じ。空なら単位ベクトルが無い） |
| `evenSectorSet`・`evenSectorRayleighSup` | `evenSectorSet'`・`evenSectorRayleighSup'`（同じ式） | `ℝ` |
| `evenSectorSet_subset`・`evenSectorSet_bddAbove`・`le_evenSectorRayleighSup` | 同じ名前に `'`（同じ手順） | `ℝ` |

* `√` と `sSup` を含む宣言（ノルム・`𝓡`・`𝓡_+`・その上限と、それらに直接触れる補題）だけは係数を `ℝ` に固定する。
  `sSup` は `ℝ` の完備性そのもの、ノルムは `ℝ` の平方根なので、一般の順序体へ上げる余地は無い。
  それらを置くのは一般化のためではなく、これらを使う必要十分版（`EvenSectorUpperBound.lean`）が具体版を参照せずに
  済むようにするためである（具体版と必要十分版は互いを参照しない。`lean/README.md`）。
* 対称行列の双線型形式の値の入れ替え `xᵀAy = yᵀAx`（具体版 `dotProduct_mulVec_comm`）は、既存の必要十分版
  `bilinear_value_of_symmetric_matrix_is_symmetric'`（`NecSuf/BilinearValueOfSymmetricMatrixIsSymmetric.lean`）を使い、ここには置かない。
* 具体版が引く主張の必要十分版を引く: 非負の項の和は各項以上は `finite_sum_ge_term'`（`NecSuf/FiniteSumDifferenceAndNonnegativeTerm.lean`）、
  二乗の大小から非負の数の大小は `order_from_squares'`（`NecSuf/NonnegativeOrderFromSquares.lean`）、`|q|^2 = q^2` は `sq_abs'`
  （`NecSuf/SquareOfAbsoluteValueAndOfSum.lean`）、積の絶対値は `abs_mul'`・実数は自身の絶対値以下は `le_abs'`
  （`NecSuf/AbsoluteValueBoundsTriangleAndProduct.lean`）、双線型形式の値を和に開く段は `dotProduct_mulVec_eq_double_sum'`
  （`NecSuf/BilinearValueAtMostValueAtAbsoluteVector.lean`）、`1^m = 1` は `one_pow'`（`NecSuf/PowerOfOneIsOne.lean`）、`√1 = 1` は `sqrt_one'`（`NecSuf/RealVectorNorm.lean`）。
  係数を上げた補題の具体版がその特殊化であることは、導出 `DefinitionRayleighSupFromNecSuf.lean`・`RealMatrixBilinearFormAndNormFromNecSuf.lean` の `*_of_necSuf` が述べる。
-/
import Ising2D.NecSuf.RealVectorNorm
import Ising2D.NecSuf.NonnegativeOrderFromSquares
import Ising2D.NecSuf.SquareOfAbsoluteValueAndOfSum
import Ising2D.NecSuf.AbsoluteValueBoundsTriangleAndProduct
import Ising2D.NecSuf.BilinearValueAtMostValueAtAbsoluteVector
import Ising2D.NecSuf.FiniteSumDifferenceAndNonnegativeTerm
import Ising2D.NecSuf.PowerOfOneIsOne
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.LinearAlgebra.Matrix.Symmetric
import Mathlib.Order.ConditionallyCompleteLattice.Basic
import Mathlib.Data.Real.Archimedean

set_option linter.unusedSectionVars false

namespace Ising2D.NecSuf

open Matrix

variable {n : Type*} [Fintype n]

/-! ## 双線型形式の値の基本の性質（係数は一般の型） -/

section Bilinear

variable {R : Type*} [CommSemiring R]

/-- スカラー倍に対する 2 次形式の振る舞い `(cx)ᵀA(cx) = c²(xᵀAx)`（具体版 `Ising2D.quad_smul` と同じ手順）。 -/
theorem quad_smul' (A : Matrix n n R) (c : R) (x : n → R) :
    (c • x) ⬝ᵥ A *ᵥ (c • x) = c ^ 2 * (x ⬝ᵥ A *ᵥ x) := by
  rw [Matrix.mulVec_smul, smul_dotProduct, dotProduct_smul, smul_eq_mul, smul_eq_mul]
  ring

/-- 対称行列に対する自己共役性 `xᵀ (A y) = (A x)ᵀ y`（具体版 `Ising2D.mulVec_dotProduct_selfadjoint` と同じ手順）。 -/
theorem mulVec_dotProduct_selfadjoint' {A : Matrix n n R} (hA : A.IsSymm) (x y : n → R) :
    x ⬝ᵥ A *ᵥ y = (A *ᵥ x) ⬝ᵥ y := by
  have hAt : Aᵀ = A := hA.eq
  have hvm : x ᵥ* A = A *ᵥ x := by
    conv_lhs => rw [← hAt]
    exact Matrix.vecMul_transpose A x
  rw [Matrix.dotProduct_mulVec, hvm]

end Bilinear

section Bounds

variable {R : Type*} [Ring R] [LinearOrder R] [IsOrderedRing R]

/-- すべての `k` で `|x_k| ≤ 1` なら `|x_iW_ijx_j| ≤ |W_ij|`（具体版 `Ising2D.abs_bilinear_term_le_abs_entry` と同じ 6 行）。 -/
theorem abs_bilinear_term_le_abs_entry' (W : Matrix n n R) (x : n → R) (hx : ∀ k, |x k| ≤ 1) (i j : n) :
    |x i * W i j * x j| ≤ |W i j| := by
  have hnn : 0 ≤ |x i| * |W i j| := mul_nonneg (abs_nonneg _) (abs_nonneg _) -- 非負の数の積
  calc |x i * W i j * x j|
      = |x i * W i j| * |x j| := abs_mul' _ _                               -- 積の絶対値（`a → x_iW_ij`、`b → x_j`）
    _ = |x i| * |W i j| * |x j| := by rw [abs_mul' (x i) (W i j)]           -- 積の絶対値（`a → x_i`、`b → W_ij`）
    _ ≤ |x i| * |W i j| * 1 := mul_le_mul_of_nonneg_left (hx j) hnn          -- `|x_j| ≤ 1` の両辺に非負の数を左から掛ける
    _ = |x i| * |W i j| := mul_one _                                          -- 1 は積の単位元
    _ ≤ 1 * |W i j| := mul_le_mul_of_nonneg_right (hx i) (abs_nonneg _)       -- `|x_i| ≤ 1` の両辺に非負の数を右から掛ける
    _ = |W i j| := one_mul _                                                  -- 1 は積の単位元

/-- `|Σ_j x_iW_ijx_j| ≤ Σ_j|x_iW_ijx_j| ≤ Σ_j|W_ij|`（具体版 `Ising2D.abs_bilinear_row_le_row_abs_sum` と同じ 2 行）。 -/
theorem abs_bilinear_row_of_unit_components_le_row_abs_sum' (W : Matrix n n R) (x : n → R)
    (hx : ∀ k, |x k| ≤ 1) (i : n) :
    |∑ j, x i * W i j * x j| ≤ ∑ j, |W i j| :=
  calc |∑ j, x i * W i j * x j|
      ≤ ∑ j, |x i * W i j * x j| := Finset.abs_sum_le_sum_abs _ _           -- 有限和の三角不等式
    _ ≤ ∑ j, |W i j| :=
        Finset.sum_le_sum fun j _ => abs_bilinear_term_le_abs_entry' W x hx i j
                                                                            -- 有限和の単調性。各 `j` は項ごとの 6 行

/-- すべての `k` で `|x_k| ≤ 1` なら `xᵀWx ≤ Σ_iΣ_j|W_ij|`（具体版 `Ising2D.bilinear_le_abs_entry_sum` と同じ 4 行）。 -/
theorem bilinear_le_abs_entry_sum' (W : Matrix n n R) (x : n → R) (hx : ∀ k, |x k| ≤ 1) :
    x ⬝ᵥ W *ᵥ x ≤ ∑ i, ∑ j, |W i j| :=
  calc x ⬝ᵥ W *ᵥ x
      ≤ |x ⬝ᵥ W *ᵥ x| := le_abs' _                                          -- 数は自身の絶対値以下
    _ = |∑ i, ∑ j, x i * W i j * x j| := by
        rw [dotProduct_mulVec_eq_double_sum']                               -- 双線型形式の値を和に開く
    _ ≤ ∑ i, |∑ j, x i * W i j * x j| := Finset.abs_sum_le_sum_abs _ _      -- 有限和の三角不等式
    _ ≤ ∑ i, ∑ j, |W i j| :=
        Finset.sum_le_sum fun i _ => abs_bilinear_row_of_unit_components_le_row_abs_sum' W x hx i
                                                                            -- 有限和の単調性。各 `i` は 2 行

end Bounds

/-! ## `𝓡` と `c(M) := sup 𝓡`（係数は `ℝ`） -/

/-- `𝓡 = {xᵀWx | ‖x‖ = 1}`（具体版 `Ising2D.rayleighSet` と同じ式）。 -/
def rayleighSet' (W : Matrix n n ℝ) : Set ℝ :=
  {r | ∃ x : n → ℝ, vecNorm' x = 1 ∧ r = x ⬝ᵥ W *ᵥ x}

/-- `c(M) := sup 𝓡`（具体版 `Ising2D.rayleighSup` と同じ式）。 -/
noncomputable def rayleighSup' (W : Matrix n n ℝ) : ℝ := sSup (rayleighSet' W)

/-- `‖x‖ = 1` なら各 `i` について `|x_i| ≤ 1`（具体版 `Ising2D.abs_component_le_one_of_unit` と同じ 4 行の鎖と、二乗の大小からの結び）。 -/
theorem abs_component_le_one_of_unit' (x : n → ℝ) (hx : vecNorm' x = 1) (i : n) : |x i| ≤ 1 := by
  have hge : ∑ k, |x k| ^ 2 ≥ |x i| ^ 2 :=
    finite_sum_ge_term' (fun k => |x k| ^ 2) (fun k => sq_nonneg _) i       -- 非負の項の和は各項以上（`a_j → |x_j|^2`、`k → i`）
  have hsum_nonneg : 0 ≤ ∑ k, |x k| ^ 2 := le_trans (sq_nonneg _) hge       -- 鎖の前: `Σ|x_j|^2 ≥ |x_i|^2 ≥ 0`
  have hsq : |x i| ^ 2 ≤ 1 ^ 2 :=
    calc |x i| ^ 2
        ≤ ∑ k, |x k| ^ 2 := hge                                             -- 1 行目: 非負の項の和は各項以上
      _ = Real.sqrt (∑ k, |x k| ^ 2) ^ 2 := (Real.sq_sqrt hsum_nonneg).symm -- 2 行目: `√y` の二乗は `y`
      _ = vecNorm' x ^ 2 := by                                              -- 3 行目: ノルムの定義
          rw [vecNorm', vecNormSq'_eq_sum]
          simp only [sq_abs']                                               -- 具体版と同じく、`x⬝x = Σ x_k^2` と `Σ|x_k|^2` の書き方の差を埋める段
      _ = 1 ^ 2 := by rw [hx]                                               -- 4 行目: `‖x‖ = 1`
  have hmul : |x i| * |x i| ≤ 1 * 1 := by simpa only [sq] using hsq
  exact order_from_squares' zero_le_one hmul                                -- 二乗の大小から非負の数の大小（`u → |x_i|`、`v → 1`）

/-- `𝓡` は上に有界: 上界は `x` によらない `Σ_iΣ_j|W_ij|`（具体版 `Ising2D.rayleighSet_bddAbove` と同じ手順。`W` に仮定を置かない）。 -/
theorem rayleighSet'_bddAbove (W : Matrix n n ℝ) : BddAbove (rayleighSet' W) := by
  refine ⟨∑ i, ∑ j, |W i j|, ?_⟩
  rintro r ⟨x, hx, rfl⟩
  exact bilinear_le_abs_entry_sum' W x (abs_component_le_one_of_unit' x hx)  -- `‖x‖ = 1` から `|x_k| ≤ 1`、続けて外側の 4 行

/-- `‖e_1‖ = 1`（具体版 `Ising2D.vecNorm_single` と同じ鎖: `i ≠ 1` の `|(e_1)_i|^2 = |0|^2 = 0^2 = 0` と
`|(e_1)_1|^2 = |1|^2 = 1^2 = 1` の 3 行の鎖 2 本と、`‖e_1‖ = √(Σ_i|(e_1)_i|^2) = √(1 + 0 + ⋯ + 0) = √1 = 1` の 4 行の鎖）。 -/
theorem vecNorm'_single [DecidableEq n] (i₁ : n) : vecNorm' (Pi.single i₁ (1 : ℝ)) = 1 := by
  have hoff : ∀ i, i ≠ i₁ → |(Pi.single i₁ (1 : ℝ) : n → ℝ) i| ^ 2 = 0 := fun i hi =>
    calc |(Pi.single i₁ (1 : ℝ) : n → ℝ) i| ^ 2
        = |(0 : ℝ)| ^ 2 := by rw [Pi.single_eq_of_ne hi]                    -- `i ≠ 1` なので `(e_1)_i = 0`
      _ = (0 : ℝ) ^ 2 := by rw [abs_of_nonneg (le_refl (0 : ℝ))]            -- `0 ≥ 0` の場合 `|0| = 0`
      _ = 0 := zero_pow two_ne_zero                                         -- `0^2 = 0`
  have hon : |(Pi.single i₁ (1 : ℝ) : n → ℝ) i₁| ^ 2 = 1 :=
    calc |(Pi.single i₁ (1 : ℝ) : n → ℝ) i₁| ^ 2
        = |(1 : ℝ)| ^ 2 := by rw [Pi.single_eq_same]                        -- `(e_1)_1 = 1`
      _ = (1 : ℝ) ^ 2 := by rw [abs_of_nonneg (zero_le_one' ℝ)]             -- `1 ≥ 0` の場合 `|1| = 1`
      _ = 1 := one_pow' 2                                                   -- `1^m = 1`（`m → 2`）
  calc vecNorm' (Pi.single i₁ (1 : ℝ))
      = Real.sqrt (∑ i, |(Pi.single i₁ (1 : ℝ) : n → ℝ) i| ^ 2) := by
        rw [vecNorm', vecNormSq'_eq_sum]
        simp only [sq_abs']                                                 -- ノルムの定義（書き方の差は `abs_component_le_one_of_unit'` と同じ）
    _ = Real.sqrt (∑ i, if i = i₁ then (1 : ℝ) else 0) := by
        congr 1
        refine Finset.sum_congr rfl fun i _ => ?_
        by_cases h : i = i₁
        · rw [if_pos h, h, hon]
        · rw [if_neg h, hoff i h]                                           -- 上の 2 本の鎖を各項へ（`1 + 0 + ⋯ + 0`）
    _ = Real.sqrt 1 := by rw [Finset.sum_ite_eq' Finset.univ i₁, if_pos (Finset.mem_univ i₁)]
                                                                            -- `1 + 0 = 1` を左から順に
    _ = 1 := sqrt_one'                                                      -- `√1 = 1`

/-- `𝓡` は空でない（具体版 `Ising2D.rayleighSet_nonempty` と同じ手順: `e_1ᵀWe_1 ∈ 𝓡`）。 -/
theorem rayleighSet'_nonempty [DecidableEq n] [Nonempty n] (W : Matrix n n ℝ) : (rayleighSet' W).Nonempty := by
  obtain ⟨i⟩ := (inferInstance : Nonempty n)
  exact ⟨_, ⟨Pi.single i 1, vecNorm'_single i, rfl⟩⟩

/-! ## `𝓡_+` と `c_+(M) := sup 𝓡_+`（係数は `ℝ`） -/

/-- `𝓡_+ := {xᵀWx | εx = x, ‖x‖ = 1}`（具体版 `Ising2D.evenSectorSet` と同じ式）。 -/
def evenSectorSet' (W ε : Matrix n n ℝ) : Set ℝ :=
  {r | ∃ x : n → ℝ, ε *ᵥ x = x ∧ vecNorm' x = 1 ∧ r = x ⬝ᵥ W *ᵥ x}

/-- `c_+(M) := sup 𝓡_+`（具体版 `Ising2D.evenSectorRayleighSup` と同じ式）。 -/
noncomputable def evenSectorRayleighSup' (W ε : Matrix n n ℝ) : ℝ := sSup (evenSectorSet' W ε)

/-- `𝓡_+ ⊆ 𝓡`（具体版 `Ising2D.evenSectorSet_subset` と同じ手順）。 -/
theorem evenSectorSet'_subset (W ε : Matrix n n ℝ) : evenSectorSet' W ε ⊆ rayleighSet' W := by
  rintro r ⟨x, _, hx, rfl⟩
  exact ⟨x, hx, rfl⟩

/-- `𝓡_+` は上に有界（具体版 `Ising2D.evenSectorSet_bddAbove` と同じ手順: `𝓡_+ ⊆ 𝓡` と `𝓡` の有界性）。 -/
theorem evenSectorSet'_bddAbove (W ε : Matrix n n ℝ) : BddAbove (evenSectorSet' W ε) :=
  (rayleighSet'_bddAbove W).mono (evenSectorSet'_subset W ε)

/-- 偶セクターの単位ベクトルに対する `xᵀWx ≤ c_+(M)`（具体版 `Ising2D.le_evenSectorRayleighSup` と同じ手順: 上限は上界）。 -/
theorem le_evenSectorRayleighSup' {W ε : Matrix n n ℝ} {x : n → ℝ}
    (hx : ε *ᵥ x = x) (hx1 : vecNorm' x = 1) :
    x ⬝ᵥ W *ᵥ x ≤ evenSectorRayleighSup' W ε :=
  le_csSup (evenSectorSet'_bddAbove W ε) ⟨x, hx, hx1, rfl⟩

end Ising2D.NecSuf
