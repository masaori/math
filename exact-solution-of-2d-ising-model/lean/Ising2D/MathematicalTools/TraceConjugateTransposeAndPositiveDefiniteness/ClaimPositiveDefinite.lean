/-
# エルミート性・正定値性と `V` の正定値性（具体版）

対応する人手証明（`structured-latex/content/009_eigenvalues_of_V.ts`）:
- `def_hermitian_positive_definite`（`eigenvalues_of_V_011_definition_...`）
- `star_preserves_norm_and_limits`（`eigenvalues_of_V_012_claim_...`。具体版は `ClaimStarPreservesNormAndLimits.lean` にあり、ここには置かない）
- `exp_hermitian_is_positive_definite`（`eigenvalues_of_V_013_claim_...`）
- `iH_is_real_symmetric`（`eigenvalues_of_V_014_claim_...`。正本は `structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`）の、反可換性による別の論法の補助だけ
  （人手の主張の具体版は `EigenvalueProblem/EigenvaluesOfVPlus/ClaimIHPauliForm.lean`）
- `V_is_positive_definite`（`eigenvalues_of_V_015_claim_...`）
- `check_number_operator_is_hermitian`（正本 `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`）の (1) の証明の中の、
  クロネッカー積の共役転置の成分の鎖（`siteProd_conjTranspose_apply`）
  と `(σ_k^a)^* = σ_k^a` の鎖（`siteOp_conjTranspose_of_conjTranspose_eq`）と `Z_j^*` の鎖（`jw_conjTranspose_of_siteOp_conjTranspose_eq`。`Z_conjTranspose`・`Y_conjTranspose`）

原文の「共役転置 `A^*`」「エルミート」「正定値」は mathlib の
`Matrix.conjTranspose` / `Matrix.IsHermitian` / `Matrix.PosDef` と同じものである。

## `star_preserves_norm_and_limits` と `exp` のエルミート性の置き場

原文 `star_preserves_norm_and_limits` の (1)(2)(3) の具体版は、人手の鎖と 1 対 1 に
`ClaimStarPreservesNormAndLimits.lean` に置いた。`posDef_exp_of_isHermitian` の `T^* = T` は、人手 `exp_of_hermitian_is_hermitian` の
具体版 `matExp_conjTranspose_of_conjTranspose_eq`（`ClaimExpOfHermitianIsHermitian.lean`）を引く。`Vmat_posDef` の `B^* = B` は、
人手 `V_is_positive_definite` の Step 2 どおり、`posDef_exp_of_isHermitian` の正定値性から「とくにエルミート」を読む。`matExp_conjTranspose_of_conjTranspose_eq` は `TensorPow M` で述べてあるので、`posDef_exp_of_isHermitian` も
`TensorPow M` で述べる（使う側はすべて `TensorPow M` である）。

## 人手 `iH_is_real_symmetric` との違い（形式化して分かったこと）

人手 `iH_is_real_symmetric` は `S_1^{(+)} = iK_1H_1^{(+)}` を `K_1 ∑ σ^z_m σ^z_{m+1} - K_1 G` へ、
`S_2` を `K_2^* ∑ σ^x_m` へ書き換えてから成分の実性と転置対称性を数えている。
このファイルの補助は、その書き換えを経ずに

- `Z_m^⊤ = Z_m`, `Y_m^⊤ = -Y_m`（Pauli 行列の転置の性質だけ）
- `Z_m^* = Z_m`, `Y_m^* = Y_m`（Pauli 行列がエルミートであること）
- `[Z_μ, Y_ν]_+ = 0`（既に形式化済みの `anticomm_Z_Y`）

の 3 つから直ちに従う（`G` も `M` の偶奇も出てこない）。
この論法は人手の論法とは別なので、人手 `iH_is_real_symmetric` の主張の具体版 `S1plus_isHermitian`・`S1plus_transpose`・
`S2_isHermitian`・`S2_transpose` はここには置かず、人手の Step 3 の鎖（因子ごとの転置と成分の実性）から
`EigenvalueProblem/EigenvaluesOfVPlus/ClaimIHPauliForm.lean` で示す。このファイルに残すのは、境界項の係数を引数 `η` に
持たせた一般形 `S1_isHermitian` / `S1_transpose`（整数運動量の経路の形式化の記録（`Vmat` ほか）と、人手の主張の範囲外の
`M_col ≤ 1` の場合を埋めるために `S1plus_isHermitian` / `S1plus_transpose` が使う）と、補助
`S2_isHermitian_by_anticommutation`・`H2_transpose`（`Vmat_posDef` と、人手の主張の範囲外の `M_col = 0` の場合を埋めるために
`S2_isHermitian` / `S2_transpose` が使う）である。
-/
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.DefinitionH1H2V1V2
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimAnticommutatorZY
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.DefinitionTrace
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimPositiveRealMultiplePreservesPositiveDefiniteFromNecSuf
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimKroneckerTranspose
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimStarPreservesNormAndLimitsFromNecSuf
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimExpOfHermitianIsHermitian
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimConjugateTransposeOfPauliMatrices
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimComplexConjugateOfSumProductDifferenceStarForm
import Ising2D.EigenvalueProblem.ReductionToATheta.DefinitionThetaGamma
import Mathlib.LinearAlgebra.Matrix.PosDef
import Mathlib.Analysis.Normed.Algebra.MatrixExponential

