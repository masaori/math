/-
「巻き付き二次符号の積と交差形式」（`claim_torus_quadratic_sign_polarization`）の具体版。

本文の `{0,1}` の元は `Bool`（`true` が 1）、`r ⊕ s` は `xor`、積 `rs` は `&&` で表す。
本文の証明と同じ二つの式鎖で示す。
- 指数の式鎖（`torusQuadraticParity_polarization`）: 定義 → 偶奇の代入 → 分配律 → 交換律と結合律 → 定義。
- 符号の式鎖（`torusQuadraticSign_polarization`）: 定義 → 指数の式鎖 → 整数指数の加法則 → 定義。
  右端の `(-1)^{h₁v₂+h₂v₁}` は本文どおり整数の指数で書き、偶奇との対応
  （`parityToSign_xor_and`。`(-1)^2 = 1` を使う）で符号に戻す。
必要十分版を呼ばない。
-/
import Ising2DLambda.KacWard.TorusQuadraticSign
import Mathlib.Algebra.Group.Basic
import Mathlib.Algebra.Ring.Int.Defs

namespace Ising2DLambda.KacWard

/-- 偶奇 `p ∈ {0,1}` から符号 `(-1)^p ∈ {-1,1}` を作る（二次符号の定義の外側）。 -/
def parityToSign (p : Bool) : ℤ := if p then -1 else 1

theorem torusQuadraticSign_eq_parityToSign (a b h v : Bool) :
    torusQuadraticSign a b h v = parityToSign (torusQuadraticParity a b h v) := rfl

/-- 整数指数の加法則（偶奇の和は `(-1)^2 = 1` により符号の積になる）。 -/
theorem parityToSign_xor (p r : Bool) :
    parityToSign (xor p r) = parityToSign p * parityToSign r := by
  cases p <;> cases r <;> decide

/-- 右端の指数: 偶奇 `h₁v₂ ⊕ h₂v₁` の符号は、整数の指数 `h₁v₂ + h₂v₁` による `(-1)` の冪に等しい。 -/
theorem parityToSign_xor_and (h₁ v₂ h₂ v₁ : Bool) :
    parityToSign (xor (h₁ && v₂) (h₂ && v₁)) =
      (-1 : ℤ) ^ (h₁.toNat * v₂.toNat + h₂.toNat * v₁.toNat) := by
  cases h₁ <;> cases v₂ <;> cases h₂ <;> cases v₁ <;> decide

/-- 指数の式鎖:
`q(h₁⊕h₂, v₁⊕v₂) ≡ q(h₁,v₁) + q(h₂,v₂) + h₁v₂ + h₂v₁ (mod 2)`。 -/
theorem torusQuadraticParity_polarization (a b h₁ v₁ h₂ v₂ : Bool) :
    torusQuadraticParity a b (xor h₁ h₂) (xor v₁ v₂) =
      xor (xor (torusQuadraticParity a b h₁ v₁) (torusQuadraticParity a b h₂ v₂))
        (xor (h₁ && v₂) (h₂ && v₁)) := by
  calc torusQuadraticParity a b (xor h₁ h₂) (xor v₁ v₂)
      -- 定義（`def_torus_quadratic_sign`）と偶奇の代入 h = h₁⊕h₂, v = v₁⊕v₂
      = xor (xor ((xor h₁ h₂) && (xor v₁ v₂)) ((!a) && (xor h₁ h₂))) ((!b) && (xor v₁ v₂)) := rfl
      -- ℤ の分配律（𝔽₂ では `&&` の `xor` への分配）
    _ = xor (xor (xor (xor (h₁ && v₁) (h₁ && v₂)) (xor (h₂ && v₁) (h₂ && v₂)))
            (xor ((!a) && h₁) ((!a) && h₂)))
          (xor ((!b) && v₁) ((!b) && v₂)) := by
        rw [Bool.and_xor_distrib_right, Bool.and_xor_distrib_left, Bool.and_xor_distrib_left,
          Bool.and_xor_distrib_left, Bool.and_xor_distrib_left]
      -- ℤ の交換律と結合律
    _ = xor (xor (xor (xor (h₁ && v₁) ((!a) && h₁)) ((!b) && v₁))
              (xor (xor (h₂ && v₂) ((!a) && h₂)) ((!b) && v₂)))
          (xor (h₁ && v₂) (h₂ && v₁)) := by
        simp only [Bool.xor_assoc, Bool.xor_comm, Bool.xor_left_comm]
      -- 定義（`def_torus_quadratic_sign`）
    _ = xor (xor (torusQuadraticParity a b h₁ v₁) (torusQuadraticParity a b h₂ v₂))
          (xor (h₁ && v₂) (h₂ && v₁)) := rfl

/-- 巻き付き二次符号の積と交差形式（本文 `claim_torus_quadratic_sign_polarization`）:
`χ_{a,b}(h₁⊕h₂, v₁⊕v₂) = χ_{a,b}(h₁,v₁) χ_{a,b}(h₂,v₂) (-1)^{h₁v₂+h₂v₁}`。 -/
theorem torusQuadraticSign_polarization (a b h₁ v₁ h₂ v₂ : Bool) :
    torusQuadraticSign a b (xor h₁ h₂) (xor v₁ v₂) =
      torusQuadraticSign a b h₁ v₁ * torusQuadraticSign a b h₂ v₂ *
        (-1 : ℤ) ^ (h₁.toNat * v₂.toNat + h₂.toNat * v₁.toNat) := by
  calc torusQuadraticSign a b (xor h₁ h₂) (xor v₁ v₂)
      -- 定義（`def_torus_quadratic_sign`）
      = parityToSign (torusQuadraticParity a b (xor h₁ h₂) (xor v₁ v₂)) := rfl
      -- 上の合同式（指数の式鎖）
    _ = parityToSign (xor (xor (torusQuadraticParity a b h₁ v₁) (torusQuadraticParity a b h₂ v₂))
          (xor (h₁ && v₂) (h₂ && v₁))) := by
        rw [torusQuadraticParity_polarization]
      -- 整数指数の加法則
    _ = parityToSign (torusQuadraticParity a b h₁ v₁) *
          parityToSign (torusQuadraticParity a b h₂ v₂) *
          (-1 : ℤ) ^ (h₁.toNat * v₂.toNat + h₂.toNat * v₁.toNat) := by
        rw [parityToSign_xor, parityToSign_xor, parityToSign_xor_and]
      -- 定義（`def_torus_quadratic_sign`）
    _ = torusQuadraticSign a b h₁ v₁ * torusQuadraticSign a b h₂ v₂ *
          (-1 : ℤ) ^ (h₁.toNat * v₂.toNat + h₂.toNat * v₁.toNat) := rfl

end Ising2DLambda.KacWard
