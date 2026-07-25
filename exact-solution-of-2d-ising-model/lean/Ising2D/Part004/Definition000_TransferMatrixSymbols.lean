/-
# 転送行列の記号の定義（サイト局所作用素と Jordan–Wigner 文字列）

対応する人手証明:
`parts/004_転送行列/000_definition_転送行列の記号の定義.typ` (`<def_transfer_matrix_symbols>`)
（Pauli 行列そのものの成分表示は
`parts/004_転送行列/014_claim_Z_YはMat2C^Mを環として生成する.typ` の証明冒頭にある）

本ファイルでは、原文の記号のうち

* `σ^x_k, σ^y_k, σ^z_k`（第 `k` 因子だけが Pauli 行列で残りが単位行列のテンソル積）
* Jordan–Wigner 文字列 `Z_m = σ^x_1 ⋯ σ^x_{m-1} σ^z_m`（`Z_1 = σ^z_1`）、
  `Y_m = σ^x_1 ⋯ σ^x_{m-1} σ^y_m`（`Y_1 = σ^y_1`）
* `ε = σ^x_1 ⋯ σ^x_M`

を、`Ising2D/Basic.lean` で確定した表現 `TensorPow M = Matrix (Conf M) (Conf M) ℂ` 上で定義する。

## 添字づけの規約（原文との差）

原文はサイトを `1, …, M` で番号づけるが、Lean では `Fin M`（`0, …, M-1`）を使う。
対応は `原文の m` ↔ `Lean の ⟨m-1, _⟩`。したがって原文の `Z_1 = σ^z_1`（空の文字列）は
Lean では `Z 0 = sigmaZ 0` にあたり、`xString` の値が `1` になることで自動的に満たされる
（原文が場合分けとして書いている `Z_1 := σ^z_1` は、Lean では特別扱い不要）。

原文の `Z_{M+1} := Z_1`（周期性）は `Fin M` 上では添字の巡回そのものなので、
定義としては現れない（必要になる箇所で `Fin M` の演算として扱う）。

## 原文の記述に対する疑義（要確認）

`<def_transfer_matrix_symbols>` の
`ε := σ^x_1 ⋯ σ^x_M = (√-1)^M Z_1 Y_1 + ⋯ + Z_M Y_M`
は **和ではなく積** `(√-1)^M Z_1 Y_1 ⋯ Z_M Y_M` でなければならない。
実際 `Z_m Y_m = σ^z_m σ^y_m = -√-1 σ^x_m` なので

  `(√-1)^M Z_1 Y_1 ⋯ Z_M Y_M = (√-1)^M (-√-1)^M σ^x_1 ⋯ σ^x_M = σ^x_1 ⋯ σ^x_M = ε`

となり積なら正しいが、和の場合は `M = 2` で
`(√-1)^2 (Z_1 Y_1 + Z_2 Y_2) = √-1 (σ^x_1 + σ^x_2) ≠ σ^x_1 σ^x_2` となって成り立たない。
本ファイルでは `ε := σ^x_1 ⋯ σ^x_M`（左辺）を定義とし、
積の形の等式は `epsilon_eq_prod_ZY`（`Ising2D/Part004/Claim014_...` 系の補題）としては
まだ形式化していない。
-/
import Ising2D.Representation

namespace Ising2D

/-! ## Pauli 行列（`Mat(2, ℂ)` の元）

`parts/004_転送行列/014_claim_Z_YはMat2C^Mを環として生成する.typ` の証明冒頭の定義。 -/

/-- Pauli 行列 `σ^x = !![0, 1; 1, 0]`。 -/
def pauliX : Matrix (Fin 2) (Fin 2) ℂ := !![0, 1; 1, 0]

/-- Pauli 行列 `σ^y = !![0, -√-1; √-1, 0]`。 -/
def pauliY : Matrix (Fin 2) (Fin 2) ℂ := !![0, -Complex.I; Complex.I, 0]

/-- Pauli 行列 `σ^z = !![1, 0; 0, -1]`。 -/
def pauliZ : Matrix (Fin 2) (Fin 2) ℂ := !![1, 0; 0, -1]

section PauliRelations

/-- `σ^x σ^x = I`（原文 Step 1 の成分計算）。 -/
@[simp]
theorem pauliX_mul_pauliX : pauliX * pauliX = 1 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [pauliX, Matrix.mul_apply, Fin.sum_univ_two]