namespace Ising2D

open Matrix
open scoped ComplexOrder

section Herm

variable {M : ℕ}

/-! ## Pauli 行列の共役転置

Pauli 行列と 2 次の単位行列の共役転置 `pauliX_conjTranspose`・`pauliZ_conjTranspose`・`pauliY_conjTranspose`・
`identity_matrix_two_conjTranspose` は、人手 `conjugate_transpose_of_pauli_x` ほかと 1 対 1 の鎖として
`ClaimConjugateTransposeOfPauliMatrices.lean` に置いた。 -/

/-! ## `siteProd` の共役転置

転置 `siteProd_transpose`（人手 `kronecker_transpose`）は、人手の成分の鎖と 1 対 1 の `calc` として
`MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimKroneckerTranspose.lean` に置いた。
共役転置は、人手 `check_number_operator_is_hermitian`（正本 `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`）の
(1) の証明の中の成分の鎖（5 行）と 1 対 1 である。人手のクロネッカー積 `A_1⊠⋯⊠A_M` は Lean の `siteProd M x` で、添字は
`Conf M` なので番号付け `ν` は現れない（`siteProd_transpose_apply` と同じ）。人手は `M_col ≥ 2` で述べるが、鎖はどの `M` でも同じである
（`M ≤ 1` の段は `complex_conjugate_star_finite_prod` の中にある）。 -/

/-- **人手 `check_number_operator_is_hermitian` の (1) の成分の鎖**: `((A_1⊠⋯⊠A_M)^*)_{I,J} = (A_1^*⊠⋯⊠A_M^*)_{I,J}`。 -/
theorem siteProd_conjTranspose_apply (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ) (s t : Conf M) :
    (siteProd M x)ᴴ s t = siteProd M (fun k => (x k)ᴴ) s t :=
  calc (siteProd M x)ᴴ s t
      = star (siteProd M x t s) := rfl                                      -- `def_hermitian_positive_definite`
    _ = star (∏ k : Fin M, x k (t k) (s k)) := by
        rw [siteProd_apply]                                                 -- `def_kronecker` (2)
    _ = ∏ k : Fin M, star (x k (t k) (s k)) :=
        complex_conjugate_star_finite_prod M _                              -- `complex_conjugate_of_product` の反復適用
    _ = ∏ k : Fin M, (x k)ᴴ (s k) (t k) := rfl                              -- `def_hermitian_positive_definite` を各因子へ
    _ = siteProd M (fun k => (x k)ᴴ) s t :=
        (siteProd_apply M (fun k => (x k)ᴴ) s t).symm                      -- `def_kronecker` (2)

/-- **人手 `check_number_operator_is_hermitian` の (1) の `(A_1⊠⋯⊠A_M)^* = A_1^*⊠⋯⊠A_M^*`**（全ての成分が等しい）。 -/
theorem siteProd_conjTranspose (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ) :
    (siteProd M x)ᴴ = siteProd M (fun k => (x k)ᴴ) :=
  Matrix.ext (siteProd_conjTranspose_apply x)   -- 両辺のすべての成分が一致する

/-! ## `σ_k^a` の共役転置

人手 `check_number_operator_is_hermitian`（正本 `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`）の
(1) の `(σ_k^a)^* = σ_k^a` の 5 行の鎖と 1 対 1 である。人手の因子の並び `I⊠⋯⊠σ^a⊠⋯⊠I` は、`sigmaX_transpose`
（`EigenvalueProblem/EigenvaluesOfVPlus/ClaimIHPauliForm.lean`）と同じく `siteProd` に入れる因子の族を `ite` で書く。
`def_site_pauli_matrices`（`siteOp`）は `Function.update` で書いてあるので、`siteProd_conjTranspose` の段と最後の段で
因子の族の書き方（`Function.update` と `ite`）を揃える（等式の変形ではなく書き方の違いだけ）。
人手の 4 行目は「`a` に応じて `conjugate_transpose_of_pauli_x`・`_y`・`_z` のどれか 1 つ」なので、鎖は第 `k` 因子 `A` と
その共役転置の等式 `hA : A^* = A` について 1 回だけ書き、`a = x, y, z` の 3 つは `hA` にそれぞれの主張を渡して得る。 -/

