/-
# 具体版: `V^{(+)}` と `T_{(V^{(+)})}` の定義

対応する人手証明のラベル: **`def_H1_plus` / `def_V1_plus_square_root` /
`V1_plus_square_root_property` / `def_V_plus` / `V1_plus_half_invertible` /
`V2_invertible` / `V_plus_factors_invertible` / `def_T_V_plus` /
`T_V_plus_is_conjugation`**
（`structured-latex/content/014_even_sector_T_action.ts` の
`evensectorT_definition_H1_plus` から `evensectorT_claim_T_V_plus_is_conjugation` まで）

**必要十分版**は `Ising2D/NecSuf/TVActionSandwich.lean`（`Ising2D.NecSuf.expUnits` /
`smulUnitsAlg` / `TV_sandwich_actsBy`）。本ファイルの内容のうち
「`exp` は単元」「スカラー倍は単元性を保つ」「3 つの共役の合成は積による共役」は
いずれも**環と代数の構造だけ**で成り立ち、行列であることもテンソル冪であることも
効いていない（必要十分版の冒頭コメント参照）。

## 原文の定義

  `V_1^{(+)} := exp(i K_1 H_1^{(+)})`,  `(V_1^{(+)})^{1/2} := exp((i/2) K_1 H_1^{(+)})`
  `V_2 := (2s_2)^{M/2} exp(i K_2^* H_2)`
  `V^{(+)} := (V_1^{(+)})^{1/2} V_2 (V_1^{(+)})^{1/2}`
  `T_{(V^{(+)})}(X) := T_{(V_1^{(+)})^{1/2}}(T_{V_2}(T_{(V_1^{(+)})^{1/2}}(X)))`

および原文が独立した主張として挙げる 3 点

  (1) `(V_1^{(+)})^{1/2}`, `V_2`, `V^{(+)}` は可逆
  (2) `((V_1^{(+)})^{1/2})^2 = V_1^{(+)}`
  (3) `T_{(V^{(+)})} = T_{V^{(+)}}`

## 形式化の方針

`H_1^{(±)}` は既存の `Ising2D.H1 M η`（引数 `η` が**原文の `∓1`**）で、
`H_1^{(+)}` は `η = -1` にあたる。008 章の経路（`Part008/Claim012_TVActions.lean`）は
一貫して `η = 1`（`H_1^{(-)}`）を使っており、本章はその `η = -1` 版である。
`(V_1^{(+)})^{1/2}` の定義・可逆性・平方根性は既存の
`Ising2D.V1pmHalf` / `V1pmHalfUnits` / `V1pmHalf_sq` を `η = -1` で使う。

### `V_2` について

人手の `V_2` は `def_transfer_matrix` の成分定義 `Ising2D.V2` であり、人手 `def_V_plus` は
`V2_exponential_representation` を引いて `V_2 = (2s_2)^{M/2}exp(iK_2^*H_2)` と書いてから `V^{(+)}` を定める。
Lean の `VPlus M s2 K1 K2star` / `VPlusUnits` / `TVPlus` は、この右辺の式 `V2H2Form`
（`s2`, `K2star` は独立な引数）で定義した一般化であり、章 014〜018 の定理はこの一般形のまま述べてある。
人手の `V_2` から作った `V^{(+)}`, `T_{(V^{(+)})}` と一致するのは `s2 = sinh 2K_2`, `K2star = K_2^*` のとき
（`V1plusHalf_mul_V2_mul_V1plusHalf` / `TV_V1plusHalfUnits_V2Units`）。人手の `V_2` の可逆性
（`V2_invertible`）は `isUnit_V2`、その単元は `V2Units`。
原文が「`exp(X)` の `1/2` 乗」と書いているものを Lean では最初から `exp(X/2)` としている点も
既存の定義と同じである（原文もこの章では最初から `exp((i/2)K_1H_1^{(+)})` を定義に採っている）。
-/
import Ising2D.Part008.Definition016_TV
import Ising2D.Part004.ClaimV2InZY

namespace Ising2D

variable {M : ℕ}

/-! ## `V^{(+)}` -/

/-- **原文の `V^{(+)} := (V_1^{(+)})^{1/2} V_2 (V_1^{(+)})^{1/2}`**。 -/
noncomputable def VPlus (M : ℕ) (s2 : ℝ) (K1 K2star : ℂ) : TensorPow M :=
  V1pmHalf M K1 (-1) * V2H2Form M s2 K2star * V1pmHalf M K1 (-1)

/-- `V^{(+)}` を単元として。`(2s_2)^{M/2} ≠ 0` のために `s_2 > 0` を要する
（原文 (1) の「`K_2 > 0` より `s_2 = sinh 2K_2 > 0`」）。 -/
noncomputable def VPlusUnits (M : ℕ) {s2 : ℝ} (hs2 : 0 < s2) (K1 K2star : ℂ) :
    (TensorPow M)ˣ :=
  V1pmHalfUnits M K1 (-1) * V2H2FormUnits M hs2 K2star * V1pmHalfUnits M K1 (-1)

