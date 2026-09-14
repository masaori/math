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
本ファイルでは `ε := σ^x_1 ⋯ σ^x_M`（左辺）を定義とし、積の形の等式を
`epsilon_eq_i_pow_smul_zyPrefixProduct` で形式化する。
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
  calc
    -- 本文: 二つの Pauli 行列を成分表示へ展開する。
    pauliZ * pauliY =
        !![1, 0; 0, -1] * !![0, -Complex.I; Complex.I, 0] := rfl
    -- 本文: `2×2` 行列積を成分ごとに計算する。
    _ = !![0, -Complex.I; -Complex.I, 0] := by
      ext i j
      fin_cases i <;> fin_cases j <;>
        simp [Matrix.mul_apply, Fin.sum_univ_two]
    -- 本文: 各成分から共通因子 `-i` を取り出す。
    _ = (-Complex.I) • !![0, 1; 1, 0] := by
      ext i j
      fin_cases i <;> fin_cases j <;> simp
    -- 本文: 残った行列を `σˣ` の定義へ戻す。
    _ = (-Complex.I) • pauliX := rfl

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
theorem Z_eq_xString_mul (m : Fin M) : Z m = xString M (m : ℕ) * sigmaZ m := by
  calc
    -- 本文: `Z_m` の定義を、接頭文字列とサイト行列の積へ書き換える。
    Z m = siteProd M (jwFamily m pauliZ) := rfl
    -- 本文: 各因子を、接頭文字列の因子とサイト行列の因子との積へ分ける。
    _ = siteProd M ((fun i : Fin M => if (i : ℕ) < (m : ℕ) then pauliX else 1) *
        Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) m pauliZ) := by
      congr 1
      funext i
      simp only [Pi.mul_apply, Function.update_apply, Pi.one_apply]
      rcases lt_trichotomy (i : ℕ) (m : ℕ) with h | h | h
      · have hne : i ≠ m := fun he => absurd (congrArg Fin.val he) (by omega)
        rw [jwFamily_of_lt h, if_pos h, if_neg hne, mul_one]
      · have he : i = m := Fin.val_injective h
        subst i
        rw [jwFamily_self, if_neg (lt_irrefl _), if_pos rfl, one_mul]
      · have hne : i ≠ m := fun he => absurd (congrArg Fin.val he) (by omega)
        rw [jwFamily_of_gt h, if_neg (by omega), if_neg hne, mul_one]
    -- 本文: クロネッカー積の積の規則を逆向きに適用する。
    _ = siteProd M (fun i : Fin M => if (i : ℕ) < (m : ℕ) then pauliX else 1) *
        siteProd M (Function.update 1 m pauliZ) := siteProd_mul M _ _
    -- 本文: 前半を `P_{m-1}`、後半をサイト行列 `σ_m^z` へ戻す。
    _ = xString M (m : ℕ) * siteOp m pauliZ := by rw [xString, siteOp_apply]
    -- 本文: サイト行列を `σ_m^z` の定義へ戻す。
    _ = xString M (m : ℕ) * sigmaZ m := rfl

