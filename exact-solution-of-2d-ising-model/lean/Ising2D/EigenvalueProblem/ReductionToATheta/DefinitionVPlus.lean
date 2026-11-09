/-
# 具体版: `V^{(+)}` と `T_{(V^{(+)})}` の定義

対応する人手証明のラベル: **`V1_plus_half_invertible` / `V2_invertible` /
`V_plus_factors_invertible` / `def_T_V_plus` / `T_V_plus_is_conjugation`**
（正本はいずれも `structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts`）

`H_1^{(+)}`（`def_H1_plus`）は章 004 の `Ising2D.H1plus`、`(V_1^{(+)})^{1/2}`（`def_V1_plus_square_root`）と
その平方根性（`V1_plus_square_root_property`。人手の正本は最大固有値に属する固有ベクトルの章のファイル
`eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`）、`V^{(+)}`（`def_V_plus`）は章 010 の
`Ising2D.V1plusHalf` / `Ising2D.V1_plus_square_root_property` / `Ising2D.VPlusOfTransfer`
（`PartitionFunction/ProjectionAndJordanWigner/DefinitionV1PlusSquareRoot.lean`）である。人手の本文はこれらの定義を章 010 の 1 か所に
まとめ、章 014 の重複定義を削除した。

**必要十分版**は `Ising2D/NecSuf/TVActionSandwich.lean`（`Ising2D.NecSuf.expUnits` /
`smulUnitsAlg` / `TV_sandwich_actsBy`）。本ファイルの内容のうち
「`exp` は単元」「スカラー倍は単元性を保つ」「3 つの共役の合成は積による共役」は
いずれも**環と代数の構造だけ**で成り立ち、行列であることもテンソル冪であることも
効いていない（必要十分版の冒頭コメント参照）。

## 原文の定義と主張

  `T_{(V^{(+)})}(X) := T_{(V_1^{(+)})^{1/2}}(T_{V_2}(T_{(V_1^{(+)})^{1/2}}(X)))`

  (1) `(V_1^{(+)})^{1/2}`, `V_2`, `V^{(+)}` は可逆
  (2) `T_{(V^{(+)})} = T_{V^{(+)}}`

## 形式化の方針

`(V_1^{(+)})^{1/2}` とその単元は章 010 の `Ising2D.V1plusHalf` / `V1plusHalfUnits`。
これは符号引数つきの補助の一般形 `V1pmHalf M K1 η` の `η = -1` と定義から一致する
（`V1plusHalf_eq_V1pmHalf`）。整数運動量の経路（`RoutesNotAdopted/IntegerMomentum/ClaimTVActionsOnHatZHatY.lean`、形式化の記録）は
一般形の `η = 1` を使っており、本章はその `(+)` 版である。

### `V_2` について

人手の `V_2` は `def_transfer_matrix` の成分定義 `Ising2D.V2` であり、人手 `def_V_plus` は
`V2_exponential_representation` を引いて `V_2 = (2s_2)^{M/2}exp(iK_2^*H_2)` と書いてから `V^{(+)}` を定める。
Lean の `VPlus M s2 K1 K2star` / `VPlusUnits` / `TVPlus` は、この右辺の式 `V2H2Form`
（`s2`, `K2star` は独立な引数）で定義した一般化であり、章 014〜018 の定理はこの一般形のまま述べてある。
人手の `V_2` から作った `V^{(+)}`, `T_{(V^{(+)})}` と一致するのは `s2 = sinh 2K_2`, `K2star = K_2^*` のとき
（`VPlusOfTransfer_eq_VPlus` / `TV_V1plusHalfUnits_V2Units`）。人手の `V_2` の可逆性
（`V2_invertible`）は `isUnit_V2`、その単元は `V2Units`（人手の二つの鎖 `V2_mul_V2Inv`・`V2Inv_mul_V2` から作り、
逆元は人手の `(a^{-1})_ℂ exp(-Y)`（`V2Units_inv_val`））。
原文が「`exp(X)` の `1/2` 乗」と書いているものを Lean では最初から `exp(X/2)` としている点も
既存の定義と同じである（原文もこの章では最初から `exp((i/2)K_1H_1^{(+)})` を定義に採っている）。
-/
import Ising2D.MathematicalTools.InvertibleMatricesLinearMapCorrespondenceAndConjugation.DefinitionTgAndTV
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.DefinitionV1PlusSquareRoot
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.ClaimV2InZY
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesProduct
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInMatrixProductFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultipleByOneFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatrixDoubleNegationFromNecSuf
import Ising2D.MathematicalTools.MatrixExponentialAndCommutators.ClaimExpOfNegativeIsLeftInverseFromNecSuf