@[simp]
theorem VPlusUnits_val {s2 : ℝ} (hs2 : 0 < s2) (K1 K2star : ℂ) :
    ((VPlusUnits M hs2 K1 K2star : (TensorPow M)ˣ) : TensorPow M) = VPlus M s2 K1 K2star := rfl

/-- **原文 `V1_plus_half_invertible`**: `(V_1^{(+)})^{1/2}` は可逆。 -/
theorem isUnit_V1plusHalf (K1 : ℂ) : IsUnit (V1pmHalf M K1 (-1)) := isUnit_V1pmHalf K1 (-1)

/-- **原文 `V_plus_factors_invertible`**: `V^{(+)}` は可逆。 -/
theorem isUnit_VPlus {s2 : ℝ} (hs2 : 0 < s2) (K1 K2star : ℂ) :
    IsUnit (VPlus M s2 K1 K2star) :=
  ⟨VPlusUnits M hs2 K1 K2star, rfl⟩

/-- **原文 `V1_plus_square_root_property`**: `((V_1^{(+)})^{1/2})^2 = V_1^{(+)}`。 -/
theorem V1plusHalf_sq (K1 : ℂ) :
    V1pmHalf M K1 (-1) * V1pmHalf M K1 (-1) = V1pm M K1 (-1) :=
  V1pmHalf_sq K1 (-1)

/-! ## 人手の `V_2`（`def_transfer_matrix`）で書いた形 -/

/-- 人手の `V_2`（`def_transfer_matrix`、`K_2 > 0`）を単元として。
`V2_exponential_representation` により、`V2H2FormUnits` を `s_2 = sinh 2K_2`, `K_2^*` で評価した単元と
同じ行列を値にもつ。 -/
noncomputable def V2Units (M : ℕ) {K2 : ℝ} (hK2 : 0 < K2) : (TensorPow M)ˣ :=
  (V2H2FormUnits M (sinh_two_mul_pos hK2) ((Kstar K2 : ℝ) : ℂ)).copy (V2 M K2)
    (V2_exponential_representation hK2) _ rfl

@[simp]
theorem V2Units_val {K2 : ℝ} (hK2 : 0 < K2) :
    ((V2Units M hK2 : (TensorPow M)ˣ) : TensorPow M) = V2 M K2 := rfl

/-- `V2_exponential_representation` による単元の書き換え。 -/
theorem V2Units_eq_V2H2FormUnits {K2 : ℝ} (hK2 : 0 < K2) :
    V2Units M hK2 = V2H2FormUnits M (sinh_two_mul_pos hK2) ((Kstar K2 : ℝ) : ℂ) :=
  Units.ext (V2_exponential_representation hK2)

/-- **原文 `V2_invertible`**: `V_2`（`def_transfer_matrix` の `V_2`、`K_2 > 0`）は可逆。 -/
theorem isUnit_V2 {K2 : ℝ} (hK2 : 0 < K2) : IsUnit (V2 M K2) := ⟨V2Units M hK2, rfl⟩

/-- **原文 `def_V_plus` を人手の `V_2` で書いた形**:
`(V_1^{(+)})^{1/2} V_2 (V_1^{(+)})^{1/2}` は `VPlus` の `s_2 = sinh 2K_2`, `K_2^*` での値
（`V2_exponential_representation` による）。 -/
theorem V1plusHalf_mul_V2_mul_V1plusHalf {K2 : ℝ} (hK2 : 0 < K2) (K1 : ℂ) :
    V1pmHalf M K1 (-1) * V2 M K2 * V1pmHalf M K1 (-1)
      = VPlus M (Real.sinh (2 * K2)) K1 ((Kstar K2 : ℝ) : ℂ) := by
  rw [V2_exponential_representation hK2, VPlus]

/-! ## `T_{(V^{(+)})}` -/

/-- **原文の `T_{(V^{(+)})}(X) := T_{(V_1^{(+)})^{1/2}}(T_{V_2}(T_{(V_1^{(+)})^{1/2}}(X)))`**。 -/
noncomputable def TVPlus (M : ℕ) {s2 : ℝ} (hs2 : 0 < s2) (K1 K2star : ℂ) :
    TensorPow M ≃ₐ[ℂ] TensorPow M :=
  TV (V1pmHalfUnits M K1 (-1)) (V2H2FormUnits M hs2 K2star)

@[simp]
theorem TVPlus_apply {s2 : ℝ} (hs2 : 0 < s2) (K1 K2star : ℂ) (x : TensorPow M) :
    TVPlus M hs2 K1 K2star x =
      TConj (V1pmHalfUnits M K1 (-1))
        (TConj (V2H2FormUnits M hs2 K2star) (TConj (V1pmHalfUnits M K1 (-1)) x)) := rfl

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
    TV (V1pmHalfUnits M K1 (-1)) (V2Units M hK2)
      = TVPlus M (sinh_two_mul_pos hK2) K1 ((Kstar K2 : ℝ) : ℂ) := by
  rw [V2Units_eq_V2H2FormUnits, TVPlus]

end Ising2D
