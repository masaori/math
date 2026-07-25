/-
# 共役写像は環準同型

対応する人手証明:
`parts/000_計算公式/045_claim_共役写像は環準同型.typ`
(`<conjugation_is_ring_homomorphism>`)

原文: `n ∈ ℤ_{≥1}`、`B ∈ (Mat(n, ℂ))^×`（正則）について、
共役写像 `T_B : Mat(n,ℂ) → Mat(n,ℂ)`, `T_B(A) = B A B⁻¹` は

1. 乗法的: `T_B(A C) = T_B(A) T_B(C)`
2. 単位的: `T_B(I) = I`
3. 合成則: `T_A ∘ T_B = T_{A B}`

を満たす。原文はこれらを行列積の結合法則と `B B⁻¹ = B⁻¹ B = I` から直接示している。

本ファイルでは
* 一般の環 `R` とその可逆元 `B : Rˣ` に対して定式化し（行列環はその特別な場合）、
* 原文と同じ形（`Matrix n n ℂ` と `Matrix.inv` による `B⁻¹`）でも系として述べ、
* さらに mathlib の `ConjAct` 作用（`MulSemiringAction (ConjAct Rˣ) R`）と一致することを示して、
  加法性まで込めた「環準同型」であることを既存結果に接続する。
-/
import Mathlib.Algebra.Ring.Action.ConjAct
import Mathlib.Data.Complex.Basic
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse

namespace Ising2D.Conjugation

section Ring

variable {R : Type*} [Ring R]

/-- 共役写像 `T_B(A) = B A B⁻¹`（`B` は環 `R` の可逆元）。 -/
def T (B : Rˣ) (A : R) : R := (B : R) * A * ((B⁻¹ : Rˣ) : R)

@[simp]
theorem T_apply (B : Rˣ) (A : R) : T B A = (B : R) * A * ((B⁻¹ : Rˣ) : R) := rfl

/-- `T_B` は mathlib の共役作用 `ConjAct Rˣ ↷ R` そのものである。 -/
theorem T_eq_conjAct_smul (B : Rˣ) (A : R) : T B A = ConjAct.toConjAct B • A := rfl

/-- 共役写像を環準同型（実際には環自己同型）としてまとめたもの。
乗法性・単位性・加法性は mathlib の `MulSemiringAction (ConjAct Rˣ) R` から得られる。 -/
def TRingHom (B : Rˣ) : R →+* R :=
  MulSemiringAction.toRingHom (ConjAct Rˣ) R (ConjAct.toConjAct B)

@[simp]
theorem coe_TRingHom (B : Rˣ) : ⇑(TRingHom B) = T B := rfl

/-- **(1) 乗法的**: `T_B(A C) = T_B(A) T_B(C)`。 -/
theorem T_mul (B : Rˣ) (A C : R) : T B (A * C) = T B A * T B C :=
  map_mul (TRingHom B) A C

/-- **(2) 単位的**: `T_B(1) = 1`。 -/
theorem T_one (B : Rˣ) : T B (1 : R) = 1 :=
  map_one (TRingHom B)

/-- 加法性（原文は明示していないが、「環準同型」であるために必要）。 -/
theorem T_add (B : Rˣ) (A C : R) : T B (A + C) = T B A + T B C :=
  map_add (TRingHom B) A C

/-- **(3) 合成則**: `T_A ∘ T_B = T_{A B}`。 -/
theorem T_comp (A B : Rˣ) : T A ∘ T B = T (A * B) := by
  funext x
  simp only [Function.comp_apply, T_apply, Units.val_mul, mul_inv_rev, Units.val_mul]
  simp only [mul_assoc]

/-- 合成則の各点版。 -/
theorem T_T (A B : Rˣ) (x : R) : T A (T B x) = T (A * B) x :=
  congrFun (T_comp A B) x

/-- 原文 Step 3 で用いられる逆元公式 `(A B)⁻¹ = B⁻¹ A⁻¹`（mathlib の `mul_inv_rev`）。 -/
theorem inv_mul_rev (A B : Rˣ) : (A * B)⁻¹ = B⁻¹ * A⁻¹ := mul_inv_rev A B

/-- 合成則 (3) を「`B ↦ T_B` は群準同型 `Rˣ →* RingAut R` である」という形で述べたもの。 -/
def TMonoidHom : Rˣ →* RingAut R where
  toFun B :=
    { toFun := T B
      invFun := T B⁻¹
      left_inv := fun x => by simp [T, mul_assoc]
      right_inv := fun x => by simp [T, mul_assoc]
      map_mul' := T_mul B
      map_add' := T_add B }
  map_one' := by ext x; simp [T]
  map_mul' A B := by ext x; simpa using (T_T A B x).symm

@[simp]
theorem TMonoidHom_apply (B : Rˣ) (x : R) : TMonoidHom B x = T B x := rfl

end Ring

section Matrix

open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- 原文の記法に沿った版: `B : Mat(n, ℂ)` が正則（`IsUnit B.det`）のとき、
`Matrix.inv` による `B⁻¹` を使った共役写像が乗法的であること。 -/
theorem matrix_conj_mul (B : Matrix n n ℂ) (hB : IsUnit B.det) (A C : Matrix n n ℂ) :
    B * (A * C) * B⁻¹ = (B * A * B⁻¹) * (B * C * B⁻¹) := by
  have h : B⁻¹ * B = 1 := nonsing_inv_mul B hB
  calc B * (A * C) * B⁻¹ = B * A * (B⁻¹ * B) * C * B⁻¹ := by
        rw [h]; simp [Matrix.mul_assoc]
    _ = (B * A * B⁻¹) * (B * C * B⁻¹) := by simp [Matrix.mul_assoc]

/-- 原文の記法に沿った版: 単位性 `T_B(I) = I`。 -/
theorem matrix_conj_one (B : Matrix n n ℂ) (hB : IsUnit B.det) :
    B * 1 * B⁻¹ = 1 := by
  rw [Matrix.mul_one, mul_nonsing_inv B hB]

/-- 原文の記法に沿った版: 合成則 `T_A(T_B(M)) = T_{A B}(M)`。

原文 Step 3 は `A, B` の正則性を仮定しているが、mathlib の `Matrix.inv` は特異行列に対して
`0` を返す全域関数として定義されており、`Matrix.mul_inv_rev`（`(A B)⁻¹ = B⁻¹ A⁻¹`）が
**正則性なしで**成立する。したがってこの合成則も仮定なしで成り立つ。 -/
theorem matrix_conj_comp (A B : Matrix n n ℂ)
    (X : Matrix n n ℂ) :
    A * (B * X * B⁻¹) * A⁻¹ = (A * B) * X * (A * B)⁻¹ := by
  rw [Matrix.mul_inv_rev]
  simp [Matrix.mul_assoc]

end Matrix

end Ising2D.Conjugation