/-- `σ^y σ^y = I`。 -/
@[simp]
theorem pauliY_mul_pauliY : pauliY * pauliY = 1 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [pauliY, Matrix.mul_apply, Fin.sum_univ_two, Complex.I_mul_I]

/-- `σ^z σ^z = I`。 -/
@[simp]
theorem pauliZ_mul_pauliZ : pauliZ * pauliZ = 1 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [pauliZ, Matrix.mul_apply, Fin.sum_univ_two]

/-- `σ^z` と `σ^x` は反可換。 -/
theorem pauliZ_mul_pauliX : pauliZ * pauliX = -(pauliX * pauliZ) := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [pauliX, pauliZ, Matrix.mul_apply, Fin.sum_univ_two]

/-- `σ^y` と `σ^x` は反可換。 -/
theorem pauliY_mul_pauliX : pauliY * pauliX = -(pauliX * pauliY) := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [pauliX, pauliY, Matrix.mul_apply, Fin.sum_univ_two]

/-- `σ^y` と `σ^z` は反可換。 -/
theorem pauliY_mul_pauliZ_anticomm : pauliY * pauliZ = -(pauliZ * pauliY) := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [pauliY, pauliZ, Matrix.mul_apply, Fin.sum_univ_two]

/-- 原文 Step 1 の `σ^y σ^z = √-1 σ^x`。 -/
theorem pauliY_mul_pauliZ : pauliY * pauliZ = Complex.I • pauliX := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [pauliX, pauliY, pauliZ, Matrix.mul_apply, Fin.sum_univ_two]

/-- 原文 Step 1 の `σ^x = -√-1 σ^y σ^z`。 -/
theorem pauliX_eq : pauliX = (-Complex.I) • (pauliY * pauliZ) := by
  rw [pauliY_mul_pauliZ, smul_smul, neg_mul, Complex.I_mul_I, neg_neg, one_smul]

/-- `σ^z σ^y = -√-1 σ^x`（`ε` の表式の検証に使う）。 -/
theorem pauliZ_mul_pauliY : pauliZ * pauliY = (-Complex.I) • pauliX := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [pauliX, pauliY, pauliZ, Matrix.mul_apply, Fin.sum_univ_two]

end PauliRelations

/-! ## サイト局所作用素 `σ^a_k`

原文の `σ^a_k := I ⊗ ⋯ ⊗ σ^a (k 番目) ⊗ ⋯ ⊗ I` を、
`Ising2D.siteProd`（`Ising2D/Representation.lean`）で作る。
`siteProd` は多重線型写像なので、第 `k` 成分だけを動かす線型写像
`MultilinearMap.toLinearMap` としてまとめて定義できる。 -/

section SiteOp

variable {M : ℕ}

/-- 第 `k` テンソル因子だけを `A` に置き換えたテンソル積
`I ⊗ ⋯ ⊗ A (k 番目) ⊗ ⋯ ⊗ I ∈ Mat(2, ℂ)^{⊗M}`。

`A` について線型であることは `siteProd` の多重線型性から自動的に従う。 -/
noncomputable def siteOp (k : Fin M) : Matrix (Fin 2) (Fin 2) ℂ →ₗ[ℂ] TensorPow M :=
  (siteProd M).toLinearMap 1 k

theorem siteOp_apply (k : Fin M) (A : Matrix (Fin 2) (Fin 2) ℂ) :
    siteOp k A = siteProd M (Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) k A) :=
  rfl

/-- `I` を置いたら単位元。 -/
@[simp]
theorem siteOp_one (k : Fin M) : siteOp k (1 : Matrix (Fin 2) (Fin 2) ℂ) = 1 := by
  rw [siteOp_apply]
  have h : Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) k 1 = 1 := by
    funext i; by_cases h : i = k <;> simp [h]
  rw [h, siteProd_one]

/-- 同じサイトの積は、そのサイトの `Mat(2, ℂ)` の積になる
（原文 Step 1 の `σ_k^a σ_k^b = I ⊗ ⋯ ⊗ (σ^a σ^b) ⊗ ⋯ ⊗ I`）。 -/
theorem siteOp_mul_same (k : Fin M) (A B : Matrix (Fin 2) (Fin 2) ℂ) :
    siteOp k A * siteOp k B = siteOp k (A * B) := by
  rw [siteOp_apply, siteOp_apply, siteOp_apply, ← siteProd_mul]
  congr 1
  funext i
  by_cases h : i = k <;> simp [Pi.mul_apply, h]

