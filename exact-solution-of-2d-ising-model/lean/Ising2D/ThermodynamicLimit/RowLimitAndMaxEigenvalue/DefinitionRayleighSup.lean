/-
# `c(M) := sup_{‖x‖=1} xᵀ W x` の定義

正本: `structured-latex/content/thermodynamic_limit_row_limit_and_max_eigenvalue.ts`
（`maxeig_006_definition_rayleigh_sup`、ラベル **`def_rayleigh_sup`**）

人手証明のとおり、**`c(M)` は最大固有値ではなく Rayleigh 商の上限として定義する。**
上限が達成されること（固有値の存在・スペクトル定理）はここでも以降でも一切使わない。

上に有界であることは、人手証明と同じく、成分の有限和 `x^⊤Wx ≤ |x^⊤Wx| ≤ Σ_iΣ_j|W_ij|` で示す（`rayleighSet_bddAbove`）。
この評価は `W` の対称性も半正定値性も使わないので、`rayleighSet_bddAbove`・`le_rayleighSup`・`quad_le_rayleighSup_mul` は `W` に仮定を置かない。
このファイルで半正定値性・正定値性を使うのは `c(M) ≥ 0`（`rayleighSup_nonneg`）・`c(M) > 0`（`rayleighSup_pos`）だけである。

`def_rayleigh_sup`（`sSup`）の必要十分版はない（`sSup` は ℝ の完備性そのものなので、ほどく余地がない）。

上に有界であることを示す人手の鎖と Lean の対応:

| 人手の段 | Lean |
| --- | --- |
| `‖x‖ = 1` から `|x_i| ≤ 1`（4 行と `nonnegative_real_order_from_squares`） | `abs_component_le_one_of_unit` |
| 項ごとの 6 行 `|x_iW_ijx_j| = … ≤ |W_ij|` | `abs_bilinear_term_le_abs_entry` |
| 各 `i` の 2 行 `|Σ_j x_iW_ijx_j| ≤ Σ_j|x_iW_ijx_j| ≤ Σ_j|W_ij|` | `abs_bilinear_row_le_row_abs_sum` |
| 外側の 4 行 `x^⊤Wx ≤ |x^⊤Wx| = |ΣΣ x_iW_ijx_j| ≤ Σ_i|Σ_j …| ≤ ΣΣ|W_ij|` | `bilinear_le_abs_entry_sum` |
| `𝓡` は上に有界 | `rayleighSet_bddAbove` |

人手の `x^⊤Wx` は `def_real_bilinear_value` の `Σ_kΣ_l (x_kW_kl)x_l` で、Lean の `x ⬝ᵥ W *ᵥ x` は `Σ_k x_k (Σ_l W_kl x_l)` である。
`dotProduct_mulVec_eq_real_bilinear_value` が mathlib の `⬝ᵥ`・`*ᵥ` の定義を人手の和の形へ開く（`def_real_bilinear_value` の行に当たる）。
有限和の主張は、添字が有限型 `n` の和に当てる `_fintype` 版（`ClaimFiniteSumsOfRealNumbers.lean`）を引く。
-/
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.TraceBound
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimFiniteSumsOfRealNumbers
import Ising2D.MathematicalTools.RealSquareRootExponentialAndHyperbolicFunctions.ClaimNonnegativeRealOrderFromSquares
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimRealAbsoluteValueBoundsTriangleAndProduct

set_option linter.unusedSectionVars false

namespace Ising2D

open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- スカラー倍に対する 2 次形式の振る舞い `(cx)ᵀA(cx) = c²(xᵀAx)`。 -/
theorem quad_smul (A : Matrix n n ℝ) (c : ℝ) (x : n → ℝ) :
    (c • x) ⬝ᵥ A *ᵥ (c • x) = c ^ 2 * (x ⬝ᵥ A *ᵥ x) := by
  rw [Matrix.mulVec_smul, smul_dotProduct, dotProduct_smul, smul_eq_mul, smul_eq_mul]
  ring

