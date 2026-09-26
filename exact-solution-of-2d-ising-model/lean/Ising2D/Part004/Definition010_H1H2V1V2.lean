/-
# `H_1^{(±)}`, `H_2` の定義、`V_1^{(±)}` の定義、`V_2` の指数表示の右辺

対応する人手証明（正本は `structured-latex/content/*.ts`）:

* `structured-latex/content/004_transfer_matrix.ts`
  * `transfer_matrix_000m_definition_indexed_hyperbolic_abbreviations`
    — `c_i`, `s_i`, `c_i^*`, `s_i^*` の定義
  * `transfer_matrix_000n_claim_indexed_hyperbolic_abbreviations_positive`
    （ラベル `indexed_hyperbolic_abbreviations_positive`）
    — `c_i`, `s_i`, `c_i^*`, `s_i^*` の正値性
  * `transfer_matrix_007_definition_V1_pm`
    — `V_1^{(±)} := exp(√-1 K_1 (Y_1 Z_2 + ⋯ + Y_{M-1} Z_M ∓ Y_M Z_1))`
  * `transfer_matrix_003a_claim_V2_in_Z_Y`（ラベル `V2_in_Z_Y`）
    — `V_2 = (2s_2)^{M/2} exp(√-1 K_2^* (Z_1Y_1 + ⋯ + Z_MY_M))` の右辺（`V2FromJordanWigner`）と
      Step 2 の直後の等式の有限和版（`I_smul_H2_eq_sum_sigmaX`）
  * `transfer_matrix_011a_definition_H1_pm`（ラベル `def_H1_pm`）
    — `H_1^{(±)} := Y_1 Z_2 + ⋯ + Y_{M-1} Z_M ∓ Y_M Z_1`
  * `transfer_matrix_011b_definition_H2`（ラベル `def_H2`）
    — `H_2 := Z_1 Y_1 + ⋯ + Z_M Y_M`
  * `transfer_matrix_011c_claim_V1_pm_exponential_representation`
    （ラベル `V1_pm_exponential_representation`）
    — `V_1^{(±)} = exp(√-1 K_1 H_1^{(±)})`
  * `transfer_matrix_011d_claim_V2_exponential_representation`
    （ラベル `V2_exponential_representation`）
    — `V_2 = (2 s_2)^{M/2} exp(√-1 K_2^* H_2)` の右辺（`V2H2Form`）
  * 人手の `V_2`（`def_transfer_matrix`）そのものについての主張 `V2_in_Z_Y`・
    `V2_exponential_representation` は `Part004/ClaimV2InZY.lean` にある。
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
`def_transfer_matrix_symbols` の「`K_i, K_i^* > 0` より `c_i, s_i, c_i^*, s_i^* > 0`」）
を可逆性の証明で明示的な仮定として置く。

## `√-1 H_2 = ∑_m σ^x_m`

人手 `V2_in_Z_Y` の Step 2 の直後の等式 `σ^x_m = √-1 Z_m Y_m`（`Ising2D.Z_mul_Y_same` から従う）を
全サイトで足し合わせたものが `I_smul_H2_eq_sum_sigmaX` である。人手 `V2_in_Z_Y` の Step 3 は
これを指数の肩の等式として使う。
-/
import Ising2D.Part004.Definition009_HatZHatY
import Ising2D.Representation
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.SpecialFunctions.Trigonometric.DerivHyp

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

/-- **人手本文 `def_H1_pm` の `H_1^{(±)} = Y_1 Z_2 + Y_2 Z_3 + ⋯ + Y_{M-1} Z_M ∓ Y_M Z_1`**
（`η` が原文の `∓1`）。 -/
noncomputable def H1 (M : ℕ) (η : ℂ) : TensorPow M :=
  ∑ m : Fin M, lastSign η m • (Y m * Z (nextSite m))

/-- **人手本文 `def_H2` の `H_2 = Z_1 Y_1 + Z_2 Y_2 + ⋯ + Z_M Y_M`**。 -/
noncomputable def H2 (M : ℕ) : TensorPow M := ∑ m : Fin M, Z m * Y m