namespace Ising2D

variable {M : ℕ}

/-! ## `V^{(+)}` -/

/-- `V^{(+)} := (V_1^{(+)})^{1/2} V_2 (V_1^{(+)})^{1/2}` の補助の一般形: `V_2` を
`V2_exponential_representation` の右辺の式 `V2H2Form M s2 K2star`（`s2`, `K2star` は独立な引数）で書いたもの。
人手 `def_V_plus` の `V^{(+)}`（`Ising2D.VPlusOfTransfer`）とは `VPlusOfTransfer_eq_VPlus` で一致する。 -/
noncomputable def VPlus (M : ℕ) (s2 : ℝ) (K1 K2star : ℂ) : TensorPow M :=
  V1plusHalf M K1 * V2H2Form M s2 K2star * V1plusHalf M K1

/-- `V^{(+)}` を単元として。`(2s_2)^{M/2} ≠ 0` のために `s_2 > 0` を要する
（原文 (1) の「`K_2 > 0` より `s_2 = sinh 2K_2 > 0`」）。 -/
noncomputable def VPlusUnits (M : ℕ) {s2 : ℝ} (hs2 : 0 < s2) (K1 K2star : ℂ) :
    (TensorPow M)ˣ :=
  V1plusHalfUnits M K1 * V2H2FormUnits M hs2 K2star * V1plusHalfUnits M K1

@[simp]
theorem VPlusUnits_val {s2 : ℝ} (hs2 : 0 < s2) (K1 K2star : ℂ) :
    ((VPlusUnits M hs2 K1 K2star : (TensorPow M)ˣ) : TensorPow M) = VPlus M s2 K1 K2star := rfl

/-- **原文 `V1_plus_half_invertible`**: `(V_1^{(+)})^{1/2}` は可逆。 -/
theorem isUnit_V1plusHalf (K1 : ℂ) : IsUnit (V1plusHalf M K1) := ⟨V1plusHalfUnits M K1, rfl⟩

/-- **原文 `V_plus_factors_invertible`**: `V^{(+)}` は可逆。 -/
theorem isUnit_VPlus {s2 : ℝ} (hs2 : 0 < s2) (K1 K2star : ℂ) :
    IsUnit (VPlus M s2 K1 K2star) :=
  ⟨VPlusUnits M hs2 K1 K2star, rfl⟩

/-! ## 人手の `V_2`（`def_transfer_matrix`）で書いた形 -/

/-! ### 人手 `V2_invertible`: `V_2 ∈ R^×` と `V_2^{-1} = (a^{-1})_ℂ exp(-Y)`

人手の `a := (2s_2)^{M_col/2}`（`s_2 = sinh 2K_2`）は Lean の `(2 * Real.sinh (2 * K2)) ^ ((M : ℝ) / 2)`、
`Y := (i(K_2^*)_ℂ)H_2` は `(Complex.I * ((Kstar K2 : ℝ) : ℂ)) • H2 M` である（Lean は `a`・`Y` に名前を置かず式で書く）。
人手の二つの鎖 `V_2h = I`・`hV_2 = I`（`h := (a^{-1})_ℂ exp(-Y)`）を `V2_mul_V2Inv`・`V2Inv_mul_V2` が 1 行ずつ受け持ち、
単元 `V2Units` はこの `h` を逆元に持つ（人手の「`def_invertible_elements_of_R` の可逆の定義（`g → V_2`, `h → h`）」）。
人手の 2〜4 行目（`V2_exponential_representation`、`a`・`Y` の置き方）は、Lean では `V2_exponential_representation` の書き換えと
`V2H2Form` の定義の展開（`rfl`）の 1 段である。`scalar_multiple_is_associative` は Lean の具体版が無く mathlib の `smul_smul` で受ける
（`VPlus_mul_W` と同じ）。 -/

/-- 人手 `V2_invertible` の `a ∈ ℝ_{>0}`（`def_indexed_hyperbolic_abbreviations` の `s_2 = sinh 2K_2`、
`def_second_transfer_matrix_prefactor`）。Lean の `a` は `Real.rpow` なので `Real.rpow_pos_of_pos` で作る。
人手の 2 行の鎖（`s_2` の略記、`def_second_transfer_matrix_prefactor`）と 1 対 1 ではない（`ClaimConstantCEvenSector.lean` の
準備の `a ∈ ℝ_{>0}` と同じ書き方。状態台帳の残りの件）。 -/
theorem V2_prefactor_pos {K2 : ℝ} (hK2 : 0 < K2) (M : ℕ) :
    0 < (2 * Real.sinh (2 * K2)) ^ ((M : ℝ) / 2) :=
  Real.rpow_pos_of_pos (by linarith [sinh_two_mul_pos hK2]) _