/-- 人手 `def_rayleigh_sup` の、上に有界であることを示す段の前半: `‖x‖ = 1` なら各 `i` について `|x_i| ≤ 1`。
Lean の `𝓡`（`rayleighSet`）は `‖x‖ = 1` を `vecNormSq x = 1`（`‖x‖^2 = xᵀx = 1`）で書くので、
ここでも `vecNormSq x = 1` を受け取り、そこから `‖x‖ = √1 = 1` を出してから人手の 4 行に入る。 -/
theorem abs_component_le_one_of_unit (x : n → ℝ) (hx : vecNormSq x = 1) (i : n) : |x i| ≤ 1 := by
  have hnorm : vecNorm x = 1 := by                                          -- Lean の `𝓡` の条件を `‖x‖ = 1` に読む
    rw [vecNorm, hx, Real.sqrt_one]
  have hge : ∑ k, |x k| ^ 2 ≥ |x i| ^ 2 :=
    finite_sum_of_nonnegative_reals_ge_term_fintype (fun k => |x k| ^ 2)
      (fun k => sq_nonneg _) i                                              -- `finite_sum_of_nonnegative_reals_is_at_least_each_term`（`a_j → |x_j|^2`、`k → i`）
  have hsum_nonneg : 0 ≤ ∑ k, |x k| ^ 2 := le_trans (sq_nonneg _) hge       -- 鎖の前: `Σ|x_j|^2 ≥ |x_i|^2 ≥ 0`
  have hsq : |x i| ^ 2 ≤ 1 ^ 2 :=
    calc |x i| ^ 2
        ≤ ∑ k, |x k| ^ 2 := hge                                             -- 1 行目: `finite_sum_of_nonnegative_reals_is_at_least_each_term`（`a_j → |x_j|^2`、`k → i`）
      _ = Real.sqrt (∑ k, |x k| ^ 2) ^ 2 :=
          (Real.sq_sqrt hsum_nonneg).symm                                   -- 2 行目: `definition_of_sqrt_r_positive` の `y^2 = x`
      _ = vecNorm x ^ 2 := by                                               -- 3 行目: `def_matrix_norm` の `‖w‖`
          rw [vecNorm, vecNormSq_eq_sum]
          simp only [sq_abs]                                                -- `sq_abs` は人手の行ではない。Lean の `vecNormSq`（`x⬝x = Σ x_k^2`）と
                                                                            -- `def_matrix_norm`（`Σ|w_k|^2`）の書き方の差を埋める段
      _ = 1 ^ 2 := by rw [hnorm]                                            -- 4 行目: `‖x‖ = 1`
  exact nonnegative_real_order_from_squares (abs_nonneg _) zero_le_one hsq  -- `nonnegative_real_order_from_squares`（`u → |x_i|`、`v → 1`）

/-- 人手証明の `𝓡 = {xᵀWx | ‖x‖ = 1}`。 -/
def rayleighSet (W : Matrix n n ℝ) : Set ℝ :=
  {r | ∃ x : n → ℝ, vecNormSq x = 1 ∧ r = x ⬝ᵥ W *ᵥ x}

/-- 人手証明の `c(M) := sup 𝓡`。 -/
noncomputable def rayleighSup (W : Matrix n n ℝ) : ℝ := sSup (rayleighSet W)

/-- 人手 `def_real_bilinear_value` の行: Lean の `x ⬝ᵥ P *ᵥ y`（`Σ_k x_k (Σ_l P_kl y_l)`）を、人手の `Σ_kΣ_l (x_kP_kl)y_l` へ開く。
mathlib の `⬝ᵥ`・`*ᵥ` の定義を開き（`dotProduct`・`mulVec`）、`x_k` を内側の和へ入れ（`Finset.mul_sum`）、積の括弧を付け替える（`mul_assoc`）。 -/
theorem dotProduct_mulVec_eq_real_bilinear_value (x y : n → ℝ) (P : Matrix n n ℝ) :
    x ⬝ᵥ P *ᵥ y = ∑ k, ∑ l, x k * P k l * y l :=
  calc x ⬝ᵥ P *ᵥ y
      = ∑ k, x k * ∑ l, P k l * y l := rfl                                    -- `⬝ᵥ`・`*ᵥ` の定義を開く
    _ = ∑ k, ∑ l, x k * (P k l * y l) := by simp only [Finset.mul_sum]         -- `x_k` を内側の和へ入れる
    _ = ∑ k, ∑ l, x k * P k l * y l := by simp only [mul_assoc]                -- 積の括弧を付け替える

