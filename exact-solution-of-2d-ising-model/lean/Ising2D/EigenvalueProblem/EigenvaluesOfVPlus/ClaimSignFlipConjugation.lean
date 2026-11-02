/-
# 符号反転共役 `U`（具体版）

対応する人手証明（`structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`）:
`sign_flip_conjugation`（`eigenvalues_of_V_016_claim_sign_flip_conjugation`）

人手の `E := E_1 ⊠ ⋯ ⊠ E_{M_col}`（`E_m` は `m` が奇数なら `σ^x`、偶数なら `I`）・`F := σ^z ⊠ ⋯ ⊠ σ^z` を
`siteProd`（クロネッカー積）で `Eflip`・`Fflip` と定義し、`U := E F` を `Uflip := Eflip * Fflip`、
`U^{-1} = F E` を `UflipInv := Fflip * Eflip` とする
（Lean の添字は 0 始まりなので、人手の「`m` が奇数」は `(i : ℕ)` が偶数にあたる）。

## 原文との違い（形式化して分かったこと）

人手の本文（`(+)` だけ）の旧版は `S_1^{(±)}` を `K_1 ∑ σ^z_m σ^z_{m+1} ∓ K_1 G` の形に書き換えてから、
`G` の因子の符号を `M` の偶奇で場合分けして数えている。
しかし実際には

  `U Z_m U^{-1} = -Z_m`,  `U Y_m U^{-1} = +Y_m`   （**`m` によらず**）

が成り立ち、ここから `U H_1^{(±)} U^{-1} = -H_1^{(±)}`、`U H_2 U^{-1} = -H_2` が
（`H_1` が `Y_m Z_{m+1}` の、`H_2` が `Z_m Y_m` の和であることから）直ちに従う。
**`M` の偶奇による場合分けも `G` への書き換えも要らない。**
原文の結論は正しいが、経路は本ファイルの方が短い。

人手の本文は `(+)` セクターの `U H_1^{(+)} U^{-1} = -H_1^{(+)}`, `U S_1^{(+)} U^{-1} = -S_1^{(+)}` だけを述べる
（`(−)` セクターは参照用ノート `structured-latex/notes/minus_sector_not_adopted.ts` へ退避済み）。
Lean では境界項の係数を引数 `η` に持たせた一般形 `Uflip_conj_H1` / `Uflip_conj_S1` を補助として残し
（整数運動量の経路の形式化の記録と章 017 が使う）、人手の主張に対応する `(+)` の定理
`Uflip_conj_H1plus` はその `η = -1` の場合として立て、`Uflip_conj_S1plus` は人手 Step 4 の鎖の行どおりに `Uflip_conj_H1plus` から示す。
-/
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.DefinitionH1H2V1V2
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimNegationFactorsOutOfMatrixProductFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInMatrixProductFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultipleOfNegatedMatrixFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimNegationIsScalarMultipleByMinusOneFromNecSuf
import Ising2D.MathematicalTools.InvertibleMatricesLinearMapCorrespondenceAndConjugation.ClaimConjugationIsRingHom

namespace Ising2D

open Matrix

section SignFlip

variable {M : ℕ}

/-! ## `E`・`F`・`U` とその逆（人手の主張の定義と Step 0 の可逆性） -/

/-- 人手の `E_m`（`m` が奇数なら `σ^x`、偶数なら `I_{Mat(2,ℂ)}`）。Lean の添字 `i` は 0 始まりなので、
人手の「`m = i+1` が奇数」は `(i : ℕ)` が偶数にあたる。 -/
noncomputable def eFlipFam (M : ℕ) : Fin M → Matrix (Fin 2) (Fin 2) ℂ :=
  fun i => if Even (i : ℕ) then pauliX else 1

/-- 人手の `E := E_1 ⊠ ⋯ ⊠ E_{M_col}`。 -/
noncomputable def Eflip (M : ℕ) : TensorPow M := siteProd M (eFlipFam M)

/-- 人手の `F := σ^z ⊠ ⋯ ⊠ σ^z`。 -/
noncomputable def Fflip (M : ℕ) : TensorPow M := siteProd M (fun _ => pauliZ)

/-- **人手の `U := E F`**。 -/
noncomputable def Uflip (M : ℕ) : TensorPow M := Eflip M * Fflip M

/-- 人手 Step 0 の `U^{-1} = F^{-1}E^{-1} = FE`。 -/
noncomputable def UflipInv (M : ℕ) : TensorPow M := Fflip M * Eflip M

/-- 人手 Step 0 の `E_mE_m = I_{Mat(2,ℂ)}`（`m` 奇数は `pauli_matrix_products` の `σ^xσ^x = I`、
偶数は `identity_matrix_is_left_unit_of_mat_mult`）。 -/
theorem eFlipFam_mul_self (i : Fin M) : eFlipFam M i * eFlipFam M i = 1 := by
  unfold eFlipFam
  by_cases h : Even (i : ℕ)
  · rw [if_pos h]
    exact pauliX_mul_pauliX                             -- `pauli_matrix_products` の `σ^xσ^x = I`
  · rw [if_neg h]
    exact identity_matrix_mul (1 : Matrix (Fin 2) (Fin 2) ℂ)
                                                        -- `identity_matrix_is_left_unit_of_mat_mult`

/-- 人手 Step 0 の `FF = I_{Mat(2^{M_col},ℂ)}` の 4 行の鎖。 -/
theorem Fflip_mul_self : Fflip M * Fflip M = 1 :=
  calc Fflip M * Fflip M
      = siteProd M (fun _ => pauliZ) * siteProd M (fun _ => pauliZ) := rfl
                                                        -- `F` の定義
    _ = siteProd M (fun _ => pauliZ * pauliZ) := (siteProd_mul M _ _).symm
                                                        -- `kronecker_product_rule` (1)
    _ = siteProd M (fun _ => (1 : Matrix (Fin 2) (Fin 2) ℂ)) := by rw [pauliZ_mul_pauliZ]
                                                        -- `pauli_matrix_products` の `σ^zσ^z = I`（全ての因子へ同時適用）
    _ = 1 := siteProd_one M                             -- `kronecker_product_rule` (2)

/-- 人手 Step 0 の `EE = I_{Mat(2^{M_col},ℂ)}` の 4 行の鎖。 -/
theorem Eflip_mul_self : Eflip M * Eflip M = 1 :=
  calc Eflip M * Eflip M
      = siteProd M (eFlipFam M) * siteProd M (eFlipFam M) := rfl
                                                        -- `E` の定義
    _ = siteProd M (fun i => eFlipFam M i * eFlipFam M i) := (siteProd_mul M _ _).symm
                                                        -- `kronecker_product_rule` (1)
    _ = siteProd M (fun _ => (1 : Matrix (Fin 2) (Fin 2) ℂ)) := by simp only [eFlipFam_mul_self]
                                                        -- 上の `E_mE_m = I`（全ての因子へ同時適用）
    _ = 1 := siteProd_one M                             -- `kronecker_product_rule` (2)

/-- 人手 Step 0 の `U` の可逆性の半分 `(EF)(FE) = I`。`def_invertible_elements_of_R` (ii) の証明の 1 本目の鎖
（`(g_1g_2)h = I`）を `g_1 = E`、`g_2 = F`、`g_1^{-1} = E`、`g_2^{-1} = F` で書いたもの。
人手の `F^{-1} = F`・`E^{-1} = E` は、Lean では `UflipInv` を `F E` と定義したうえで、ここで `FF = I`・`EE = I` を直接使う。 -/
theorem Uflip_mul_inv : Uflip M * UflipInv M = 1 :=
  calc Uflip M * UflipInv M
      = (Eflip M * Fflip M) * (Fflip M * Eflip M) := rfl
                                                        -- `U = EF` と `h = g_2^{-1}g_1^{-1} = FE` の代入
    _ = ((Eflip M * Fflip M) * Fflip M) * Eflip M := (Matrix.mul_assoc _ _ _).symm
                                                        -- `mat_mult_associative`（Lean の具体版は無く、mathlib の `Matrix.mul_assoc` を 1 回）
    _ = (Eflip M * (Fflip M * Fflip M)) * Eflip M := by rw [Matrix.mul_assoc (Eflip M) (Fflip M) (Fflip M)]
                                                        -- `mat_mult_associative`
    _ = (Eflip M * 1) * Eflip M := by rw [Fflip_mul_self]
                                                        -- `g_2g_2^{-1} = I`（`FF = I`）
    _ = Eflip M * Eflip M := by rw [mul_identity_matrix_tensorPow]
                                                        -- `identity_matrix_is_right_unit_of_mat_mult`
    _ = 1 := Eflip_mul_self                             -- `g_1g_1^{-1} = I`（`EE = I`）

