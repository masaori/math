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
`(V_1^{(+)})^{1/2}`, `V_2` の定義・可逆性・平方根性は既存の
`Ising2D.V1half` / `V1halfUnits` / `V1half_sq` / `V2` / `V2Units` を `η = -1` で使う。
原文が「`exp(X)` の `1/2` 乗」と書いているものを Lean では最初から `exp(X/2)` としている点も
既存の定義と同じである（原文もこの章では最初から `exp((i/2)K_1H_1^{(+)})` を定義に採っている）。
-/
import Ising2D.Part008.Definition016_TV

namespace Ising2D

variable {M : ℕ}

/-! ## `V^{(+)}` -/

/-- **原文の `V^{(+)} := (V_1^{(+)})^{1/2} V_2 (V_1^{(+)})^{1/2}`**。 -/
noncomputable def VPlus (M : ℕ) (s2 : ℝ) (K1 K2star : ℂ) : TensorPow M :=
  V1half M K1 (-1) * V2 M s2 K2star * V1half M K1 (-1)

/-- `V^{(+)}` を単元として。`(2s_2)^{M/2} ≠ 0` のために `s_2 > 0` を要する
（原文 (1) の「`K_2 > 0` より `s_2 = sinh 2K_2 > 0`」）。 -/
noncomputable def VPlusUnits (M : ℕ) {s2 : ℝ} (hs2 : 0 < s2) (K1 K2star : ℂ) :
    (TensorPow M)ˣ :=
  V1halfUnits M K1 (-1) * V2Units M hs2 K2star * V1halfUnits M K1 (-1)

@[simp]
theorem VPlusUnits_val {s2 : ℝ} (hs2 : 0 < s2) (K1 K2star : ℂ) :
    ((VPlusUnits M hs2 K1 K2star : (TensorPow M)ˣ) : TensorPow M) = VPlus M s2 K1 K2star := rfl

/-- **原文 `V1_plus_half_invertible`**: `(V_1^{(+)})^{1/2}` は可逆。 -/
theorem isUnit_V1halfPlus (K1 : ℂ) : IsUnit (V1half M K1 (-1)) := isUnit_V1half K1 (-1)

/-- **原文 `V_plus_factors_invertible`**: `V^{(+)}` は可逆。 -/
theorem isUnit_VPlus {s2 : ℝ} (hs2 : 0 < s2) (K1 K2star : ℂ) :
    IsUnit (VPlus M s2 K1 K2star) :=
  ⟨VPlusUnits M hs2 K1 K2star, rfl⟩

/-- **原文 `V1_plus_square_root_property`**: `((V_1^{(+)})^{1/2})^2 = V_1^{(+)}`。 -/
theorem V1halfPlus_sq (K1 : ℂ) :
    V1half M K1 (-1) * V1half M K1 (-1) = V1 M K1 (-1) :=
  V1half_sq K1 (-1)

/-! ## `T_{(V^{(+)})}` -/

/-- **原文の `T_{(V^{(+)})}(X) := T_{(V_1^{(+)})^{1/2}}(T_{V_2}(T_{(V_1^{(+)})^{1/2}}(X)))`**。 -/
noncomputable def TVPlus (M : ℕ) {s2 : ℝ} (hs2 : 0 < s2) (K1 K2star : ℂ) :
    TensorPow M ≃ₐ[ℂ] TensorPow M :=
  TV (V1halfUnits M K1 (-1)) (V2Units M hs2 K2star)

@[simp]
theorem TVPlus_apply {s2 : ℝ} (hs2 : 0 < s2) (K1 K2star : ℂ) (x : TensorPow M) :
    TVPlus M hs2 K1 K2star x =
      TConj (V1halfUnits M K1 (-1))
        (TConj (V2Units M hs2 K2star) (TConj (V1halfUnits M K1 (-1)) x)) := rfl

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

end Ising2D