/-- 人手 `def_rayleigh_sup` の項ごとの 6 行: すべての `k` で `|x_k| ≤ 1` なら `|x_iW_ijx_j| ≤ |W_ij|`。 -/
theorem abs_bilinear_term_le_abs_entry (W : Matrix n n ℝ) (x : n → ℝ) (hx : ∀ k, |x k| ≤ 1) (i j : n) :
    |x i * W i j * x j| ≤ |W i j| := by
  have hnn : 0 ≤ |x i| * |W i j| := mul_nonneg (abs_nonneg _) (abs_nonneg _) -- 非負の実数の積
  calc |x i * W i j * x j|
      = |x i * W i j| * |x j| := real_abs_of_product _ _                     -- `real_abs_of_product`（`a → x_iW_ij`、`b → x_j`）
    _ = |x i| * |W i j| * |x j| := by rw [real_abs_of_product (x i) (W i j)] -- `real_abs_of_product`（`a → x_i`、`b → W_ij`）
    _ ≤ |x i| * |W i j| * 1 := mul_le_mul_of_nonneg_left (hx j) hnn          -- `|x_j| ≤ 1` の両辺に非負の実数 `|x_i||W_ij|` を左から掛ける
    _ = |x i| * |W i j| := mul_one _                                          -- 1 は ℝ の積の単位元
    _ ≤ 1 * |W i j| := mul_le_mul_of_nonneg_right (hx i) (abs_nonneg _)       -- `|x_i| ≤ 1` の両辺に非負の実数 `|W_ij|` を右から掛ける
    _ = |W i j| := one_mul _                                                  -- 1 は ℝ の積の単位元

/-- 人手 `def_rayleigh_sup` の各 `i` の 2 行: `|Σ_j x_iW_ijx_j| ≤ Σ_j|x_iW_ijx_j| ≤ Σ_j|W_ij|`。 -/
theorem abs_bilinear_row_le_row_abs_sum (W : Matrix n n ℝ) (x : n → ℝ) (hx : ∀ k, |x k| ≤ 1) (i : n) :
    |∑ j, x i * W i j * x j| ≤ ∑ j, |W i j| :=
  calc |∑ j, x i * W i j * x j|
      ≤ ∑ j, |x i * W i j * x j| :=
        finite_sum_of_real_numbers_triangle_inequality_fintype _              -- `finite_sum_of_real_numbers_triangle_inequality`（`a_j → x_iW_ijx_j`）
    _ ≤ ∑ j, |W i j| :=
        finite_sum_of_real_numbers_is_monotone_fintype _ _
          (abs_bilinear_term_le_abs_entry W x hx i)                           -- `finite_sum_of_real_numbers_is_monotone`。各 `j` の大小は項ごとの 6 行

/-- 人手 `def_rayleigh_sup` の外側の 4 行: すべての `k` で `|x_k| ≤ 1` なら `x^⊤Wx ≤ Σ_iΣ_j|W_ij|`。 -/
theorem bilinear_le_abs_entry_sum (W : Matrix n n ℝ) (x : n → ℝ) (hx : ∀ k, |x k| ≤ 1) :
    x ⬝ᵥ W *ᵥ x ≤ ∑ i, ∑ j, |W i j| :=
  calc x ⬝ᵥ W *ᵥ x
      ≤ |x ⬝ᵥ W *ᵥ x| := real_number_is_at_most_its_absolute_value _        -- `real_number_is_at_most_its_absolute_value`（`q → x^⊤Wx`）
    _ = |∑ i, ∑ j, x i * W i j * x j| := by
        rw [dotProduct_mulVec_eq_real_bilinear_value]                         -- `def_real_bilinear_value`（`P → W`、`y → x`）
    _ ≤ ∑ i, |∑ j, x i * W i j * x j| :=
        finite_sum_of_real_numbers_triangle_inequality_fintype _              -- `finite_sum_of_real_numbers_triangle_inequality`（`a_i → Σ_j x_iW_ijx_j`）
    _ ≤ ∑ i, ∑ j, |W i j| :=
        finite_sum_of_real_numbers_is_monotone_fintype _ _
          (abs_bilinear_row_le_row_abs_sum W x hx)                            -- `finite_sum_of_real_numbers_is_monotone`。各 `i` の大小は各 `i` の 2 行