/-- 人手 Step 0 の `U` の可逆性の残り半分 `(FE)(EF) = I`。`def_invertible_elements_of_R` (ii) の証明の 2 本目の鎖
（`h(g_1g_2) = I`）を `g_1 = E`、`g_2 = F` で書いたもの。 -/
theorem UflipInv_mul : UflipInv M * Uflip M = 1 :=
  calc UflipInv M * Uflip M
      = (Fflip M * Eflip M) * (Eflip M * Fflip M) := rfl
                                                        -- `h = g_2^{-1}g_1^{-1} = FE` と `U = EF` の代入
    _ = ((Fflip M * Eflip M) * Eflip M) * Fflip M := (Matrix.mul_assoc _ _ _).symm
                                                        -- `mat_mult_associative`
    _ = (Fflip M * (Eflip M * Eflip M)) * Fflip M := by rw [Matrix.mul_assoc (Fflip M) (Eflip M) (Eflip M)]
                                                        -- `mat_mult_associative`
    _ = (Fflip M * 1) * Fflip M := by rw [Eflip_mul_self]
                                                        -- `g_1^{-1}g_1 = I`（`EE = I`）
    _ = Fflip M * Fflip M := by rw [mul_identity_matrix_tensorPow]
                                                        -- `identity_matrix_is_right_unit_of_mat_mult`
    _ = 1 := Fflip_mul_self                             -- `g_2^{-1}g_2 = I`（`FF = I`）

/-- 人手の `U = EF` のサイト `i` の因子 `E_{i+1}σ^z`（`Uflip_conj_sigmaX` ほかのサイトごとの成分計算が使う）。 -/
noncomputable def flipFam (M : ℕ) : Fin M → Matrix (Fin 2) (Fin 2) ℂ :=
  fun i => eFlipFam M i * pauliZ

/-- `U^{-1} = FE` のサイト `i` の因子 `σ^zE_{i+1}`。 -/
noncomputable def flipFamInv (M : ℕ) : Fin M → Matrix (Fin 2) (Fin 2) ℂ :=
  fun i => pauliZ * eFlipFam M i

/-- `U = EF` はサイトごとの因子 `E_{i+1}σ^z` のクロネッカー積（`kronecker_product_rule` (1)）。 -/
theorem Uflip_eq_siteProd : Uflip M = siteProd M (flipFam M) :=
  (siteProd_mul M _ _).symm

/-- `U^{-1} = FE` はサイトごとの因子 `σ^zE_{i+1}` のクロネッカー積（`kronecker_product_rule` (1)）。 -/
theorem UflipInv_eq_siteProd : UflipInv M = siteProd M (flipFamInv M) :=
  (siteProd_mul M _ _).symm

private theorem flipFam_mul_inv (i : Fin M) : flipFam M i * flipFamInv M i = 1 := by
  unfold flipFam flipFamInv eFlipFam
  by_cases h : Even (i : ℕ) <;> simp only [h, if_pos, if_neg, if_true, if_false] <;>
    · ext a b
      fin_cases a <;> fin_cases b <;>
        simp [pauliX, pauliZ, Matrix.mul_apply, Fin.sum_univ_two, Matrix.one_apply]

/-! ## 人手 Step 0 の `σ_m^aσ_m^a = I_{Mat(2^{M_col},ℂ)}`（`a ∈ {x, z}`）

人手の鎖の 5 行と 1 対 1 に対応する。`siteProd M x` が人手のクロネッカー積 `x_1 ⊠ ⋯ ⊠ x_M`、
`Function.update 1 m A` が「`m` 番目だけ `A`、ほかは `I = I_{Mat(2,ℂ)}`」の因子の並びである。 -/

/-- 人手 Step 0 の鎖の 2 行目の右辺の因子の並び: 因子ごとの積 `(I⊠⋯⊠A⊠⋯⊠I)` と `(I⊠⋯⊠B⊠⋯⊠I)` の
各サイトの積は、`m` 番目が `AB`、ほかが `II` である。 -/
theorem update_one_mul_update_one_same (m : Fin M) (A B : Matrix (Fin 2) (Fin 2) ℂ) :
    Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) m A
        * Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) m B
      = Function.update (fun _ : Fin M => (1 : Matrix (Fin 2) (Fin 2) ℂ) * 1) m (A * B) := by
  funext i
  by_cases h : i = m
  · subst h; simp only [Pi.mul_apply, Function.update_self]
  · simp only [Pi.mul_apply, Function.update_of_ne h, Pi.one_apply]

/-- 人手 Step 0 の鎖（`a` を一つ固定した形）。`A = σ^a` で `AA = I` なら、サイト `m` の `σ_m^a` について
`σ_m^aσ_m^a = I_{Mat(2^{M_col},ℂ)}`。 -/
theorem siteOp_mul_self_of_mul_self_eq_one (m : Fin M) (A : Matrix (Fin 2) (Fin 2) ℂ)
    (hA : A * A = 1) : siteOp m A * siteOp m A = 1 :=
  calc siteOp m A * siteOp m A
      = siteProd M (Function.update 1 m A) * siteProd M (Function.update 1 m A) := rfl
                                                        -- `def_site_pauli_matrices`
    _ = siteProd M (Function.update (fun _ : Fin M => (1 : Matrix (Fin 2) (Fin 2) ℂ) * 1) m (A * A)) := by
        rw [← siteProd_mul, update_one_mul_update_one_same]
                                                        -- `kronecker_product_rule` (1)
    _ = siteProd M (Function.update (fun _ : Fin M => (1 : Matrix (Fin 2) (Fin 2) ℂ) * 1) m 1) := by
        rw [hA]                                         -- `pauli_matrix_products` の `σ^aσ^a = I`
    _ = siteProd M (Function.update (fun _ : Fin M => (1 : Matrix (Fin 2) (Fin 2) ℂ)) m 1) := by
        rw [identity_matrix_mul (1 : Matrix (Fin 2) (Fin 2) ℂ)]
                                                        -- `identity_matrix_is_left_unit_of_mat_mult`（`m` 番目以外へ同時適用）
    _ = 1 := by
        rw [Function.update_eq_self_iff.mpr rfl]
        exact siteProd_one M                            -- `kronecker_product_rule` (2)

/-- 人手 Step 0 の `σ_m^xσ_m^x = I_{Mat(2^{M_col},ℂ)}`（`a = x`）。同じ主張の `sigmaX_mul_self`
（`DefinitionTransferMatrixSymbols.lean`）は `siteOp_mul_same` で 1 段に閉じており、この鎖の 5 行とは対応しない。 -/
theorem sigmaX_mul_sigmaX_site (m : Fin M) : sigmaX m * sigmaX m = 1 :=
  siteOp_mul_self_of_mul_self_eq_one m pauliX pauliX_mul_pauliX

/-- 人手 Step 0 の `σ_m^zσ_m^z = I_{Mat(2^{M_col},ℂ)}`（`a = z`）。同じ主張の `sigmaZ_mul_self`
（`ClaimEpsilonD0GCommuteAndDiagonalAction.lean`）は `epsilon_G_is_involution` の箇所に対応する。 -/
theorem sigmaZ_mul_sigmaZ_site (m : Fin M) : sigmaZ m * sigmaZ m = 1 :=
  siteOp_mul_self_of_mul_self_eq_one m pauliZ pauliZ_mul_pauliZ

/-! ## 人手 Step 1 の `Wσ_k^aW^{-1}` の鎖（`W ∈ {E, F}`）と、サイトのパウリ行列の積へ戻す鎖

人手の鎖の各行と 1 対 1 に対応する。`w` が人手の `W_1, …, W_{M_col}`（`F` なら全て `σ^z`、`E` なら `E_m`）、
`siteProd M w` が `W = W_1 ⊠ ⋯ ⊠ W_{M_col}` である。人手の 1 行目「Step 0 の `W^{-1} = W`」は、
Lean では `W^{-1}` を置かず主張を `(W σ_k^a) W` で述べるので立てない。 -/

