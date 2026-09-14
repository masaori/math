/-
# `H_1^{(±)}`, `H_2` の定義と転送行列 `V_1^{(±)}`, `V_2` の定義

対応する人手証明（正本は `structured-latex/content/*.ts`）:

* `structured-latex/content/004_transfer_matrix.ts`
  * `transfer_matrix_001_definition_symbols`（ラベル `def_transfer_matrix_symbols`）
    — `V_1`, `V_2` の定義、`K_i^*`, `c_i`, `s_i`, `c_i^*`, `s_i^*` の定義
  * `transfer_matrix_007_definition_V1_pm`
    — `V_1^{(±)} := exp(√-1 K_1 (Y_1 Z_2 + ⋯ + Y_{M-1} Z_M ∓ Y_M Z_1))`
  * `transfer_matrix_003a_claim_V2_in_Z_Y`（ラベル `V2_in_Z_Y`）
    — `V_2 = (2s_2)^{M/2} exp(√-1 K_2^* (Z_1Y_1 + ⋯ + Z_MY_M))`
  * `transfer_matrix_011_definition_H1_H2`
    — `H_1^{(±)} := Y_1 Z_2 + ⋯ + Y_{M-1} Z_M ∓ Y_M Z_1`、`H_2 := Z_1 Y_1 + ⋯ + Z_M Y_M`、
      `V_1^{(±)} = exp(√-1 K_1 H_1^{(±)})`、`V_2 = (2 s_2)^{M/2} exp(√-1 K_2^* H_2)`
（旧 Typst の対応ファイルは `_old/typst/parts/004_転送行列/006, 010`。）

## 形式化の方針

### 添字の巡回（`m + 1` の `M` での巻き戻り）

原文の site 添字は `1, …, M` で、`H_1^{(±)}` の第 `m` 項は `Y_m Z_{m+1}`、
最終項だけ `m = M` で `Z_{M+1} = Z_1` へ巻き戻る（`def_transfer_matrix_symbols` の
`Z_{M+1} := Z_1` がこの巻き戻しの規約）。

Lean では site 添字を `Fin M`（`0, …, M-1`）で表し、原文の `m` は `(m : ℕ) + 1` に対応する。
巻き戻しは **`Fin M` の `Add` インスタンス（`NeZero M` を要求する）を使わず**、
`nextSite m := ⟨((m : ℕ) + 1) % M, _⟩` という自前の定義で書く。理由:

* `Fin M` の加法は `NeZero M` インスタンスを要求するため、`M` を一般の自然数のまま扱えない。
  `nextSite` は `m : Fin M` が存在する時点で `0 < M` が従う（`Fin.pos`）ので、
  `M` に追加の仮定を置かずに書ける。既存ファイル（`Definition009_HatZHatY.lean` 等）も
  `M` に `NeZero` を課さない流儀なので、それに揃える。
* 原文の「最終項だけ符号が付く」は `lastSign η m := if (m : ℕ) + 1 = M then η else 1`
  で表す（原文の `m = M` が Lean の `(m : ℕ) + 1 = M`）。

### `(±)` の符号

原文の `∓`（`H_1^{(±)}` の最終項の係数）は引数 `η : ℂ` として持たせる。
`η = -1` が `(+)`、`η = +1` が `(-)`。これは既存の `hatZ M η μ`（`Definition009_HatZHatY.lean`）
が原文の `∓1` を `η` で持たせている流儀と同じである。

### `(2 s_2)^{M/2}`

`M` が奇数のとき指数 `M/2` は整数でないので、`Real.rpow`（`(2 * s2) ^ ((M : ℝ) / 2)`）を使う。
`Real.rpow` は底が正のときにのみ通常の意味を持つので、`s2 > 0`（原文
`def_transfer_matrix_symbols` 末尾の「`K_i, K_i^* > 0` より `c_i, s_i, c_i^*, s_i^* > 0`」）
を可逆性の証明で明示的な仮定として置く。

## 原文の問題点