/-- 原文 `V2_in_Z_Y` の Step 0–2 に対応する等式。

Step 0–2 の単一サイト計算とクロネッカー積への持ち上げは
`Ising2D.Z_mul_Y_same` が担い、本定理が各サイトの等式を有限和へ持ち上げる。
これにより `second_transfer_matrix_pauli_form` の `V_2` の指数
`K_2^*(σ^x_1 + ⋯)` と `V2_exponential_representation` の指数
`√-1 K_2^* H_2` が一致する（人手 `V2_in_Z_Y` Step 3）。

`Z_m Y_m = -√-1 σ^x_m`（`Ising2D.Z_mul_Y_same`）より `√-1 H_2 = ∑_m σ^x_m`。 -/
theorem I_smul_H2_eq_sum_sigmaX :
    (Complex.I • H2 M) = ∑ m : Fin M, sigmaX m := by
  rw [H2, Finset.smul_sum]
  refine Finset.sum_congr rfl fun m _ => ?_
  rw [Z_mul_Y_same, smul_smul]
  norm_num [Complex.I_mul_I]

/-! ## 双曲線関数の添字つき略記 -/

/-- 人手本文 `def_indexed_hyperbolic_abbreviations` の八つの実数値をまとめたもの。 -/
structure IndexedHyperbolicAbbreviations where
  c1 : ℝ
  s1 : ℝ
  c2 : ℝ
  s2 : ℝ
  c1star : ℝ
  s1star : ℝ
  c2star : ℝ
  s2star : ℝ

/-- 人手本文の
`c_i := cosh(2K_i)`, `s_i := sinh(2K_i)`,
`c_i^* := cosh(2K_i^*)`, `s_i^* := sinh(2K_i^*)`（`i ∈ {1,2}`）。 -/
noncomputable def indexedHyperbolicAbbreviations
    (K1 K2 K1star K2star : ℝ) : IndexedHyperbolicAbbreviations where
  c1 := Real.cosh (2 * K1)
  s1 := Real.sinh (2 * K1)
  c2 := Real.cosh (2 * K2)
  s2 := Real.sinh (2 * K2)
  c1star := Real.cosh (2 * K1star)
  s1star := Real.sinh (2 * K1star)
  c2star := Real.cosh (2 * K2star)
  s2star := Real.sinh (2 * K2star)