/-- **人手 `check_number_operator_is_hermitian` の (1) の `(σ_k^a)^* = σ_k^a` の 5 行の鎖**（人手の `k ∈ {1, …, M_col}` は Lean の 0 始まりの `k : Fin M`。第 `k` 因子 `A` で、`A^* = A` を 4 行目に使う）。 -/
theorem siteOp_conjTranspose_of_conjTranspose_eq (k : Fin M) {A : Matrix (Fin 2) (Fin 2) ℂ} (hA : Aᴴ = A) :
    (siteOp k A)ᴴ = siteOp k A := by
  have hform : ∀ B : Matrix (Fin 2) (Fin 2) ℂ,
      Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) k B = fun l => if l = k then B else 1 := by
    intro B
    funext l
    by_cases h : l = k
    · rw [h, Function.update_self, if_pos rfl]
    · rw [Function.update_of_ne h, if_neg h]; rfl
  calc
    (siteOp k A)ᴴ
        = (siteProd M (Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) k A))ᴴ := rfl
                                                        -- `def_site_pauli_matrices`
    _ = siteProd M (fun l => if l = k then Aᴴ else (1 : Matrix (Fin 2) (Fin 2) ℂ)ᴴ) := by
      rw [siteProd_conjTranspose, hform]                -- 直前の式（`siteProd_conjTranspose`。`M → M_col`, `A_k → A`, `A_l → I`（`l ≠ k`））
      congr 1
      funext l
      dsimp only
      by_cases h : l = k
      · rw [if_pos h, if_pos h]
      · rw [if_neg h, if_neg h]
    _ = siteProd M (fun l => if l = k then Aᴴ else 1) := by
      rw [identity_matrix_two_conjTranspose]            -- `conjugate_transpose_of_identity_matrix_of_order_two`（第 `k` 因子以外の因子へ同時に）
    _ = siteProd M (fun l => if l = k then A else 1) := by
      rw [hA]                                           -- `a` に応じて `conjugate_transpose_of_pauli_x`・`_y`・`_z` のどれか 1 つ
    _ = siteOp k A := by
      rw [← hform]; rfl                                 -- `def_site_pauli_matrices`

/-- 人手 `check_number_operator_is_hermitian` の (1) の `(σ_k^x)^* = σ_k^x`（`a = x`）。 -/
theorem sigmaX_conjTranspose (k : Fin M) : (sigmaX k)ᴴ = sigmaX k :=
  siteOp_conjTranspose_of_conjTranspose_eq k pauliX_conjTranspose   -- 4 行目は `conjugate_transpose_of_pauli_x`

/-- 人手 `check_number_operator_is_hermitian` の (1) の `(σ_k^y)^* = σ_k^y`（`a = y`）。 -/
theorem sigmaY_conjTranspose (k : Fin M) : (sigmaY k)ᴴ = sigmaY k :=
  siteOp_conjTranspose_of_conjTranspose_eq k pauliY_conjTranspose   -- 4 行目は `conjugate_transpose_of_pauli_y`

/-- 人手 `check_number_operator_is_hermitian` の (1) の `(σ_k^z)^* = σ_k^z`（`a = z`）。 -/
theorem sigmaZ_conjTranspose (k : Fin M) : (sigmaZ k)ᴴ = sigmaZ k :=
  siteOp_conjTranspose_of_conjTranspose_eq k pauliZ_conjTranspose   -- 4 行目は `conjugate_transpose_of_pauli_z`

/-! ## `Z_m`, `Y_m` の転置 -/

theorem Z_transpose (m : Fin M) : (Z m)ᵀ = Z m := by
  rw [Z, siteProd_transpose]
  congr 1
  funext i
  unfold jwFamily
  split
  · exact pauliX_transpose
  · split
    · exact pauliZ_transpose
    · exact Matrix.transpose_one

theorem Y_transpose (m : Fin M) : (Y m)ᵀ = -(Y m) := by
  rw [Y, siteProd_transpose]
  have hfam : (fun i => (jwFamily m pauliY i)ᵀ) = jwFamily m (-pauliY) := by
    funext i
    unfold jwFamily
    split
    · exact pauliX_transpose
    · split
      · exact pauliY_transpose
      · exact Matrix.transpose_one
  rw [hfam, jw_eq_xString_mul, map_neg, Matrix.mul_neg, ← jw_eq_xString_mul]

/-! ## `Z_j^*`, `Y_j^*`

人手 `check_number_operator_is_hermitian`（正本 `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`）の
(1) の `Z_j^*` の 5 行の鎖と 1 対 1 である。人手は `Y_j` を「`σ_j^z` を `σ_j^y` に替えた同じ計算」とするので、鎖は第 `j` サイトの
因子 `A` と `hA : (σ_j^A)^* = σ_j^A`（Lean の `siteOp j A`）について 1 回だけ書き（`jw_conjTranspose_of_siteOp_conjTranspose_eq`）、
`Z_j`・`Y_j` は `A → σ^z`・`A → σ^y` として得る。

人手の左から順の積 `σ_1^x⋯σ_{j-1}^x` は Lean の `xString M (j-1)`（`xString_succ` が `P_{r+1} = P_rσ_{r+1}^x`）、
`(XW)^* = W^*X^*` の反復適用で現れる逆順の積 `B_{j-1}⋯B_1` は `revSiteProduct B (j-1)`（`B` は人手のサイト `i+1` の因子を Lean の `i` に置く族）である。
反復適用は `r` についての帰納法（`xString_conjTranspose`）、`distinct_site_pauli_matrices_commute` の反復適用は
「人手の `σ_{i+1}^x`（Lean のサイト `i < r`）のどれとも可換な行列は `P_r` と可換」（`commute_xString_of_commute_sigmaX`）の帰納法で、それを人手の `σ_j^A`（Lean のサイト `j`）と
人手の `σ_{r+1}^x`（Lean のサイト `r`）に当てる（`siteOp_mul_xString`・`revSiteProduct_sigmaX_eq_xString`）。人手の `j ∈ {1, …, M_col}` は Lean の 0 始まりの `j : Fin M` で、人手の `j-1` が Lean の `(j : ℕ)` である。 -/