* `transfer_matrix_001_definition_symbols` の `V_2` は
  `(2 sinh 2K_2)^{M/2} exp(K_2^*(σ^x_1 + ⋯ + σ^x_M))` と書かれているのに対し、
  `transfer_matrix_011_definition_H1_H2` の `V_2` は
  `(2 s_2)^{M/2} exp(√-1 K_2^* H_2)` である。
  両者が一致するには `√-1 H_2 = σ^x_1 + ⋯ + σ^x_M`、すなわち
  `√-1 Z_m Y_m = σ^x_m` が要る。実際 `Z_m Y_m = -√-1 σ^x_m`
  （`Ising2D.Z_mul_Y_same`）なので `√-1 Z_m Y_m = √-1 · (-√-1) σ^x_m = σ^x_m` で一致する。
  原文はこの等式を明示していない（`transfer_matrix_011` は「よって、」とだけ書く）。
  本ファイルでは `I_smul_H2_eq_sum_sigmaX`（`√-1 H_2 = ∑_m σ^x_m`）として補って証明する。
-/
import Ising2D.Part004.Definition009_HatZHatY
import Ising2D.Representation
import Mathlib.Analysis.SpecialFunctions.Pow.Real

namespace Ising2D

variable {M : ℕ}

/-! ## 巡回する site 添字 -/

/-- 原文の `m ↦ m + 1`（`m = M` のときは `1` へ巻き戻る）。
Lean の `Fin M` は `0` 始まりなので、`(m : ℕ) + 1` を `M` で割った余りをとる。 -/
def nextSite (m : Fin M) : Fin M := ⟨((m : ℕ) + 1) % M, Nat.mod_lt _ m.pos⟩

theorem nextSite_val_of_lt {m : Fin M} (h : (m : ℕ) + 1 < M) :
    ((nextSite m : Fin M) : ℕ) = (m : ℕ) + 1 := by
  simp [nextSite, Nat.mod_eq_of_lt h]

theorem nextSite_val_of_last {m : Fin M} (h : (m : ℕ) + 1 = M) :
    ((nextSite m : Fin M) : ℕ) = 0 := by
  simp [nextSite, ← h]

/-- 原文 `H_1^{(±)}` の最終項の係数 `∓1`。`η` が原文の `∓1` にあたる。
Lean の添字は 0 始まりなので、原文の `m = M` は `(m : ℕ) + 1 = M`。 -/
def lastSign (η : ℂ) (m : Fin M) : ℂ := if (m : ℕ) + 1 = M then η else 1

@[simp]
theorem lastSign_of_last {η : ℂ} {m : Fin M} (h : (m : ℕ) + 1 = M) : lastSign η m = η := by
  simp [lastSign, h]

@[simp]
theorem lastSign_of_not_last {η : ℂ} {m : Fin M} (h : (m : ℕ) + 1 ≠ M) : lastSign η m = 1 := by
  simp [lastSign, h]

theorem lastSign_one (m : Fin M) : lastSign 1 m = 1 := by
  rw [lastSign]; split <;> rfl

/-! ## `H_1^{(±)}` と `H_2` -/

/-- **原文の `H_1^{(±)} = Y_1 Z_2 + Y_2 Z_3 + ⋯ + Y_{M-1} Z_M ∓ Y_M Z_1`**
（`η` が原文の `∓1`）。 -/
noncomputable def H1 (M : ℕ) (η : ℂ) : TensorPow M :=
  ∑ m : Fin M, lastSign η m • (Y m * Z (nextSite m))

/-- **原文の `H_2 = Z_1 Y_1 + Z_2 Y_2 + ⋯ + Z_M Y_M`**。 -/
noncomputable def H2 (M : ℕ) : TensorPow M := ∑ m : Fin M, Z m * Y m

/-- 原文 `V2_in_Z_Y` の Step 0–2 に対応する等式。

