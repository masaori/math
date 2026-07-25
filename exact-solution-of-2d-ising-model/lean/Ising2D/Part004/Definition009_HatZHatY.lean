/-
# `hat(Z)`, `hat(Y)` の定義（離散フーリエ変換）

対応する人手証明:
`parts/004_転送行列/009_definition_Zhat_Yhatの定義.typ` (`<def_hatZ_hatY>`)

原文の定義（`ℳ := {-M, …, -1, 1, …, M}`、`μ ∈ ℳ`）:

  `hat(Z)_μ^{(±)} := ∑_{j=1}^{M} (∓1 if j = 1 else 1) Z_j exp(-√-1 · 2π j μ / M)`
  `hat(Y)_μ      := ∑_{j=1}^{M} Y_j exp(-√-1 · 2π j μ / M)`

すなわち `hat(Z)^{(-)}` は全 `j` で重み `+1` の一様和、`hat(Z)^{(+)}` は `j = 1` の項だけ
符号が反転する（`<recover_Z_Y_from_hatZ_hatY>` の冒頭でも「`hat(Z)^{(-)}` は uniform」と
明記されている）。

## 形式化の方針

* 添字 `μ` は `ℤ` のまま扱う（原文の `ℳ` は `ℤ` の部分集合であり、定義式自体は
  すべての `μ ∈ ℤ` で意味を持つ。`M` 周期性は `Claim012_HatPeriodicity.lean` で述べる）。
* サイトの添字は Lean では `Fin M`（`0, …, M-1`）で、原文の `j` は `(j : ℕ) + 1`。
  したがって位相因子は `expPhase M (((j : ℕ) + 1) * μ)`、
  原文の「`j = 1` の項」は Lean の `(j : ℕ) = 0` の項である。
* `(±)` の符号は、原文の `∓1`（`j = 1` の係数）を引数 `η : ℂ` として持たせる
  （`hatZ M η μ`）。`hat(Z)^{(+)}` は `η = -1`、`hat(Z)^{(-)}` は `η = 1`。
  以降の反交換関係で本質的に効くのは `η^2 = 1` だけである。
-/
import Ising2D.Part004.Claim008_ExpSum
import Ising2D.Part006.Claim000_AnticommutatorZY

namespace Ising2D

variable {M : ℕ}

/-- 原文の係数 `(∓1 if j = 1 else 1)`。`η` が原文の `∓1` にあたる。
Lean の添字は 0 始まりなので、原文の `j = 1` は `(j : ℕ) = 0`。 -/
def firstSign (η : ℂ) (j : Fin M) : ℂ := if (j : ℕ) = 0 then η else 1

@[simp]
theorem firstSign_of_val_eq_zero {η : ℂ} {j : Fin M} (h : (j : ℕ) = 0) :
    firstSign η j = η := by simp [firstSign, h]

@[simp]
theorem firstSign_of_val_ne_zero {η : ℂ} {j : Fin M} (h : (j : ℕ) ≠ 0) :
    firstSign η j = 1 := by simp [firstSign, h]

theorem firstSign_one (j : Fin M) : firstSign 1 j = 1 := by
  rw [firstSign]; split <;> rfl

/-- **原文の `hat(Z)_μ^{(±)}`**（`η` が原文の `∓1`、すなわち `j = 1` の項の係数）。 -/
noncomputable def hatZ (M : ℕ) (η : ℂ) (μ : ℤ) : TensorPow M :=
  ∑ j : Fin M, (firstSign η j * expPhase M (((j : ℕ) + 1 : ℤ) * μ)) • Z j

/-- **原文の `hat(Y)_μ`**。 -/
noncomputable def hatY (M : ℕ) (μ : ℤ) : TensorPow M :=
  ∑ j : Fin M, expPhase M (((j : ℕ) + 1 : ℤ) * μ) • Y j

/-- 原文の `hat(Z)_μ^{(+)}`（`j = 1` の係数が `-1`）。 -/
noncomputable abbrev hatZPlus (M : ℕ) (μ : ℤ) : TensorPow M := hatZ M (-1) μ

/-- 原文の `hat(Z)_μ^{(-)}`（全 `j` で係数 `+1`、すなわち一様和）。 -/
noncomputable abbrev hatZMinus (M : ℕ) (μ : ℤ) : TensorPow M := hatZ M 1 μ

theorem hatZPlus_def (M : ℕ) (μ : ℤ) : hatZPlus M μ = hatZ M (-1) μ := rfl

theorem hatZMinus_def (M : ℕ) (μ : ℤ) : hatZMinus M μ = hatZ M 1 μ := rfl

/-- **`hat(Z)^{(-)}` は一様和**（`<recover_Z_Y_from_hatZ_hatY>` 冒頭の注記）:
`hat(Z)_μ^{(-)} = ∑_{j=1}^M Z_j exp(-√-1 · 2π j μ / M)`。 -/
theorem hatZMinus_eq (M : ℕ) (μ : ℤ) :
    hatZMinus M μ = ∑ j : Fin M, expPhase M (((j : ℕ) + 1 : ℤ) * μ) • Z j := by
  rw [hatZMinus_def, hatZ]
  exact Finset.sum_congr rfl fun j _ => by rw [firstSign_one, one_mul]

/-- **`(+)` と `(-)` の差は `j = 1` の項の符号だけ**（原文の場合分けの意味を確認する形）:
`hat(Z)_μ^{(+)} = hat(Z)_μ^{(-)} - 2 exp(-√-1 · 2πμ/M) Z_1`。 -/
theorem hatZPlus_eq_hatZMinus_sub (hM : M ≠ 0) (μ : ℤ) :
    hatZPlus M μ =
      hatZMinus M μ - (2 * expPhase M μ) • Z (⟨0, Nat.pos_of_ne_zero hM⟩ : Fin M) := by
  set z : Fin M := ⟨0, Nat.pos_of_ne_zero hM⟩ with hz
  have hzval : (z : ℕ) = 0 := rfl
  have hsub : hatZMinus M μ - hatZPlus M μ = (2 * expPhase M μ) • Z z := by
    rw [hatZMinus_eq, hatZPlus_def, hatZ, ← Finset.sum_sub_distrib,
      Finset.sum_eq_single_of_mem z (Finset.mem_univ z)]
    · have h0 : (((z : ℕ) : ℤ) + 1) * μ = μ := by rw [hzval]; push_cast; ring
      rw [h0, firstSign_of_val_eq_zero hzval, ← sub_smul]
      congr 1
      ring
    · intro j _ hj
      have hjv : (j : ℕ) ≠ 0 := fun h => hj (Fin.val_injective (by rw [h, hzval]))
      rw [firstSign_of_val_ne_zero hjv, one_mul, sub_self]
  rw [eq_sub_iff_add_eq, ← hsub]
  abel

end Ising2D
