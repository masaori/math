/-
「巻き付き二次符号の積と交差形式」（`claim_torus_quadratic_sign_polarization`）の必要十分版。

具体版 `torusQuadraticSign_polarization` と同じ二つの式鎖（定義 → 代入 → 分配律 → 交換律と結合律 →
定義、のあと加法を積へ移す写像）で、`{0,1}`・`xor`・整数を使わない。使うのは次だけである。
- 指数の住処 `R` の二つの演算 `add`・`mul`。`add` の交換律と結合律（項の並べ替えに要る）と、
  `mul` の `add` への左右の分配律（`(h₁+h₂)(v₁+v₂)` と `α(h₁+h₂)` の展開に要る）。
  零・単位元・`mul` の交換律と結合律・`1 + 1 = 0` は使わない。
  `mul` の交換律を使わないので、交差項は `h₁v₂ + h₂v₁` の向きのまま残る。
- 一次の係数 `α`・`β` は `R` の任意の元（具体版では `1 - a`・`1 - b`）。
- 符号の値の住処 `M` は積を持つだけの型。`σ : R → M` は加法を積へ移す（具体版では整数指数の加法則）。
  `M` の結合律・可換律・単位元は使わない（積は左から順に組む形のまま現れる）。
-/
import Mathlib.Algebra.Group.Basic

namespace Ising2DLambda.NecSuf.KacWard

variable {R M : Type*}

/-- 一次の係数 `α`・`β` を持つ二次式 `hv + αh + βv`（`R` の二つの演算だけで書く）。 -/
def quadraticForm (add mul : R → R → R) (α β h v : R) : R :=
  add (add (mul h v) (mul α h)) (mul β v)

/-- 指数の式鎖: `q(h₁+h₂, v₁+v₂) = (q(h₁,v₁) + q(h₂,v₂)) + (h₁v₂ + h₂v₁)`。 -/
theorem quadraticForm_polarization_necSuf (add mul : R → R → R)
    (hcomm : ∀ x y, add x y = add y x) (hassoc : ∀ x y z, add (add x y) z = add x (add y z))
    (hleft : ∀ x y z, mul x (add y z) = add (mul x y) (mul x z))
    (hright : ∀ x y z, mul (add x y) z = add (mul x z) (mul y z))
    (α β h₁ v₁ h₂ v₂ : R) :
    quadraticForm add mul α β (add h₁ h₂) (add v₁ v₂) =
      add (add (quadraticForm add mul α β h₁ v₁) (quadraticForm add mul α β h₂ v₂))
        (add (mul h₁ v₂) (mul h₂ v₁)) := by
  letI : AddCommSemigroup R := { add := add, add_assoc := hassoc, add_comm := hcomm }
  calc quadraticForm add mul α β (add h₁ h₂) (add v₁ v₂)
      -- 定義と代入
      = add (add (mul (add h₁ h₂) (add v₁ v₂)) (mul α (add h₁ h₂))) (mul β (add v₁ v₂)) := rfl
      -- 分配律
    _ = add (add (add (add (mul h₁ v₁) (mul h₁ v₂)) (add (mul h₂ v₁) (mul h₂ v₂)))
            (add (mul α h₁) (mul α h₂)))
          (add (mul β v₁) (mul β v₂)) := by
        rw [hright, hleft, hleft, hleft, hleft]
      -- 加法の交換律と結合律（`add` を `+` として並べ替える）
    _ = add (add (add (add (mul h₁ v₁) (mul α h₁)) (mul β v₁))
              (add (add (mul h₂ v₂) (mul α h₂)) (mul β v₂)))
          (add (mul h₁ v₂) (mul h₂ v₁)) := by
        show (mul h₁ v₁ + mul h₁ v₂ + (mul h₂ v₁ + mul h₂ v₂)) + (mul α h₁ + mul α h₂) +
            (mul β v₁ + mul β v₂) =
          (mul h₁ v₁ + mul α h₁ + mul β v₁ + (mul h₂ v₂ + mul α h₂ + mul β v₂)) +
            (mul h₁ v₂ + mul h₂ v₁)
        simp only [add_comm, add_left_comm]
      -- 定義
    _ = add (add (quadraticForm add mul α β h₁ v₁) (quadraticForm add mul α β h₂ v₂))
          (add (mul h₁ v₂) (mul h₂ v₁)) := rfl

/-- 二次符号の積と交差形式の必要十分版:
`σ(q(h₁+h₂, v₁+v₂)) = σ(q(h₁,v₁)) σ(q(h₂,v₂)) σ(h₁v₂ + h₂v₁)`。 -/
theorem quadraticSign_polarization_necSuf [Mul M] (add mul : R → R → R)
    (hcomm : ∀ x y, add x y = add y x) (hassoc : ∀ x y z, add (add x y) z = add x (add y z))
    (hleft : ∀ x y z, mul x (add y z) = add (mul x y) (mul x z))
    (hright : ∀ x y z, mul (add x y) z = add (mul x z) (mul y z))
    (σ : R → M) (hσ : ∀ x y, σ (add x y) = σ x * σ y)
    (α β h₁ v₁ h₂ v₂ : R) :
    σ (quadraticForm add mul α β (add h₁ h₂) (add v₁ v₂)) =
      σ (quadraticForm add mul α β h₁ v₁) * σ (quadraticForm add mul α β h₂ v₂) *
        σ (add (mul h₁ v₂) (mul h₂ v₁)) := by
  calc σ (quadraticForm add mul α β (add h₁ h₂) (add v₁ v₂))
      -- 指数の式鎖
      = σ (add (add (quadraticForm add mul α β h₁ v₁) (quadraticForm add mul α β h₂ v₂))
          (add (mul h₁ v₂) (mul h₂ v₁))) := by
        rw [quadraticForm_polarization_necSuf add mul hcomm hassoc hleft hright]
      -- 加法を積へ移す（外側の和）
    _ = σ (add (quadraticForm add mul α β h₁ v₁) (quadraticForm add mul α β h₂ v₂)) *
          σ (add (mul h₁ v₂) (mul h₂ v₁)) := hσ _ _
      -- 加法を積へ移す（内側の和）
    _ = σ (quadraticForm add mul α β h₁ v₁) * σ (quadraticForm add mul α β h₂ v₂) *
          σ (add (mul h₁ v₂) (mul h₂ v₁)) := by
        rw [hσ]

end Ising2DLambda.NecSuf.KacWard
