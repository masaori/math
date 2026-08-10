/-
具体版が必要十分版の特殊化として得られることの明示（`lean/README.md` の要件 4）。

必要十分版の `entry_of_not_right` / `entry_of_right` に
P := (S(τ) = τ)、Q := (|O| = 1)、v := U_{τ,τ}、z := κ(0)、o := κ(1)、
f := (fun a => t + ι(-a))、x := t を代入すると具体版が出る。渡す仮定は次の 4 つだけである。

  S(τ) = τ ↔ |O| = 1                     ← 既出の `rowShift_eq_self_iff_card_orbit_eq_one`
  ¬(S(τ) = τ) → U_{τ,τ} = κ(0)           ← `def_shift_matrix` の場合分け
  S(τ) = τ → U_{τ,τ} = κ(1)              ← `def_shift_matrix` の場合分け
  t + ι(-κ(0)) = t                       ← 零元の逆元は零元、零元を足しても変わらない

**値の側の代数構造も、軌道であることも、型の有限性も、順序 ≺ も渡していない。**
このことは、具体版の証明がそれらを使っていないという主張の裏取りになっている。
準備（`ch(U)_{τ,τ} = t + ι(-U_{τ,τ})`）と、第一の場合で `2 ≤ |O|` を `¬(|O| = 1)` へ直す段だけは
ここで行う（どちらも必要十分版の外にある）。

住処: ℤ のみ。ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.ShiftCharDiagonalEntry
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.ShiftCharDiagonalEntry

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 第一の場合を必要十分版から導いたもの。 -/
theorem charMatrix_shiftMatrix_diag_of_two_le_from_necSuf {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) {τ : RowConfig L} (hmem : τ ∈ O) (hcard : 2 ≤ O.card) :
    charMatrix L (shiftMatrix L) τ τ = Polynomial.X := by
  classical
  have hmain : (fun a : Polynomial ℤ => Polynomial.X + constSecond (-a)) (shiftMatrix L τ τ)
      = Polynomial.X :=
    NecSuf.AlgebraicEigenvalue.entry_of_not_right
      (P := rowShift L τ = τ) (Q := O.card = 1) (z := constPoly 0)
      (f := fun a : Polynomial ℤ => Polynomial.X + constSecond (-a))
      (rowShift_eq_self_iff_card_orbit_eq_one hO hmem)
      (fun hne => by
        have hne' : ¬(τ = rowShift L τ) := fun h => hne h.symm
        simp only [shiftMatrix]
        rw [if_neg hne'])
      (by simp [constSecond, constPoly])
      (by omega)
  calc charMatrix L (shiftMatrix L) τ τ
      = Polynomial.X + constSecond (-(shiftMatrix L τ τ)) := charMatrix_diag _ τ
    _ = Polynomial.X := hmain

/-- 第二の場合を必要十分版から導いたもの。 -/
theorem charMatrix_shiftMatrix_diag_of_card_one_from_necSuf {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) {τ : RowConfig L} (hmem : τ ∈ O) (hcard : O.card = 1) :
    charMatrix L (shiftMatrix L) τ τ = Polynomial.X + constSecond (-(constPoly 1)) := by
  classical
  have hmain : (fun a : Polynomial ℤ => Polynomial.X + constSecond (-a)) (shiftMatrix L τ τ)
      = (fun a : Polynomial ℤ => Polynomial.X + constSecond (-a)) (constPoly 1) :=
    NecSuf.AlgebraicEigenvalue.entry_of_right
      (P := rowShift L τ = τ) (Q := O.card = 1) (o := constPoly 1)
      (f := fun a : Polynomial ℤ => Polynomial.X + constSecond (-a))
      (rowShift_eq_self_iff_card_orbit_eq_one hO hmem)
      (fun hfix => by
        simp only [shiftMatrix]
        rw [if_pos hfix.symm])
      hcard
  calc charMatrix L (shiftMatrix L) τ τ
      = Polynomial.X + constSecond (-(shiftMatrix L τ τ)) := charMatrix_diag _ τ
    _ = Polynomial.X + constSecond (-(constPoly 1)) := hmain

end Ising2DLambda.AlgebraicEigenvalue