/-- 原文どおりの分解 `Y_m = (σ^x_1 ⋯ σ^x_{m-1}) σ^y_m`。 -/
theorem Y_eq_xString_mul (m : Fin M) : Y m = xString M (m : ℕ) * sigmaY m := by
  calc
    -- 本文: `Y_m` の定義を、接頭文字列とサイト行列の積へ書き換える。
    Y m = siteProd M (jwFamily m pauliY) := rfl
    -- 本文: 各因子を、接頭文字列の因子とサイト行列の因子との積へ分ける。
    _ = siteProd M ((fun i : Fin M => if (i : ℕ) < (m : ℕ) then pauliX else 1) *
        Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) m pauliY) := by
      congr 1
      funext i
      simp only [Pi.mul_apply, Function.update_apply, Pi.one_apply]
      rcases lt_trichotomy (i : ℕ) (m : ℕ) with h | h | h
      · have hne : i ≠ m := fun he => absurd (congrArg Fin.val he) (by omega)
        rw [jwFamily_of_lt h, if_pos h, if_neg hne, mul_one]
      · have he : i = m := Fin.val_injective h
        subst i
        rw [jwFamily_self, if_neg (lt_irrefl _), if_pos rfl, one_mul]
      · have hne : i ≠ m := fun he => absurd (congrArg Fin.val he) (by omega)
        rw [jwFamily_of_gt h, if_neg (by omega), if_neg hne, mul_one]
    -- 本文: クロネッカー積の積の規則を逆向きに適用する。
    _ = siteProd M (fun i : Fin M => if (i : ℕ) < (m : ℕ) then pauliX else 1) *
        siteProd M (Function.update 1 m pauliY) := siteProd_mul M _ _
    -- 本文: 前半を `P_{m-1}`、後半をサイト行列 `σ_m^y` へ戻す。
    _ = xString M (m : ℕ) * siteOp m pauliY := by rw [xString, siteOp_apply]
    -- 本文: サイト行列を `σ_m^y` の定義へ戻す。
    _ = xString M (m : ℕ) * sigmaY m := rfl

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
  calc
    -- 本文: 直前に得た `Z_m,Y_m` のクロネッカー積表示を積へ代入する。
    Z m * Y m = siteProd M (jwFamily m pauliZ) * siteProd M (jwFamily m pauliY) := rfl
    -- 本文: クロネッカー積の積を因子ごとの積へ移す。
    _ = siteProd M (jwFamily m pauliZ * jwFamily m pauliY) :=
      (siteProd_mul M (jwFamily m pauliZ) (jwFamily m pauliY)).symm
    _ = siteProd M (fun i =>
        if (i : ℕ) < (m : ℕ) then pauliX * pauliX
        else if i = m then pauliZ * pauliY else 1 * 1) := by
      congr 1
      funext i
      simp only [Pi.mul_apply]
      rcases lt_trichotomy (i : ℕ) (m : ℕ) with h | h | h
      · have hne : i ≠ m := fun he => absurd (congrArg Fin.val he) (by omega)
        rw [jwFamily_of_lt h, jwFamily_of_lt h, if_pos h]
      · have he : i = m := Fin.val_injective h
        rw [he, jwFamily_self, jwFamily_self, if_neg (by omega), if_pos rfl]
      · have hne : i ≠ m := fun he => absurd (congrArg Fin.val he) (by omega)
        rw [jwFamily_of_gt h, jwFamily_of_gt h, if_neg (by omega), if_neg hne]
    -- 本文: 先頭の各因子へ `(σˣ)²=I` を適用する。
    _ = siteProd M (fun i =>
        if (i : ℕ) < (m : ℕ) then 1
        else if i = m then pauliZ * pauliY else 1 * 1) := by
      congr 1
      funext i
      by_cases h : (i : ℕ) < (m : ℕ) <;> simp [h]
    -- 本文: 末尾の各因子へ `II=I` を適用する。
    _ = siteProd M (fun i =>
        if (i : ℕ) < (m : ℕ) then 1
        else if i = m then pauliZ * pauliY else 1) := by
      congr 1
      funext i
      simp
    _ = siteOp m (pauliZ * pauliY) := by
      rw [siteOp_apply]
      congr 1
      funext i
      by_cases he : i = m
      · subst i
        simp
      · have hlt_or_gt : (i : ℕ) < (m : ℕ) ∨ (m : ℕ) < (i : ℕ) := by omega
        rcases hlt_or_gt with hlt | hgt
        · simp [hlt, he]
        · simp [he]
    -- 本文: 一サイトの積 `σᶻσʸ=-iσˣ` を代入する。
    _ = siteOp m ((-Complex.I) • pauliX) := by rw [pauliZ_mul_pauliY]
    -- 本文: 一因子の複素スカラーをクロネッカー積の外へ出す。
    _ = (-Complex.I) • siteOp m pauliX := by rw [map_smul]
    -- 本文: サイト行列 `σ_m^x` の定義へ戻す。
    _ = (-Complex.I) • sigmaX m := rfl