/-- 人手のサイト `i+1` の `σ^x`（Lean の 0 始まりのサイト `i`）。`i ≥ M` では使わない（`I` を置く）。 -/
noncomputable def sigmaXAt (M : ℕ) (i : ℕ) : TensorPow M :=
  if h : i < M then sigmaX ⟨i, h⟩ else 1

theorem sigmaXAt_of_lt {i : ℕ} (h : i < M) : sigmaXAt M i = sigmaX ⟨i, h⟩ := by
  rw [sigmaXAt, dif_pos h]

/-- 逆順の積 `B_r ⋯ B_1`（人手の 1 始まりの添字。Lean の族では `B (r-1) * ⋯ * B 0`）。空の積は `I`。 -/
noncomputable def revSiteProduct (B : ℕ → TensorPow M) : ℕ → TensorPow M
  | 0 => 1
  | r + 1 => B r * revSiteProduct B r

/-- **人手 `(σ_1^x⋯σ_r^x)^* = (σ_r^x)^*⋯(σ_1^x)^*`**: `star_preserves_norm_and_limits` (1) の `(XW)^* = W^*X^*` の反復適用（`r` の帰納法）。 -/
theorem xString_conjTranspose : ∀ r : ℕ, r ≤ M →
    (xString M r)ᴴ = revSiteProduct (fun i => (sigmaXAt M i)ᴴ) r
  | 0, _ =>
    calc (xString M 0)ᴴ
        = (1 : TensorPow M)ᴴ := by rw [xString_zero]           -- 空の積は `I`
      _ = 1 := identity_conjTranspose_tensorPow                  -- `I^* = I`
      _ = revSiteProduct (fun i => (sigmaXAt M i)ᴴ) 0 := rfl     -- 空の積は `I`
  | r + 1, h =>
    calc (xString M (r + 1))ᴴ
        = (xString M r * sigmaX ⟨r, h⟩)ᴴ := by rw [xString_succ r h]   -- `P_{r+1} = P_rσ_{r+1}^x`
      _ = (sigmaX ⟨r, h⟩)ᴴ * (xString M r)ᴴ :=
          conjTranspose_mul_tensorPow _ _                                -- `star_preserves_norm_and_limits` (1) の `(XW)^* = W^*X^*`
      _ = (sigmaXAt M r)ᴴ * revSiteProduct (fun i => (sigmaXAt M i)ᴴ) r := by
          rw [xString_conjTranspose r (Nat.le_of_succ_le h), sigmaXAt_of_lt h]   -- 帰納法の仮定
      _ = revSiteProduct (fun i => (sigmaXAt M i)ᴴ) (r + 1) := rfl

/-- 人手の「各因子へ `(σ_i^x)^* = σ_i^x`」（`sigmaX_conjTranspose` を逆順の積の全ての因子へ同時に。`r` の帰納法で因子を 1 つずつ書き換える）。 -/
theorem revSiteProduct_sigmaXAt_conjTranspose : ∀ r : ℕ, r ≤ M →
    revSiteProduct (fun i => (sigmaXAt M i)ᴴ) r = revSiteProduct (sigmaXAt M) r
  | 0, _ => rfl                                                              -- 空の積は `I`
  | r + 1, h =>
    calc revSiteProduct (fun i => (sigmaXAt M i)ᴴ) (r + 1)
        = (sigmaX ⟨r, h⟩)ᴴ * revSiteProduct (fun i => (sigmaXAt M i)ᴴ) r := by
          show (sigmaXAt M r)ᴴ * _ = _; rw [sigmaXAt_of_lt h]                -- 逆順の積の定義
      _ = sigmaX ⟨r, h⟩ * revSiteProduct (fun i => (sigmaXAt M i)ᴴ) r := by
          rw [sigmaX_conjTranspose]                       -- `(σ_k^a)^* = σ_k^a`（`a = x`）
      _ = sigmaX ⟨r, h⟩ * revSiteProduct (sigmaXAt M) r := by
          rw [revSiteProduct_sigmaXAt_conjTranspose r (Nat.le_of_succ_le h)]   -- 帰納法の仮定
      _ = revSiteProduct (sigmaXAt M) (r + 1) := by
          show _ = sigmaXAt M r * _; rw [sigmaXAt_of_lt h]                   -- 逆順の積の定義