/-- 人手 `def_rayleigh_sup` の「`𝓡` は上に有界」: 上界は `x` によらない `Σ_iΣ_j|W_ij|`。`W` に仮定を置かない。 -/
theorem rayleighSet_bddAbove (W : Matrix n n ℝ) : BddAbove (rayleighSet W) := by
  refine ⟨∑ i, ∑ j, |W i j|, ?_⟩
  rintro r ⟨x, hx, rfl⟩
  exact bilinear_le_abs_entry_sum W x (abs_component_le_one_of_unit x hx)     -- `‖x‖ = 1` から `|x_k| ≤ 1`、続けて外側の 4 行

/-- 単位ベクトルに対する `xᵀWx ≤ c(M)`。 -/
theorem le_rayleighSup {W : Matrix n n ℝ} {x : n → ℝ} (hx : vecNormSq x = 1) :
    x ⬝ᵥ W *ᵥ x ≤ rayleighSup W :=
  le_csSup (rayleighSet_bddAbove W) ⟨x, hx, rfl⟩

/-- 人手証明の `xᵀWx ≤ c(M)‖x‖²`（任意の `x`）。 -/
theorem quad_le_rayleighSup_mul {W : Matrix n n ℝ} (x : n → ℝ) :
    x ⬝ᵥ W *ᵥ x ≤ rayleighSup W * vecNormSq x := by
  rcases eq_or_ne x 0 with rfl | hx
  · simp [vecNormSq]
  · have ha : 0 < vecNormSq x := vecNormSq_pos hx
    set a := vecNormSq x with hadef
    set c : ℝ := (Real.sqrt a)⁻¹ with hcdef
    have hsq : Real.sqrt a ^ 2 = a := Real.sq_sqrt ha.le
    have hsqrt_pos : 0 < Real.sqrt a := Real.sqrt_pos.mpr ha
    have hc2 : c ^ 2 = a⁻¹ := by
      rw [hcdef, inv_pow, hsq]
    have hunit : vecNormSq (c • x) = 1 := by
      rw [vecNormSq_smul, ← hadef, hc2, inv_mul_cancel₀ (ne_of_gt ha)]
    have hle := le_rayleighSup (W := W) hunit
    rw [quad_smul, hc2] at hle
    calc x ⬝ᵥ W *ᵥ x = a * (a⁻¹ * (x ⬝ᵥ W *ᵥ x)) := by
          field_simp
      _ ≤ a * rayleighSup W := by
          exact mul_le_mul_of_nonneg_left hle ha.le
      _ = rayleighSup W * a := by ring

variable [Nonempty n]

theorem rayleighSet_nonempty (W : Matrix n n ℝ) : (rayleighSet W).Nonempty := by
  obtain ⟨i⟩ := (inferInstance : Nonempty n)
  exact ⟨_, ⟨Pi.single i 1, vecNormSq_single i, rfl⟩⟩

/-- `c(M) ≥ 0`（`W` の半正定値性だけを使う）。 -/
theorem rayleighSup_nonneg {W : Matrix n n ℝ}
    (hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) : 0 ≤ rayleighSup W := by
  obtain ⟨i⟩ := (inferInstance : Nonempty n)
  exact le_trans (hpsd (Pi.single i 1)) (le_rayleighSup (W := W) (vecNormSq_single i))

/-- `c(M) > 0`（`W` の正定値性だけを使う）。 -/
theorem rayleighSup_pos {W : Matrix n n ℝ}
    (hpd : ∀ x : n → ℝ, x ≠ 0 → 0 < x ⬝ᵥ W *ᵥ x) : 0 < rayleighSup W := by
  have hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x := by
    intro x
    rcases eq_or_ne x 0 with rfl | hx
    · simp
    · exact (hpd x hx).le
  obtain ⟨i⟩ := (inferInstance : Nonempty n)
  have hne : (Pi.single i 1 : n → ℝ) ≠ 0 := by
    intro h
    have hu := vecNormSq_single (n := n) i
    rw [h] at hu
    simp [vecNormSq] at hu
  exact lt_of_lt_of_le (hpd _ hne) (le_rayleighSup (W := W) (vecNormSq_single i))

end Ising2D