/-- 人手 Step 1 の `Wσ_k^aW^{-1} = I ⊠ ⋯ ⊠ ((W_kσ^a)W_k) ⊠ ⋯ ⊠ I` の鎖の 2 行目以降
（`W_mW_m = I` を仮定に取る。`W = F` では `pauli_matrix_products` の `σ^zσ^z = I`、`W = E` では Step 0 の `E_mE_m = I`）。 -/
theorem siteProd_conj_siteOp (w : Fin M → Matrix (Fin 2) (Fin 2) ℂ) (hw : ∀ i, w i * w i = 1)
    (k : Fin M) (A : Matrix (Fin 2) (Fin 2) ℂ) :
    (siteProd M w * siteOp k A) * siteProd M w
      = siteProd M (Function.update (fun _ : Fin M => (1 : Matrix (Fin 2) (Fin 2) ℂ)) k ((w k * A) * w k)) :=
  calc (siteProd M w * siteOp k A) * siteProd M w
      = (siteProd M w * siteOp k A) * siteProd M w := rfl
                                                        -- `W` の定義（Lean の `W` は初めから `siteProd M w`）
    _ = (siteProd M w * siteProd M (Function.update 1 k A)) * siteProd M w := rfl
                                                        -- `def_site_pauli_matrices`
    _ = siteProd M (Function.update (fun i => w i * 1) k (w k * A)) * siteProd M w := by
        rw [← siteProd_mul]
        congr 2
        funext i
        by_cases h : i = k
        · subst h; simp only [Pi.mul_apply, Function.update_self]
        · simp only [Pi.mul_apply, Function.update_of_ne h, Pi.one_apply]
                                                        -- `kronecker_product_rule` (1)
    _ = siteProd M (Function.update (fun i => (w i * 1) * w i) k ((w k * A) * w k)) := by
        rw [← siteProd_mul]
        congr 1
        funext i
        by_cases h : i = k
        · subst h; simp only [Pi.mul_apply, Function.update_self]
        · simp only [Pi.mul_apply, Function.update_of_ne h]
                                                        -- `kronecker_product_rule` (1)
    _ = siteProd M (Function.update (fun i => w i * w i) k ((w k * A) * w k)) := by
        simp only [mul_identity_matrix]                 -- `identity_matrix_is_right_unit_of_mat_mult`（`k` 番目以外へ同時適用）
    _ = siteProd M (Function.update (fun _ : Fin M => (1 : Matrix (Fin 2) (Fin 2) ℂ)) k ((w k * A) * w k)) := by
        simp only [hw]                                  -- 上の `W_mW_m = I`（`k` 番目以外へ同時適用）

/-- 人手 Step 1 の `I ⊠ ⋯ ⊠ ((σ^pσ^a)σ^p) ⊠ ⋯ ⊠ I = (σ_k^pσ_k^a)σ_k^p` の 5 行の鎖（`P = σ^p`）。 -/
theorem siteProd_update_conj_eq_siteOp (k : Fin M) (P A : Matrix (Fin 2) (Fin 2) ℂ) :
    siteProd M (Function.update (fun _ : Fin M => (1 : Matrix (Fin 2) (Fin 2) ℂ)) k ((P * A) * P))
      = (siteOp k P * siteOp k A) * siteOp k P :=
  calc siteProd M (Function.update (fun _ : Fin M => (1 : Matrix (Fin 2) (Fin 2) ℂ)) k ((P * A) * P))
      = siteProd M (Function.update (fun _ : Fin M => (1 : Matrix (Fin 2) (Fin 2) ℂ) * 1) k ((P * A) * P)) := by
        rw [identity_matrix_mul (1 : Matrix (Fin 2) (Fin 2) ℂ)]
                                                        -- `identity_matrix_is_left_unit_of_mat_mult`（`k` 番目以外へ同時適用）
    _ = siteProd M (Function.update (fun _ : Fin M => ((1 : Matrix (Fin 2) (Fin 2) ℂ) * 1) * 1) k ((P * A) * P)) := by
        rw [mul_identity_matrix ((1 : Matrix (Fin 2) (Fin 2) ℂ) * 1)]
                                                        -- `identity_matrix_is_right_unit_of_mat_mult`（`k` 番目以外へ同時適用）
    _ = siteProd M (Function.update (fun _ : Fin M => (1 : Matrix (Fin 2) (Fin 2) ℂ) * 1) k (P * A))
          * siteProd M (Function.update 1 k P) := by
        rw [← siteProd_mul]
        congr 1
        funext i
        by_cases h : i = k
        · subst h; simp only [Pi.mul_apply, Function.update_self]
        · simp only [Pi.mul_apply, Function.update_of_ne h, Pi.one_apply]
                                                        -- `kronecker_product_rule` (1)
    _ = (siteProd M (Function.update 1 k P) * siteProd M (Function.update 1 k A))
          * siteProd M (Function.update 1 k P) := by
        rw [← siteProd_mul M (Function.update 1 k P) (Function.update 1 k A), update_one_mul_update_one_same]
                                                        -- `kronecker_product_rule` (1)
    _ = (siteOp k P * siteOp k A) * siteOp k P := rfl   -- `def_site_pauli_matrices`

/-- 人手 Step 1 の `k` が偶数のときの鎖 `I ⊠ ⋯ ⊠ ((E_kσ^a)E_k) ⊠ ⋯ ⊠ I = σ_k^a` の 4 行
（Lean の添字は 0 始まりなので、人手の「`k` が偶数」は `(k : ℕ)` が奇数）。 -/
theorem siteProd_update_eFlipFam_conj_of_odd (k : Fin M) (hk : ¬ Even (k : ℕ))
    (A : Matrix (Fin 2) (Fin 2) ℂ) :
    siteProd M (Function.update (fun _ : Fin M => (1 : Matrix (Fin 2) (Fin 2) ℂ)) k
        ((eFlipFam M k * A) * eFlipFam M k))
      = siteOp k A :=
  calc siteProd M (Function.update (fun _ : Fin M => (1 : Matrix (Fin 2) (Fin 2) ℂ)) k
        ((eFlipFam M k * A) * eFlipFam M k))
      = siteProd M (Function.update (fun _ : Fin M => (1 : Matrix (Fin 2) (Fin 2) ℂ)) k ((1 * A) * 1)) := by
        rw [eFlipFam, if_neg hk]                        -- `E_k` の定義（`k` 偶数）
    _ = siteProd M (Function.update (fun _ : Fin M => (1 : Matrix (Fin 2) (Fin 2) ℂ)) k (A * 1)) := by
        rw [identity_matrix_mul A]                      -- `identity_matrix_is_left_unit_of_mat_mult`
    _ = siteProd M (Function.update (fun _ : Fin M => (1 : Matrix (Fin 2) (Fin 2) ℂ)) k A) := by
        rw [mul_identity_matrix A]                      -- `identity_matrix_is_right_unit_of_mat_mult`
    _ = siteOp k A := rfl                               -- `def_site_pauli_matrices`

/-- 人手 Step 1 の `F` の因子について `σ^zσ^z = I`（`pauli_matrix_products`）。 -/
theorem pauliZ_family_mul_self (i : Fin M) :
    (fun _ : Fin M => pauliZ) i * (fun _ : Fin M => pauliZ) i = 1 :=
  pauliZ_mul_pauliZ

/-- 人手 Step 1 の `Fσ_k^aF^{-1}` の鎖の 1・2 行目: `(Fσ_k^a)F = (σ_k^zσ_k^a)σ_k^z`。 -/
theorem Fflip_conj_siteOp (k : Fin M) (A : Matrix (Fin 2) (Fin 2) ℂ) :
    (Fflip M * siteOp k A) * Fflip M = (sigmaZ k * siteOp k A) * sigmaZ k :=
  calc (Fflip M * siteOp k A) * Fflip M
      = siteProd M (Function.update (fun _ : Fin M => (1 : Matrix (Fin 2) (Fin 2) ℂ)) k ((pauliZ * A) * pauliZ)) :=
        siteProd_conj_siteOp (fun _ => pauliZ) pauliZ_family_mul_self k A
                                                        -- 上の `Wσ_k^aW^{-1}` の鎖（`W = F`）
    _ = (sigmaZ k * siteOp k A) * sigmaZ k := siteProd_update_conj_eq_siteOp k pauliZ A
                                                        -- 上の `(σ_k^pσ_k^a)σ_k^p` の鎖（`p = z`）

