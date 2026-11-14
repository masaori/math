/-
# `Z_m, Y_m` は線型独立

対応する人手証明:
`parts/004_転送行列/001_claim_Z_mとY_mは線型独立.typ`
（構造化TeX: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts` の
ブロック `transfer_matrix_002_claim_Z_Y_linearly_independent`、ラベル `Z_Y_linearly_independent`）

原文の主張: `{Z_1, …, Z_M, Y_1, …, Y_M}` は線型独立。

**本ファイルを書いた時点では原文の証明は「TODO: 証明略」のまま**だったので、Lean 側で先に証明した
（`parts/006_ZとYの反交換関係` の `[Z_μ, Y_ν]₊` と同じパターン）。
その後、人手証明側でも別経路の証明（`I, σ^x, σ^y, σ^z` のクロネッカー積の族 `(F_q)` が線型独立であることを使う筋）が
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
人手は多重添字の集合 `𝒫 = {1,2,3,4}^M` を全単射 `π : {1, …, N} → 𝒫` で並べて `F_q`（`q ∈ {1, …, N}`）と書くが、
Lean は `kronecker_family_of_independent_family_is_independent` と同じく多重添字 `p : Fin M → Fin 4` を添字とする有限和で書く
（`ClaimKroneckerFamilyOfIndependentFamilyIsIndependent.lean` の記号の読み替え）。

| 人手の Step | Lean |
| --- | --- |
| Step 1 の `L := c_0 I + c_x σ^x + c_y σ^y + c_z σ^z` の 4 成分の鎖 | `pauliComb_apply_00`・`_01`・`_10`・`_11` |
| Step 1 の `L = O` から (p)〜(s) | `pauliComb_eq_zero_equations` |
| Step 1 の `c_0`・`c_z`・`c_x`・`ic_y`・`c_y` が零になる 5 本の鎖 | `pauliComb_coeff_zero_eq_zero`・`_z_`・`_x_`・`_I_mul_y_`・`_y_eq_zero` |
| Step 1 の結論「`𝓑` は線型独立」（`L = O` ならば係数はすべて `0_ℂ`） | `pauliComb_eq_zero_coeffs` |
| Step 1 の番号付け `e_1, e_2, e_3, e_4 := I, σ^x, σ^y, σ^z` | `pauliFamily`（`ClaimZYGenerateAlgebra.lean`。Lean の添字は `0, …, 3`） |
| Step 2 の `F_q := e_{π(q)_1} ⊠ ⋯ ⊠ e_{π(q)_M}` | `pauliKroneckerFamily` |
| Step 2 の `((c_1I+c_2σ^x)+c_3σ^y)+c_4σ^z = ⋯ = O` の 6 行の鎖 | 最後の行（仮定）を除く 5 行は `pauliComb_eq_sum_pauliFamily`、最後の行は `pauliFamily_sum_eq_zero_coeffs` の `.trans h` |
| Step 2 の「Step 1 の線型独立性より `c_1 = ⋯ = c_4 = 0_ℂ`」 | `pauliFamily_sum_eq_zero_coeffs`（`pauliFamily_linearIndependent` は同じ線型独立性を mathlib の `LinearIndependent` の形で述べた系） |
| Step 2 の「`kronecker_family_of_independent_family_is_independent` より族 `(F_q)` は線型独立」 | `pauliKroneckerFamily_independent` |
| Step 6 のクロネッカーのデルタ `δ_{qq'}`（`def_kronecker_delta` の `n → N`） | `multiIndexDelta`（添字は多重添字。値は `multiIndexDelta_self`・`multiIndexDelta_of_ne`） |
| Step 6 の係数の族 `d_q := Σ_m α_mδ_{q q_Z(m)} + Σ_m β_mδ_{q q_Y(m)}` | `zyStep6Coeff` |
| Step 6 の準備 (t) の 2 本の鎖 | `zy_step6_prep_t`（同じ形の 1 本を 2 か所へ当てる） |
| Step 6 の準備 (u)・(v) の 4 本の鎖 | `zy_step6_prep_uv`（同じ形の 1 本を 4 か所へ当てる） |
| Step 6 の `Σ_q d_qF_q` の 11 行の鎖 | 最後の行（仮定）を除く 10 行は `sum_zyStep6Coeff_smul_pauliKroneckerFamily`、最後の行は `zy_step6_coeffs_eq_zero` の `.trans h` |
| Step 6 の「Step 2 より `d_q = 0_ℂ`」 | `zy_step6_coeffs_eq_zero` の `pauliKroneckerFamily_independent` の段 |
| Step 6 の `α_{m_0}` の 8 行の鎖・`β_{m_0}` の 8 行の鎖 | `zy_step6_alpha_eq_zero`・`zy_step6_beta_eq_zero` |
| Step 6 の結論 | `zy_step6_coeffs_eq_zero` |

Step 3〜5（`Z_m`・`Y_m` のクロネッカー積の形、対応する多重添字 `ζ(m)`・`η(m)` と `q_Z(m)`・`q_Y(m)`、それらが相異なること）の
Lean はまだ無い。Step 6 は、Step 4 の `F_{q_Z(m)} = Z_m`・`F_{q_Y(m)} = Y_m` と Step 5 の「`q_Z`・`q_Y` の値は相異なる」を仮定に取って述べ、
Step 3〜5 と合わせて主張を導く段は Step 3〜5 と一緒に置く。

## 必要十分版

人手の Step 1〜6 の経路の補題（Step 1・Step 2・Step 6）に必要十分版を置くかは、Step 3〜5 の Lean が揃った後、
主張全体の必要十分版の扱いと一緒に状態台帳の (cl7f) で決める。`NecSuf/CliffordIndependence.lean` は Clifford 関係による
別証明の必要十分版で、README 4 節の要件 1（証明手順が具体版と同じ）により、人手の経路の必要十分版にはならない。
いま分かっている、各 Step で効いているもの:
- Step 1: 係数の積が可換であること・`2_ℂ` が可逆であること（`twice_times_inverse_of_two_is_original_in_cc`。標数 2 では成り立たない）・
  `(-i)i = 1_ℂ`（`negative_i_times_i_is_one_in_cc`。`i` が単元であること）と、成分の定義だけである。
- Step 2: 有限和の定義の段を辿る 5 行の鎖と、`kronecker_family_of_independent_family_is_independent` を当てはめる段だけである。
  後者で取り払える構造は、その必要十分版 `NecSuf/ProductFamilyOfIndependentFamilyIsIndependent.lean` が示している。
- Step 6: Step 2 の線型独立性、Step 4・5 の仮定、クロネッカーのデルタの値、有限和の操作（係数の和のスカラー倍の分配、
  有限和の分割と順序交換、項が一つだけ残る和）、スカラー倍の結合則、`0` 倍が `O` であること（`0•A = O`）、`O` のスカラー倍が `O` であること（`c•O = O`）、
  `1` 倍、係数の積の `0`・`1`、係数の加法の単位元だけで、
  行列であることも係数が ℂ であることも、係数の積が可換であることも効いていない。
-/
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimZYGenerateAlgebra
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimAnticommutatorZY
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimKroneckerFamilyOfIndependentFamilyIsIndependent
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarSumAndFiniteSumOfMatrixSumsFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultiplesOfOneMatrixFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultipleOfZeroMatrixFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimZeroScalarMultipleAndMatrixSumCommutativeFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultipleByOneFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimFiniteSumOfMatricesWithSingleNonzeroTerm
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimFiniteDoubleSumOfMatricesInterchange
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimFiniteSumWithSingleNonzeroTerm
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimTwiceTimesInverseOfTwoIsOriginalInCC
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimITimesIAndNegativeITimesIInCC
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimSumPlusAndMinusDifferenceInCC
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimNegationInProductAndNegationPlusSelfInCC

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

/-! ## 人手 Step 1: `I, σ^x, σ^y, σ^z` は線型独立

人手証明の Step 1 は、`𝓑` の線型独立性を成分の比較で示す（張ることは使わない）。
`L := c_0 I + c_x σ^x + c_y σ^y + c_z σ^z` の 4 成分の鎖（`pauliComb_apply_00`〜`_11`）、
`L = O` から得る (p)〜(s)、係数が零になる 5 本の鎖（`pauliComb_coeff_*_eq_zero`）を 1 行ずつ辿る。
係数が零になる鎖が引く主張は、`twice_times_inverse_of_two_is_original_in_cc` が `complex_two_mul_mul_inv_two`、
`sum_plus_difference_is_twice_first_in_cc`・`sum_minus_difference_is_twice_second_in_cc` が `complex_sum_add_difference`・
`complex_sum_sub_difference`、`negation_plus_self_is_zero_in_cc` が `neg_add_self_complex`、`negative_i_times_i_is_one_in_cc` が
`complex_neg_I_mul_I` である（人手の添字 `1, 2` は Lean では `0, 1`）。
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
          rw [pauliX_apply_00, pauliY_apply_00, pauliZ_apply_00]        -- `def_pauli_matrices` の `(1,1)` 成分
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
          rw [pauliX_apply_01, pauliY_apply_01, pauliZ_apply_01]        -- `def_pauli_matrices` の `(1,2)` 成分
    _ = ((0 + cx * 1) + cy * (-Complex.I)) + 0 := by
          rw [mul_zero, mul_zero]                                       -- `complex_times_zero_is_zero` を 2 か所へ
    _ = (cx * 1 + cy * (-Complex.I)) + 0 := by rw [zero_add]
          -- `complex_zero_plus_is_original`（`z → c_x 1_ℂ`。具体版は無く `zero_add`）
    _ = cx * 1 + cy * (-Complex.I) := by rw [add_zero]
          -- `complex_numbers_form_a_field` の加法の単位元
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
          rw [pauliX_apply_10, pauliY_apply_10, pauliZ_apply_10]        -- `def_pauli_matrices` の `(2,1)` 成分
    _ = ((0 + cx * 1) + cy * Complex.I) + 0 := by
          rw [mul_zero, mul_zero]                                       -- `complex_times_zero_is_zero` を 2 か所へ
    _ = (cx * 1 + cy * Complex.I) + 0 := by rw [zero_add]
          -- `complex_zero_plus_is_original`（`z → c_x 1_ℂ`。具体版は無く `zero_add`）
    _ = cx * 1 + cy * Complex.I := by rw [add_zero]
          -- `complex_numbers_form_a_field` の加法の単位元
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
          rw [pauliX_apply_11, pauliY_apply_11, pauliZ_apply_11]        -- `def_pauli_matrices` の `(2,2)` 成分
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
      = (2 * c0) * 2⁻¹ := (complex_two_mul_mul_inv_two c0).symm
                                      -- `twice_times_inverse_of_two_is_original_in_cc`（`z → c_0`）を右辺から左辺へ
    _ = ((c0 + cz) + (c0 - cz)) * 2⁻¹ := by rw [complex_sum_add_difference c0 cz]
                                      -- `sum_plus_difference_is_twice_first_in_cc`（`a → c_0, b → c_z`）を右辺から左辺へ
    _ = (0 + (c0 - cz)) * 2⁻¹ := by rw [hp]                           -- (p)
    _ = (0 + 0) * 2⁻¹ := by rw [hs]                                   -- (s)
    _ = 0 * 2⁻¹ := by rw [add_zero]                                   -- `complex_numbers_form_a_field` の加法の単位元（`z → 0_ℂ`）
    _ = 0 := zero_mul _                                               -- `complex_zero_times_is_zero`（`z → 2_ℂ^{-1}`）

/-- 人手 Step 1 の `c_z = 0_ℂ` の鎖（(p)・(s) から）。 -/
theorem pauliComb_coeff_z_eq_zero {c0 cz : ℂ} (hp : c0 + cz = 0) (hs : c0 - cz = 0) :
    cz = 0 := by
  calc cz
      = (2 * cz) * 2⁻¹ := (complex_two_mul_mul_inv_two cz).symm
                                      -- `twice_times_inverse_of_two_is_original_in_cc`（`z → c_z`）を右辺から左辺へ
    _ = ((c0 + cz) - (c0 - cz)) * 2⁻¹ := by rw [complex_sum_sub_difference c0 cz]
                                      -- `sum_minus_difference_is_twice_second_in_cc`（`a → c_0, b → c_z`）を右辺から左辺へ
    _ = (0 - (c0 - cz)) * 2⁻¹ := by rw [hp]                           -- (p)
    _ = (0 - 0) * 2⁻¹ := by rw [hs]                                   -- (s)
    _ = (0 + -0) * 2⁻¹ := by rw [sub_eq_add_neg]                      -- `def_complex_difference`
    _ = (-0 + 0) * 2⁻¹ := by rw [add_comm (0 : ℂ) (-0)]               -- 加法の可換律
    _ = 0 * 2⁻¹ := by rw [neg_add_self_complex 0]                     -- `negation_plus_self_is_zero_in_cc`（`x → 0_ℂ`）
    _ = 0 := zero_mul _                                               -- `complex_zero_times_is_zero`（`z → 2_ℂ^{-1}`）

/-- 人手 Step 1 の `c_x = 0_ℂ` の鎖（(r)・(q) から）。 -/
theorem pauliComb_coeff_x_eq_zero {cx cy : ℂ} (hq : cx - Complex.I * cy = 0)
    (hr : cx + Complex.I * cy = 0) : cx = 0 := by
  calc cx
      = (2 * cx) * 2⁻¹ := (complex_two_mul_mul_inv_two cx).symm
                                      -- `twice_times_inverse_of_two_is_original_in_cc`（`z → c_x`）を右辺から左辺へ
    _ = ((cx + Complex.I * cy) + (cx - Complex.I * cy)) * 2⁻¹ := by
          rw [complex_sum_add_difference cx (Complex.I * cy)]
                                      -- `sum_plus_difference_is_twice_first_in_cc`（`a → c_x, b → ic_y`）を右辺から左辺へ
    _ = (0 + (cx - Complex.I * cy)) * 2⁻¹ := by rw [hr]               -- (r)
    _ = (0 + 0) * 2⁻¹ := by rw [hq]                                   -- (q)
    _ = 0 * 2⁻¹ := by rw [add_zero]                                   -- `complex_numbers_form_a_field` の加法の単位元（`z → 0_ℂ`）
    _ = 0 := zero_mul _                                               -- `complex_zero_times_is_zero`（`z → 2_ℂ^{-1}`）

/-- 人手 Step 1 の `ic_y = 0_ℂ` の鎖（(r)・(q) から）。 -/
theorem pauliComb_coeff_I_mul_y_eq_zero {cx cy : ℂ} (hq : cx - Complex.I * cy = 0)
    (hr : cx + Complex.I * cy = 0) : Complex.I * cy = 0 := by
  calc Complex.I * cy
      = (2 * (Complex.I * cy)) * 2⁻¹ := (complex_two_mul_mul_inv_two _).symm
                                      -- `twice_times_inverse_of_two_is_original_in_cc`（`z → ic_y`）を右辺から左辺へ
    _ = ((cx + Complex.I * cy) - (cx - Complex.I * cy)) * 2⁻¹ := by
          rw [complex_sum_sub_difference cx (Complex.I * cy)]
                                      -- `sum_minus_difference_is_twice_second_in_cc`（`a → c_x, b → ic_y`）を右辺から左辺へ
    _ = (0 - (cx - Complex.I * cy)) * 2⁻¹ := by rw [hr]               -- (r)
    _ = (0 - 0) * 2⁻¹ := by rw [hq]                                   -- (q)
    _ = (0 + -0) * 2⁻¹ := by rw [sub_eq_add_neg]                      -- `def_complex_difference`
    _ = (-0 + 0) * 2⁻¹ := by rw [add_comm (0 : ℂ) (-0)]               -- 加法の可換律
    _ = 0 * 2⁻¹ := by rw [neg_add_self_complex 0]                     -- `negation_plus_self_is_zero_in_cc`（`x → 0_ℂ`）
    _ = 0 := zero_mul _                                               -- `complex_zero_times_is_zero`（`z → 2_ℂ^{-1}`）

/-- 人手 Step 1 の `c_y = 0_ℂ` の鎖（`ic_y = 0_ℂ` から）。 -/
theorem pauliComb_coeff_y_eq_zero {cy : ℂ} (h : Complex.I * cy = 0) : cy = 0 := by
  calc cy
      = 1 * cy := (one_mul cy).symm                                   -- 積の単位元を右辺から左辺へ
    _ = ((-Complex.I) * Complex.I) * cy := by rw [complex_neg_I_mul_I]  -- `negative_i_times_i_is_one_in_cc` を右辺から左辺へ
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

/-! ## 人手 Step 2: クロネッカー積の族 `(F_q)` の線型独立性

人手は Step 1 の番号付け `e_1, e_2, e_3, e_4 := I, σ^x, σ^y, σ^z`（Lean の `pauliFamily` の添字 `0, …, 3`）のもとで、
`Σ_{a=1}^{4} c_ae_a = O` を Step 1 の `L = O` の形へ戻して `c_1 = ⋯ = c_4 = 0_ℂ` を得、
`kronecker_family_of_independent_family_is_independent` に渡して族 `(F_q)` の線型独立性を得る。 -/

/-- 人手 Step 2 の `F_q := e_{π(q)_1} ⊠ ⋯ ⊠ e_{π(q)_M}`（多重添字 `π(q)` は Lean の `p : Fin M → Fin 4`）。 -/
noncomputable def pauliKroneckerFamily (p : Fin M → Fin 4) : TensorPow M :=
  siteProd M (fun k => pauliFamily (p k))

/-- 人手 Step 2 の鎖 `((c_1I+c_2σ^x)+c_3σ^y)+c_4σ^z = Σ_{a=1}^{4} c_ae_a`（人手の `c_1, …, c_4` は Lean の `c 0, …, c 3`）。
`def_finite_sum_of_matrices` の `r = 1` の段と `r + 1 = 2, 3, 4` の段は、Lean では `Fin.sum_univ_one`・`Fin.sum_univ_castSucc` で、
途中の `Σ_{a=1}^{r}` は `Fin r` の上の和（`Fin 4` の始めの `r` 個へ `Fin.castSucc` で送ったもの）である。 -/
theorem pauliComb_eq_sum_pauliFamily (c : Fin 4 → ℂ) :
    pauliComb (c 0) (c 1) (c 2) (c 3) = ∑ a, c a • pauliFamily a := by
  calc pauliComb (c 0) (c 1) (c 2) (c 3)
      = ((c 0 • (1 : Matrix (Fin 2) (Fin 2) ℂ) + c 1 • pauliX) + c 2 • pauliY) + c 3 • pauliZ := rfl
                                                                      -- 人手 Step 2 の鎖の行ではない。Step 1 の `L`（`c_0 → c_1, …, c_z → c_4`）を開いて鎖の左辺の形へつなぐ段
    _ = ((c 0 • pauliFamily 0 + c 1 • pauliFamily 1) + c 2 • pauliFamily 2) + c 3 • pauliFamily 3 := rfl
                                                                      -- Step 1 の `e_1, …, e_4` の定義を右辺から左辺へ 4 か所へ
    _ = ((∑ a : Fin 1, c ((a.castSucc).castSucc.castSucc) • pauliFamily ((a.castSucc).castSucc.castSucc)
            + c 1 • pauliFamily 1) + c 2 • pauliFamily 2) + c 3 • pauliFamily 3 := by
          rw [Fin.sum_univ_one]; rfl                                    -- `def_finite_sum_of_matrices` の `r = 1` の段を右辺から左辺へ
    _ = (∑ a : Fin 2, c (a.castSucc.castSucc) • pauliFamily (a.castSucc.castSucc)
            + c 2 • pauliFamily 2) + c 3 • pauliFamily 3 := by
          rw [Fin.sum_univ_castSucc (fun a : Fin 2 => c (a.castSucc.castSucc) • pauliFamily (a.castSucc.castSucc))]
          rfl                                                           -- `def_finite_sum_of_matrices` の `r + 1 = 2` の段を右辺から左辺へ
    _ = ∑ a : Fin 3, c a.castSucc • pauliFamily a.castSucc + c 3 • pauliFamily 3 := by
          rw [Fin.sum_univ_castSucc (fun a : Fin 3 => c a.castSucc • pauliFamily a.castSucc)]
          rfl                                                           -- `def_finite_sum_of_matrices` の `r + 1 = 3` の段を右辺から左辺へ
    _ = ∑ a, c a • pauliFamily a := by
          rw [Fin.sum_univ_castSucc (fun a : Fin 4 => c a • pauliFamily a)]
          rfl                                                           -- `def_finite_sum_of_matrices` の `r + 1 = 4` の段を右辺から左辺へ

/-- 人手 Step 2 の「`Σ_{a=1}^{4} c_ae_a = O` ならば、Step 1 の線型独立性（`c_0 → c_1, …, c_z → c_4`）より
`c_1 = c_2 = c_3 = c_4 = 0_ℂ`」（`kronecker_family_of_independent_family_is_independent` の仮定の形）。 -/
theorem pauliFamily_sum_eq_zero_coeffs (c : Fin 4 → ℂ) (h : ∑ a, c a • pauliFamily a = 0) :
    ∀ a, c a = 0 := by
  have hcomb : pauliComb (c 0) (c 1) (c 2) (c 3) = 0 :=
    (pauliComb_eq_sum_pauliFamily c).trans h                           -- 上の鎖と仮定
  obtain ⟨h0, h1, h2, h3⟩ := pauliComb_eq_zero_coeffs hcomb          -- Step 1 の線型独立性
  intro a
  fin_cases a
  · exact h0
  · exact h1
  · exact h2
  · exact h3

/-- `pauliFamily_sum_eq_zero_coeffs` を mathlib の `LinearIndependent` の形で述べたもの。 -/
theorem pauliFamily_linearIndependent : LinearIndependent ℂ pauliFamily := by
  rw [Fintype.linearIndependent_iff]
  exact pauliFamily_sum_eq_zero_coeffs

/-- 人手 Step 2 の結論: `e_1, …, e_4` は `kronecker_family_of_independent_family_is_independent` の仮定を満たし
（`b_a → e_a`）、族 `(F_q)` は線型独立である。すなわち `Σ_q d_qF_q = O` ならばすべての `q` について `d_q = 0_ℂ`。 -/
theorem pauliKroneckerFamily_independent (d : (Fin M → Fin 4) → ℂ)
    (hd : ∑ p, d p • pauliKroneckerFamily p = 0) : ∀ p, d p = 0 :=
  kronecker_family_of_independent_family_is_independent pauliFamily pauliFamily_sum_eq_zero_coeffs d hd

/-! ## 人手 Step 6: 結論

人手は係数の族 `d_q := Σ_m α_mδ_{q q_Z(m)} + Σ_m β_mδ_{q q_Y(m)}` を置き、準備 (t)・(u)・(v) を示したうえで、
`Σ_q d_qF_q` を 11 行の鎖で仮定の左辺 `O` に戻し、Step 2 の線型独立性から `d_q = 0_ℂ` を得て、
`α_{m_0}`・`β_{m_0}` を 8 行の鎖で `d_{q_Z(m_0)}`・`d_{q_Y(m_0)}` に戻す。

Lean の読み替え:
- 人手の添字 `q ∈ {1, …, N}`（Step 2 の全単射 `π` で多重添字を並べたもの）は、Step 2 と同じく多重添字 `p : Fin M → Fin 4` そのものである。
  人手の `q_Z(m) := π^{-1}(ζ(m))`・`q_Y(m) := π^{-1}(η(m))` は、Lean では多重添字 `qZ m`・`qY m`（人手の `ζ(m)`・`η(m)`）になる。
- 人手のクロネッカーのデルタ `δ_{qq'}`（`def_kronecker_delta` の `n → N`）は、多重添字の上の `multiIndexDelta`（同じ定義を添字 `𝒫` で述べたもの）である。
- Step 3〜5 の Lean はまだ無いので、Step 4 の `F_{q_Z(m)} = Z_m`・`F_{q_Y(m)} = Y_m` と Step 5 の「`q_Z(1), …, q_Z(M), q_Y(1), …, q_Y(M)` は相異なる」を
  仮定 `hFZ`・`hFY`・`hZZ`・`hYY`・`hZY` に取る。それらを Step 3〜5 から与えて主張を導く段は、Step 3〜5 の Lean と一緒に置く。
- 人手のサイトの番号 `m ∈ {1, …, M}` は Lean の `m : Fin M`（`0, …, M-1`）で、人手の `m` が Lean の `m - 1` に当たる。人手の `m → 1` は Lean の `⟨0, _⟩` である。
- 人手が引く `scalar_multiple_is_associative` は Lean の具体版が無いので、既存の慣行どおり mathlib の `smul_smul` を引く。 -/

/-- 人手 Step 6 のクロネッカーのデルタ `δ_{qq'}`（`def_kronecker_delta` を、Lean の添字である多重添字 `𝒫 = (Fin M → Fin 4)` の上で述べたもの）。 -/
noncomputable def multiIndexDelta (p p' : Fin M → Fin 4) : ℂ := if p = p' then 1 else 0

/-- `def_kronecker_delta` の `q = q'` の値。 -/
theorem multiIndexDelta_self (p : Fin M → Fin 4) : multiIndexDelta p p = 1 := if_pos rfl

/-- `def_kronecker_delta` の `q ≠ q'` の値。 -/
theorem multiIndexDelta_of_ne {p p' : Fin M → Fin 4} (h : p ≠ p') : multiIndexDelta p p' = 0 := if_neg h

/-- 人手 Step 6 の係数の族 `d_q := Σ_m α_mδ_{q q_Z(m)} + Σ_m β_mδ_{q q_Y(m)}`。 -/
noncomputable def zyStep6Coeff (qZ qY : Fin M → (Fin M → Fin 4)) (α β : Fin M → ℂ) (q : Fin M → Fin 4) : ℂ :=
  ∑ m, α m * multiIndexDelta q (qZ m) + ∑ m, β m * multiIndexDelta q (qY m)

/-- 人手 Step 6 の準備 (t): `q ≠ q'` ならば `c(δ_{qq'}F_q) = O`。人手の 2 本の鎖（`c → α_m, q' → q_Z(m)` と
`c → β_m, q' → q_Y(m)`）は同じ形で、この 1 本をそれぞれへ当てる。 -/
theorem zy_step6_prep_t (c : ℂ) {q q' : Fin M → Fin 4} (h : q ≠ q') :
    c • (multiIndexDelta q q' • pauliKroneckerFamily q) = 0 := by
  calc c • (multiIndexDelta q q' • pauliKroneckerFamily q)
      = c • ((0 : ℂ) • pauliKroneckerFamily q) := by rw [multiIndexDelta_of_ne h]       -- `def_kronecker_delta`（`q ≠ q'`）
    _ = c • (0 : TensorPow M) := by rw [zero_smul_tensorPow]                           -- `zero_scalar_multiple_is_zero_matrix`（`A → F_q`）
    _ = 0 := smul_zero_matrix_tensorPow c                                               -- `scalar_multiple_of_zero_matrix`（`a → c`）

/-- 人手 Step 6 の準備 (u)・(v): `q ≠ q'` ならば `cδ_{qq'} = 0_ℂ`。人手の 4 本の鎖（(u) の `c → α_m, q → q_Z(m_0), q' → q_Z(m)` と
`c → β_m, q → q_Y(m_0), q' → q_Y(m)`、(v) の `c → β_m, q → q_Z(m_0), q' → q_Y(m)` と `c → α_m, q → q_Y(m_0), q' → q_Z(m)`）は
同じ形で、この 1 本をそれぞれへ当てる（`q ≠ q'` は Step 5 から）。 -/
theorem zy_step6_prep_uv (c : ℂ) {q q' : Fin M → Fin 4} (h : q ≠ q') :
    c * multiIndexDelta q q' = 0 := by
  calc c * multiIndexDelta q q'
      = c * 0 := by rw [multiIndexDelta_of_ne h]                                         -- `def_kronecker_delta`（`q ≠ q'`）
    _ = 0 := mul_zero c                                                                  -- `complex_times_zero_is_zero`（`z → c`）

/-- 人手 Step 6 の `Σ_q d_qF_q` の鎖のうち、最後の行（仮定）を除く 10 行:
`Σ_q d_qF_q = Σ_m α_mZ_m + Σ_m β_mY_m`。
3 段目の `finite_sum_smul_one_tensorPow_fin` は項の個数 `M` を問わないので、この補題は `M = 0` でも成り立つ。
`M = 0` は人手の範囲の外である（人手は `M_col ≥ 1`）。 -/
theorem sum_zyStep6Coeff_smul_pauliKroneckerFamily (qZ qY : Fin M → (Fin M → Fin 4))
    (hFZ : ∀ m, pauliKroneckerFamily (qZ m) = Z m) (hFY : ∀ m, pauliKroneckerFamily (qY m) = Y m)
    (α β : Fin M → ℂ) :
    ∑ q, zyStep6Coeff qZ qY α β q • pauliKroneckerFamily q = ∑ m, α m • Z m + ∑ m, β m • Y m := by
  calc ∑ q, zyStep6Coeff qZ qY α β q • pauliKroneckerFamily q
      = ∑ q, ((∑ m, α m * multiIndexDelta q (qZ m)) + (∑ m, β m * multiIndexDelta q (qY m)))
          • pauliKroneckerFamily q := rfl
                                    -- `d_q` の定義を `N` か所へ
    _ = ∑ q, ((∑ m, α m * multiIndexDelta q (qZ m)) • pauliKroneckerFamily q
          + (∑ m, β m * multiIndexDelta q (qY m)) • pauliKroneckerFamily q) :=
        Finset.sum_congr rfl fun q _ => add_smul_tensorPow _ _ _
                                    -- `scalar_sum_distributes_over_matrix` を `N` か所へ
    _ = ∑ q, (∑ m, (α m * multiIndexDelta q (qZ m)) • pauliKroneckerFamily q
          + ∑ m, (β m * multiIndexDelta q (qY m)) • pauliKroneckerFamily q) :=
        Finset.sum_congr rfl fun q _ => by
          rw [finite_sum_smul_one_tensorPow_fin M (fun m => α m * multiIndexDelta q (qZ m)),
            finite_sum_smul_one_tensorPow_fin M (fun m => β m * multiIndexDelta q (qY m))]
                                    -- `finite_sum_of_scalar_multiples_of_one_matrix` を右辺から左辺へ `2N` か所へ
    _ = ∑ q, (∑ m, α m • (multiIndexDelta q (qZ m) • pauliKroneckerFamily q)
          + ∑ m, β m • (multiIndexDelta q (qY m) • pauliKroneckerFamily q)) := by
        simp only [smul_smul]       -- `scalar_multiple_is_associative`（mathlib の `smul_smul`）を右辺から左辺へ `2NM` か所へ
    _ = ∑ q, ∑ m, α m • (multiIndexDelta q (qZ m) • pauliKroneckerFamily q)
          + ∑ q, ∑ m, β m • (multiIndexDelta q (qY m) • pauliKroneckerFamily q) :=
        finite_sum_of_matrix_sums_tensorPow_fintype _ _
                                    -- `finite_sum_of_matrix_sums`（`r → N`）
    _ = ∑ m, ∑ q, α m • (multiIndexDelta q (qZ m) • pauliKroneckerFamily q)
          + ∑ m, ∑ q, β m • (multiIndexDelta q (qY m) • pauliKroneckerFamily q) := by
        rw [finite_double_sum_of_matrices_interchange
            (fun q m => α m • (multiIndexDelta q (qZ m) • pauliKroneckerFamily q)),
          finite_double_sum_of_matrices_interchange
            (fun q m => β m • (multiIndexDelta q (qY m) • pauliKroneckerFamily q))]
                                    -- `finite_double_sum_of_matrices_interchange`（`r → N, s → M`）を 2 か所へ
    _ = ∑ m, α m • (multiIndexDelta (qZ m) (qZ m) • pauliKroneckerFamily (qZ m))
          + ∑ m, β m • (multiIndexDelta (qY m) (qY m) • pauliKroneckerFamily (qY m)) := by
        congr 1
        · exact Finset.sum_congr rfl fun m _ =>
            finite_sum_of_matrices_with_single_nonzero_term
              (fun q => α m • (multiIndexDelta q (qZ m) • pauliKroneckerFamily q)) (qZ m)
              (fun q hq => zy_step6_prep_t (α m) hq)
        · exact Finset.sum_congr rfl fun m _ =>
            finite_sum_of_matrices_with_single_nonzero_term
              (fun q => β m • (multiIndexDelta q (qY m) • pauliKroneckerFamily q)) (qY m)
              (fun q hq => zy_step6_prep_t (β m) hq)
                                    -- `finite_sum_of_matrices_with_single_nonzero_term`（`q → q_Z(m)` または `q_Y(m)`）を `2M` か所へ。(t)
    _ = ∑ m, α m • ((1 : ℂ) • pauliKroneckerFamily (qZ m))
          + ∑ m, β m • ((1 : ℂ) • pauliKroneckerFamily (qY m)) := by
        simp only [multiIndexDelta_self]
                                    -- `def_kronecker_delta` を `2M` か所へ
    _ = ∑ m, α m • pauliKroneckerFamily (qZ m) + ∑ m, β m • pauliKroneckerFamily (qY m) := by
        simp only [one_smul_tensorPow]
                                    -- `scalar_multiple_by_one`（`A → F_{q_Z(m)}` または `F_{q_Y(m)}`）を `2M` か所へ
    _ = ∑ m, α m • Z m + ∑ m, β m • Y m := by
        simp only [hFZ, hFY]        -- Step 4 の `F_{q_Z(m)} = Z_m`・`F_{q_Y(m)} = Y_m` を `2M` か所へ

/-- 人手 Step 6 の `α_{m_0}` の 8 行の鎖（`d_q = 0_ℂ`（`q → q_Z(m_0)`）まで）。 -/
theorem zy_step6_alpha_eq_zero (qZ qY : Fin M → (Fin M → Fin 4))
    (hZZ : ∀ m m', m ≠ m' → qZ m ≠ qZ m') (hZY : ∀ m m', qZ m ≠ qY m')
    (α β : Fin M → ℂ) (hd : ∀ q, zyStep6Coeff qZ qY α β q = 0) (m₀ : Fin M) : α m₀ = 0 := by
  let one : Fin M := ⟨0, Nat.lt_of_le_of_lt (Nat.zero_le _) m₀.isLt⟩   -- 人手の `1 ∈ {1, …, M}`（`M ≥ 1`）
  calc α m₀
      = α m₀ * 1 := (mul_one _).symm                                                     -- 積の単位元を右辺から左辺へ
    _ = α m₀ * multiIndexDelta (qZ m₀) (qZ m₀) := by rw [multiIndexDelta_self]          -- `def_kronecker_delta` を右辺から左辺へ
    _ = ∑ m, α m * multiIndexDelta (qZ m₀) (qZ m) :=
        (finite_sum_with_single_nonzero_term_fintype (fun m => α m * multiIndexDelta (qZ m₀) (qZ m)) m₀
          (fun m hm => zy_step6_prep_uv (α m) (hZZ m₀ m (Ne.symm hm)))).symm
                                    -- `finite_sum_with_single_nonzero_term`（`n → m_0`）を右辺から左辺へ。(u)
    _ = ∑ m, α m * multiIndexDelta (qZ m₀) (qZ m) + 0 := (add_zero _).symm                -- 加法の単位元を右辺から左辺へ
    _ = ∑ m, α m * multiIndexDelta (qZ m₀) (qZ m) + β one * multiIndexDelta (qZ m₀) (qY one) := by
        rw [zy_step6_prep_uv (β one) (hZY m₀ one)]                                       -- (v)（`m → 1`）を右辺から左辺へ
    _ = ∑ m, α m * multiIndexDelta (qZ m₀) (qZ m) + ∑ m, β m * multiIndexDelta (qZ m₀) (qY m) := by
        rw [finite_sum_with_single_nonzero_term_fintype (fun m => β m * multiIndexDelta (qZ m₀) (qY m)) one
          (fun m _ => zy_step6_prep_uv (β m) (hZY m₀ m))]
                                    -- `finite_sum_with_single_nonzero_term`（`n → 1`）を右辺から左辺へ。(v)
    _ = zyStep6Coeff qZ qY α β (qZ m₀) := rfl                                           -- `d_q` の定義（`q → q_Z(m_0)`）
    _ = 0 := hd _                                                                        -- 上の `d_q = 0_ℂ`（`q → q_Z(m_0)`）

/-- 人手 Step 6 の `β_{m_0}` の 8 行の鎖（`d_q = 0_ℂ`（`q → q_Y(m_0)`）まで）。 -/
theorem zy_step6_beta_eq_zero (qZ qY : Fin M → (Fin M → Fin 4))
    (hYY : ∀ m m', m ≠ m' → qY m ≠ qY m') (hZY : ∀ m m', qZ m ≠ qY m')
    (α β : Fin M → ℂ) (hd : ∀ q, zyStep6Coeff qZ qY α β q = 0) (m₀ : Fin M) : β m₀ = 0 := by
  let one : Fin M := ⟨0, Nat.lt_of_le_of_lt (Nat.zero_le _) m₀.isLt⟩   -- 人手の `1 ∈ {1, …, M}`（`M ≥ 1`）
  calc β m₀
      = β m₀ * 1 := (mul_one _).symm                                                     -- 積の単位元を右辺から左辺へ
    _ = β m₀ * multiIndexDelta (qY m₀) (qY m₀) := by rw [multiIndexDelta_self]          -- `def_kronecker_delta` を右辺から左辺へ
    _ = ∑ m, β m * multiIndexDelta (qY m₀) (qY m) :=
        (finite_sum_with_single_nonzero_term_fintype (fun m => β m * multiIndexDelta (qY m₀) (qY m)) m₀
          (fun m hm => zy_step6_prep_uv (β m) (hYY m₀ m (Ne.symm hm)))).symm
                                    -- `finite_sum_with_single_nonzero_term`（`n → m_0`）を右辺から左辺へ。(u)
    _ = 0 + ∑ m, β m * multiIndexDelta (qY m₀) (qY m) := (zero_add _).symm
                                    -- `complex_zero_plus_is_original`（`z → Σ_m β_mδ_{q_Y(m_0) q_Y(m)}`）を右辺から左辺へ（具体版は無く `zero_add`）
    _ = α one * multiIndexDelta (qY m₀) (qZ one) + ∑ m, β m * multiIndexDelta (qY m₀) (qY m) := by
        rw [zy_step6_prep_uv (α one) (Ne.symm (hZY one m₀))]                             -- (v)（`m → 1`）を右辺から左辺へ
    _ = ∑ m, α m * multiIndexDelta (qY m₀) (qZ m) + ∑ m, β m * multiIndexDelta (qY m₀) (qY m) := by
        rw [finite_sum_with_single_nonzero_term_fintype (fun m => α m * multiIndexDelta (qY m₀) (qZ m)) one
          (fun m _ => zy_step6_prep_uv (α m) (Ne.symm (hZY m m₀)))]
                                    -- `finite_sum_with_single_nonzero_term`（`n → 1`）を右辺から左辺へ。(v)
    _ = zyStep6Coeff qZ qY α β (qY m₀) := rfl                                           -- `d_q` の定義（`q → q_Y(m_0)`）
    _ = 0 := hd _                                                                        -- 上の `d_q = 0_ℂ`（`q → q_Y(m_0)`）

/-- **人手 Step 6**: Step 4 の `F_{q_Z(m)} = Z_m`・`F_{q_Y(m)} = Y_m` と、Step 5 の「`q_Z(1), …, q_Z(M), q_Y(1), …, q_Y(M)` は相異なる」のもとで、
`Σ_m α_mZ_m + Σ_m β_mY_m = O` ならば `α_1 = ⋯ = α_M = β_1 = ⋯ = β_M = 0_ℂ`。
`Σ_q d_qF_q = O`（10 行の鎖と仮定）から Step 2 の線型独立性（`pauliKroneckerFamily_independent`、人手の「`d_1, …, d_N` をここで定めたものとする」）で
`d_q = 0_ℂ` を得て、`α_{m_0}`・`β_{m_0}` の鎖へ渡す。 -/
theorem zy_step6_coeffs_eq_zero (qZ qY : Fin M → (Fin M → Fin 4))
    (hFZ : ∀ m, pauliKroneckerFamily (qZ m) = Z m) (hFY : ∀ m, pauliKroneckerFamily (qY m) = Y m)
    (hZZ : ∀ m m', m ≠ m' → qZ m ≠ qZ m') (hYY : ∀ m m', m ≠ m' → qY m ≠ qY m')
    (hZY : ∀ m m', qZ m ≠ qY m')
    (α β : Fin M → ℂ) (h : ∑ m, α m • Z m + ∑ m, β m • Y m = 0) :
    (∀ m, α m = 0) ∧ (∀ m, β m = 0) := by
  have hsum : ∑ q, zyStep6Coeff qZ qY α β q • pauliKroneckerFamily q = 0 :=
    (sum_zyStep6Coeff_smul_pauliKroneckerFamily qZ qY hFZ hFY α β).trans h               -- 上の 10 行の鎖と仮定
  have hd := pauliKroneckerFamily_independent _ hsum                                      -- Step 2 の線型独立性
  exact ⟨zy_step6_alpha_eq_zero qZ qY hZZ hZY α β hd, zy_step6_beta_eq_zero qZ qY hYY hZY α β hd⟩

end Ising2D