/-- 人手 `distinct_site_pauli_matrices_commute` の反復適用の本体: `σ_{i+1}^x`（`i < r`）のどれとも可換な `A` は `P_r` と可換（`r` の帰納法）。 -/
theorem commute_xString_of_commute_sigmaX (A : TensorPow M) :
    ∀ r : ℕ, ∀ hr : r ≤ M, (∀ i : ℕ, ∀ hi : i < r, A * sigmaX ⟨i, by omega⟩ = sigmaX ⟨i, by omega⟩ * A) →
      A * xString M r = xString M r * A
  | 0, _, _ => by
    rw [xString_zero, mul_identity_matrix_tensorPow, identity_matrix_mul_tensorPow]
    -- `AI = A = IA`（`identity_matrix_is_right_unit_of_mat_mult`・`identity_matrix_is_left_unit_of_mat_mult` にあたる）
  | r + 1, h, hc =>
    calc A * xString M (r + 1)
        = A * (xString M r * sigmaX ⟨r, h⟩) := by rw [xString_succ r h]   -- `P_{r+1} = P_rσ_{r+1}^x`
      _ = (A * xString M r) * sigmaX ⟨r, h⟩ := (mul_assoc _ _ _).symm      -- `mat_mult_associative` にあたる
      _ = (xString M r * A) * sigmaX ⟨r, h⟩ := by
          rw [commute_xString_of_commute_sigmaX A r (Nat.le_of_succ_le h)
            (fun i hi => hc i (Nat.lt_succ_of_lt hi))]                       -- 帰納法の仮定
      _ = xString M r * (A * sigmaX ⟨r, h⟩) := mul_assoc _ _ _               -- `mat_mult_associative` にあたる
      _ = xString M r * (sigmaX ⟨r, h⟩ * A) := by rw [hc r (Nat.lt_succ_self r)]   -- `A` と `σ_{r+1}^x` の可換性
      _ = (xString M r * sigmaX ⟨r, h⟩) * A := (mul_assoc _ _ _).symm      -- `mat_mult_associative` にあたる
      _ = xString M (r + 1) * A := by rw [xString_succ r h]                  -- `P_{r+1} = P_rσ_{r+1}^x`

/-- 人手の「`σ_j^a` を `σ_1^x⋯σ_{j-1}^x` の右へ移す」（人手の添字）: `distinct_site_pauli_matrices_commute`（Lean のサイト `j` と `i < j`。人手のサイト `j+1` と `i+1 ≤ j`）の反復適用。 -/
theorem siteOp_mul_xString (j : Fin M) (A : Matrix (Fin 2) (Fin 2) ℂ) :
    siteOp j A * xString M (j : ℕ) = xString M (j : ℕ) * siteOp j A :=
  commute_xString_of_commute_sigmaX (siteOp j A) (j : ℕ) (Nat.le_of_lt j.isLt)
    (fun i hi => siteOp_mul_comm (Fin.ne_of_val_ne (by simp only; omega)) A pauliX)
                                                          -- `distinct_site_pauli_matrices_commute`（Lean のサイト `j ≠ i`）

/-- 人手の「`σ_r^x⋯σ_1^x = σ_1^x⋯σ_r^x`」（人手の添字）: `distinct_site_pauli_matrices_commute`（Lean のサイト `r` と `i < r`。人手のサイト `r+1` と `i+1 ≤ r`）の反復適用（`r` の帰納法）。 -/
theorem revSiteProduct_sigmaX_eq_xString : ∀ r : ℕ, r ≤ M →
    revSiteProduct (sigmaXAt M) r = xString M r
  | 0, _ => by rw [xString_zero]; rfl                                        -- 空の積は `I`
  | r + 1, h =>
    calc revSiteProduct (sigmaXAt M) (r + 1)
        = sigmaX ⟨r, h⟩ * revSiteProduct (sigmaXAt M) r := by
          show sigmaXAt M r * _ = _; rw [sigmaXAt_of_lt h]                   -- 逆順の積の定義
      _ = sigmaX ⟨r, h⟩ * xString M r := by
          rw [revSiteProduct_sigmaX_eq_xString r (Nat.le_of_succ_le h)]     -- 帰納法の仮定
      _ = xString M r * sigmaX ⟨r, h⟩ :=
          commute_xString_of_commute_sigmaX (sigmaX ⟨r, h⟩) r (Nat.le_of_succ_le h)
            (fun i hi => siteOp_mul_comm (Fin.ne_of_val_ne (by simp only; omega)) pauliX pauliX)
                                                          -- `distinct_site_pauli_matrices_commute`（Lean のサイト `r ≠ i`）
      _ = xString M (r + 1) := (xString_succ r h).symm                       -- `P_{r+1} = P_rσ_{r+1}^x`