/-- 人手 Step 1 の `Eσ_k^aE^{-1}` の鎖（`k` 奇数）の 1〜3 行目: `(Eσ_k^a)E = (σ_k^xσ_k^a)σ_k^x`
（人手の「`k` が奇数」は `(k : ℕ)` が偶数）。 -/
theorem Eflip_conj_siteOp_of_even (k : Fin M) (hk : Even (k : ℕ)) (A : Matrix (Fin 2) (Fin 2) ℂ) :
    (Eflip M * siteOp k A) * Eflip M = (sigmaX k * siteOp k A) * sigmaX k :=
  calc (Eflip M * siteOp k A) * Eflip M
      = siteProd M (Function.update (fun _ : Fin M => (1 : Matrix (Fin 2) (Fin 2) ℂ)) k
          ((eFlipFam M k * A) * eFlipFam M k)) :=
        siteProd_conj_siteOp (eFlipFam M) eFlipFam_mul_self k A
                                                        -- 上の `Wσ_k^aW^{-1}` の鎖（`W = E`）
    _ = siteProd M (Function.update (fun _ : Fin M => (1 : Matrix (Fin 2) (Fin 2) ℂ)) k ((pauliX * A) * pauliX)) := by
        rw [eFlipFam, if_pos hk]                        -- `E_k` の定義（`k` 奇数）
    _ = (sigmaX k * siteOp k A) * sigmaX k := siteProd_update_conj_eq_siteOp k pauliX A
                                                        -- 上の `(σ_k^pσ_k^a)σ_k^p` の鎖（`p = x`）

/-- 人手 Step 1 の `Eσ_k^aE^{-1} = σ_k^a`（`k` 偶数）の 2 行
（人手の「`k` が偶数」は `(k : ℕ)` が奇数）。 -/
theorem Eflip_conj_siteOp_of_odd (k : Fin M) (hk : ¬ Even (k : ℕ)) (A : Matrix (Fin 2) (Fin 2) ℂ) :
    (Eflip M * siteOp k A) * Eflip M = siteOp k A :=
  calc (Eflip M * siteOp k A) * Eflip M
      = siteProd M (Function.update (fun _ : Fin M => (1 : Matrix (Fin 2) (Fin 2) ℂ)) k
          ((eFlipFam M k * A) * eFlipFam M k)) :=
        siteProd_conj_siteOp (eFlipFam M) eFlipFam_mul_self k A
                                                        -- 上の `Wσ_k^aW^{-1}` の鎖（`W = E`）
    _ = siteOp k A := siteProd_update_eFlipFam_conj_of_odd k hk A
                                                        -- 上の `k` が偶数のときの鎖

/-! ## 人手 Step 1 の `F` による共役の鎖（`a ∈ {x, y, z}`）

人手の鎖の各行と 1 対 1 に対応する。1・2 行目は `Fflip_conj_siteOp`、3 行目以降は下の `sigmaZ_sigmaX_sigmaZ_site`・`sigmaZ_sigmaY_sigmaZ_site`・`sigmaZ_sigmaZ_sigmaZ_site` である。
鎖の全体は `Fflip_conj_sigmaX`・`Fflip_conj_sigmaY`・`Fflip_conj_sigmaZ`。
`U σ_k^a U^{-1}` の符号を与える `Uflip_conj_sigmaX`・`Uflip_conj_sigmaY`・`Uflip_conj_sigmaZ` は、`U` をサイトごとの因子 `flipFam` の
クロネッカー積として持ち、サイトごとの成分計算で示しており、ここの鎖を使わない。 -/

/-- 人手 Step 1 の `σ_k^pσ_k^q = -(σ_k^qσ_k^p)`（`(p, q) ∈ {(z, x), (y, z), (y, x)}`）の 10 行の鎖（組を一つ固定した形）。
`A = σ^p`、`B = σ^q` で `AB = -(BA)` なら、サイト `k` の `σ_k^p`・`σ_k^q` について `σ_k^pσ_k^q = -(σ_k^qσ_k^p)`。 -/
theorem siteOp_mul_of_anticomm (k : Fin M) (A B : Matrix (Fin 2) (Fin 2) ℂ) (hAB : A * B = -(B * A)) :
    siteOp k A * siteOp k B = -(siteOp k B * siteOp k A) :=
  calc siteOp k A * siteOp k B
      = siteProd M (Function.update 1 k A) * siteProd M (Function.update 1 k B) := rfl
                                                        -- `def_site_pauli_matrices`
    _ = siteProd M (Function.update (fun _ : Fin M => (1 : Matrix (Fin 2) (Fin 2) ℂ) * 1) k (A * B)) := by
        rw [← siteProd_mul, update_one_mul_update_one_same]
                                                        -- `kronecker_product_rule` (1)
    _ = siteProd M (Function.update (fun _ : Fin M => (1 : Matrix (Fin 2) (Fin 2) ℂ)) k (A * B)) := by
        rw [identity_matrix_mul (1 : Matrix (Fin 2) (Fin 2) ℂ)]
                                                        -- `identity_matrix_is_left_unit_of_mat_mult`（`k` 番目以外へ同時適用）
    _ = siteProd M (Function.update (fun _ : Fin M => (1 : Matrix (Fin 2) (Fin 2) ℂ)) k (-(B * A))) := by
        rw [hAB]                                        -- `pauli_matrix_products` の `σ^pσ^q = -σ^qσ^p`
    _ = siteProd M (Function.update (fun _ : Fin M => (1 : Matrix (Fin 2) (Fin 2) ℂ)) k ((-1 : ℂ) • (B * A))) := by
        rw [neg_eq_neg_one_smul_matrix (B * A)]
                                                        -- `negation_is_scalar_multiple_by_minus_one`
    _ = (-1 : ℂ) • siteProd M (Function.update (fun _ : Fin M => (1 : Matrix (Fin 2) (Fin 2) ℂ)) k (B * A)) :=
        (siteProd M).map_update_smul _ k (-1 : ℂ) (B * A)
                                                        -- `kronecker_multilinear`（第 `k` 因子についての線型性。Lean の具体版は無く、`siteProd` の多重線型性 `MultilinearMap.map_update_smul` を 1 回）
    _ = (-1 : ℂ) • siteProd M (Function.update (fun _ : Fin M => (1 : Matrix (Fin 2) (Fin 2) ℂ) * 1) k (B * A)) := by
        rw [identity_matrix_mul (1 : Matrix (Fin 2) (Fin 2) ℂ)]
                                                        -- `identity_matrix_is_left_unit_of_mat_mult`（`k` 番目以外へ同時適用）
    _ = (-1 : ℂ) • (siteProd M (Function.update 1 k B) * siteProd M (Function.update 1 k A)) := by
        rw [← siteProd_mul, update_one_mul_update_one_same]
                                                        -- `kronecker_product_rule` (1)
    _ = (-1 : ℂ) • (siteOp k B * siteOp k A) := rfl     -- `def_site_pauli_matrices`
    _ = -(siteOp k B * siteOp k A) := (neg_eq_neg_one_smul_tensorPow _).symm
                                                        -- `negation_is_scalar_multiple_by_minus_one`

/-- 人手 Step 1 の `σ_k^zσ_k^x = -(σ_k^xσ_k^z)`（`(p, q) = (z, x)`）。 -/
theorem sigmaZ_mul_sigmaX_site (k : Fin M) : sigmaZ k * sigmaX k = -(sigmaX k * sigmaZ k) :=
  siteOp_mul_of_anticomm k pauliZ pauliX pauliZ_mul_pauliX

/-- 人手 Step 1 の `σ_k^yσ_k^z = -(σ_k^zσ_k^y)`（`(p, q) = (y, z)`）。 -/
theorem sigmaY_mul_sigmaZ_site (k : Fin M) : sigmaY k * sigmaZ k = -(sigmaZ k * sigmaY k) :=
  siteOp_mul_of_anticomm k pauliY pauliZ pauliY_mul_pauliZ_anticomm

/-- 人手 Step 1 の `σ_k^yσ_k^x = -(σ_k^xσ_k^y)`（`(p, q) = (y, x)`）。 -/
theorem sigmaY_mul_sigmaX_site (k : Fin M) : sigmaY k * sigmaX k = -(sigmaX k * sigmaY k) :=
  siteOp_mul_of_anticomm k pauliY pauliX pauliY_mul_pauliX