/-- 異なるサイトの作用素は可換（原文 Step 1 の異サイト可換性）。 -/
theorem siteOp_mul_comm {k l : Fin M} (hkl : k ≠ l) (A B : Matrix (Fin 2) (Fin 2) ℂ) :
    siteOp k A * siteOp l B = siteOp l B * siteOp k A := by
  rw [siteOp_apply, siteOp_apply, ← siteProd_mul, ← siteProd_mul]
  congr 1
  funext i
  simp only [Pi.mul_apply, Function.update_apply, Pi.one_apply]
  by_cases hk : i = k
  · have hl : ¬ (i = l) := by rw [hk]; exact hkl
    rw [if_pos hk, if_neg hl, mul_one, one_mul]
  · by_cases hl : i = l
    · rw [if_neg hk, if_pos hl, mul_one, one_mul]
    · rw [if_neg hk, if_neg hl]

/-- 原文の `σ^x_k`。 -/
noncomputable def sigmaX (k : Fin M) : TensorPow M := siteOp k pauliX

/-- 原文の `σ^y_k`。 -/
noncomputable def sigmaY (k : Fin M) : TensorPow M := siteOp k pauliY

/-- 原文の `σ^z_k`。 -/
noncomputable def sigmaZ (k : Fin M) : TensorPow M := siteOp k pauliZ

/-- `σ^x_k σ^x_k = I`（原文 Step 1）。 -/
@[simp]
theorem sigmaX_mul_self (k : Fin M) : sigmaX k * sigmaX k = 1 := by
  rw [sigmaX, siteOp_mul_same, pauliX_mul_pauliX, siteOp_one]

/-- `σ^x_k = -√-1 σ^y_k σ^z_k`（原文 Step 1 の持ち上げ）。 -/
theorem sigmaX_eq (k : Fin M) : sigmaX k = (-Complex.I) • (sigmaY k * sigmaZ k) := by
  rw [sigmaY, sigmaZ, siteOp_mul_same, sigmaX, ← map_smul, ← pauliX_eq]

end SiteOp

/-! ## Jordan–Wigner 文字列 `Z_m`, `Y_m` と `ε` -/

section JordanWigner

variable {M : ℕ}

/-- `Z_m`, `Y_m` を作る「サイト成分の族」。

サイト `i` の成分は
* `i < m` なら `σ^x`（Jordan–Wigner 文字列の部分）
* `i = m` なら `A`（`Z_m` なら `σ^z`、`Y_m` なら `σ^y`）
* `i > m` なら `I`

である。`siteProd` に流し込むと原文の `σ^x_1 ⋯ σ^x_{m-1} A_m` になる
（`Z_eq_xString_mul` / `Y_eq_xString_mul` 参照）。 -/
def jwFamily (m : Fin M) (A : Matrix (Fin 2) (Fin 2) ℂ) :
    Fin M → Matrix (Fin 2) (Fin 2) ℂ :=
  fun i => if (i : ℕ) < (m : ℕ) then pauliX else if i = m then A else 1

theorem jwFamily_of_lt {m i : Fin M} {A : Matrix (Fin 2) (Fin 2) ℂ}
    (h : (i : ℕ) < (m : ℕ)) : jwFamily m A i = pauliX := by
  simp [jwFamily, h]

@[simp]
theorem jwFamily_self (m : Fin M) (A : Matrix (Fin 2) (Fin 2) ℂ) :
    jwFamily m A m = A := by
  simp [jwFamily]

theorem jwFamily_of_gt {m i : Fin M} {A : Matrix (Fin 2) (Fin 2) ℂ}
    (h : (m : ℕ) < (i : ℕ)) : jwFamily m A i = 1 := by
  have h1 : ¬ ((i : ℕ) < (m : ℕ)) := by omega
  have h2 : i ≠ m := fun he => absurd (congrArg Fin.val he) (by omega)
  simp [jwFamily, h1, h2]

/-- 原文の `Z_m := σ^x_1 ⋯ σ^x_{m-1} σ^z_m`（`Z_1 := σ^z_1`）。
Lean の添字は 0 始まりで、`Z 0 = σ^z_0` が原文の `Z_1` にあたる。 -/
noncomputable def Z (m : Fin M) : TensorPow M := siteProd M (jwFamily m pauliZ)

/-- 原文の `Y_m := σ^x_1 ⋯ σ^x_{m-1} σ^y_m`（`Y_1 := σ^y_1`）。 -/
noncomputable def Y (m : Fin M) : TensorPow M := siteProd M (jwFamily m pauliY)