/-- **人手 `check_number_operator_is_hermitian` の (1) の `Z_j^*` の 5 行の鎖**（第 `j` サイトの因子 `A` と `(σ_j^A)^* = σ_j^A` について。
`Z_j` は `A → σ^z`、`Y_j` は `A → σ^y`）。 -/
theorem jw_conjTranspose_of_siteOp_conjTranspose_eq (j : Fin M) {A : Matrix (Fin 2) (Fin 2) ℂ}
    (hA : (siteOp j A)ᴴ = siteOp j A) :
    (xString M (j : ℕ) * siteOp j A)ᴴ = xString M (j : ℕ) * siteOp j A :=
  calc (xString M (j : ℕ) * siteOp j A)ᴴ
      = (siteOp j A)ᴴ * revSiteProduct (fun i => (sigmaXAt M i)ᴴ) (j : ℕ) := by
        rw [conjTranspose_mul_tensorPow, xString_conjTranspose (j : ℕ) (Nat.le_of_lt j.isLt)]
                                                          -- `star_preserves_norm_and_limits` (1) の `(XW)^* = W^*X^*` の反復適用
    _ = siteOp j A * revSiteProduct (sigmaXAt M) (j : ℕ) := by
        rw [hA, revSiteProduct_sigmaXAt_conjTranspose (j : ℕ) (Nat.le_of_lt j.isLt)]   -- `(σ_k^a)^* = σ_k^a`
    _ = xString M (j : ℕ) * siteOp j A := by
        rw [revSiteProduct_sigmaX_eq_xString (j : ℕ) (Nat.le_of_lt j.isLt), siteOp_mul_xString]
                                                          -- `distinct_site_pauli_matrices_commute` の反復適用

/-- **人手 `check_number_operator_is_hermitian` の (1) の `Z_j^* = Z_j`**。 -/
theorem Z_conjTranspose (m : Fin M) : (Z m)ᴴ = Z m :=
  calc (Z m)ᴴ
      = (xString M (m : ℕ) * siteOp m pauliZ)ᴴ := by rw [Z_eq_xString_mul]; rfl   -- `def_jordan_wigner_Z_matrices`
    _ = xString M (m : ℕ) * siteOp m pauliZ :=
        jw_conjTranspose_of_siteOp_conjTranspose_eq m (sigmaZ_conjTranspose m)     -- 2〜4 行目（`A → σ^z`）
    _ = Z m := by rw [Z_eq_xString_mul]; rfl                                       -- `def_jordan_wigner_Z_matrices`

/-- **人手 `check_number_operator_is_hermitian` の (1) の `Y_j^* = Y_j`**（`σ_j^z` を `σ_j^y` に替えた同じ計算）。 -/
theorem Y_conjTranspose (m : Fin M) : (Y m)ᴴ = Y m :=
  calc (Y m)ᴴ
      = (xString M (m : ℕ) * siteOp m pauliY)ᴴ := by rw [Y_eq_xString_mul]; rfl   -- `def_jordan_wigner_Y_matrices`
    _ = xString M (m : ℕ) * siteOp m pauliY :=
        jw_conjTranspose_of_siteOp_conjTranspose_eq m (sigmaY_conjTranspose m)     -- 2〜4 行目（`A → σ^y`）
    _ = Y m := by rw [Y_eq_xString_mul]; rfl                                       -- `def_jordan_wigner_Y_matrices`

/-! ## `H_1^{(±)}`, `H_2` の反エルミート性・転置対称性 -/

/-- `(Y_m Z_n)^* = -(Y_m Z_n)`（`[Z,Y]_+ = 0` による）。 -/
theorem conjTranspose_Y_mul_Z (m n : Fin M) : (Y m * Z n)ᴴ = -(Y m * Z n) := by
  rw [conjTranspose_mul_tensorPow, Z_conjTranspose, Y_conjTranspose]
  have h := anticomm_Z_Y n m
  rw [acomm] at h
  linear_combination (norm := noncomm_ring) h

/-- `(Y_m Z_n)^⊤ = Y_m Z_n`。 -/
theorem transpose_Y_mul_Z (m n : Fin M) : (Y m * Z n)ᵀ = Y m * Z n := by
  rw [Matrix.transpose_mul, Z_transpose, Y_transpose]
  have h := anticomm_Z_Y n m
  rw [acomm] at h
  linear_combination (norm := noncomm_ring) -h

theorem conjTranspose_Z_mul_Y (m : Fin M) : (Z m * Y m)ᴴ = -(Z m * Y m) := by
  rw [conjTranspose_mul_tensorPow, Z_conjTranspose, Y_conjTranspose]
  have h := anticomm_Z_Y m m
  rw [acomm] at h
  linear_combination (norm := noncomm_ring) h

theorem transpose_Z_mul_Y (m : Fin M) : (Z m * Y m)ᵀ = Z m * Y m := by
  rw [Matrix.transpose_mul, Z_transpose, Y_transpose]
  have h := anticomm_Z_Y m m
  rw [acomm] at h
  linear_combination (norm := noncomm_ring) -h

