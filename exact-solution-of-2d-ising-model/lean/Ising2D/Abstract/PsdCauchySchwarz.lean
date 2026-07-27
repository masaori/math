/-
# 半正定値対称双線型形式の Cauchy–Schwarz の不等式（抽象版）

対応する人手証明のラベル: **`psd_cauchy_schwarz`**
（`structured-latex/content/011_max_eigenvalue.ts` の `maxeig_005_claim_psd_cauchy_schwarz`）

具体版: `Ising2D.psd_cauchy_schwarz`
（`Ising2D/Part011/Claim005_PsdCauchySchwarz.lean`。本ファイルの系として導出している）

## この主張に本質的に効いている構造

人手証明は `P ∈ Mat(n, ℝ)` が対称かつ半正定値であることを仮定して
`(yᵀPx)² ≤ (xᵀPx)(yᵀPy)` を示すが、証明が実際に使っているのは次の 3 つだけである。

1. 係数が**順序体**であること（`t := -(yᵀPx)/(xᵀPx)` を代入するための割り算と、
   不等式の向きを保つ乗除）。
2. 形式が**双線型**であること（`q(t) = (y + t x)ᵀP(y + t x)` を展開するため）。
3. 形式が**対称**かつ**半正定値**であること。

行列であること・実数であること・有限次元であること・完備性・連続性・平方根は
一切効いていない。したがって主張は「順序体 `R` 上の任意の `R`-加群上の
対称半正定値双線型形式」で成り立つ（`Ising2D.Abstract.psd_cauchy_schwarz`）。
-/
import Mathlib.LinearAlgebra.BilinearMap
import Mathlib.Algebra.Order.Field.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith

namespace Ising2D.Abstract

variable {R V : Type*} [Field R] [LinearOrder R] [IsStrictOrderedRing R]
  [AddCommGroup V] [Module R V]

omit [LinearOrder R] [IsStrictOrderedRing R] in
/-- 双線型形式の `q(t) = B (y + t • x) (y + t • x)` の展開。

人手証明の「`P` が対称なので `yᵀPx = xᵀPy` であり、展開すると
`q(t) = (xᵀPx)t² + 2(yᵀPx)t + (yᵀPy)`」に対応する。 -/
theorem bilin_quadratic_expand (B : V →ₗ[R] V →ₗ[R] R)
    (hsymm : ∀ u v, B u v = B v u) (x y : V) (t : R) :
    B (y + t • x) (y + t • x)
      = (B x x) * t ^ 2 + 2 * (B y x) * t + (B y y) := by
  have h1 : B (y + t • x) = B y + t • B x := by
    rw [map_add, map_smul]
  rw [h1]
  simp only [LinearMap.add_apply, LinearMap.smul_apply, map_add, map_smul,
    smul_eq_mul]
  rw [hsymm x y]
  ring

/-- **半正定値対称双線型形式に対する Cauchy–Schwarz の不等式（抽象版）**。

順序体 `R` 上の `R`-加群 `V` と、対称かつ半正定値な双線型形式 `B` について
`(B y x)² ≤ (B x x)(B y y)`。

人手証明 `psd_cauchy_schwarz` の場合分け (i) `xᵀPx > 0` / (ii) `xᵀPx = 0` を
そのまま写している。 -/
theorem psd_cauchy_schwarz (B : V →ₗ[R] V →ₗ[R] R)
    (hsymm : ∀ u v, B u v = B v u) (hpsd : ∀ u, 0 ≤ B u u) (x y : V) :
    (B y x) ^ 2 ≤ (B x x) * (B y y) := by
  set a := B x x with ha
  set b := B y x with hb
  set c := B y y with hc
  -- `q(t) = a t² + 2 b t + c ≥ 0` がすべての `t` で成り立つ
  have hq : ∀ t : R, 0 ≤ a * t ^ 2 + 2 * b * t + c := by
    intro t
    have h := hpsd (y + t • x)
    rwa [bilin_quadratic_expand B hsymm x y t] at h
  have ha0 : 0 ≤ a := hpsd x
  rcases eq_or_lt_of_le ha0 with h | hapos
  · -- (ii) `a = 0` のとき。1 次の係数 `b` は `0` でなければならない。
    have ha' : a = 0 := h.symm
    have hb0 : b = 0 := by
      by_contra hbne
      have := hq (-(c + 1) / (2 * b))
      rw [ha'] at this
      have h2b : (2 : R) * b ≠ 0 := by
        simpa using mul_ne_zero (two_ne_zero) hbne
      have : (0 : R) ≤ -1 := by
        have hcalc : (0 : R) * (-(c + 1) / (2 * b)) ^ 2
            + 2 * b * (-(c + 1) / (2 * b)) + c = -1 := by
          field_simp
          ring
        rwa [hcalc] at this
      linarith
    rw [ha', hb0]
    simp
  · -- (i) `a > 0` のとき。`t := -b/a` を代入する。
    have h := hq (-b / a)
    have hcalc : a * (-b / a) ^ 2 + 2 * b * (-b / a) + c = c - b ^ 2 / a := by
      field_simp
      ring
    rw [hcalc] at h
    have : b ^ 2 / a ≤ c := by linarith
    calc b ^ 2 = (b ^ 2 / a) * a := by field_simp
      _ ≤ c * a := by exact mul_le_mul_of_nonneg_right this (le_of_lt hapos)
      _ = a * c := by ring

end Ising2D.Abstract