/-- **人手 `V2_invertible` の 1 本目の鎖**: `V_2h = I`（`h := (a^{-1})_ℂ exp(-Y)`）。人手の 13 行と 1 対 1
（1 行目（`h` の置き方）は主張が `h` を展開した式なので段を持たず、2〜4 行目は 1 段）。 -/
theorem V2_mul_V2Inv {K2 : ℝ} (hK2 : 0 < K2) :
    V2 M K2 * (((((2 * Real.sinh (2 * K2)) ^ ((M : ℝ) / 2))⁻¹ : ℝ) : ℂ) •
        matExp (-((Complex.I * ((Kstar K2 : ℝ) : ℂ)) • H2 M))) = 1 := by
  set a : ℝ := (2 * Real.sinh (2 * K2)) ^ ((M : ℝ) / 2) with ha
  set Y : TensorPow M := (Complex.I * ((Kstar K2 : ℝ) : ℂ)) • H2 M with hY
  have hane : a ≠ 0 := ne_of_gt (V2_prefactor_pos hK2 M)
  calc V2 M K2 * (((a⁻¹ : ℝ) : ℂ) • matExp (-Y))
      = ((a : ℂ) • matExp Y) * (((a⁻¹ : ℝ) : ℂ) • matExp (-Y)) := by
        rw [V2_exponential_representation hK2]; rfl
        -- `V2_exponential_representation`、`a`・`Y` の置き方（`K_2^*`・`a` は `inclusion_rr_to_cc` の像）
    _ = (a : ℂ) • (matExp Y * (((a⁻¹ : ℝ) : ℂ) • matExp (-Y))) :=
        smul_mul_matrix_tensorPow _ _ _                    -- `scalar_multiple_factors_out_of_left_factor`
    _ = (a : ℂ) • (((a⁻¹ : ℝ) : ℂ) • (matExp Y * matExp (-Y))) := by
        rw [mul_smul_matrix_tensorPow]                     -- `scalar_multiple_factors_out_of_right_factor`
    _ = ((a : ℂ) * ((a⁻¹ : ℝ) : ℂ)) • (matExp Y * matExp (-Y)) :=
        smul_smul _ _ _                                    -- `scalar_multiple_is_associative`（mathlib の `smul_smul`）
    _ = ((a * a⁻¹ : ℝ) : ℂ) • (matExp Y * matExp (-Y)) := by
        rw [real_inclusion_mul]                            -- `real_inclusion_preserves_product`（`a → a`, `b → a^{-1}`）
    _ = ((1 : ℝ) : ℂ) • (matExp Y * matExp (-Y)) := by
        rw [mul_inv_cancel₀ hane]                          -- ℝ で `aa^{-1} = 1`
    _ = (1 : ℂ) • (matExp Y * matExp (-Y)) := by
        rw [Complex.ofReal_one]                            -- `1_ℂ` は `inclusion_rr_to_cc` の略記 `r_ℂ` の `r = 1`
    _ = matExp Y * matExp (-Y) := one_smul_tensorPow _     -- `scalar_multiple_by_one`
    _ = matExp (-(-Y)) * matExp (-Y) := by
        rw [neg_neg_tensorPow]                             -- `matrix_double_negation`（`A → Y`）
    _ = 1 := matExp_neg_mul_matExp_tensorPow _             -- `exp_of_negative_is_left_inverse`（`A → -Y`）