/-- 人手本文 `indexed_hyperbolic_abbreviations_positive` の具体版。
二組の結合定数と双対結合定数について、本文の略記定義を代入したうえで、
各添字の四つの正値性を本文と同じ順で示す。
解析関数そのものに固有の主張なので、不要な構造を除いた別の必要十分版は置かない。 -/
theorem indexedHyperbolicAbbreviations_pos
    {K1 K2 K1star K2star : ℝ}
    (hK1 : 0 < K1) (hK2 : 0 < K2) (hK1star : 0 < K1star) (hK2star : 0 < K2star) :
    0 < (indexedHyperbolicAbbreviations K1 K2 K1star K2star).c1 ∧
      0 < (indexedHyperbolicAbbreviations K1 K2 K1star K2star).s1 ∧
      0 < (indexedHyperbolicAbbreviations K1 K2 K1star K2star).c1star ∧
      0 < (indexedHyperbolicAbbreviations K1 K2 K1star K2star).s1star ∧
      0 < (indexedHyperbolicAbbreviations K1 K2 K1star K2star).c2 ∧
      0 < (indexedHyperbolicAbbreviations K1 K2 K1star K2star).s2 ∧
      0 < (indexedHyperbolicAbbreviations K1 K2 K1star K2star).c2star ∧
      0 < (indexedHyperbolicAbbreviations K1 K2 K1star K2star).s2star := by
  -- 人手本文の第1段: 正の結合定数を二倍しても正である。
  have h2K1 : 0 < 2 * K1 := mul_pos (by norm_num) hK1
  have h2K1star : 0 < 2 * K1star := mul_pos (by norm_num) hK1star
  have h2K2 : 0 < 2 * K2 := mul_pos (by norm_num) hK2
  have h2K2star : 0 < 2 * K2star := mul_pos (by norm_num) hK2star
  -- 人手本文の第2段: 各正の引数で `cosh x > sinh x > 0` を得る。
  have hSinhK1 : 0 < Real.sinh (2 * K1) := (Real.sinh_pos_iff).2 h2K1
  have hSinhK1star : 0 < Real.sinh (2 * K1star) := (Real.sinh_pos_iff).2 h2K1star
  have hSinhK2 : 0 < Real.sinh (2 * K2) := (Real.sinh_pos_iff).2 h2K2
  have hSinhK2star : 0 < Real.sinh (2 * K2star) := (Real.sinh_pos_iff).2 h2K2star
  have hSinhLtCoshK1 : Real.sinh (2 * K1) < Real.cosh (2 * K1) := Real.sinh_lt_cosh _
  have hSinhLtCoshK1star : Real.sinh (2 * K1star) < Real.cosh (2 * K1star) :=
    Real.sinh_lt_cosh _
  have hSinhLtCoshK2 : Real.sinh (2 * K2) < Real.cosh (2 * K2) := Real.sinh_lt_cosh _
  have hSinhLtCoshK2star : Real.sinh (2 * K2star) < Real.cosh (2 * K2star) :=
    Real.sinh_lt_cosh _
  -- 人手本文の第3段: 略記定義を代入して二つの連鎖不等式を得る。
  have hS1LtC1 :
      (indexedHyperbolicAbbreviations K1 K2 K1star K2star).s1 <
        (indexedHyperbolicAbbreviations K1 K2 K1star K2star).c1 := by
    simpa [indexedHyperbolicAbbreviations] using hSinhLtCoshK1
  have hS1starLtC1star :
      (indexedHyperbolicAbbreviations K1 K2 K1star K2star).s1star <
        (indexedHyperbolicAbbreviations K1 K2 K1star K2star).c1star := by
    simpa [indexedHyperbolicAbbreviations] using hSinhLtCoshK1star
  have hS2LtC2 :
      (indexedHyperbolicAbbreviations K1 K2 K1star K2star).s2 <
        (indexedHyperbolicAbbreviations K1 K2 K1star K2star).c2 := by
    simpa [indexedHyperbolicAbbreviations] using hSinhLtCoshK2
  have hS2starLtC2star :
      (indexedHyperbolicAbbreviations K1 K2 K1star K2star).s2star <
        (indexedHyperbolicAbbreviations K1 K2 K1star K2star).c2star := by
    simpa [indexedHyperbolicAbbreviations] using hSinhLtCoshK2star
  -- 人手本文の第4・第5段: `s_i`, `s_i^*` の正値性を定義から取り出す。
  have hS1 : 0 < (indexedHyperbolicAbbreviations K1 K2 K1star K2star).s1 := by
    simpa [indexedHyperbolicAbbreviations] using hSinhK1
  have hS1star : 0 < (indexedHyperbolicAbbreviations K1 K2 K1star K2star).s1star := by
    simpa [indexedHyperbolicAbbreviations] using hSinhK1star
  have hS2 : 0 < (indexedHyperbolicAbbreviations K1 K2 K1star K2star).s2 := by
    simpa [indexedHyperbolicAbbreviations] using hSinhK2
  have hS2star : 0 < (indexedHyperbolicAbbreviations K1 K2 K1star K2star).s2star := by
    simpa [indexedHyperbolicAbbreviations] using hSinhK2star
  -- 人手本文の第6・第7段: 推移律で `c_i`, `c_i^*` の正値性を得る。
  have hC1 : 0 < (indexedHyperbolicAbbreviations K1 K2 K1star K2star).c1 :=
    lt_trans hS1 hS1LtC1
  have hC1star : 0 < (indexedHyperbolicAbbreviations K1 K2 K1star K2star).c1star :=
    lt_trans hS1star hS1starLtC1star
  have hC2 : 0 < (indexedHyperbolicAbbreviations K1 K2 K1star K2star).c2 :=
    lt_trans hS2 hS2LtC2
  have hC2star : 0 < (indexedHyperbolicAbbreviations K1 K2 K1star K2star).c2star :=
    lt_trans hS2star hS2starLtC2star
  exact ⟨hC1, hS1, hC1star, hS1star, hC2, hS2, hC2star, hS2star⟩

