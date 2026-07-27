/-
# 具体版: `B_1(θ), B_2` の定義（`θ ∈ ℝ` 一般）

対応する人手証明のラベル: **`def_B1_theta_B2`**
（`structured-latex/content/014_even_sector_T_action.ts` の
`evensectorT_007_definition_B1_B2`）

**抽象版**は `Ising2D/Abstract/TVAction.lean` の `Ising2D.Abstract.twoDimConjMat`
（`!![cosh s, β sinhc s; α sinhc s, cosh s]`）。原文の `B_1(θ), B_2` が
その特殊化であることは `Ising2D.B1mat_eq_twoDimConjMat` / `B2mat_eq_twoDimConjMat`
（`Part008/Claim012_TVActions.lean`）で既に証明されている。

## 原文の定義と Lean の既存定義

原文は 008 章では `B_1, B_2` を `θ_μ`（`μ ∈ 𝓜`）に限って導入しており、
本章でそれを `θ ∈ ℝ` 一般へ広げ直している。

**Lean 側の既存定義 `Ising2D.B1mat` / `Ising2D.B2mat`
（`Part008/Definition016_TV.lean`）は最初から `θ : ℂ` 一般で定義されているので、
本章の `def_B1_theta_B2` はその `θ = (θ : ℝ) : ℂ` への制限そのものである。**
新しい定義は要らない。本ファイルでは、原文の行列成分と `B1mat` / `B2mat` の成分が
一致することを明示するだけにする（原文との突き合わせ）。
-/
import Ising2D.Part008.Definition016_TV

namespace Ising2D

/-! ## `B_1(θ)` の 4 成分（原文の行列そのもの） -/

@[simp] theorem B1mat_zero_zero (K1 θ : ℂ) : B1mat K1 θ 0 0 = Complex.cosh K1 := rfl

@[simp] theorem B1mat_zero_one (K1 θ : ℂ) :
    B1mat K1 θ 0 1 = -Complex.I * Complex.exp (θ * Complex.I) * Complex.sinh K1 := rfl

@[simp] theorem B1mat_one_zero (K1 θ : ℂ) :
    B1mat K1 θ 1 0 = Complex.I * Complex.exp (-θ * Complex.I) * Complex.sinh K1 := rfl

@[simp] theorem B1mat_one_one (K1 θ : ℂ) : B1mat K1 θ 1 1 = Complex.cosh K1 := rfl

/-! ## `B_2` の 4 成分 -/

@[simp] theorem B2mat_zero_zero (K2star : ℂ) :
    B2mat K2star 0 0 = Complex.cosh (2 * K2star) := rfl

@[simp] theorem B2mat_zero_one (K2star : ℂ) :
    B2mat K2star 0 1 = Complex.I * Complex.sinh (2 * K2star) := rfl

@[simp] theorem B2mat_one_zero (K2star : ℂ) :
    B2mat K2star 1 0 = -Complex.I * Complex.sinh (2 * K2star) := rfl

@[simp] theorem B2mat_one_one (K2star : ℂ) :
    B2mat K2star 1 1 = Complex.cosh (2 * K2star) := rfl

end Ising2D