/-- **人手 `V2_invertible` の 2 本目の鎖**: `hV_2 = I`。人手の 12 行と 1 対 1
（1 行目（`h` の置き方）は主張が `h` を展開した式なので段を持たず、2〜4 行目は 1 段）。 -/
theorem V2Inv_mul_V2 {K2 : ℝ} (hK2 : 0 < K2) :
    (((((2 * Real.sinh (2 * K2)) ^ ((M : ℝ) / 2))⁻¹ : ℝ) : ℂ) •
        matExp (-((Complex.I * ((Kstar K2 : ℝ) : ℂ)) • H2 M))) * V2 M K2 = 1 := by
  set a : ℝ := (2 * Real.sinh (2 * K2)) ^ ((M : ℝ) / 2) with ha
  set Y : TensorPow M := (Complex.I * ((Kstar K2 : ℝ) : ℂ)) • H2 M with hY
  have hane : a ≠ 0 := ne_of_gt (V2_prefactor_pos hK2 M)
  calc (((a⁻¹ : ℝ) : ℂ) • matExp (-Y)) * V2 M K2
      = (((a⁻¹ : ℝ) : ℂ) • matExp (-Y)) * ((a : ℂ) • matExp Y) := by
        rw [V2_exponential_representation hK2]; rfl
        -- `V2_exponential_representation`、`a`・`Y` の置き方（`K_2^*`・`a` は `inclusion_rr_to_cc` の像）
    _ = ((a⁻¹ : ℝ) : ℂ) • (matExp (-Y) * ((a : ℂ) • matExp Y)) :=
        smul_mul_matrix_tensorPow _ _ _                    -- `scalar_multiple_factors_out_of_left_factor`
    _ = ((a⁻¹ : ℝ) : ℂ) • ((a : ℂ) • (matExp (-Y) * matExp Y)) := by
        rw [mul_smul_matrix_tensorPow]                     -- `scalar_multiple_factors_out_of_right_factor`
    _ = (((a⁻¹ : ℝ) : ℂ) * (a : ℂ)) • (matExp (-Y) * matExp Y) :=
        smul_smul _ _ _                                    -- `scalar_multiple_is_associative`（mathlib の `smul_smul`）
    _ = ((a⁻¹ * a : ℝ) : ℂ) • (matExp (-Y) * matExp Y) := by
        rw [real_inclusion_mul]                            -- `real_inclusion_preserves_product`（`a → a^{-1}`, `b → a`）
    _ = ((1 : ℝ) : ℂ) • (matExp (-Y) * matExp Y) := by
        rw [inv_mul_cancel₀ hane]                          -- ℝ で `a^{-1}a = 1`
    _ = (1 : ℂ) • (matExp (-Y) * matExp Y) := by
        rw [Complex.ofReal_one]                            -- `1_ℂ` は `inclusion_rr_to_cc` の略記 `r_ℂ` の `r = 1`
    _ = matExp (-Y) * matExp Y := one_smul_tensorPow _     -- `scalar_multiple_by_one`
    _ = 1 := matExp_neg_mul_matExp_tensorPow _             -- `exp_of_negative_is_left_inverse`（`A → Y`）

/-- 人手の `V_2`（`def_transfer_matrix`、`K_2 > 0`）を単元として。人手 `V2_invertible` の最後の 2 行のとおり、
上の二つの積から `def_invertible_elements_of_R` の可逆の定義（`g → V_2`, `h → (a^{-1})_ℂ exp(-Y)`）で作る。
`V2_exponential_representation` により、`V2H2FormUnits` を `s_2 = sinh 2K_2`, `K_2^*` で評価した単元と
同じ単元である（`V2Units_eq_V2H2FormUnits`）。 -/
noncomputable def V2Units (M : ℕ) {K2 : ℝ} (hK2 : 0 < K2) : (TensorPow M)ˣ where
  val := V2 M K2
  inv := (((((2 * Real.sinh (2 * K2)) ^ ((M : ℝ) / 2))⁻¹ : ℝ) : ℂ) •
    matExp (-((Complex.I * ((Kstar K2 : ℝ) : ℂ)) • H2 M)))
  val_inv := V2_mul_V2Inv hK2
  inv_val := V2Inv_mul_V2 hK2

/-- **人手 `V2_invertible` の逆元**: `V_2^{-1} = (a^{-1})_ℂ exp(-Y)`（`def_invertible_elements_of_R` の逆元の一意性と記号
`g^{-1}`。Lean の単元の逆元は `V2Units` の作り方のとおり）。 -/
theorem V2Units_inv_val {K2 : ℝ} (hK2 : 0 < K2) :
    (((V2Units M hK2)⁻¹ : (TensorPow M)ˣ) : TensorPow M)
      = (((((2 * Real.sinh (2 * K2)) ^ ((M : ℝ) / 2))⁻¹ : ℝ) : ℂ) •
          matExp (-((Complex.I * ((Kstar K2 : ℝ) : ℂ)) • H2 M))) := rfl

@[simp]
theorem V2Units_val {K2 : ℝ} (hK2 : 0 < K2) :
    ((V2Units M hK2 : (TensorPow M)ˣ) : TensorPow M) = V2 M K2 := rfl