/-- Jordan–Wigner 文字列 `σ^x_1 ⋯ σ^x_m`（Lean の 0 始まり添字で `i < m` なるサイト全部）。
原文の `P_{m-1} = σ^x_1 ⋯ σ^x_{m-1}` にあたる。 -/
noncomputable def xString (M : ℕ) (m : ℕ) : TensorPow M :=
  siteProd M (fun i => if (i : ℕ) < m then pauliX else 1)

/-- 空の文字列は単位元（原文の `P_0 := I`）。 -/
@[simp]
theorem xString_zero : xString M 0 = 1 := by
  rw [xString]
  have h : (fun i : Fin M => if (i : ℕ) < 0 then pauliX else 1) = 1 := by
    funext i; simp
  rw [h, siteProd_one]

/-- 文字列は 1 サイトずつ伸ばせる: `P_{m+1} = P_m σ^x_m`。 -/
theorem xString_succ (m : ℕ) (h : m < M) :
    xString M (m + 1) = xString M m * sigmaX ⟨m, h⟩ := by
  rw [xString, xString, sigmaX, siteOp_apply, ← siteProd_mul]
  congr 1
  funext i
  simp only [Pi.mul_apply, Function.update_apply, Pi.one_apply]
  rcases lt_trichotomy (i : ℕ) m with hi | hi | hi
  · have hne : i ≠ (⟨m, h⟩ : Fin M) := Fin.ne_of_val_ne (show (i : ℕ) ≠ m by omega)
    rw [if_pos (by omega : (i : ℕ) < m + 1), if_pos hi, if_neg hne, mul_one]
  · have he : i = (⟨m, h⟩ : Fin M) := Fin.val_injective hi
    rw [if_pos (by omega : (i : ℕ) < m + 1), if_neg (by omega : ¬ ((i : ℕ) < m)),
      if_pos he, one_mul]
  · have hne : i ≠ (⟨m, h⟩ : Fin M) := Fin.ne_of_val_ne (show (i : ℕ) ≠ m by omega)
    rw [if_neg (by omega : ¬ ((i : ℕ) < m + 1)), if_neg (by omega : ¬ ((i : ℕ) < m)),
      if_neg hne, mul_one]

/-- `P_m P_m = I`（原文 Step 2 の `P_{m-1} P_{m-1} = I`）。 -/
@[simp]
theorem xString_mul_self (m : ℕ) : xString M m * xString M m = 1 := by
  rw [xString, ← siteProd_mul]
  have h : ((fun i : Fin M => if (i : ℕ) < m then pauliX else 1) *
      (fun i : Fin M => if (i : ℕ) < m then pauliX else 1)) = 1 := by
    funext i
    by_cases hi : (i : ℕ) < m <;> simp [Pi.mul_apply, hi]
  rw [h, siteProd_one]

/-- 原文どおりの分解 `σ^x_1 ⋯ σ^x_{m-1} A_m = (σ^x_1 ⋯ σ^x_{m-1}) · A_m`。
`Z_m`（`A = σ^z`）と `Y_m`（`A = σ^y`）に共通の補題。 -/
theorem jw_eq_xString_mul (m : Fin M) (A : Matrix (Fin 2) (Fin 2) ℂ) :
    siteProd M (jwFamily m A) = xString M (m : ℕ) * siteOp m A := by
  rw [xString, siteOp_apply, ← siteProd_mul]
  congr 1
  funext i
  simp only [Pi.mul_apply, Function.update_apply, Pi.one_apply]
  rcases lt_trichotomy (i : ℕ) (m : ℕ) with h | h | h
  · have hne : i ≠ m := fun he => absurd (congrArg Fin.val he) (by omega)
    rw [jwFamily_of_lt h, if_pos h, if_neg hne, mul_one]
  · have he : i = m := Fin.val_injective h
    subst he
    rw [jwFamily_self, if_neg (lt_irrefl _), if_pos rfl, one_mul]
  · have hne : i ≠ m := fun he => absurd (congrArg Fin.val he) (by omega)
    rw [jwFamily_of_gt h, if_neg (by omega : ¬ ((i : ℕ) < (m : ℕ))), if_neg hne, mul_one]

/-- 原文どおりの分解 `Z_m = (σ^x_1 ⋯ σ^x_{m-1}) σ^z_m`。 -/
theorem Z_eq_xString_mul (m : Fin M) : Z m = xString M (m : ℕ) * sigmaZ m :=
  jw_eq_xString_mul m pauliZ

