/-
# `(V_1^{(+)})^{1/2}` の定義と平方根性、偶セクターの転送行列 `V^{(+)}` の定義

対応する人手証明（正本は `structured-latex/content/010_transfer_matrix_bridge.ts`）:

* `bridge_definition_V1_pm_square_root`（ラベル **`def_V1_plus_square_root`**）
  — `(V_1^{(+)})^{1/2} := exp((i/2) K_1 H_1^{(+)})`（`Ising2D.V1plusHalf`）
* `bridge_claim_V1_pm_square_root_squares_to_V1_pm`（ラベル **`V1_plus_square_root_property`**）
  — `((V_1^{(+)})^{1/2})^2 = V_1^{(+)}`（`Ising2D.V1_plus_square_root_property`）
* `evensectorT_definition_V_plus`（ラベル **`def_V_plus`**）
  — `V^{(+)} := (V_1^{(+)})^{1/2} V_2 (V_1^{(+)})^{1/2}`（`Ising2D.VPlusOfTransfer`。
  `V_2` は `def_transfer_matrix` の `V_2`）

`(i/2) K_1` は Lean では `(1/2) * √-1 * K_1` と書く。一般の行列の平方根は一意でないので、
人手と同じく最初から `exp(X/2)` を定義に採る。

章 014〜018 の `VPlus M s2 K1 K2star`（`Part014/Definition001_VPlus.lean`）は、`V_2` を
`V2_exponential_representation` の右辺の式 `V2H2Form`（`s2`, `K2star` を独立な引数とする一般化）で
書いた補助の一般形である。`s2 = sinh 2K_2`, `K2star = K_2^*` で本ファイルの `VPlusOfTransfer` と
一致する（`Ising2D.VPlusOfTransfer_eq_VPlus`、`Part014/Definition001_VPlus.lean`）。

必要十分版は置かない。平方根性の核「可換な `X, X` について `exp X exp X = exp(X+X)`」は mathlib の
`Matrix.exp_add_of_commute` そのものであり、ほどく構造が無い。
-/
import Ising2D.Part001.DefinitionTransferMatrix

namespace Ising2D

variable {M : ℕ}

/-- **人手本文 `def_V1_plus_square_root`**: `(V_1^{(+)})^{1/2} := exp((i/2) K_1 H_1^{(+)})`。 -/
noncomputable def V1plusHalf (M : ℕ) (K1 : ℂ) : TensorPow M :=
  matExp (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M)

/-- `(V_1^{(+)})^{1/2}` は一般形 `V1pmHalf` の `η = -1`。 -/
theorem V1plusHalf_eq_V1pmHalf (K1 : ℂ) : V1plusHalf M K1 = V1pmHalf M K1 (-1) := rfl

/-- **人手本文 `V1_plus_square_root_property`**: `((V_1^{(+)})^{1/2})^2 = V_1^{(+)}`。

人手の鎖 `exp(X)exp(X) = exp(X+X) = exp(iK_1H_1^{(+)}) = V_1^{(+)}`（`X := (i/2)K_1H_1^{(+)}`）を
そのまま辿る。 -/
theorem V1_plus_square_root_property (K1 : ℂ) :
    V1plusHalf M K1 * V1plusHalf M K1 = V1plus M K1 := by
  -- `X` は自分自身と可換
  have h : Commute (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M)
      (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M) := Commute.refl _
  -- `exp(X)exp(X) = exp(X+X)`（`theorem_exp_product`）
  rw [V1plusHalf, matExp, ← Matrix.exp_add_of_commute _ _ h, ← two_smul ℂ, smul_smul]
  -- `2 · (1/2) √-1 K_1 = √-1 K_1` と `V1_plus_exponential_representation`
  rw [V1plus_exponential_representation, matExp]
  congr 2
  ring

/-- `(V_1^{(+)})^{1/2}` を単元として（逆元は `exp(-(i/2)K_1H_1^{(+)})`）。 -/
noncomputable def V1plusHalfUnits (M : ℕ) (K1 : ℂ) : (TensorPow M)ˣ :=
  matExpUnits (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M)

@[simp]
theorem V1plusHalfUnits_val (K1 : ℂ) :
    ((V1plusHalfUnits M K1 : (TensorPow M)ˣ) : TensorPow M) = V1plusHalf M K1 := rfl

/-- 単元としても一般形の `η = -1`。 -/
theorem V1plusHalfUnits_eq_V1pmHalfUnits (K1 : ℂ) :
    V1plusHalfUnits M K1 = V1pmHalfUnits M K1 (-1) := rfl

/-- **人手本文 `def_V_plus`**: `V^{(+)} := (V_1^{(+)})^{1/2} V_2 (V_1^{(+)})^{1/2}`
（`V_2` は `def_transfer_matrix` の `V_2`）。 -/
noncomputable def VPlusOfTransfer (M : ℕ) (K1 : ℂ) (K2 : ℝ) : TensorPow M :=
  V1plusHalf M K1 * V2 M K2 * V1plusHalf M K1

end Ising2D