/-! ## `V_1^{(±)}`, `(V_1^{(±)})^{1/2}` と、`V_2` の二つの指数表示の右辺

ここで定義する名前の整理:

* `V1pm M K1 η` は人手 `def_V1_pm` の `V_1^{(±)}`（`η` が人手の `∓1`）。
  人手 `def_transfer_matrix` の `V_1` とは別の行列であり、`V_1` は
  `Ising2D.V1`（`Part001/DefinitionTransferMatrix.lean`）である。
* `V2FromJordanWigner M s2 K2star`, `V2H2Form M s2 K2star` は、人手 `V2_in_Z_Y`・
  `V2_exponential_representation` の**右辺の式**に名前を付けたもの。`s2`, `K2star` を
  独立な引数として持つ一般化であり、人手の `V_2`（`Ising2D.V2`）と一致するのは
  `s2 = sinh 2K_2`, `K2star = K_2^*` のとき（`Part004/ClaimV2InZY.lean` の
  `V2_in_Z_Y` / `V2_exponential_representation`）。
-/

/-- **人手本文 `def_V1_pm` の有限和を省略しない定義**。
`H1` という名前を使わず、境界項を含む有限和をそのまま指数へ入れる。 -/
noncomputable def V1pmFromDefinition (M : ℕ) (K1 η : ℂ) : TensorPow M :=
  matExp ((Complex.I * K1) •
    (∑ m : Fin M, lastSign η m • (Y m * Z (nextSite m))))

/-- **人手の `V_1^{(±)} = exp(√-1 K_1 H_1^{(±)})`**（`η` が人手の `∓1`）。 -/
noncomputable def V1pm (M : ℕ) (K1 η : ℂ) : TensorPow M :=
  matExp ((Complex.I * K1) • H1 M η)

/-- **人手本文 `V1_pm_exponential_representation` の具体版**。
`def_V1_pm` の有限和を `def_H1_pm` の `H_1^{(±)}` へ置き換える一段に対応する。 -/
theorem V1pm_exponential_representation (M : ℕ) (K1 η : ℂ) :
    V1pmFromDefinition M K1 η = V1pm M K1 η := by
  rfl

/-- **人手 `def_V1_pm_square_root` の `(V_1^{(±)})^{1/2} = exp((1/2)√-1 K_1 H_1^{(±)})`**。
人手も最初から `exp(X/2)` を定義に採っている（一般の行列の平方根は一意でないため）。 -/
noncomputable def V1pmHalf (M : ℕ) (K1 η : ℂ) : TensorPow M :=
  matExp (((1 / 2 : ℂ) * Complex.I * K1) • H1 M η)

