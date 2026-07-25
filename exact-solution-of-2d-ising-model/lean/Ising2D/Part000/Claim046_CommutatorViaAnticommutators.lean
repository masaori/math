/-
# 交換子と反交換子の関係

対応する人手証明:
`parts/000_計算公式/046_claim_交換子と反交換子の関係.typ`
(`<commutator_via_anticommutators>`)

原文: `n ∈ ℤ_{≥1}`、`a, b, c ∈ Mat(n, ℂ)` について、
交換子 `[x, y] := x y - y x`、反交換子 `[x, y]₊ := x y + y x` とするとき

  `[a b, c] = a [b, c]₊ - [a, c]₊ b`

が成り立つ。

原文の証明は分配法則・結合法則しか使っていないので、ここでは
**任意の（非可換）環 `R`** に対して定式化する（`Mat(n, ℂ)` はその特別な場合であり、
系 `matrix_commutator_via_anticommutators` として原文の形でも述べる）。
交換子は mathlib の Lie 括弧 `⁅·,·⁆`（`Ring.lie_def : ⁅x, y⁆ = x * y - y * x`）と
一致するので、その形の言い換えも与える。
-/
import Mathlib.Algebra.Lie.OfAssociative
import Mathlib.Data.Complex.Basic
import Mathlib.Data.Matrix.Basic
import Mathlib.Tactic.NoncommRing

namespace Ising2D

section Ring

variable {R : Type*} [Ring R]

/-- 反交換子 `[a, b]₊ := a b + b a`（原文の `[a, b]_(+)`）。
mathlib には対応する定義が無いのでここで導入する。 -/
def acomm (a b : R) : R := a * b + b * a

@[simp]
theorem acomm_def (a b : R) : acomm a b = a * b + b * a := rfl

/-- 反交換子は対称。 -/
theorem acomm_comm (a b : R) : acomm a b = acomm b a := by
  simp [acomm, add_comm]

/-- 原文の交換子 `[x, y] := x y - y x` は mathlib の Lie 括弧と一致する。 -/
theorem sub_mul_comm_eq_lie (a b : R) : a * b - b * a = ⁅a, b⁆ :=
  (Ring.lie_def a b).symm

/-- **`<commutator_via_anticommutators>` の形式化**:
`[a b, c] = a [b, c]₊ - [a, c]₊ b`。

原文の証明（右辺を反交換子の定義で展開し、分配法則・結合法則で整理する）と同じ内容を
`noncomm_ring`（非可換環の正規化）で実行する。 -/
theorem commutator_via_anticommutators (a b c : R) :
    (a * b) * c - c * (a * b) = a * acomm b c - acomm a c * b := by
  simp only [acomm]
  noncomm_ring

/-- 上を mathlib の Lie 括弧で述べた版。 -/
theorem lie_mul_eq_acomm_sub_acomm (a b c : R) :
    ⁅a * b, c⁆ = a * acomm b c - acomm a c * b := by
  rw [← sub_mul_comm_eq_lie]
  exact commutator_via_anticommutators a b c

end Ring

section Matrix

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- 原文の記法（`Mat(n, ℂ)` の元 `a, b, c`）に沿った系。 -/
theorem matrix_commutator_via_anticommutators (a b c : Matrix n n ℂ) :
    (a * b) * c - c * (a * b) = a * (b * c + c * b) - (a * c + c * a) * b :=
  commutator_via_anticommutators a b c

end Matrix

end Ising2D