/-- 原文どおりの分解 `Y_m = (σ^x_1 ⋯ σ^x_{m-1}) σ^y_m`。 -/
theorem Y_eq_xString_mul (m : Fin M) : Y m = xString M (m : ℕ) * sigmaY m :=
  jw_eq_xString_mul m pauliY

/-- 原文の `Z_1 = σ^z_1`（Lean の添字では `Z 0 = σ^z_0`）。
原文では場合分けで与えているが、`xString` の空積が `I` になるので自動的に従う。 -/
theorem Z_zero (h : 0 < M) : Z (⟨0, h⟩ : Fin M) = sigmaZ ⟨0, h⟩ := by
  rw [Z_eq_xString_mul]
  simp

/-- 原文の `Y_1 = σ^y_1`（Lean の添字では `Y 0 = σ^y_0`）。 -/
theorem Y_zero (h : 0 < M) : Y (⟨0, h⟩ : Fin M) = sigmaY ⟨0, h⟩ := by
  rw [Y_eq_xString_mul]
  simp

/-- 同じサイト `m` に載せた 2 つの Jordan–Wigner 文字列の積は、文字列部分が
`σ^x σ^x = I` で消えて、サイト `m` の 1 因子だけが残る。 -/
theorem jw_mul_jw_same (m : Fin M) (A B : Matrix (Fin 2) (Fin 2) ℂ) :
    siteProd M (jwFamily m A) * siteProd M (jwFamily m B) = siteOp m (A * B) := by
  rw [← siteProd_mul, siteOp_apply]
  congr 1
  funext i
  simp only [Pi.mul_apply, Function.update_apply, Pi.one_apply]
  rcases lt_trichotomy (i : ℕ) (m : ℕ) with h | h | h
  · have hne : i ≠ m := fun he => absurd (congrArg Fin.val he) (by omega)
    rw [jwFamily_of_lt h, jwFamily_of_lt h, pauliX_mul_pauliX, if_neg hne]
  · rw [Fin.val_injective h, jwFamily_self, jwFamily_self, if_pos rfl]
  · have hne : i ≠ m := fun he => absurd (congrArg Fin.val he) (by omega)
    rw [jwFamily_of_gt h, jwFamily_of_gt h, mul_one, if_neg hne]

/-- `Z_m Y_m = -√-1 σ^x_m`。原文の `ε` の表式（下記 `epsilon` の docstring 参照）の要。 -/
theorem Z_mul_Y_same (m : Fin M) : Z m * Y m = (-Complex.I) • sigmaX m := by
  rw [Z, Y, jw_mul_jw_same, pauliZ_mul_pauliY, map_smul, sigmaX]

/-- `σ^x_m = √-1 Z_m Y_m`（上の言い換え）。 -/
theorem sigmaX_eq_smul_Z_mul_Y (m : Fin M) : sigmaX m = Complex.I • (Z m * Y m) := by
  rw [Z_mul_Y_same, smul_smul, mul_neg, Complex.I_mul_I, neg_neg, one_smul]

/-- 原文の `ε := σ^x_1 ⋯ σ^x_M`。

原文はさらに `ε = (√-1)^M Z_1 Y_1 + ⋯ + Z_M Y_M` と書いているが、これは
**和ではなく積**でなければならない（ファイル冒頭の「原文の記述に対する疑義」参照）。
積であることの根拠は `sigmaX_eq_smul_Z_mul_Y`（`σ^x_m = √-1 Z_m Y_m`）と
`xString_succ_eq`（文字列を 1 因子ずつ `√-1 Z_m Y_m` で伸ばせる）である。 -/
noncomputable def epsilon (M : ℕ) : TensorPow M := xString M M

theorem epsilon_mul_self : epsilon M * epsilon M = 1 := xString_mul_self M

/-- `ε` の積表示の再帰形: `P_{m+1} = P_m · (√-1 Z_m Y_m)`。

これを `m = 0, …, M-1` と重ねれば `ε = P_M = (√-1)^M Z_1 Y_1 ⋯ Z_M Y_M`（**積**）になる。
原文の `+`（和）では成り立たない。 -/
theorem xString_succ_eq (m : ℕ) (h : m < M) :
    xString M (m + 1) = xString M m * (Complex.I • (Z (⟨m, h⟩ : Fin M) * Y ⟨m, h⟩)) := by
  rw [xString_succ m h, sigmaX_eq_smul_Z_mul_Y]

end JordanWigner

end Ising2D