/-- `σ^x_m = √-1 Z_m Y_m`（上の言い換え）。 -/
theorem sigmaX_eq_smul_Z_mul_Y (m : Fin M) : sigmaX m = Complex.I • (Z m * Y m) := by
  rw [Z_mul_Y_same, smul_smul, mul_neg, Complex.I_mul_I, neg_neg, one_smul]

/-- サイト作用素を左から順に掛けた接頭積。本文の有限帰納法で扱う左辺をそのまま表す。 -/
noncomputable def sigmaXPrefixProduct (M : ℕ) : ℕ → TensorPow M
  | 0 => 1
  | m + 1 => sigmaXPrefixProduct M m * if h : m < M then sigmaX ⟨m, h⟩ else 1

/-- 原文の `ε := σ^x_1 ⋯ σ^x_M`。

定義をサイト作用素の左からの接頭積そのものにすることで、下の有限帰納法が
`ε` の積表示を各因子のクロネッカー積へ変換する本文の段と一対一に対応する。

原文はさらに `ε = (√-1)^M Z_1 Y_1 + ⋯ + Z_M Y_M` と書いているが、これは
**和ではなく積**でなければならない（ファイル冒頭の「原文の記述に対する疑義」参照）。
積であることの根拠は `sigmaX_eq_smul_Z_mul_Y`（`σ^x_m = √-1 Z_m Y_m`）と
`xString_succ_eq`（文字列を 1 因子ずつ `√-1 Z_m Y_m` で伸ばせる）である。 -/
noncomputable def epsilon (M : ℕ) : TensorPow M := sigmaXPrefixProduct M M

/-- 本文の有限帰納法に対応し、サイト作用素の接頭積を各因子のクロネッカー積へ直す。 -/
theorem sigmaXPrefixProduct_eq_xString (m : ℕ) (hm : m ≤ M) :
    sigmaXPrefixProduct M m = xString M m := by
  induction m with
  | zero =>
      calc
        -- 本文第一帰納法の初項: `P_0` は空積なので単位行列である。
        sigmaXPrefixProduct M 0 = 1 := rfl
        -- 本文: 単位行列を全因子が `I` のクロネッカー積へ直す。
        _ = siteProd M (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) := (siteProd_one M).symm
        _ = siteProd M (fun i => if (i : ℕ) < 0 then pauliX else 1) := by
          apply congrArg (siteProd M)
          funext i
          simp
        _ = xString M 0 := rfl
  | succ m ih =>
      have hlt : m < M := Nat.lt_of_succ_le hm
      calc
        -- 本文第一帰納法: `P_{m+1}=P_m σ_{m+1}^x`。
        sigmaXPrefixProduct M (m + 1) =
            sigmaXPrefixProduct M m * sigmaX ⟨m, hlt⟩ := by
          rw [sigmaXPrefixProduct, dif_pos hlt]
        -- 本文: 帰納法の仮定を代入する。
        _ = xString M m * sigmaX ⟨m, hlt⟩ := by
          rw [ih (Nat.le_of_lt hlt)]
        -- 本文: 接頭積とサイト行列をそれぞれクロネッカー積へ展開する。
        _ = siteProd M (fun i => if (i : ℕ) < m then pauliX else 1) *
            siteProd M (Function.update 1 (⟨m, hlt⟩ : Fin M) pauliX) := by
          rw [xString, sigmaX, siteOp_apply]
        -- 本文: クロネッカー積の積を因子ごとの積へ移す。
        _ = siteProd M ((fun i : Fin M => if (i : ℕ) < m then pauliX else 1) *
            (Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ)
              (⟨m, hlt⟩ : Fin M) pauliX)) :=
          (siteProd_mul M _ _).symm
        -- 本文: `σˣI=Iσˣ=σˣ` と `II=I` を各因子へ適用する。
        _ = siteProd M (fun i => if (i : ℕ) < m + 1 then pauliX else 1) := by
          congr 1
          funext i
          simp only [Pi.mul_apply, Function.update_apply, Pi.one_apply]
          rcases lt_trichotomy (i : ℕ) m with hi | hi | hi
          · have hne : i ≠ (⟨m, hlt⟩ : Fin M) :=
              Fin.ne_of_val_ne (show (i : ℕ) ≠ m by omega)
            rw [if_pos hi, if_neg hne, mul_one, if_pos (by omega)]
          · have he : i = (⟨m, hlt⟩ : Fin M) := Fin.val_injective hi
            rw [if_neg (by omega), if_pos he, one_mul, if_pos (by omega)]
          · have hne : i ≠ (⟨m, hlt⟩ : Fin M) :=
              Fin.ne_of_val_ne (show (i : ℕ) ≠ m by omega)
            rw [if_neg (by omega), if_neg hne, mul_one, if_neg (by omega)]
        _ = xString M (m + 1) := rfl