theorem H1_conjTranspose {η : ℂ} (hη : star η = η) :
    (H1 M η)ᴴ = -(H1 M η) := by
  rw [H1, Matrix.conjTranspose_sum, ← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun m _ => ?_
  have hstar : star (lastSign η m) = lastSign η m := by
    unfold lastSign
    split
    · exact hη
    · exact star_one _
  rw [Matrix.conjTranspose_smul, conjTranspose_Y_mul_Z, smul_neg, hstar]

theorem H1_transpose {η : ℂ} : (H1 M η)ᵀ = H1 M η := by
  rw [H1]
  rw [Matrix.transpose_sum]
  refine Finset.sum_congr rfl fun m _ => ?_
  rw [Matrix.transpose_smul, transpose_Y_mul_Z]

theorem H2_conjTranspose : (H2 M)ᴴ = -(H2 M) := by
  rw [H2, Matrix.conjTranspose_sum, ← Finset.sum_neg_distrib]
  exact Finset.sum_congr rfl fun m _ => conjTranspose_Z_mul_Y m

theorem H2_transpose : (H2 M)ᵀ = H2 M := by
  rw [H2, Matrix.transpose_sum]
  exact Finset.sum_congr rfl fun m _ => transpose_Z_mul_Y m

/-- 補助: `c` が実（`\bar c = c`）なら `\overline{ic} = -(ic)`。人手の主張ではなく、下の補助 `S1_isHermitian`・
`S2_isHermitian_by_anticommutation` だけが使う。人手の主張の具体版を当てるのは 1 段目（`complex_conjugate_of_product`）と
3 段目（`\bar i = -i`）で、ほかは `star` の読み替え・仮定・`(-x)y = -(xy)` の段である。 -/
private theorem star_I_mul {c : ℂ} (hc : star c = c) :
    star (Complex.I * c) = -(Complex.I * c) :=
  calc star (Complex.I * c)
      = star Complex.I * star c := complex_conjugate_star_mul _ _   -- `complex_conjugate_of_product`
    _ = (starRingEnd ℂ) Complex.I * star c := rfl                   -- `star` を `starRingEnd ℂ` と読む
    _ = (-Complex.I) * star c := by
        rw [conj_I_eq_neg_I]                                        -- `relation_of_gamma_2_theta_tilde` の `\bar i = -i`
    _ = (-Complex.I) * c := by rw [hc]                              -- 仮定 `\bar c = c`
    _ = -(Complex.I * c) := neg_mul _ _                             -- `(-x)y = -(xy)`

/-- 補助: 一般形 `i K_1 H1 M η`（`η` 実）はエルミート。 -/
theorem S1_isHermitian {K1 η : ℂ} (hK1 : star K1 = K1) (hη : star η = η) :
    (((Complex.I * K1) • H1 M η)).IsHermitian := by
  have h : (((Complex.I * K1) • H1 M η))ᴴ = (Complex.I * K1) • H1 M η := by
    rw [Matrix.conjTranspose_smul, H1_conjTranspose hη, star_I_mul hK1,
      smul_neg, neg_smul, neg_neg]
  exact h

/-- 補助: 一般形 `i K_1 H1 M η` は転置不変。 -/
theorem S1_transpose {K1 η : ℂ} : (((Complex.I * K1) • H1 M η))ᵀ = (Complex.I * K1) • H1 M η := by
  rw [Matrix.transpose_smul, H1_transpose]

/-- 補助: `S_2 = iK_2^*H_2`（`K_2^*` 実）は、`[Z, Y]_+ = 0` からエルミート（全ての `M`）。
人手 `iH_is_real_symmetric` の論法（Step 3 の転置の鎖と成分の実性）ではない。人手の主張の具体版は
`S2_isHermitian`（`EigenvalueProblem/EigenvaluesOfVPlus/ClaimIHPauliForm.lean`）で、このファイルの中で `S_2` のエルミート性を要る
整数運動量の経路の形式化の記録 `Vmat_posDef`（このファイルは `ClaimIHPauliForm.lean` より前にある）と、`S2_isHermitian` の
人手の主張の範囲外の `M_col = 0` の場合がこちらを使う。 -/
theorem S2_isHermitian_by_anticommutation {K2star : ℂ} (hK2 : star K2star = K2star) :
    (((Complex.I * K2star) • H2 M)).IsHermitian := by
  have h : (((Complex.I * K2star) • H2 M))ᴴ = (Complex.I * K2star) • H2 M := by
    rw [Matrix.conjTranspose_smul, H2_conjTranspose, star_I_mul hK2,
      smul_neg, neg_smul, neg_neg]
  exact h

end Herm

/-! ## `exp` の正定値性（原文 `exp_hermitian_is_positive_definite`） -/

section PosDef

/-- **原文 `exp_hermitian_is_positive_definite`**: エルミート行列の `exp` はエルミートかつ正定値。

原文は `T := exp(S/2)` について `exp(S) = T^*(IT)` と書き、`I` が正定値であること（`identity_matrix_is_positive_definite`）と
`T' := exp(-S/2)` が `T'T = I` を満たすこと（`exp_of_negative_is_left_inverse`）から `congruence_preserves_positive_definite` で示す。
ここでは `exp(S/2)` の可逆性 → `A^* A` が正定値（mathlib の `Matrix.PosDef.conjTranspose_mul_self`）で示しており、人手の段とは一対一でない。
人手の `T^* = T`（`exp_of_hermitian_is_hermitian` を `H = S/2` に当てはめる）だけは、その具体版
`matExp_conjTranspose_of_conjTranspose_eq` を引く。 -/
theorem posDef_exp_of_isHermitian {M : ℕ} {S : TensorPow M} (hS : S.IsHermitian) :
    (NormedSpace.exp S).PosDef := by
  set X : TensorPow M := (1 / 2 : ℂ) • S with hX
  have hhalf : X.IsHermitian := by
    have : Xᴴ = X := by
      rw [hX, Matrix.conjTranspose_smul, hS.eq]
      norm_num
    exact this
  have hsq : NormedSpace.exp X * NormedSpace.exp X = NormedSpace.exp S := by
    rw [← Matrix.exp_add_of_commute _ _ (Commute.refl _), hX, ← two_smul ℂ, smul_smul]
    norm_num
  have hinj : Function.Injective (NormedSpace.exp X).mulVec :=
    Matrix.mulVec_injective_of_isUnit (Matrix.isUnit_exp _)
  have h := Matrix.PosDef.conjTranspose_mul_self (NormedSpace.exp X) hinj
  -- 人手 `T^* = T`（`exp_of_hermitian_is_hermitian`、`S → H = S/2`）
  have hT : (NormedSpace.exp X)ᴴ = NormedSpace.exp X := matExp_conjTranspose_of_conjTranspose_eq X hhalf
  rwa [hT, hsq] at h

end PosDef

/-! ## `V` の正定値性（原文 `V_is_positive_definite`） -/

section Vpos

variable {M : ℕ}

/-- **原文 `V_is_positive_definite` の `V := (V_1^{(±)})^{1/2} V_2 (V_1^{(±)})^{1/2}`**。 -/
noncomputable def Vmat (M : ℕ) (K1 η : ℂ) (s2 : ℝ) (K2star : ℂ) : TensorPow M :=
  V1pmHalf M K1 η * V2H2Form M s2 K2star * V1pmHalf M K1 η

/-- **原文 `V_is_positive_definite` Step 3**: `V` は正定値。 -/
theorem Vmat_posDef {K1 η K2star : ℂ} {s2 : ℝ}
    (hK1 : star K1 = K1) (hη : star η = η)
    (hK2 : star K2star = K2star) (hs2 : 0 < s2) :
    (Vmat M K1 η s2 K2star).PosDef := by
  have hS1 : (((1 / 2 : ℂ)) • ((Complex.I * K1) • H1 M η)).IsHermitian := by
    have : ((((1 / 2 : ℂ)) • ((Complex.I * K1) • H1 M η)))ᴴ
        = ((1 / 2 : ℂ)) • ((Complex.I * K1) • H1 M η) := by
      rw [Matrix.conjTranspose_smul, (S1_isHermitian hK1 hη).eq]
      norm_num
    exact this
  have hB : (V1pmHalf M K1 η).IsHermitian := by
    have hEq : V1pmHalf M K1 η = NormedSpace.exp (((1 / 2 : ℂ)) • ((Complex.I * K1) • H1 M η)) := by
      rw [V1pmHalf, matExp, smul_smul, mul_assoc]
    rw [hEq]
    -- `exp_hermitian_is_positive_definite`（`S → ½(iK_1H)`）で正定値、`def_hermitian_positive_definite` よりとくにエルミート
    exact (posDef_exp_of_isHermitian hS1).isHermitian
  have hA : (NormedSpace.exp ((Complex.I * K2star) • H2 M)).PosDef :=
    posDef_exp_of_isHermitian (S2_isHermitian_by_anticommutation hK2)
  have hinj : Function.Injective (V1pmHalf M K1 η).mulVec := by
    have hEq : V1pmHalf M K1 η = NormedSpace.exp (((1 / 2 : ℂ) * Complex.I * K1) • H1 M η) := rfl
    rw [hEq]
    exact Matrix.mulVec_injective_of_isUnit (Matrix.isUnit_exp _)
  have hBAB : ((V1pmHalf M K1 η)ᴴ * NormedSpace.exp ((Complex.I * K2star) • H2 M)
      * V1pmHalf M K1 η).PosDef := hA.conjTranspose_mul_mul_same hinj
  rw [hB.eq] at hBAB
  have hV : Vmat M K1 η s2 K2star
      = (((((2 * s2) ^ ((M : ℝ) / 2) : ℝ)) : ℂ))
        • (V1pmHalf M K1 η * NormedSpace.exp ((Complex.I * K2star) • H2 M) * V1pmHalf M K1 η) := by
    rw [Vmat, V2H2Form, matExp]
    rw [Matrix.mul_smul, Matrix.smul_mul]
  rw [hV]
  refine positive_real_multiple_preserves_positive_definite_tensorPow hBAB ?_
  have : (0 : ℝ) < 2 * s2 := by linarith
  exact Real.rpow_pos_of_pos this _

/-- **原文 `V_is_positive_definite` Step 5**: `tr(V) > 0`。 -/
theorem trace_Vmat_pos {K1 η K2star : ℂ} {s2 : ℝ}
    (hK1 : star K1 = K1) (hη : star η = η)
    (hK2 : star K2star = K2star) (hs2 : 0 < s2) :
    0 < (Vmat M K1 η s2 K2star).trace :=
  (Vmat_posDef hK1 hη hK2 hs2).trace_pos

end Vpos

end Ising2D