/-- 人手 Step 1 の `Fσ_k^xF^{-1}` の鎖の 3 行目以降: `(σ_k^zσ_k^x)σ_k^z = -σ_k^x`。 -/
theorem sigmaZ_sigmaX_sigmaZ_site (k : Fin M) : (sigmaZ k * sigmaX k) * sigmaZ k = -(sigmaX k) :=
  calc (sigmaZ k * sigmaX k) * sigmaZ k
      = (-(sigmaX k * sigmaZ k)) * sigmaZ k := by rw [sigmaZ_mul_sigmaX_site]
                                                        -- 上の `σ_k^pσ_k^q` の鎖（`(p, q) = (z, x)`）
    _ = -((sigmaX k * sigmaZ k) * sigmaZ k) := neg_mul_matrix_tensorPow _ _
                                                        -- `negation_factors_out_of_left_factor`
    _ = -(sigmaX k * (sigmaZ k * sigmaZ k)) := by rw [Matrix.mul_assoc (sigmaX k) (sigmaZ k) (sigmaZ k)]
                                                        -- `mat_mult_associative`（Lean の具体版は無く、mathlib の `Matrix.mul_assoc` を 1 回）
    _ = -(sigmaX k * 1) := by rw [sigmaZ_mul_sigmaZ_site]
                                                        -- Step 0 の `σ_m^zσ_m^z = I`（`m = k`）
    _ = -(sigmaX k) := by rw [mul_identity_matrix_tensorPow]
                                                        -- `identity_matrix_is_right_unit_of_mat_mult`

/-- 人手 Step 1 の `Fσ_k^yF^{-1}` の鎖の 3 行目以降: `(σ_k^zσ_k^y)σ_k^z = -σ_k^y`。 -/
theorem sigmaZ_sigmaY_sigmaZ_site (k : Fin M) : (sigmaZ k * sigmaY k) * sigmaZ k = -(sigmaY k) :=
  calc (sigmaZ k * sigmaY k) * sigmaZ k
      = sigmaZ k * (sigmaY k * sigmaZ k) := Matrix.mul_assoc (sigmaZ k) (sigmaY k) (sigmaZ k)
                                                        -- `mat_mult_associative`（Lean の具体版は無く、mathlib の `Matrix.mul_assoc` を 1 回）
    _ = sigmaZ k * (-(sigmaZ k * sigmaY k)) := by rw [sigmaY_mul_sigmaZ_site]
                                                        -- 上の `σ_k^pσ_k^q` の鎖（`(p, q) = (y, z)`）
    _ = -(sigmaZ k * (sigmaZ k * sigmaY k)) := mul_neg_matrix_tensorPow _ _
                                                        -- `negation_factors_out_of_right_factor`
    _ = -((sigmaZ k * sigmaZ k) * sigmaY k) := by rw [← Matrix.mul_assoc (sigmaZ k) (sigmaZ k) (sigmaY k)]
                                                        -- `mat_mult_associative`（mathlib の `Matrix.mul_assoc` を 1 回）
    _ = -(1 * sigmaY k) := by rw [sigmaZ_mul_sigmaZ_site]
                                                        -- Step 0 の `σ_m^zσ_m^z = I`（`m = k`）
    _ = -(sigmaY k) := by rw [identity_matrix_mul_tensorPow]
                                                        -- `identity_matrix_is_left_unit_of_mat_mult`

/-- 人手 Step 1 の `Fσ_k^zF^{-1}` の鎖の 3 行目以降: `(σ_k^zσ_k^z)σ_k^z = σ_k^z`。 -/
theorem sigmaZ_sigmaZ_sigmaZ_site (k : Fin M) : (sigmaZ k * sigmaZ k) * sigmaZ k = sigmaZ k :=
  calc (sigmaZ k * sigmaZ k) * sigmaZ k
      = 1 * sigmaZ k := by rw [sigmaZ_mul_sigmaZ_site]  -- Step 0 の `σ_m^zσ_m^z = I`（`m = k`）
    _ = sigmaZ k := identity_matrix_mul_tensorPow _     -- `identity_matrix_is_left_unit_of_mat_mult`

/-! ## 人手 Step 1 の `E` による共役の鎖（`k` が奇数、`a ∈ {x, y, z}`）

人手の鎖の各行と 1 対 1 に対応する。1〜3 行目は `Eflip_conj_siteOp_of_even`、4 行目以降は下の `sigmaX_sigmaX_sigmaX_site`・`sigmaX_sigmaY_sigmaX_site`・`sigmaX_sigmaZ_sigmaX_site` である。
鎖の全体は `Eflip_conj_sigmaX_of_even`・`Eflip_conj_sigmaY_of_even`・`Eflip_conj_sigmaZ_of_even`。 -/

/-- 人手 Step 1 の `Eσ_k^xE^{-1}` の鎖の 4 行目以降: `(σ_k^xσ_k^x)σ_k^x = σ_k^x`。 -/
theorem sigmaX_sigmaX_sigmaX_site (k : Fin M) : (sigmaX k * sigmaX k) * sigmaX k = sigmaX k :=
  calc (sigmaX k * sigmaX k) * sigmaX k
      = 1 * sigmaX k := by rw [sigmaX_mul_sigmaX_site]  -- Step 0 の `σ_m^xσ_m^x = I`（`m = k`）
    _ = sigmaX k := identity_matrix_mul_tensorPow _     -- `identity_matrix_is_left_unit_of_mat_mult`

/-- 人手 Step 1 の `Eσ_k^yE^{-1}` の鎖の 4 行目以降: `(σ_k^xσ_k^y)σ_k^x = -σ_k^y`。 -/
theorem sigmaX_sigmaY_sigmaX_site (k : Fin M) : (sigmaX k * sigmaY k) * sigmaX k = -(sigmaY k) :=
  calc (sigmaX k * sigmaY k) * sigmaX k
      = sigmaX k * (sigmaY k * sigmaX k) := Matrix.mul_assoc (sigmaX k) (sigmaY k) (sigmaX k)
                                                        -- `mat_mult_associative`（Lean の具体版は無く、mathlib の `Matrix.mul_assoc` を 1 回）
    _ = sigmaX k * (-(sigmaX k * sigmaY k)) := by rw [sigmaY_mul_sigmaX_site]
                                                        -- 上の `σ_k^pσ_k^q` の鎖（`(p, q) = (y, x)`）
    _ = -(sigmaX k * (sigmaX k * sigmaY k)) := mul_neg_matrix_tensorPow _ _
                                                        -- `negation_factors_out_of_right_factor`
    _ = -((sigmaX k * sigmaX k) * sigmaY k) := by rw [← Matrix.mul_assoc (sigmaX k) (sigmaX k) (sigmaY k)]
                                                        -- `mat_mult_associative`（mathlib の `Matrix.mul_assoc` を 1 回）
    _ = -(1 * sigmaY k) := by rw [sigmaX_mul_sigmaX_site]
                                                        -- Step 0 の `σ_m^xσ_m^x = I`（`m = k`）
    _ = -(sigmaY k) := by rw [identity_matrix_mul_tensorPow]
                                                        -- `identity_matrix_is_left_unit_of_mat_mult`

/-- 人手 Step 1 の `Eσ_k^zE^{-1}` の鎖の 4 行目以降: `(σ_k^xσ_k^z)σ_k^x = -σ_k^z`。 -/
theorem sigmaX_sigmaZ_sigmaX_site (k : Fin M) : (sigmaX k * sigmaZ k) * sigmaX k = -(sigmaZ k) :=
  calc (sigmaX k * sigmaZ k) * sigmaX k
      = sigmaX k * (sigmaZ k * sigmaX k) := Matrix.mul_assoc (sigmaX k) (sigmaZ k) (sigmaX k)
                                                        -- `mat_mult_associative`（mathlib の `Matrix.mul_assoc` を 1 回）
    _ = sigmaX k * (-(sigmaX k * sigmaZ k)) := by rw [sigmaZ_mul_sigmaX_site]
                                                        -- 上の `σ_k^pσ_k^q` の鎖（`(p, q) = (z, x)`）
    _ = -(sigmaX k * (sigmaX k * sigmaZ k)) := mul_neg_matrix_tensorPow _ _
                                                        -- `negation_factors_out_of_right_factor`
    _ = -((sigmaX k * sigmaX k) * sigmaZ k) := by rw [← Matrix.mul_assoc (sigmaX k) (sigmaX k) (sigmaZ k)]
                                                        -- `mat_mult_associative`（mathlib の `Matrix.mul_assoc` を 1 回）
    _ = -(1 * sigmaZ k) := by rw [sigmaX_mul_sigmaX_site]
                                                        -- Step 0 の `σ_m^xσ_m^x = I`（`m = k`）
    _ = -(sigmaZ k) := by rw [identity_matrix_mul_tensorPow]
                                                        -- `identity_matrix_is_left_unit_of_mat_mult`