/-- 本文の有限帰納法の終端: `ε` は全因子が `σˣ` のクロネッカー積である。 -/
theorem epsilon_eq_siteProd_pauliX_by_induction :
    epsilon M = siteProd M (fun _ => pauliX) := by
  calc
    epsilon M = sigmaXPrefixProduct M M := rfl
    _ = xString M M := sigmaXPrefixProduct_eq_xString (M := M) M (Nat.le_refl M)
    _ = siteProd M (fun _ => pauliX) := by
      rw [xString]
      congr 1
      funext i
      rw [if_pos i.isLt]

/-- **`<epsilon_square_identity>` の人手証明と一対一に対応する具体版**:
有限帰納法でサイト積を全 `σˣ` 因子へ直し、クロネッカー積の積、`(σˣ)²=I₂`、
単位因子のクロネッカー積を順に適用する。 -/
theorem epsilon_mul_self : epsilon M * epsilon M = 1 := by
  rw [epsilon_eq_siteProd_pauliX_by_induction, ← siteProd_mul]
  have h : (fun _ : Fin M => pauliX) * (fun _ : Fin M => pauliX) = 1 := by
    funext i
    simp [Pi.mul_apply]
  rw [h, siteProd_one]

/-- `ε` の積表示の再帰形: `P_{m+1} = P_m · (√-1 Z_m Y_m)`。

これを `m = 0, …, M-1` と重ねれば `ε = P_M = (√-1)^M Z_1 Y_1 ⋯ Z_M Y_M`（**積**）になる。
原文の `+`（和）では成り立たない。 -/
theorem xString_succ_eq (m : ℕ) (h : m < M) :
    xString M (m + 1) = xString M m * (Complex.I • (Z (⟨m, h⟩ : Fin M) * Y ⟨m, h⟩)) := by
  rw [xString_succ m h, sigmaX_eq_smul_Z_mul_Y]

/-- `Z_0Y_0,\ldots,Z_{m-1}Y_{m-1}` を添字順に左から掛けた接頭積。
本文の `Q_m` に対応する。 -/
noncomputable def zyPrefixProduct (M : ℕ) : ℕ → TensorPow M
  | 0 => 1
  | m + 1 => zyPrefixProduct M m *
      if h : m < M then Z (⟨m, h⟩ : Fin M) * Y ⟨m, h⟩ else 1