Step 0–2 の単一サイト計算とクロネッカー積への持ち上げは
`Ising2D.Z_mul_Y_same` が担い、本定理が各サイトの等式を有限和へ持ち上げる。
これにより `def_transfer_matrix_symbols` の `V_2` の指数
`K_2^*(σ^x_1 + ⋯)` と `transfer_matrix_011_definition_H1_H2` の指数
`√-1 K_2^* H_2` が一致する。

`Z_m Y_m = -√-1 σ^x_m`（`Ising2D.Z_mul_Y_same`）より `√-1 H_2 = ∑_m σ^x_m`。 -/
theorem I_smul_H2_eq_sum_sigmaX :
    (Complex.I • H2 M) = ∑ m : Fin M, sigmaX m := by
  rw [H2, Finset.smul_sum]
  refine Finset.sum_congr rfl fun m _ => ?_
  rw [Z_mul_Y_same, smul_smul]
  norm_num [Complex.I_mul_I]

/-! ## 転送行列 `V_1^{(±)}`, `(V_1^{(±)})^{1/2}`, `V_2` -/

/-- **原文の `V_1^{(±)} = exp(√-1 K_1 H_1^{(±)})`**。 -/
noncomputable def V1 (M : ℕ) (K1 η : ℂ) : TensorPow M :=
  matExp ((Complex.I * K1) • H1 M η)

/-- **原文の `(V_1^{(±)})^{1/2} = exp((1/2)√-1 K_1 H_1^{(±)})`**
（`TV1_hatZ_hatY_012_claim_TV1_TV2_actions` の証明で使われている表式。
原文は「`exp(X)` の `1/2` 乗」を `exp(X/2)` と読み替えているが、
一般の行列の平方根は一意でないので、Lean では `exp(X/2)` の方を定義とする）。 -/
noncomputable def V1half (M : ℕ) (K1 η : ℂ) : TensorPow M :=
  matExp (((1 / 2 : ℂ) * Complex.I * K1) • H1 M η)