/-! ## 人手 Step 1 の `F`・`E` による共役の鎖の全体 -/

/-- 人手 Step 1 の `Fσ_k^xF^{-1} = -σ_k^x`（`W` の鎖・`(σ_k^pσ_k^a)σ_k^p` の鎖のあとに 3 行目以降を続ける）。 -/
theorem Fflip_conj_sigmaX (k : Fin M) : (Fflip M * sigmaX k) * Fflip M = -(sigmaX k) :=
  (Fflip_conj_siteOp k pauliX).trans (sigmaZ_sigmaX_sigmaZ_site k)

/-- 人手 Step 1 の `Fσ_k^yF^{-1} = -σ_k^y`。 -/
theorem Fflip_conj_sigmaY (k : Fin M) : (Fflip M * sigmaY k) * Fflip M = -(sigmaY k) :=
  (Fflip_conj_siteOp k pauliY).trans (sigmaZ_sigmaY_sigmaZ_site k)

/-- 人手 Step 1 の `Fσ_k^zF^{-1} = σ_k^z`。 -/
theorem Fflip_conj_sigmaZ (k : Fin M) : (Fflip M * sigmaZ k) * Fflip M = sigmaZ k :=
  (Fflip_conj_siteOp k pauliZ).trans (sigmaZ_sigmaZ_sigmaZ_site k)

/-- 人手 Step 1 の `Eσ_k^xE^{-1} = σ_k^x`（人手の `k` 奇数、Lean の `(k : ℕ)` 偶数）。 -/
theorem Eflip_conj_sigmaX_of_even (k : Fin M) (hk : Even (k : ℕ)) :
    (Eflip M * sigmaX k) * Eflip M = sigmaX k :=
  (Eflip_conj_siteOp_of_even k hk pauliX).trans (sigmaX_sigmaX_sigmaX_site k)

/-- 人手 Step 1 の `Eσ_k^yE^{-1} = -σ_k^y`（人手の `k` 奇数）。 -/
theorem Eflip_conj_sigmaY_of_even (k : Fin M) (hk : Even (k : ℕ)) :
    (Eflip M * sigmaY k) * Eflip M = -(sigmaY k) :=
  (Eflip_conj_siteOp_of_even k hk pauliY).trans (sigmaX_sigmaY_sigmaX_site k)

/-- 人手 Step 1 の `Eσ_k^zE^{-1} = -σ_k^z`（人手の `k` 奇数）。 -/
theorem Eflip_conj_sigmaZ_of_even (k : Fin M) (hk : Even (k : ℕ)) :
    (Eflip M * sigmaZ k) * Eflip M = -(sigmaZ k) :=
  (Eflip_conj_siteOp_of_even k hk pauliZ).trans (sigmaX_sigmaZ_sigmaX_site k)

/-! ## 共役写像の性質 -/

/-- 人手 Step 0 の可逆性から作る、`U` を可逆元とする `TensorPow M` の単元（`↑· = U`、`↑·⁻¹ = U^{-1}`）。 -/
noncomputable def UflipUnit (M : ℕ) : (TensorPow M)ˣ :=
  ⟨Uflip M, UflipInv M, Uflip_mul_inv, UflipInv_mul⟩

/-- 人手 Step 3 の 3 行: 共役 `X ↦ U X U^{-1}` は積を保つ。
`U(AB)U^{-1} = T_U(AB)`（`T_B` の定義）`= T_U(A)T_U(B)`（`conjugation_is_ring_homomorphism` の乗法性 `Conjugation.T_mul`）
`= (UAU^{-1})(UBU^{-1})`（`T_B` の定義）。Lean の `U * X * U⁻¹` は人手の読み `(UX)U^{-1}` と同じ括弧である。 -/
theorem Uflip_conj_mul (A B : TensorPow M) :
    Uflip M * (A * B) * UflipInv M
      = (Uflip M * A * UflipInv M) * (Uflip M * B * UflipInv M) :=
  calc Uflip M * (A * B) * UflipInv M
      = Conjugation.T (UflipUnit M) (A * B) := rfl                           -- `T_B` の定義（`B = U`）
    _ = Conjugation.T (UflipUnit M) A * Conjugation.T (UflipUnit M) B :=
        Conjugation.T_mul _ _ _                                              -- 乗法性
    _ = (Uflip M * A * UflipInv M) * (Uflip M * B * UflipInv M) := rfl       -- `T_B` の定義（`B = U`）

/-- 人手 Step 4 の 2 行: `(U(cA))U^{-1} = (c(UA))U^{-1} = c((UA)U^{-1})`。 -/
theorem Uflip_conj_smul (c : ℂ) (A : TensorPow M) :
    Uflip M * (c • A) * UflipInv M = c • (Uflip M * A * UflipInv M) :=
  calc Uflip M * (c • A) * UflipInv M
      = (c • (Uflip M * A)) * UflipInv M := by
        rw [mul_smul_matrix_tensorPow]                                       -- `scalar_multiple_factors_out_of_right_factor`
    _ = c • (Uflip M * A * UflipInv M) :=
        smul_mul_matrix_tensorPow _ _ _                                      -- `scalar_multiple_factors_out_of_left_factor`

theorem Uflip_conj_sum {ι : Type*} (s : Finset ι) (f : ι → TensorPow M) :
    Uflip M * (∑ i ∈ s, f i) * UflipInv M = ∑ i ∈ s, Uflip M * f i * UflipInv M := by
  rw [Finset.mul_sum, Finset.sum_mul]

/-- サイト局所作用素への共役。 -/
theorem Uflip_conj_siteProd (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ) :
    Uflip M * siteProd M x * UflipInv M
      = siteProd M (fun i => flipFam M i * x i * flipFamInv M i) := by
  rw [Uflip_eq_siteProd, UflipInv_eq_siteProd, ← siteProd_mul, ← siteProd_mul]
  rfl

theorem Uflip_conj_siteOp (k : Fin M) (A : Matrix (Fin 2) (Fin 2) ℂ) :
    Uflip M * siteOp k A * UflipInv M = siteOp k (flipFam M k * A * flipFamInv M k) := by
  rw [siteOp_apply, Uflip_conj_siteProd, siteOp_apply]
  congr 1
  funext i
  by_cases h : i = k
  · subst h; simp
  · simp [h, flipFam_mul_inv i]

/-! ## `σ^x, σ^y, σ^z` への作用（原文 Step 1） -/

private theorem conj_pauliX (i : Fin M) :
    flipFam M i * pauliX * flipFamInv M i = (-1 : ℂ) • pauliX := by
  unfold flipFam flipFamInv eFlipFam
  by_cases h : Even (i : ℕ) <;> simp only [h, if_pos, if_neg, if_true, if_false] <;>
    · ext a b
      fin_cases a <;> fin_cases b <;>
        simp [pauliX, pauliZ, Matrix.mul_apply, Fin.sum_univ_two]

private theorem conj_pauliY (i : Fin M) :
    flipFam M i * pauliY * flipFamInv M i
      = (if Even (i : ℕ) then (1 : ℂ) else -1) • pauliY := by
  unfold flipFam flipFamInv eFlipFam
  by_cases h : Even (i : ℕ) <;> simp only [h, if_pos, if_neg, if_true, if_false] <;>
    · ext a b
      fin_cases a <;> fin_cases b <;>
        simp [pauliX, pauliY, pauliZ, Matrix.mul_apply, Fin.sum_univ_two]

private theorem conj_pauliZ (i : Fin M) :
    flipFam M i * pauliZ * flipFamInv M i
      = (if Even (i : ℕ) then (-1 : ℂ) else 1) • pauliZ := by
  unfold flipFam flipFamInv eFlipFam
  by_cases h : Even (i : ℕ) <;> simp only [h, if_pos, if_neg, if_true, if_false] <;>
    · ext a b
      fin_cases a <;> fin_cases b <;>
        simp [pauliX, pauliZ, Matrix.mul_apply, Fin.sum_univ_two]

