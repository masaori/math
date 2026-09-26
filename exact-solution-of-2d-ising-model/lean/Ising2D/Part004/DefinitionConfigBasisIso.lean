/-
# スピン配置から多重添字への写像 `ι`

対応する人手証明（正本は `structured-latex/content/004_transfer_matrix.ts`）:

* `bridge_001_definition_config_basis`（ラベル **`def_config_basis_iso`**）

人手の定義: `ι : 𝔐 → 𝓘 = {1,2}^{M_col}`, `ι(μ) := (i_1,…,i_{M_col})`,
`i_m := 1 (μ(m) = +1)`, `i_m := 2 (μ(m) = -1)`。

## Lean での表現

Lean 側の表現 `Ising2D.TensorPow M = Matrix (Conf M) (Conf M) ℂ`（`Ising2D/Basic.lean`）は
**添字型が `Conf M = Fin M → Fin 2` そのもの**であり、人手の多重添字の集合 `𝓘 = {1,2}^{M_col}` は
`Conf M` である（人手の `def_kronecker` が「`𝓘` の元 `I` を行番号・列番号 `ν(I)` と同一視して使う」と
定めていることの Lean 側の表現）。したがって `ι` は `𝔐 = SpinConf M`（`Part001/DefinitionRowConfigurations.lean`）
から `Conf M` への写像 `Ising2D.configBasisIso` として与える（成分ごとの写像 `SpinVal → Fin 2` の直積）。
`ι` が全単射であること（成分ごとに逆写像 `spinOfIdx` をもつこと）も合わせて `Equiv` として持つ。

対応は人手どおり
* `+1 ↦ 0`（Lean の `Fin 2` は 0 始まりなので、人手の `i_m = 1` が Lean の `0`）
* `-1 ↦ 1`（人手の `i_m = 2`）
であり、逆向きの読み替え（多重添字からスピン値へ）を `Ising2D.sgn` と書く。
-/
import Ising2D.Basic
import Ising2D.Part001.DefinitionRowConfigurations
import Mathlib.Tactic.Linarith

namespace Ising2D

/-! ## 多重添字の成分からスピン値への読み替え -/

/-- 多重添字（`Fin 2`）からスピン値への読み替え。人手の `i_m = 1 ↦ +1`, `i_m = 2 ↦ -1`
（Lean の `Fin 2` は 0 始まり）。 -/
def sgn : Fin 2 → ℝ := ![1, -1]

@[simp] theorem sgn_zero : sgn 0 = 1 := rfl
@[simp] theorem sgn_one : sgn 1 = -1 := rfl

theorem sgn_mem (i : Fin 2) : sgn i = 1 ∨ sgn i = -1 := by
  fin_cases i <;> simp

theorem sgn_ne_zero (i : Fin 2) : sgn i ≠ 0 := by
  rcases sgn_mem i with h | h <;> rw [h] <;> norm_num

theorem sgn_mul_self (i : Fin 2) : sgn i * sgn i = 1 := by
  fin_cases i <;> norm_num [sgn]

/-- `sgn` を ℂ の値として見たもの（行列の成分に使う）。 -/
noncomputable def sgnC (i : Fin 2) : ℂ := (sgn i : ℝ)

@[simp] theorem sgnC_zero : sgnC 0 = 1 := by simp [sgnC]
@[simp] theorem sgnC_one : sgnC 1 = -1 := by simp [sgnC]

/-- 人手の `σ^z = !![1, 0; 0, -1]` は `sgn` の対角行列である。 -/
theorem sgnC_eq_ite (i : Fin 2) : sgnC i = if i = 0 then 1 else -1 := by
  fin_cases i <;> simp

/-! ## 成分ごとの全単射 `SpinVal ≃ Fin 2` -/

/-- 人手の `+1 ↦ 1`, `-1 ↦ 2`（Lean では `+1 ↦ 0`, `-1 ↦ 1`）。 -/
noncomputable def idxOfSpin (s : SpinVal) : Fin 2 := if (s : ℝ) = 1 then 0 else 1

/-- 逆向き。 -/
def spinOfIdx (i : Fin 2) : SpinVal := ⟨sgn i, sgn_mem i⟩

@[simp] theorem coe_spinOfIdx (i : Fin 2) : ((spinOfIdx i : SpinVal) : ℝ) = sgn i := rfl

theorem sgn_idxOfSpin (s : SpinVal) : sgn (idxOfSpin s) = (s : ℝ) := by
  rcases s.2 with h | h
  · rw [idxOfSpin, if_pos h, sgn_zero, h]
  · rw [idxOfSpin, if_neg (by rw [h]; norm_num), sgn_one, h]

/-- **人手の成分ごとの全単射 `{-1,1} → {1,2}`。** -/
noncomputable def spinIdxEquiv : SpinVal ≃ Fin 2 where
  toFun := idxOfSpin
  invFun := spinOfIdx
  left_inv s := by
    apply Subtype.ext
    rw [coe_spinOfIdx, sgn_idxOfSpin]
  right_inv i := by
    fin_cases i <;> simp [idxOfSpin, spinOfIdx, sgn] <;> norm_num

/-! ## スピン配置と多重添字 -/

/-- **人手の `ι : 𝔐 → 𝓘`（`def_config_basis_iso`）。**

`Conf M = Fin M → Fin 2` が Lean 側の `𝓘 = {1,2}^M` であり、
これは `TensorPow M = Matrix (Conf M) (Conf M) ℂ` の添字型そのものなので、
「行・列の番号と `𝔐` の同一視」はこの全単射を取ることで完全に確定する。 -/
noncomputable def configBasisIso (M : ℕ) : SpinConf M ≃ Conf M :=
  Equiv.piCongrRight fun _ => spinIdxEquiv

@[simp]
theorem configBasisIso_apply {M : ℕ} (μ : SpinConf M) (m : Fin M) :
    configBasisIso M μ m = idxOfSpin (μ m) := rfl

/-- 人手の `ι` を通してスピン値を読み戻すと元に戻る: `sgn(ι(μ)(m)) = μ(m)`。 -/
@[simp]
theorem sgn_configBasisIso {M : ℕ} (μ : SpinConf M) (m : Fin M) :
    sgn (configBasisIso M μ m) = (μ m : ℝ) := by
  rw [configBasisIso_apply, sgn_idxOfSpin]

theorem sgnC_configBasisIso {M : ℕ} (μ : SpinConf M) (m : Fin M) :
    sgnC (configBasisIso M μ m) = ((μ m : ℝ) : ℂ) := by
  rw [sgnC, sgn_configBasisIso]

/-- 人手の「`ι` は全単射だから `ι(μ) = ι(μ') ⟺ μ = μ'`」。 -/
theorem configBasisIso_eq_iff {M : ℕ} (μ μ' : SpinConf M) :
    configBasisIso M μ = configBasisIso M μ' ↔ μ = μ' :=
  (configBasisIso M).apply_eq_iff_eq

/-! ## 標準基底 `f_I` -/

/-- 人手の `f_I = e_{i_1} ⊠ ⋯ ⊠ e_{i_M} ∈ 𝓕 = ℂ^{2^M}`。
`Conf M` を添字とする数ベクトル空間の標準基底ベクトルである
（クロネッカー積の成分の定義から、これがちょうど `e_{i_1} ⊠ ⋯ ⊠ e_{i_M}` にあたる）。 -/
noncomputable def basisVec {M : ℕ} (I : Conf M) : Conf M → ℂ := Pi.single I 1

end Ising2D
