/-
章「固有値の代数性」の「シフト行列の特性行列の対角成分は、その軌道の元の個数で決まる」の
具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_shift_char_diagonal_entry`）に対応する。

  人手証明                                           このファイル
  準備 ch(U)_{τ,τ} = t + ι(-U_{τ,τ})                  charMatrix_diag
  第一の場合 |O| ≥ 2 ⇒ ch(U)_{τ,τ} = t                charMatrix_shiftMatrix_diag_of_two_le
  第二の場合 |O| = 1 ⇒ ch(U)_{τ,τ} = t + ι(-κ(1))     charMatrix_shiftMatrix_diag_of_card_one

mathlib の `Matrix.charpoly` や置換行列の既製定理は引いていない。使ったのは既に示した
`rowShift_eq_self_iff_card_orbit_eq_one` と、`charMatrix` / `shiftMatrix` の定義だけである。

住処: 人手証明のこのブロックは ℤ を宣言している。
ここに ℝ / ℂ は現れない（成分は `Polynomial (Polynomial ℤ)`、添字は行配位、個数は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.ShiftCharTerm
import Ising2DLambda.AlgebraicEigenvalue.OrbitFixedIffCardOne

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 人手証明の準備「`ch(A)_{τ,τ} = t + ι(-A_{τ,τ})`」。定義の対角の場合である。 -/
theorem charMatrix_diag (A : RowMatrix L) (τ : RowConfig L) :
    charMatrix L A τ τ = Polynomial.X + constSecond (-A τ τ) := by
  simp [charMatrix]

/-- 人手証明の第一の場合「`|O| ≥ 2` ならば `ch(U)_{τ,τ} = t`」。

`|O| ≠ 1` から `S(τ) ≠ τ` を出し（同値の対偶）、`U_{τ,τ} = κ(0)` を経て `t` に着く。 -/
theorem charMatrix_shiftMatrix_diag_of_two_le {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) {τ : RowConfig L} (hmem : τ ∈ O) (hcard : 2 ≤ O.card) :
    charMatrix L (shiftMatrix L) τ τ = Polynomial.X := by
  classical
  have hne : rowShift L τ ≠ τ := by
    intro hfix
    have : O.card = 1 := (rowShift_eq_self_iff_card_orbit_eq_one hO hmem).mp hfix
    omega
  have hentry : shiftMatrix L τ τ = constPoly 0 := by
    have hne' : ¬(τ = rowShift L τ) := fun h => hne h.symm
    simp only [shiftMatrix]
    rw [if_neg hne']
  calc charMatrix L (shiftMatrix L) τ τ
      = Polynomial.X + constSecond (-(shiftMatrix L τ τ)) := charMatrix_diag _ τ
    _ = Polynomial.X + constSecond (-(constPoly 0)) := by rw [hentry]
    _ = Polynomial.X := by simp [constSecond, constPoly]

/-- 人手証明の第二の場合「`|O| = 1` ならば `ch(U)_{τ,τ} = t + ι(-κ(1))`」。

`|O| = 1` から `S(τ) = τ` を出し（同値を右辺から左辺へ）、`U_{τ,τ} = κ(1)` を代入する。 -/
theorem charMatrix_shiftMatrix_diag_of_card_one {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) {τ : RowConfig L} (hmem : τ ∈ O) (hcard : O.card = 1) :
    charMatrix L (shiftMatrix L) τ τ = Polynomial.X + constSecond (-(constPoly 1)) := by
  classical
  have hfix : rowShift L τ = τ := (rowShift_eq_self_iff_card_orbit_eq_one hO hmem).mpr hcard
  have hentry : shiftMatrix L τ τ = constPoly 1 := by
    simp only [shiftMatrix]
    rw [if_pos hfix.symm]
  calc charMatrix L (shiftMatrix L) τ τ
      = Polynomial.X + constSecond (-(shiftMatrix L τ τ)) := charMatrix_diag _ τ
    _ = Polynomial.X + constSecond (-(constPoly 1)) := by rw [hentry]

end Ising2DLambda.AlgebraicEigenvalue