theorem Uflip_conj_sigmaX (k : Fin M) :
    Uflip M * sigmaX k * UflipInv M = (-1 : ℂ) • sigmaX k := by
  rw [sigmaX, Uflip_conj_siteOp, conj_pauliX, map_smul]

theorem Uflip_conj_sigmaY (k : Fin M) :
    Uflip M * sigmaY k * UflipInv M = (if Even (k : ℕ) then (1 : ℂ) else -1) • sigmaY k := by
  rw [sigmaY, Uflip_conj_siteOp, conj_pauliY, map_smul]

theorem Uflip_conj_sigmaZ (k : Fin M) :
    Uflip M * sigmaZ k * UflipInv M = (if Even (k : ℕ) then (-1 : ℂ) else 1) • sigmaZ k := by
  rw [sigmaZ, Uflip_conj_siteOp, conj_pauliZ, map_smul]

/-! ## Jordan–Wigner 文字列への作用 -/

theorem Uflip_conj_xString (k : ℕ) (hk : k ≤ M) :
    Uflip M * xString M k * UflipInv M = ((-1 : ℂ) ^ k) • xString M k := by
  induction k with
  | zero => simp [Uflip_mul_inv]
  | succ k ih =>
      have hk' : k < M := by omega
      rw [xString_succ k hk', Uflip_conj_mul, ih (by omega), Uflip_conj_sigmaX]
      rw [smul_mul_assoc, Matrix.mul_smul, smul_smul, ← xString_succ k hk']
      congr 1
      all_goals ring

/-- **原文 Step 1 の帰結**: `U Z_m U^{-1} = -Z_m`（`m` の偶奇によらない）。 -/
theorem Uflip_conj_Z (m : Fin M) : Uflip M * Z m * UflipInv M = -(Z m) := by
  rw [Z_eq_xString_mul, Uflip_conj_mul, Uflip_conj_xString (m : ℕ) (le_of_lt m.isLt),
    Uflip_conj_sigmaZ, smul_mul_assoc, Matrix.mul_smul, smul_smul, ← Z_eq_xString_mul]
  have hsign : ((-1 : ℂ) ^ (m : ℕ)) * (if Even (m : ℕ) then (-1 : ℂ) else 1) = -1 := by
    by_cases h : Even (m : ℕ)
    · rw [if_pos h, h.neg_one_pow, one_mul]
    · rw [if_neg h, (Nat.not_even_iff_odd.1 h).neg_one_pow, mul_one]
  rw [hsign, neg_one_smul]

/-- **原文 Step 1 の帰結**: `U Y_m U^{-1} = +Y_m`（`m` の偶奇によらない）。 -/
theorem Uflip_conj_Y (m : Fin M) : Uflip M * Y m * UflipInv M = Y m := by
  rw [Y_eq_xString_mul, Uflip_conj_mul, Uflip_conj_xString (m : ℕ) (le_of_lt m.isLt),
    Uflip_conj_sigmaY, smul_mul_assoc, Matrix.mul_smul, smul_smul, ← Y_eq_xString_mul]
  have hsign : ((-1 : ℂ) ^ (m : ℕ)) * (if Even (m : ℕ) then (1 : ℂ) else -1) = 1 := by
    by_cases h : Even (m : ℕ)
    · rw [if_pos h, h.neg_one_pow, one_mul]
    · rw [if_neg h, (Nat.not_even_iff_odd.1 h).neg_one_pow]
      norm_num
  rw [hsign, one_smul]

/-! ## `H_1^{(+)}`, `H_2` への作用（人手 Step 3） -/

/-- 補助: 一般形で `U (H1 M η) U^{-1} = -(H1 M η)`。 -/
theorem Uflip_conj_H1 (η : ℂ) : Uflip M * H1 M η * UflipInv M = -(H1 M η) := by
  rw [H1, Uflip_conj_sum, ← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun m _ => ?_
  rw [Uflip_conj_smul, Uflip_conj_mul, Uflip_conj_Y, Uflip_conj_Z]
  -- 人手 Step 3 の `Y_j(-Z_k) = -(Y_jZ_k)`（`negation_factors_out_of_right_factor`）
  rw [mul_neg_matrix_tensorPow, smul_neg]

/-- **人手本文 `sign_flip_conjugation`（Step 3）**: `U H_2 U^{-1} = -H_2`。 -/
theorem Uflip_conj_H2 : Uflip M * H2 M * UflipInv M = -(H2 M) := by
  rw [H2, Uflip_conj_sum, ← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun m _ => ?_
  -- 人手 Step 3 の `(-Z_j)Y_j = -(Z_jY_j)`（`negation_factors_out_of_left_factor`）
  rw [Uflip_conj_mul, Uflip_conj_Y, Uflip_conj_Z, neg_mul_matrix_tensorPow]

/-- 補助: 一般形で `U (i K_1 H1 M η) U^{-1} = -(i K_1 H1 M η)`。 -/
theorem Uflip_conj_S1 (K1 η : ℂ) :
    Uflip M * ((Complex.I * K1) • H1 M η) * UflipInv M = -((Complex.I * K1) • H1 M η) := by
  rw [Uflip_conj_smul, Uflip_conj_H1, smul_neg]

/-- **人手本文 `sign_flip_conjugation`（Step 4）**: `U S_2 U^{-1} = -S_2`（`S_2 = i K_2^* H_2`）。人手の鎖の 6 行と 1 対 1（両端の「`S_2` の定義」の行は Lean では主張の式そのもの）。 -/
theorem Uflip_conj_S2 (K2star : ℂ) :
    Uflip M * ((Complex.I * K2star) • H2 M) * UflipInv M
      = -((Complex.I * K2star) • H2 M) :=
  calc Uflip M * ((Complex.I * K2star) • H2 M) * UflipInv M
      = ((Complex.I * K2star) • (Uflip M * H2 M)) * UflipInv M := by
        rw [mul_smul_matrix_tensorPow]                                       -- `scalar_multiple_factors_out_of_right_factor`
    _ = (Complex.I * K2star) • (Uflip M * H2 M * UflipInv M) :=
        smul_mul_matrix_tensorPow _ _ _                                      -- `scalar_multiple_factors_out_of_left_factor`
    _ = (Complex.I * K2star) • (-(H2 M)) := by rw [Uflip_conj_H2]            -- Step 3
    _ = -((Complex.I * K2star) • H2 M) := smul_neg_matrix_tensorPow _ _      -- `scalar_multiple_of_negated_matrix`

/-- **人手本文 `sign_flip_conjugation`（Step 3）**: `U H_1^{(+)} U^{-1} = -H_1^{(+)}`。 -/
theorem Uflip_conj_H1plus : Uflip M * H1plus M * UflipInv M = -(H1plus M) :=
  Uflip_conj_H1 (-1)

/-- **人手本文 `sign_flip_conjugation`（Step 4）**: `U S_1^{(+)} U^{-1} = -S_1^{(+)}`
（`S_1^{(+)} = i K_1 H_1^{(+)}`）。人手の鎖の 6 行と 1 対 1（両端の「`S_1^{(+)}` の定義」の行は Lean では主張の式そのもの）。 -/
theorem Uflip_conj_S1plus (K1 : ℂ) :
    Uflip M * ((Complex.I * K1) • H1plus M) * UflipInv M = -((Complex.I * K1) • H1plus M) :=
  calc Uflip M * ((Complex.I * K1) • H1plus M) * UflipInv M
      = ((Complex.I * K1) • (Uflip M * H1plus M)) * UflipInv M := by
        rw [mul_smul_matrix_tensorPow]                                       -- `scalar_multiple_factors_out_of_right_factor`
    _ = (Complex.I * K1) • (Uflip M * H1plus M * UflipInv M) :=
        smul_mul_matrix_tensorPow _ _ _                                      -- `scalar_multiple_factors_out_of_left_factor`
    _ = (Complex.I * K1) • (-(H1plus M)) := by rw [Uflip_conj_H1plus]        -- Step 3
    _ = -((Complex.I * K1) • H1plus M) := smul_neg_matrix_tensorPow _ _      -- `scalar_multiple_of_negated_matrix`

/-! ## 指数関数への作用（人手本文 `constant_c_value_even_sector` Step 2） -/

/-
人手 `constant_c_value_even_sector` Step 2 の 3 段（`Uflip_conj_pow`・`Uflip_conj_expPartialSum`・`Uflip_conj_matExp`）は、
必要十分版 `NecSuf/ConjugationOfExpSeries.lean` の `NecSuf.conj_pow_of_inv`・`NecSuf.conj_partialSum_of_inv`・
`NecSuf.conj_series_limit_of_inv` と同じ手順であり、具体版をその特殊化として導いたものは
`ClaimSignFlipConjugationFromNecSuf.lean` にある。
-/

/-- 人手本文 `constant_c_value_even_sector` Step 2 の `U S^k U^{-1} = (U S U^{-1})^k`
（`k` についての帰納法。`k = 0` は `UU^{-1} = I`、帰納段階は `U^{-1}U = I`（`Uflip_conj_mul`））。
必要十分版は `NecSuf.conj_pow_of_inv`。 -/
theorem Uflip_conj_pow (S : TensorPow M) (k : ℕ) :
    Uflip M * S ^ k * UflipInv M = (Uflip M * S * UflipInv M) ^ k := by
  induction k with
  | zero =>
    calc Uflip M * S ^ 0 * UflipInv M
        = Uflip M * UflipInv M := by rw [pow_zero, mul_one]
      _ = 1 := Uflip_mul_inv
      _ = (Uflip M * S * UflipInv M) ^ 0 := (pow_zero _).symm
  | succ k ih =>
    calc Uflip M * S ^ (k + 1) * UflipInv M
        = Uflip M * (S ^ k * S) * UflipInv M := by rw [pow_succ]
      _ = (Uflip M * S ^ k * UflipInv M) * (Uflip M * S * UflipInv M) := Uflip_conj_mul _ _
      _ = (Uflip M * S * UflipInv M) ^ k * (Uflip M * S * UflipInv M) := by rw [ih]
      _ = (Uflip M * S * UflipInv M) ^ (k + 1) := (pow_succ _ _).symm

/-- 人手本文 `constant_c_value_even_sector` Step 2 の「共役は行列の積・和・スカラー倍を保ち」を
`def_exp` の部分和 `∑_{k<n} (k!)^{-1} S^k` に当てたもの（和を保つのは分配法則 `Uflip_conj_sum`）。
必要十分版は `NecSuf.conj_partialSum_of_inv`。 -/
theorem Uflip_conj_expPartialSum (S : TensorPow M) (n : ℕ) :
    Uflip M * (∑ k ∈ Finset.range n, ((k.factorial : ℂ))⁻¹ • S ^ k) * UflipInv M
      = ∑ k ∈ Finset.range n, ((k.factorial : ℂ))⁻¹ • (Uflip M * S * UflipInv M) ^ k := by
  calc Uflip M * (∑ k ∈ Finset.range n, ((k.factorial : ℂ))⁻¹ • S ^ k) * UflipInv M
      = ∑ k ∈ Finset.range n, Uflip M * (((k.factorial : ℂ))⁻¹ • S ^ k) * UflipInv M :=
        Uflip_conj_sum _ _
    _ = ∑ k ∈ Finset.range n, ((k.factorial : ℂ))⁻¹ • (Uflip M * S ^ k * UflipInv M) := by
        simp only [Uflip_conj_smul]
    _ = ∑ k ∈ Finset.range n, ((k.factorial : ℂ))⁻¹ • (Uflip M * S * UflipInv M) ^ k := by
        simp only [Uflip_conj_pow]

/-- **人手本文 `constant_c_value_even_sector` Step 2** の `U exp(S) U^{-1} = exp(U S U^{-1})`。

人手どおり、`def_exp`（`matExp_hasSum`）の部分和 `s_n(S) := ∑_{k<n} (k!)^{-1} S^k` について
1. `U s_n(S) U^{-1} = s_n(USU^{-1})`（`Uflip_conj_expPartialSum`）、
2. `‖UXU^{-1} - UWU^{-1}‖ = ‖U(X-W)U^{-1}‖ ≤ ‖U‖‖U^{-1}‖‖X-W‖`（`matrix_norm_submultiplicativity`）から
   `s_n(S) → exp(S)` のとき `U s_n(S) U^{-1} → U exp(S) U^{-1}`、
3. `s_n(USU^{-1}) → exp(USU^{-1})` と極限の一意性（`def_exp` が引く `matrix_norm_triangle_inequality` (4)）
の順に示す。ノルムは mathlib の Frobenius ノルム（成分の絶対値の二乗和の `1/2` 乗）で、
`def_matrix_norm` の行列ノルム（二乗和の平方根）と値が一致する。劣乗法性 `Matrix.frobenius_norm_mul` は、
値が一致するこのノルムでの人手 `matrix_norm_submultiplicativity` と同じ主張である。
必要十分版は `NecSuf.conj_series_limit_of_inv`（連続性を仮定として受け取る）。 -/
theorem Uflip_conj_matExp (S : TensorPow M) :
    Uflip M * matExp S * UflipInv M = matExp (Uflip M * S * UflipInv M) := by
  letI : NormedAddCommGroup (TensorPow M) := Matrix.frobeniusNormedAddCommGroup
  -- 2 の評価 `‖UXU^{-1} - UWU^{-1}‖ ≤ ‖U‖‖U^{-1}‖‖X-W‖`
  have hle : ∀ X W : TensorPow M,
      ‖Uflip M * X * UflipInv M - Uflip M * W * UflipInv M‖
        ≤ ‖Uflip M‖ * ‖UflipInv M‖ * ‖X - W‖ := by
    intro X W
    calc ‖Uflip M * X * UflipInv M - Uflip M * W * UflipInv M‖
        = ‖Uflip M * (X - W) * UflipInv M‖ := by rw [mul_sub, sub_mul]
      _ ≤ ‖Uflip M * (X - W)‖ * ‖UflipInv M‖ := Matrix.frobenius_norm_mul _ _
      _ ≤ ‖Uflip M‖ * ‖X - W‖ * ‖UflipInv M‖ := by
          gcongr
          exact Matrix.frobenius_norm_mul _ _
      _ = ‖Uflip M‖ * ‖UflipInv M‖ * ‖X - W‖ := by ring
  -- `def_exp`: 部分和 `s_n(S) → exp(S)`
  have hS : Filter.Tendsto (fun n => ∑ k ∈ Finset.range n, ((k.factorial : ℂ))⁻¹ • S ^ k)
      Filter.atTop (nhds (matExp S)) := (matExp_hasSum S).tendsto_sum_nat
  -- 2: `U s_n(S) U^{-1} → U exp(S) U^{-1}`
  have hconj : Filter.Tendsto
      (fun n => Uflip M * (∑ k ∈ Finset.range n, ((k.factorial : ℂ))⁻¹ • S ^ k) * UflipInv M)
      Filter.atTop (nhds (Uflip M * matExp S * UflipInv M)) := by
    have hS0 := tendsto_iff_norm_sub_tendsto_zero.1 hS
    refine tendsto_iff_norm_sub_tendsto_zero.2 ?_
    have h0 : Filter.Tendsto
        (fun n => ‖Uflip M‖ * ‖UflipInv M‖
          * ‖(∑ k ∈ Finset.range n, ((k.factorial : ℂ))⁻¹ • S ^ k) - matExp S‖)
        Filter.atTop (nhds 0) := by
      simpa using hS0.const_mul (‖Uflip M‖ * ‖UflipInv M‖)
    exact squeeze_zero (fun _ => norm_nonneg _) (fun n => hle _ _) h0
  -- 1 で `U s_n(S) U^{-1}` を `s_n(USU^{-1})` に書き換える
  have hconj' : Filter.Tendsto
      (fun n => ∑ k ∈ Finset.range n, ((k.factorial : ℂ))⁻¹ • (Uflip M * S * UflipInv M) ^ k)
      Filter.atTop (nhds (Uflip M * matExp S * UflipInv M)) := by
    simpa only [Uflip_conj_expPartialSum] using hconj
  -- 3: `s_n(USU^{-1}) → exp(USU^{-1})` と極限の一意性
  have hUSU : Filter.Tendsto
      (fun n => ∑ k ∈ Finset.range n, ((k.factorial : ℂ))⁻¹ • (Uflip M * S * UflipInv M) ^ k)
      Filter.atTop (nhds (matExp (Uflip M * S * UflipInv M))) :=
    (matExp_hasSum (Uflip M * S * UflipInv M)).tendsto_sum_nat
  exact tendsto_nhds_unique hconj' hUSU

end SignFlip

end Ising2D
