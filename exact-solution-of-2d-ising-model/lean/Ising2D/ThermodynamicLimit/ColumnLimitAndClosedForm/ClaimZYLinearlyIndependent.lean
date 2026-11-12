/-
# `Z_m, Y_m` は線型独立

対応する人手証明:
`parts/004_転送行列/001_claim_Z_mとY_mは線型独立.typ`
（構造化TeX: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts` の
ブロック `transfer_matrix_002_claim_Z_Y_linearly_independent`、ラベル `Z_Y_linearly_independent`）

原文の主張: `{Z_1, …, Z_M, Y_1, …, Y_M}` は線型独立。

**本ファイルを書いた時点では原文の証明は「TODO: 証明略」のまま**だったので、Lean 側で先に証明した
（`parts/006_ZとYの反交換関係` の `[Z_μ, Y_ν]₊` と同じパターン）。
その後、人手証明側でも別経路の証明（`{I, σ^x, σ^y, σ^z}^{⊗M}` が基底であることを使う筋）が
書かれている。両者は同じ主張の別証明であり、下記の Clifford 関係による証明の方が短い。

## 形式化にあたっての読み替え

原文は「集合 `{Z_1, …, Z_M, Y_1, …, Y_M}` が線型独立」と書くが、線型独立性は本来
**族**（添字づけられた列）の性質である。ここでは添字型を `Fin M ⊕ Fin M` にとった族
`ZY`（`inl m ↦ Z_m`, `inr m ↦ Y_m`）の線型独立性として述べる（`ZY_linearIndependent`）。
族としての線型独立は「`2M` 個の元がすべて相異なり、かつ集合として線型独立」を含意するので、
原文の主張より強い。集合としての形（`LinearIndepOn ℂ id (ZYSet M)`）も系として与える
（`ZYSet_linearIndepOn`）。

## 証明の方針（原文が省略した部分）

`parts/006_ZとYの反交換関係/000_claim_...` で証明した反交換関係

  `[Z_μ, Z_ν]₊ = 2 I δ_{μν}`,  `[Z_μ, Y_ν]₊ = 0`,  `[Y_μ, Y_ν]₊ = 2 I δ_{μν}`

は「`ZY` が Clifford 関係 `[e_a, e_b]₊ = 2 δ_{ab} I` を満たす」とまとめられる。
このとき `∑_a g_a e_a = 0` の両辺と `e_b` の反交換子をとると

  `0 = [∑_a g_a e_a, e_b]₊ = ∑_a g_a [e_a, e_b]₊ = 2 g_b I`

となり、`I ≠ 0` から `g_b = 0`。これが本ファイルの証明である
（反交換子の左線型性は `Ising2D.acomm_sum_smul_left`）。

## 人手証明の Step と 1 対 1 に対応する部分

いまの `ZY_linearIndependent` は上の Clifford 関係による別証明で、人手の Step 1〜6 とは対応しない。
人手の Step を 1 対 1 に辿る補題は、次の Step から順に足している。

| 人手の Step | Lean |
| --- | --- |
| Step 1 の「`𝓑` は張る」（`Z_Y_generate_algebra` の証明の Step 3 前半を引く） | `pauliFamily_spans` |
| Step 1 の `L := c_0 I + c_x σ^x + c_y σ^y + c_z σ^z` の 4 成分の鎖 | `pauliComb_apply_00`・`_01`・`_10`・`_11` |
| Step 1 の `L = O` から (p)〜(s) | `pauliComb_eq_zero_equations` |
| Step 1 の `c_0`・`c_z`・`c_x`・`ic_y`・`c_y` が零になる 5 本の鎖 | `pauliComb_coeff_zero_eq_zero`・`_z_`・`_x_`・`_I_mul_y_`・`_y_eq_zero` |
| Step 1 の結論「`𝓑` は線型独立」「張り、線型独立なので基底」 | `pauliComb_eq_zero_coeffs`・`pauliFamily_linearIndependent`・`pauliFamily_spans_and_linearIndependent` |

Step 1 の線型独立性の補題には必要十分版を置かない。主張 `Z_Y_linearly_independent` の中の Step の補題であり、
主張そのものの必要十分版は `NecSuf/CliffordIndependence.lean` に既に在るためである。
この補題で効いているのは、係数の積が可換であること・`2_ℂ` が可逆であること（準備 (a)。標数 2 では成り立たない）・
`(-i)i = 1_ℂ`（準備 (g)。`i` が単元であること）と、成分の定義だけである。
-/
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimZYGenerateAlgebra
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimAnticommutatorZY

namespace Ising2D

variable {M : ℕ}

/-- 原文の `Z_1, …, Z_M, Y_1, …, Y_M` を 1 つの族としてまとめたもの。
添字型 `Fin M ⊕ Fin M` の `inl` 側が `Z`、`inr` 側が `Y`。 -/
noncomputable def ZY : Fin M ⊕ Fin M → TensorPow M
  | Sum.inl m => Z m
  | Sum.inr m => Y m

@[simp] theorem ZY_inl (m : Fin M) : ZY (Sum.inl m) = Z m := rfl
@[simp] theorem ZY_inr (m : Fin M) : ZY (Sum.inr m) = Y m := rfl

/-- **`ZY` は Clifford 関係 `[e_a, e_b]₊ = 2 δ_{ab} I` を満たす。**

`parts/006_ZとYの反交換関係/000_claim_...` (`<anticommutator_of_Z_and_Y>`) の 3 式
（`anticomm_Z_Z`, `anticomm_Z_Y`, `anticomm_Y_Y` と対称版 `anticomm_Y_Z`）を
1 本にまとめた形。 -/
theorem acomm_ZY (a b : Fin M ⊕ Fin M) :
    acomm (ZY a) (ZY b) = (if a = b then (2 : ℂ) else 0) • (1 : TensorPow M) := by
  cases a with
  | inl μ =>
      cases b with
      | inl ν =>
          rw [ZY_inl, ZY_inl, anticomm_Z_Z, deltaM]
          by_cases h : μ = ν
          · rw [if_pos h, if_pos (congrArg Sum.inl h), mul_one]
          · rw [if_neg h, if_neg (fun he => h (Sum.inl.inj he)), mul_zero]
      | inr ν =>
          rw [ZY_inl, ZY_inr, anticomm_Z_Y, if_neg (by simp), zero_smul]
  | inr μ =>
      cases b with
      | inl ν =>
          rw [ZY_inr, ZY_inl, anticomm_Y_Z, if_neg (by simp), zero_smul]
      | inr ν =>
          rw [ZY_inr, ZY_inr, anticomm_Y_Y, deltaM]
          by_cases h : μ = ν
          · rw [if_pos h, if_pos (congrArg Sum.inr h), mul_one]
          · rw [if_neg h, if_neg (fun he => h (Sum.inr.inj he)), mul_zero]

/-- Clifford 関係を満たす族は線型独立、という一般補題（原文が省略した論証そのもの）。

`∑_a g_a e_a = 0` に `e_b` との反交換子をとると `2 g_b · 1 = 0` が出る。
`R` が非自明（`1 ≠ 0`）なら `g_b = 0`。 -/
theorem linearIndependent_of_clifford {ι : Type*} [Fintype ι] [DecidableEq ι]
    (e : ι → TensorPow M) (h : ∀ a b, acomm (e a) (e b) =
      (if a = b then (2 : ℂ) else 0) • (1 : TensorPow M)) :
    LinearIndependent ℂ e := by
  classical
  rw [Fintype.linearIndependent_iff]
  intro g hg b
  -- `[∑ₐ gₐ eₐ, e_b]₊ = ∑ₐ gₐ [eₐ, e_b]₊ = (g_b · 2) • 1`
  have hsum : acomm (∑ a, g a • e a) (e b) = (g b * 2) • (1 : TensorPow M) := by
    rw [acomm_sum_smul_left, Finset.sum_eq_single_of_mem b (Finset.mem_univ b)]
    · rw [h, if_pos rfl, smul_smul]
    · intro a _ hab
      rw [h, if_neg hab, zero_smul, smul_zero]
  -- 左辺は仮定より `[0, e_b]₊ = 0`
  have hzero : (g b * 2) • (1 : TensorPow M) = 0 := by
    rw [← hsum, hg, acomm, zero_mul, mul_zero, add_zero]
  -- 対角成分を見て `g b * 2 = 0`
  have hentry := congrArg (fun A : TensorPow M => A (default : Conf M) (default : Conf M)) hzero
  simp only [Matrix.smul_apply, Matrix.one_apply_eq, smul_eq_mul, mul_one,
    Matrix.zero_apply] at hentry
  exact by linear_combination hentry / 2

/-- **`<Z_m, Y_m は線型独立>` の形式化**（原文は「TODO: 証明略」）。

族 `(Z_1, …, Z_M, Y_1, …, Y_M)` は ℂ 上線型独立である。 -/
theorem ZY_linearIndependent (M : ℕ) :
    LinearIndependent ℂ (ZY : Fin M ⊕ Fin M → TensorPow M) :=
  linearIndependent_of_clifford ZY acomm_ZY

/-- 族としての線型独立から、`2M` 個の元がすべて相異なることが従う
（原文が集合 `{Z_1, …, Z_M, Y_1, …, Y_M}` と書いていることの正当化）。 -/
theorem ZY_injective (M : ℕ) : Function.Injective (ZY : Fin M ⊕ Fin M → TensorPow M) :=
  (ZY_linearIndependent M).injective

theorem ZYSet_eq_range (M : ℕ) : ZYSet M = Set.range (ZY : Fin M ⊕ Fin M → TensorPow M) := by
  ext v
  simp [ZYSet, Set.mem_range, Sum.exists, or_comm]

/-- 原文の字面どおり、**集合** `S = {Z_1, …, Z_M, Y_1, …, Y_M}` が線型独立であること。 -/
theorem ZYSet_linearIndepOn (M : ℕ) : LinearIndepOn ℂ id (ZYSet M) := by
  rw [ZYSet_eq_range]
  exact (ZY_linearIndependent M).linearIndepOn_id

/-! ## 人手 Step 1: `𝓑 = {I, σ^x, σ^y, σ^z}` は `Mat(2, ℂ)` の基底

人手証明の Step 1 は、`𝓑` が張ることを `Z_Y_generate_algebra` の証明の Step 3 前半から引き
（Lean は `pauliFamily_spans`）、線型独立性を成分の比較で示す。
`L := c_0 I + c_x σ^x + c_y σ^y + c_z σ^z` の 4 成分の鎖（`pauliComb_apply_00`〜`_11`）、
`L = O` から得る (p)〜(s)、係数が零になる 5 本の鎖（`pauliComb_coeff_*_eq_zero`）を 1 行ずつ辿る。
準備 (a)・(c)・(d)・(e) は `zy_prep_two_mul_mul_inv_two`・`zy_prep_add_neg`・`zy_prep_sum_add_diff`・
`zy_prep_sum_sub_diff`、(g) は `zy_prep_neg_I_mul_I` である（人手の添字 `1, 2` は Lean では `0, 1`）。
人手と同じく mathlib の基底の一般論（`Basis`）は使わない。 -/

/-- 人手 Step 1 の `L := c_0 I + c_x σ^x + c_y σ^y + c_z σ^z`（和は左から結ぶ）。 -/
noncomputable def pauliComb (c0 cx cy cz : ℂ) : Matrix (Fin 2) (Fin 2) ℂ :=
  c0 • (1 : Matrix (Fin 2) (Fin 2) ℂ) + cx • pauliX + cy • pauliY + cz • pauliZ

/-- 人手 Step 1 の `L_{11}` の鎖。 -/
theorem pauliComb_apply_00 (c0 cx cy cz : ℂ) : pauliComb c0 cx cy cz 0 0 = c0 + cz := by
  calc pauliComb c0 cx cy cz 0 0
      = (c0 • (1 : Matrix (Fin 2) (Fin 2) ℂ) + cx • pauliX + cy • pauliY + cz • pauliZ) 0 0 := rfl
                                                                      -- `L` の定義
    _ = (((c0 • (1 : Matrix (Fin 2) (Fin 2) ℂ)) 0 0 + (cx • pauliX) 0 0)
          + (cy • pauliY) 0 0) + (cz • pauliZ) 0 0 := by
          rw [matrix_sum_apply, matrix_sum_apply, matrix_sum_apply]    -- `def_matrix_sum` を 3 か所へ
    _ = ((c0 * (1 : Matrix (Fin 2) (Fin 2) ℂ) 0 0 + cx * pauliX 0 0)
          + cy * pauliY 0 0) + cz * pauliZ 0 0 := by
          rw [matrix_smul_apply, matrix_smul_apply, matrix_smul_apply, matrix_smul_apply]
                                                                      -- `def_matrix_scalar_multiple` を 4 か所へ
    _ = ((c0 * kroneckerDelta (0 : Fin 2) 0 + cx * pauliX 0 0)
          + cy * pauliY 0 0) + cz * pauliZ 0 0 := by
          rw [identity_matrix_apply]                                    -- `def_identity_matrix`
    _ = ((c0 * 1 + cx * pauliX 0 0) + cy * pauliY 0 0) + cz * pauliZ 0 0 := by
          rw [kroneckerDelta_self]                                      -- `def_kronecker_delta`
    _ = ((c0 * 1 + cx * 0) + cy * 0) + cz * 1 := by
          rw [pauliX_apply_00, pauliY_apply_00, pauliZ_apply_00]        -- `pauli_matrix_products` の `(1,1)` 成分
    _ = ((c0 * 1 + 0) + 0) + cz * 1 := by
          rw [mul_zero, mul_zero]                                       -- `complex_times_zero_is_zero` を 2 か所へ
    _ = c0 * 1 + cz * 1 := by rw [add_zero, add_zero]                 -- 加法の単位元を 2 か所へ
    _ = c0 + cz := by rw [mul_one, mul_one]                           -- 積の単位元を 2 か所へ

/-- 人手 Step 1 の `L_{12}` の鎖。 -/
theorem pauliComb_apply_01 (c0 cx cy cz : ℂ) :
    pauliComb c0 cx cy cz 0 1 = cx - Complex.I * cy := by
  calc pauliComb c0 cx cy cz 0 1
      = (c0 • (1 : Matrix (Fin 2) (Fin 2) ℂ) + cx • pauliX + cy • pauliY + cz • pauliZ) 0 1 := rfl
                                                                      -- `L` の定義
    _ = (((c0 • (1 : Matrix (Fin 2) (Fin 2) ℂ)) 0 1 + (cx • pauliX) 0 1)
          + (cy • pauliY) 0 1) + (cz • pauliZ) 0 1 := by
          rw [matrix_sum_apply, matrix_sum_apply, matrix_sum_apply]    -- `def_matrix_sum` を 3 か所へ
    _ = ((c0 * (1 : Matrix (Fin 2) (Fin 2) ℂ) 0 1 + cx * pauliX 0 1)
          + cy * pauliY 0 1) + cz * pauliZ 0 1 := by
          rw [matrix_smul_apply, matrix_smul_apply, matrix_smul_apply, matrix_smul_apply]
                                                                      -- `def_matrix_scalar_multiple` を 4 か所へ
    _ = ((c0 * kroneckerDelta (0 : Fin 2) 1 + cx * pauliX 0 1)
          + cy * pauliY 0 1) + cz * pauliZ 0 1 := by
          rw [identity_matrix_apply]                                    -- `def_identity_matrix`
    _ = ((c0 * 0 + cx * pauliX 0 1) + cy * pauliY 0 1) + cz * pauliZ 0 1 := by
          rw [kroneckerDelta_of_ne (by decide)]                         -- `def_kronecker_delta`
    _ = ((c0 * 0 + cx * 1) + cy * (-Complex.I)) + cz * 0 := by
          rw [pauliX_apply_01, pauliY_apply_01, pauliZ_apply_01]        -- `pauli_matrix_products` の `(1,2)` 成分
    _ = ((0 + cx * 1) + cy * (-Complex.I)) + 0 := by
          rw [mul_zero, mul_zero]                                       -- `complex_times_zero_is_zero` を 2 か所へ
    _ = cx * 1 + cy * (-Complex.I) := by rw [zero_add, add_zero]      -- 加法の単位元を 2 か所へ
    _ = cx + cy * (-Complex.I) := by rw [mul_one]                     -- 積の単位元
    _ = cx + (-Complex.I) * cy := by rw [mul_comm cy (-Complex.I)]    -- 積の可換律
    _ = cx + -(Complex.I * cy) := by rw [neg_I_mul_eq_neg_of_I_mul]   -- `negative_i_times_complex_is_negation_of_i_times`（`z → c_y`）
    _ = cx - Complex.I * cy := (sub_eq_add_neg _ _).symm              -- `def_complex_difference` を右辺から左辺へ

/-- 人手 Step 1 の `L_{21}` の鎖。 -/
theorem pauliComb_apply_10 (c0 cx cy cz : ℂ) :
    pauliComb c0 cx cy cz 1 0 = cx + Complex.I * cy := by
  calc pauliComb c0 cx cy cz 1 0
      = (c0 • (1 : Matrix (Fin 2) (Fin 2) ℂ) + cx • pauliX + cy • pauliY + cz • pauliZ) 1 0 := rfl
                                                                      -- `L` の定義
    _ = (((c0 • (1 : Matrix (Fin 2) (Fin 2) ℂ)) 1 0 + (cx • pauliX) 1 0)
          + (cy • pauliY) 1 0) + (cz • pauliZ) 1 0 := by
          rw [matrix_sum_apply, matrix_sum_apply, matrix_sum_apply]    -- `def_matrix_sum` を 3 か所へ
    _ = ((c0 * (1 : Matrix (Fin 2) (Fin 2) ℂ) 1 0 + cx * pauliX 1 0)
          + cy * pauliY 1 0) + cz * pauliZ 1 0 := by
          rw [matrix_smul_apply, matrix_smul_apply, matrix_smul_apply, matrix_smul_apply]
                                                                      -- `def_matrix_scalar_multiple` を 4 か所へ
    _ = ((c0 * kroneckerDelta (1 : Fin 2) 0 + cx * pauliX 1 0)
          + cy * pauliY 1 0) + cz * pauliZ 1 0 := by
          rw [identity_matrix_apply]                                    -- `def_identity_matrix`
    _ = ((c0 * 0 + cx * pauliX 1 0) + cy * pauliY 1 0) + cz * pauliZ 1 0 := by
          rw [kroneckerDelta_of_ne (by decide)]                         -- `def_kronecker_delta`
    _ = ((c0 * 0 + cx * 1) + cy * Complex.I) + cz * 0 := by
          rw [pauliX_apply_10, pauliY_apply_10, pauliZ_apply_10]        -- `pauli_matrix_products` の `(2,1)` 成分
    _ = ((0 + cx * 1) + cy * Complex.I) + 0 := by
          rw [mul_zero, mul_zero]                                       -- `complex_times_zero_is_zero` を 2 か所へ
    _ = cx * 1 + cy * Complex.I := by rw [zero_add, add_zero]         -- 加法の単位元を 2 か所へ
    _ = cx + cy * Complex.I := by rw [mul_one]                        -- 積の単位元
    _ = cx + Complex.I * cy := by rw [mul_comm cy Complex.I]          -- 積の可換律

/-- 人手 Step 1 の `L_{22}` の鎖。 -/
theorem pauliComb_apply_11 (c0 cx cy cz : ℂ) : pauliComb c0 cx cy cz 1 1 = c0 - cz := by
  calc pauliComb c0 cx cy cz 1 1
      = (c0 • (1 : Matrix (Fin 2) (Fin 2) ℂ) + cx • pauliX + cy • pauliY + cz • pauliZ) 1 1 := rfl
                                                                      -- `L` の定義
    _ = (((c0 • (1 : Matrix (Fin 2) (Fin 2) ℂ)) 1 1 + (cx • pauliX) 1 1)
          + (cy • pauliY) 1 1) + (cz • pauliZ) 1 1 := by
          rw [matrix_sum_apply, matrix_sum_apply, matrix_sum_apply]    -- `def_matrix_sum` を 3 か所へ
    _ = ((c0 * (1 : Matrix (Fin 2) (Fin 2) ℂ) 1 1 + cx * pauliX 1 1)
          + cy * pauliY 1 1) + cz * pauliZ 1 1 := by
          rw [matrix_smul_apply, matrix_smul_apply, matrix_smul_apply, matrix_smul_apply]
                                                                      -- `def_matrix_scalar_multiple` を 4 か所へ
    _ = ((c0 * kroneckerDelta (1 : Fin 2) 1 + cx * pauliX 1 1)
          + cy * pauliY 1 1) + cz * pauliZ 1 1 := by
          rw [identity_matrix_apply]                                    -- `def_identity_matrix`
    _ = ((c0 * 1 + cx * pauliX 1 1) + cy * pauliY 1 1) + cz * pauliZ 1 1 := by
          rw [kroneckerDelta_self]                                      -- `def_kronecker_delta`
    _ = ((c0 * 1 + cx * 0) + cy * 0) + cz * (-1) := by
          rw [pauliX_apply_11, pauliY_apply_11, pauliZ_apply_11]        -- `pauli_matrix_products` の `(2,2)` 成分
    _ = ((c0 * 1 + 0) + 0) + cz * (-1) := by
          rw [mul_zero, mul_zero]                                       -- `complex_times_zero_is_zero` を 2 か所へ
    _ = c0 * 1 + cz * (-1) := by rw [add_zero, add_zero]              -- 加法の単位元を 2 か所へ
    _ = c0 + cz * (-1) := by rw [mul_one]                             -- 積の単位元
    _ = c0 + (-1) * cz := by rw [mul_comm cz (-1)]                    -- 積の可換律
    _ = c0 + -cz := by rw [neg_one_mul]                               -- `multiply_by_minus_one`（`z → c_z`）を右辺から左辺へ
    _ = c0 - cz := (sub_eq_add_neg _ _).symm                          -- `def_complex_difference` を右辺から左辺へ

/-- 人手 Step 1 の (p)〜(s): それぞれ `L_{ij}` の鎖・`L = O`・`def_zero_matrix` の 3 行の鎖。 -/
theorem pauliComb_eq_zero_equations {c0 cx cy cz : ℂ} (h : pauliComb c0 cx cy cz = 0) :
    c0 + cz = 0 ∧ cx - Complex.I * cy = 0 ∧ cx + Complex.I * cy = 0 ∧ c0 - cz = 0 := by
  refine ⟨?_, ?_, ?_, ?_⟩
  · calc c0 + cz = pauliComb c0 cx cy cz 0 0 := (pauliComb_apply_00 _ _ _ _).symm   -- `L_{11}` の鎖を右辺から左辺へ
      _ = (0 : Matrix (Fin 2) (Fin 2) ℂ) 0 0 := by rw [h]                          -- `L = O`
      _ = 0 := matrix_zero_apply _ _                                                -- `def_zero_matrix`
  · calc cx - Complex.I * cy = pauliComb c0 cx cy cz 0 1 := (pauliComb_apply_01 _ _ _ _).symm  -- `L_{12}` の鎖を右辺から左辺へ
      _ = (0 : Matrix (Fin 2) (Fin 2) ℂ) 0 1 := by rw [h]                          -- `L = O`
      _ = 0 := matrix_zero_apply _ _                                                -- `def_zero_matrix`
  · calc cx + Complex.I * cy = pauliComb c0 cx cy cz 1 0 := (pauliComb_apply_10 _ _ _ _).symm  -- `L_{21}` の鎖を右辺から左辺へ
      _ = (0 : Matrix (Fin 2) (Fin 2) ℂ) 1 0 := by rw [h]                          -- `L = O`
      _ = 0 := matrix_zero_apply _ _                                                -- `def_zero_matrix`
  · calc c0 - cz = pauliComb c0 cx cy cz 1 1 := (pauliComb_apply_11 _ _ _ _).symm   -- `L_{22}` の鎖を右辺から左辺へ
      _ = (0 : Matrix (Fin 2) (Fin 2) ℂ) 1 1 := by rw [h]                          -- `L = O`
      _ = 0 := matrix_zero_apply _ _                                                -- `def_zero_matrix`

/-- 人手 Step 1 の `c_0 = 0_ℂ` の鎖（(p)・(s) から）。 -/
theorem pauliComb_coeff_zero_eq_zero {c0 cz : ℂ} (hp : c0 + cz = 0) (hs : c0 - cz = 0) :
    c0 = 0 := by
  calc c0
      = (2 * c0) * 2⁻¹ := (zy_prep_two_mul_mul_inv_two c0).symm         -- (a)（`z → c_0`）を右辺から左辺へ
    _ = ((c0 + cz) + (c0 - cz)) * 2⁻¹ := by rw [zy_prep_sum_add_diff c0 cz]  -- (d)（`z → c_0, w → c_z`）を右辺から左辺へ
    _ = (0 + (c0 - cz)) * 2⁻¹ := by rw [hp]                           -- (p)
    _ = (0 + 0) * 2⁻¹ := by rw [hs]                                   -- (s)
    _ = 0 * 2⁻¹ := by rw [add_zero]                                   -- 加法の単位元
    _ = 0 := zero_mul _                                               -- `complex_zero_times_is_zero`（`z → 2_ℂ^{-1}`）

/-- 人手 Step 1 の `c_z = 0_ℂ` の鎖（(p)・(s) から）。 -/
theorem pauliComb_coeff_z_eq_zero {c0 cz : ℂ} (hp : c0 + cz = 0) (hs : c0 - cz = 0) :
    cz = 0 := by
  calc cz
      = (2 * cz) * 2⁻¹ := (zy_prep_two_mul_mul_inv_two cz).symm         -- (a)（`z → c_z`）を右辺から左辺へ
    _ = ((c0 + cz) - (c0 - cz)) * 2⁻¹ := by rw [zy_prep_sum_sub_diff c0 cz]  -- (e)（`z → c_0, w → c_z`）を右辺から左辺へ
    _ = (0 - (c0 - cz)) * 2⁻¹ := by rw [hp]                           -- (p)
    _ = (0 - 0) * 2⁻¹ := by rw [hs]                                   -- (s)
    _ = (0 + -0) * 2⁻¹ := by rw [sub_eq_add_neg]                      -- `def_complex_difference`
    _ = 0 * 2⁻¹ := by rw [zy_prep_add_neg]                            -- (c)（`z → 0_ℂ`）
    _ = 0 := zero_mul _                                               -- `complex_zero_times_is_zero`（`z → 2_ℂ^{-1}`）

/-- 人手 Step 1 の `c_x = 0_ℂ` の鎖（(r)・(q) から）。 -/
theorem pauliComb_coeff_x_eq_zero {cx cy : ℂ} (hq : cx - Complex.I * cy = 0)
    (hr : cx + Complex.I * cy = 0) : cx = 0 := by
  calc cx
      = (2 * cx) * 2⁻¹ := (zy_prep_two_mul_mul_inv_two cx).symm         -- (a)（`z → c_x`）を右辺から左辺へ
    _ = ((cx + Complex.I * cy) + (cx - Complex.I * cy)) * 2⁻¹ := by
          rw [zy_prep_sum_add_diff cx (Complex.I * cy)]                -- (d)（`z → c_x, w → ic_y`）を右辺から左辺へ
    _ = (0 + (cx - Complex.I * cy)) * 2⁻¹ := by rw [hr]               -- (r)
    _ = (0 + 0) * 2⁻¹ := by rw [hq]                                   -- (q)
    _ = 0 * 2⁻¹ := by rw [add_zero]                                   -- 加法の単位元
    _ = 0 := zero_mul _                                               -- `complex_zero_times_is_zero`（`z → 2_ℂ^{-1}`）

/-- 人手 Step 1 の `ic_y = 0_ℂ` の鎖（(r)・(q) から）。 -/
theorem pauliComb_coeff_I_mul_y_eq_zero {cx cy : ℂ} (hq : cx - Complex.I * cy = 0)
    (hr : cx + Complex.I * cy = 0) : Complex.I * cy = 0 := by
  calc Complex.I * cy
      = (2 * (Complex.I * cy)) * 2⁻¹ := (zy_prep_two_mul_mul_inv_two _).symm  -- (a)（`z → ic_y`）を右辺から左辺へ
    _ = ((cx + Complex.I * cy) - (cx - Complex.I * cy)) * 2⁻¹ := by
          rw [zy_prep_sum_sub_diff cx (Complex.I * cy)]                -- (e)（`z → c_x, w → ic_y`）を右辺から左辺へ
    _ = (0 - (cx - Complex.I * cy)) * 2⁻¹ := by rw [hr]               -- (r)
    _ = (0 - 0) * 2⁻¹ := by rw [hq]                                   -- (q)
    _ = (0 + -0) * 2⁻¹ := by rw [sub_eq_add_neg]                      -- `def_complex_difference`
    _ = 0 * 2⁻¹ := by rw [zy_prep_add_neg]                            -- (c)（`z → 0_ℂ`）
    _ = 0 := zero_mul _                                               -- `complex_zero_times_is_zero`（`z → 2_ℂ^{-1}`）

/-- 人手 Step 1 の `c_y = 0_ℂ` の鎖（`ic_y = 0_ℂ` から）。 -/
theorem pauliComb_coeff_y_eq_zero {cy : ℂ} (h : Complex.I * cy = 0) : cy = 0 := by
  calc cy
      = 1 * cy := (one_mul cy).symm                                   -- 積の単位元を右辺から左辺へ
    _ = ((-Complex.I) * Complex.I) * cy := by rw [zy_prep_neg_I_mul_I]  -- (g) を右辺から左辺へ
    _ = (-Complex.I) * (Complex.I * cy) := mul_assoc _ _ _            -- 積の結合律
    _ = (-Complex.I) * 0 := by rw [h]                                 -- 上の `ic_y = 0_ℂ`
    _ = 0 := mul_zero _                                               -- `complex_times_zero_is_zero`（`z → -i`）

/-- 人手 Step 1 の線型独立性: `c_0 I + c_x σ^x + c_y σ^y + c_z σ^z = O` ならば `c_0 = c_x = c_y = c_z = 0_ℂ`。 -/
theorem pauliComb_eq_zero_coeffs {c0 cx cy cz : ℂ} (h : pauliComb c0 cx cy cz = 0) :
    c0 = 0 ∧ cx = 0 ∧ cy = 0 ∧ cz = 0 := by
  obtain ⟨hp, hq, hr, hs⟩ := pauliComb_eq_zero_equations h
  exact ⟨pauliComb_coeff_zero_eq_zero hp hs, pauliComb_coeff_x_eq_zero hq hr,
    pauliComb_coeff_y_eq_zero (pauliComb_coeff_I_mul_y_eq_zero hq hr),
    pauliComb_coeff_z_eq_zero hp hs⟩

/-- 人手 Step 1 の「よって `𝓑` は線型独立である」を族 `pauliFamily`（`e_1, …, e_4` は Lean の添字 `0, …, 3`）について述べた形。 -/
theorem pauliFamily_linearIndependent : LinearIndependent ℂ pauliFamily := by
  rw [Fintype.linearIndependent_iff]
  intro g hg
  have hcomb : pauliComb (g 0) (g 1) (g 2) (g 3) = 0 := by
    rw [← hg, Fin.sum_univ_four]
    rfl
  obtain ⟨h0, h1, h2, h3⟩ := pauliComb_eq_zero_coeffs hcomb
  intro a
  fin_cases a
  · exact h0
  · exact h1
  · exact h2
  · exact h3

/-- 人手 Step 1 の結論「`𝓑` は `Mat(2,ℂ)` を張り、かつ線型独立なので基底である」
（張ることは `pauliFamily_spans`。人手と同じく基底を「張り、線型独立」として述べる）。 -/
theorem pauliFamily_spans_and_linearIndependent :
    (∀ A : Matrix (Fin 2) (Fin 2) ℂ, ∃ c : Fin 4 → ℂ, A = ∑ a, c a • pauliFamily a) ∧
      LinearIndependent ℂ pauliFamily :=
  ⟨pauliFamily_spans, pauliFamily_linearIndependent⟩

end Ising2D