/-- **人手 `V2_in_Z_Y` の右辺** `(2s_2)^{M/2} exp(√-1 K_2^* (Z_1Y_1 + ⋯ + Z_MY_M))`
（有限和を省略しない表示。`s2`, `K2star` は独立な引数）。 -/
noncomputable def V2FromJordanWigner
    (M : ℕ) (s2 : ℝ) (K2star : ℂ) : TensorPow M :=
  ((((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ)) •
    matExp ((Complex.I * K2star) • (∑ m : Fin M, Z m * Y m))

/-- **人手 `V2_exponential_representation` の右辺** `(2 s_2)^{M/2} exp(√-1 K_2^* H_2)`
（`s2`, `K2star` は独立な引数）。
`(2 s_2)^{M/2}` は `M` が奇数のとき実冪なので `Real.rpow` を使う。 -/
noncomputable def V2H2Form (M : ℕ) (s2 : ℝ) (K2star : ℂ) : TensorPow M :=
  ((((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ)) • matExp ((Complex.I * K2star) • H2 M)

/-- 人手 `V2_exponential_representation` の証明の第 2 段（`def_H2` で有限和を `H_2` に置き換える）を、
右辺の式どうしの等式として述べたもの。人手の `V_2` についての主張は
`Ising2D.V2_exponential_representation`（`Part004/ClaimV2InZY.lean`）。 -/
theorem V2FromJordanWigner_eq_V2H2Form (M : ℕ) (s2 : ℝ) (K2star : ℂ) :
    V2FromJordanWigner M s2 K2star = V2H2Form M s2 K2star := by
  rfl

/-- `V_1^{(±)} = ((V_1^{(±)})^{1/2})^2`（「平方根」の名に値することの確認）。 -/
theorem V1pmHalf_sq (K1 η : ℂ) :
    V1pmHalf M K1 η * V1pmHalf M K1 η = V1pm M K1 η := by
  have h : Commute (((1 / 2 : ℂ) * Complex.I * K1) • H1 M η)
      (((1 / 2 : ℂ) * Complex.I * K1) • H1 M η) := Commute.refl _
  rw [V1pmHalf, V1pm, matExp, matExp, ← Matrix.exp_add_of_commute _ _ h, ← two_smul ℂ]
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
noncomputable def V1pmUnits (M : ℕ) (K1 η : ℂ) : (TensorPow M)ˣ :=
  matExpUnits ((Complex.I * K1) • H1 M η)

/-- `(V_1^{(±)})^{1/2}` を単元として。 -/
noncomputable def V1pmHalfUnits (M : ℕ) (K1 η : ℂ) : (TensorPow M)ˣ :=
  matExpUnits (((1 / 2 : ℂ) * Complex.I * K1) • H1 M η)

@[simp]
theorem V1pmUnits_val (K1 η : ℂ) :
    ((V1pmUnits M K1 η : (TensorPow M)ˣ) : TensorPow M) = V1pm M K1 η := rfl

@[simp]
theorem V1pmHalfUnits_val (K1 η : ℂ) :
    ((V1pmHalfUnits M K1 η : (TensorPow M)ˣ) : TensorPow M) = V1pmHalf M K1 η := rfl

theorem isUnit_V1pm (K1 η : ℂ) : IsUnit (V1pm M K1 η) := ⟨V1pmUnits M K1 η, rfl⟩

theorem isUnit_V1pmHalf (K1 η : ℂ) : IsUnit (V1pmHalf M K1 η) := ⟨V1pmHalfUnits M K1 η, rfl⟩

/-- `(2 s_2)^{M/2} ≠ 0`（`s_2 > 0` のとき）。原文 `def_transfer_matrix_symbols` 末尾の
「`K_i > 0` より `s_i > 0`」に対応する仮定。 -/
theorem rpow_two_s2_ne_zero {s2 : ℝ} (hs2 : 0 < s2) (M : ℕ) :
    ((((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ)) ≠ 0 := by
  refine Complex.ofReal_ne_zero.mpr (ne_of_gt ?_)
  exact Real.rpow_pos_of_pos (by linarith) _

/-- `V2H2Form` を単元として。スカラー因子が 0 でないために `s_2 > 0` を要する。 -/
noncomputable def V2H2FormUnits (M : ℕ) {s2 : ℝ} (hs2 : 0 < s2) (K2star : ℂ) : (TensorPow M)ˣ :=
  smulUnits ((((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ)) (rpow_two_s2_ne_zero hs2 M)
    (matExpUnits ((Complex.I * K2star) • H2 M))

@[simp]
theorem V2H2FormUnits_val {s2 : ℝ} (hs2 : 0 < s2) (K2star : ℂ) :
    ((V2H2FormUnits M hs2 K2star : (TensorPow M)ˣ) : TensorPow M) = V2H2Form M s2 K2star := rfl

/-- `V2H2Form` は可逆（人手 `V2_invertible` の一般化。人手の `V_2` については
`Ising2D.isUnit_V2`（`Part004/ClaimV2InZY.lean`））。 -/
theorem isUnit_V2H2Form {s2 : ℝ} (hs2 : 0 < s2) (K2star : ℂ) : IsUnit (V2H2Form M s2 K2star) :=
  ⟨V2H2FormUnits M hs2 K2star, rfl⟩

end Ising2D
