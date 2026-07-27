/-
# `!![g, a; -b, g]` 型の 2×2 行列の固有値・固有ベクトル・対角化（**抽象版**）

対応する人手証明のラベル: `eigenvector_of_A_theta_tilde`, `diagonalization_check_P_D`
（`structured-latex/content/015_A_theta_tilde_diagonalization.ts` の
`Athetatilde_004_claim_eigenvector`, `Athetatilde_005_claim_diagonalization`）

具体版: `Ising2D/Part015/Claim004_EigenATildeDiag.lean`
（既存の `Ising2D/Part008/Claim027_EigenATheta.lean` の `AMat_mulVec_eigen` 等も同じ主張の具体版）。

## この主張に本質的に効いている構造は何か（具体版が過剰な構造を要求していないかの検査）

人手証明は `A(θ~_μ) = !![γ_1, γ_2(θ~); -γ_2(-θ~), γ_1]` について
特性多項式 `λ^2 - 2γ_1λ + (γ_1^2 + γ_2γ_2(-θ))` の因数分解と、
固有ベクトル `(∓|γ_2|, γ_2(-θ~))` の直接代入を行う。ここに効いているのは

* **行列が `!![g, a; -b, g]` の形（対角成分が等しい）であること**
* **`s^2 = -(a b)` を満たす `s` が係数環に取れること**

の 2 つだけである。**係数は任意の可換環でよい。** 複素数であることも、`γ_1` が実数であることも、
`γ_2` の具体形も、`θ` が半整数運動量であることも、`|γ_2|` が絶対値であることも効いていない。
人手証明が `√(-γ_2γ_2(-θ))` として導入する量は、ここでは「2 乗が `-(ab)` になる元 `s`」
という仮定だけに退化する（分岐の選択は `s` と `-s` の交換にすぎない）。

対角化 `A = P D P⁻¹` については、可逆性（`det P` が単元であること）が別途要る。
これは人手証明が確認していない点であり（`Part008/Claim027_EigenATheta.lean` 冒頭を参照）、
抽象版では `Invertible` 仮定として明示される。
-/
import Mathlib.LinearAlgebra.Matrix.Notation
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.FinCases

namespace Ising2D.Abstract

open Matrix

variable {R : Type*} [CommRing R]

/-- `!![g, a; -b, g]` の特性多項式。**任意の可換環**で成り立つ。 -/
theorem skew2_charPoly (g a b lam : R) :
    (!![g, a; -b, g] - lam • (1 : Matrix (Fin 2) (Fin 2) R)).det
      = lam ^ 2 - 2 * g * lam + (g ^ 2 + a * b) := by
  rw [Matrix.det_fin_two]
  simp
  ring

/-- 特性多項式の因数分解 `= (λ - (g+s))(λ - (g-s))`（`s^2 = -(a b)`）。 -/
theorem skew2_charPoly_factor (g a b s lam : R) (hs : s ^ 2 = -(a * b)) :
    lam ^ 2 - 2 * g * lam + (g ^ 2 + a * b)
      = (lam - (g + s)) * (lam - (g - s)) := by
  linear_combination hs

/-- **抽象版の固有ベクトル**: `s^2 = -(a b)` なら `(-s, b)` は固有値 `g + s` の固有ベクトル。 -/
theorem skew2_mulVec (g a b s : R) (hs : s ^ 2 = -(a * b)) :
    !![g, a; -b, g] *ᵥ ![-s, b] = (g + s) • ![-s, b] := by
  funext i
  fin_cases i <;> simp [Matrix.mulVec, dotProduct] <;>
    first
      | linear_combination hs
      | ring

/-- 2 つの固有ベクトルを列に並べた行列 `Q`（`s` と `-s`）。 -/
theorem skew2_mul_col (g a b s : R) (hs : s ^ 2 = -(a * b)) :
    !![g, a; -b, g] * !![-s, s; b, b] = !![-s, s; b, b] * !![g + s, 0; 0, g - s] := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [Matrix.mul_apply, Fin.sum_univ_two] <;>
      first
        | linear_combination hs
        | linear_combination -hs
        | ring

/-- `det !![-s, s; b, b] = -2 s b`。 -/
theorem skew2_det_col (s b : R) : (!![-s, s; b, b]).det = -(2 * s * b) := by
  rw [Matrix.det_fin_two_of]; ring

/-- **抽象版の対角化**: `A P = P D` かつ `det P` が単元なら `A = P D P⁻¹`。
**この形は 2×2 であることすら使っていない**（任意の有限型の添字でよい）。 -/
theorem eq_conj_of_mul_eq {n : Type*} [DecidableEq n] [Fintype n]
    {A P D : Matrix n n R} (h : A * P = P * D) (hP : IsUnit P.det) :
    A = P * D * P⁻¹ := by
  rw [← h, Matrix.mul_nonsing_inv_cancel_right _ _ hP]

end Ising2D.Abstract