/-- `V2_exponential_representation` による単元の書き換え。 -/
theorem V2Units_eq_V2H2FormUnits {K2 : ℝ} (hK2 : 0 < K2) :
    V2Units M hK2 = V2H2FormUnits M (sinh_two_mul_pos hK2) ((Kstar K2 : ℝ) : ℂ) :=
  Units.ext (V2_exponential_representation hK2)

/-- **原文 `V2_invertible`**: `V_2`（`def_transfer_matrix` の `V_2`、`K_2 > 0`）は可逆。 -/
theorem isUnit_V2 {K2 : ℝ} (hK2 : 0 < K2) : IsUnit (V2 M K2) := ⟨V2Units M hK2, rfl⟩

/-- **人手 `def_V_plus` の `V^{(+)}` と補助の一般形の一致**:
`(V_1^{(+)})^{1/2} V_2 (V_1^{(+)})^{1/2}`（`VPlusOfTransfer`）は `VPlus` の `s_2 = sinh 2K_2`, `K_2^*` での値
（人手 `def_V_plus` が引く `V2_exponential_representation` による）。 -/
theorem VPlusOfTransfer_eq_VPlus {K2 : ℝ} (hK2 : 0 < K2) (K1 : ℂ) :
    VPlusOfTransfer M K1 K2 = VPlus M (Real.sinh (2 * K2)) K1 ((Kstar K2 : ℝ) : ℂ) := by
  rw [VPlusOfTransfer, V2_exponential_representation hK2, VPlus]

/-! ## `T_{(V^{(+)})}` -/

/-- **原文の `T_{(V^{(+)})}(X) := T_{(V_1^{(+)})^{1/2}}(T_{V_2}(T_{(V_1^{(+)})^{1/2}}(X)))`**。 -/
noncomputable def TVPlus (M : ℕ) {s2 : ℝ} (hs2 : 0 < s2) (K1 K2star : ℂ) :
    TensorPow M ≃ₐ[ℂ] TensorPow M :=
  TV (V1plusHalfUnits M K1) (V2H2FormUnits M hs2 K2star)

@[simp]
theorem TVPlus_apply {s2 : ℝ} (hs2 : 0 < s2) (K1 K2star : ℂ) (x : TensorPow M) :
    TVPlus M hs2 K1 K2star x =
      TConj (V1plusHalfUnits M K1)
        (TConj (V2H2FormUnits M hs2 K2star) (TConj (V1plusHalfUnits M K1) x)) := rfl

/-- **原文 `T_V_plus_is_conjugation`**: 合成として定めた `T_{(V^{(+)})}` は `V^{(+)}` による共役そのものに一致する。 -/
theorem TVPlus_eq_TConj {s2 : ℝ} (hs2 : 0 < s2) (K1 K2star : ℂ) :
    TVPlus M hs2 K1 K2star = TConj (VPlusUnits M hs2 K1 K2star) :=
  TV_eq_TConj _ _

/-- 原文 `T_V_plus_is_conjugation` を「値」で書いた版: `T_{(V^{(+)})}(X) = V^{(+)} X (V^{(+)})^{-1}`。 -/
theorem TVPlus_apply_eq_conj {s2 : ℝ} (hs2 : 0 < s2) (K1 K2star : ℂ) (x : TensorPow M) :
    TVPlus M hs2 K1 K2star x =
      VPlus M s2 K1 K2star * x *
        (((VPlusUnits M hs2 K1 K2star)⁻¹ : (TensorPow M)ˣ) : TensorPow M) := by
  rw [TVPlus_eq_TConj hs2, TConj_apply, VPlusUnits_val]

/-- **原文 `def_T_V_plus` を人手の `V_2` で書いた形**:
`T_{(V_1^{(+)})^{1/2}} ∘ T_{V_2} ∘ T_{(V_1^{(+)})^{1/2}}` は `TVPlus` の `s_2 = sinh 2K_2`, `K_2^*` での値。 -/
theorem TV_V1plusHalfUnits_V2Units {K2 : ℝ} (hK2 : 0 < K2) (K1 : ℂ) :
    TV (V1plusHalfUnits M K1) (V2Units M hK2)
      = TVPlus M (sinh_two_mul_pos hK2) K1 ((Kstar K2 : ℝ) : ℂ) := by
  rw [V2Units_eq_V2H2FormUnits, TVPlus]

end Ising2D