/-- **`<global_spin_flip_jordan_wigner_representation>` の第二の有限帰納法に対応する具体版**:
本文と同じ向きの `Q_m=(-√-1)^mP_m` を、局所積
`Z_mY_m=-√-1 σ^x_m` から空積・帰納段の順に示す。 -/
theorem zyPrefixProduct_eq_neg_i_pow_smul_xString (m : ℕ) (hm : m ≤ M) :
    zyPrefixProduct M m = (-Complex.I) ^ m • xString M m := by
  induction m with
  | zero =>
      calc
        -- 本文第二帰納法の初項: `Q_0` は空積なので単位行列である。
        zyPrefixProduct M 0 = 1 := rfl
        -- 本文: `(-i)^0=1`。
        _ = (-Complex.I) ^ 0 • (1 : TensorPow M) := by simp
        -- 本文: `P_0` の定義を代入する。
        _ = (-Complex.I) ^ 0 • xString M 0 := by rw [xString_zero]
  | succ m ih =>
      have hlt : m < M := Nat.lt_of_succ_le hm
      calc
        -- 本文第二帰納法: `Q_{m+1}=Q_m(Z_{m+1}Y_{m+1})`。
        zyPrefixProduct M (m + 1) =
            zyPrefixProduct M m * (Z ⟨m, hlt⟩ * Y ⟨m, hlt⟩) := by
          rw [zyPrefixProduct, dif_pos hlt]
        -- 本文: 帰納法の仮定を代入する。
        _ = ((-Complex.I) ^ m • xString M m) *
            (Z ⟨m, hlt⟩ * Y ⟨m, hlt⟩) := by
          rw [ih (Nat.le_of_lt hlt)]
        -- 本文: 局所積 `Z_{m+1}Y_{m+1}=-iσ_{m+1}^x` を代入する。
        _ = ((-Complex.I) ^ m • xString M m) *
            ((-Complex.I) • sigmaX ⟨m, hlt⟩) := by
          rw [Z_mul_Y_same]
        -- 本文: 左のスカラー作用を行列積の外へ出す。
        _ = (-Complex.I) ^ m •
            (xString M m * ((-Complex.I) • sigmaX ⟨m, hlt⟩)) := by
          rw [Matrix.smul_mul]
        -- 本文: 右因子のスカラー作用を内側の積の外へ出す。
        _ = (-Complex.I) ^ m •
            ((-Complex.I) • (xString M m * sigmaX ⟨m, hlt⟩)) := by
          rw [Matrix.mul_smul]
        -- 本文: 二つのスカラー作用を合成する。
        _ = (((-Complex.I) ^ m * (-Complex.I)) •
            (xString M m * sigmaX ⟨m, hlt⟩)) := by
          rw [smul_smul]
        -- 本文: `(-i)` の冪の再帰を適用する。
        _ = (-Complex.I) ^ (m + 1) •
            (xString M m * sigmaX ⟨m, hlt⟩) := by rw [pow_succ]
        -- 本文: `P_{m+1}` の定義を代入する。
        _ = (-Complex.I) ^ (m + 1) • xString M (m + 1) := by
          rw [xString_succ m hlt]

/-- 全スピン反転行列の Jordan--Wigner 表示（原文の右辺は和でなく積）。 -/
theorem epsilon_eq_i_pow_smul_zyPrefixProduct :
    epsilon M = Complex.I ^ M • zyPrefixProduct M M := by
  calc
    -- 本文終端: 全スピン反転行列の定義を接頭積 `P_M` へ直す。
    epsilon M = sigmaXPrefixProduct M M := rfl
    _ = xString M M := sigmaXPrefixProduct_eq_xString (M := M) M (Nat.le_refl M)
    -- 本文: `P_M=1^MP_M`。
    _ = (1 : ℂ) ^ M • xString M M := by simp
    -- 本文: `i(-i)=1` を底へ代入する。
    _ = (Complex.I * (-Complex.I)) ^ M • xString M M := by
      rw [mul_neg, Complex.I_mul_I, neg_neg]
    -- 本文: 積の冪を二つの冪の積へ分ける。
    _ = (Complex.I ^ M * (-Complex.I) ^ M) • xString M M := by rw [mul_pow]
    -- 本文: スカラー作用の合成として `i^M` を外側へ出す。
    _ = Complex.I ^ M • ((-Complex.I) ^ M • xString M M) := by rw [mul_smul]
    -- 本文: 第二帰納法の終端 `Q_M=(-i)^MP_M` を代入する。
    _ = Complex.I ^ M • zyPrefixProduct M M := by
      rw [zyPrefixProduct_eq_neg_i_pow_smul_xString (M := M) M (Nat.le_refl M)]

end JordanWigner

end Ising2D