/-- **原文の `V_2 = (2 s_2)^{M/2} exp(√-1 K_2^* H_2)`**。
`(2 s_2)^{M/2}` は `M` が奇数のとき実冪なので `Real.rpow` を使う。 -/
noncomputable def V2 (M : ℕ) (s2 : ℝ) (K2star : ℂ) : TensorPow M :=
  ((((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ)) • matExp ((Complex.I * K2star) • H2 M)

/-- `V_1^{(±)} = ((V_1^{(±)})^{1/2})^2`（「平方根」の名に値することの確認）。 -/
theorem V1half_sq (K1 η : ℂ) :
    V1half M K1 η * V1half M K1 η = V1 M K1 η := by
  have h : Commute (((1 / 2 : ℂ) * Complex.I * K1) • H1 M η)
      (((1 / 2 : ℂ) * Complex.I * K1) • H1 M η) := Commute.refl _
  rw [V1half, V1, matExp, matExp, ← Matrix.exp_add_of_commute _ _ h, ← two_smul ℂ]
  congr 1
  rw [smul_smul]
  congr 1
  ring

/-! ## 可逆性 -/

/-- `exp X` を単元として取り出したもの（逆元は `exp (-X)`）。 -/
noncomputable def matExpUnits (A : TensorPow M) : (TensorPow M)ˣ where
  val := matExp A
  inv := matExp (-A)
  val_inv := by
    have h : Commute A (-A) := (Commute.refl A).neg_right
    show NormedSpace.exp A * NormedSpace.exp (-A) = 1
    rw [← Matrix.exp_add_of_commute A (-A) h, add_neg_cancel]
    exact NormedSpace.exp_zero
  inv_val := by
    have h : Commute (-A) A := (Commute.refl A).neg_left
    show NormedSpace.exp (-A) * NormedSpace.exp A = 1
    rw [← Matrix.exp_add_of_commute (-A) A h, neg_add_cancel]
    exact NormedSpace.exp_zero

@[simp]
theorem matExpUnits_val (A : TensorPow M) : ((matExpUnits A : (TensorPow M)ˣ) : TensorPow M) =
    matExp A := rfl

@[simp]
theorem matExpUnits_inv (A : TensorPow M) :
    (((matExpUnits A)⁻¹ : (TensorPow M)ˣ) : TensorPow M) = matExp (-A) := rfl

/-- 0 でないスカラー倍は単元性を保つ。 -/
noncomputable def smulUnits (c : ℂ) (hc : c ≠ 0) (u : (TensorPow M)ˣ) : (TensorPow M)ˣ where
  val := c • (u : TensorPow M)
  inv := c⁻¹ • ((u⁻¹ : (TensorPow M)ˣ) : TensorPow M)
  val_inv := by
    rw [smul_mul_smul_comm, u.mul_inv, mul_inv_cancel₀ hc, one_smul]
  inv_val := by
    rw [smul_mul_smul_comm, u.inv_mul, inv_mul_cancel₀ hc, one_smul]

@[simp]
theorem smulUnits_val (c : ℂ) (hc : c ≠ 0) (u : (TensorPow M)ˣ) :
    ((smulUnits c hc u : (TensorPow M)ˣ) : TensorPow M) = c • (u : TensorPow M) := rfl

/-- `V_1^{(±)}` を単元として。 -/
noncomputable def V1Units (M : ℕ) (K1 η : ℂ) : (TensorPow M)ˣ :=
  matExpUnits ((Complex.I * K1) • H1 M η)

/-- `(V_1^{(±)})^{1/2}` を単元として。 -/
noncomputable def V1halfUnits (M : ℕ) (K1 η : ℂ) : (TensorPow M)ˣ :=
  matExpUnits (((1 / 2 : ℂ) * Complex.I * K1) • H1 M η)

@[simp]
theorem V1Units_val (K1 η : ℂ) :
    ((V1Units M K1 η : (TensorPow M)ˣ) : TensorPow M) = V1 M K1 η := rfl

@[simp]
theorem V1halfUnits_val (K1 η : ℂ) :
    ((V1halfUnits M K1 η : (TensorPow M)ˣ) : TensorPow M) = V1half M K1 η := rfl

theorem isUnit_V1 (K1 η : ℂ) : IsUnit (V1 M K1 η) := ⟨V1Units M K1 η, rfl⟩

theorem isUnit_V1half (K1 η : ℂ) : IsUnit (V1half M K1 η) := ⟨V1halfUnits M K1 η, rfl⟩

/-- `(2 s_2)^{M/2} ≠ 0`（`s_2 > 0` のとき）。原文 `def_transfer_matrix_symbols` 末尾の
「`K_i > 0` より `s_i > 0`」に対応する仮定。 -/
theorem rpow_two_s2_ne_zero {s2 : ℝ} (hs2 : 0 < s2) (M : ℕ) :
    ((((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ)) ≠ 0 := by
  refine Complex.ofReal_ne_zero.mpr (ne_of_gt ?_)
  exact Real.rpow_pos_of_pos (by linarith) _

/-- `V_2` を単元として。スカラー因子が 0 でないために `s_2 > 0` を要する。 -/
noncomputable def V2Units (M : ℕ) {s2 : ℝ} (hs2 : 0 < s2) (K2star : ℂ) : (TensorPow M)ˣ :=
  smulUnits ((((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ)) (rpow_two_s2_ne_zero hs2 M)
    (matExpUnits ((Complex.I * K2star) • H2 M))

@[simp]
theorem V2Units_val {s2 : ℝ} (hs2 : 0 < s2) (K2star : ℂ) :
    ((V2Units M hs2 K2star : (TensorPow M)ˣ) : TensorPow M) = V2 M s2 K2star := rfl

/-- **原文 `V2_invertible`**: `V_2` は可逆。 -/
theorem isUnit_V2 {s2 : ℝ} (hs2 : 0 < s2) (K2star : ℂ) : IsUnit (V2 M s2 K2star) :=
  ⟨V2Units M hs2 K2star, rfl⟩

end Ising2D
