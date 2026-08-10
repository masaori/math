/-
具体版が必要十分版の特殊化として得られることの明示（`lean/README.md` の要件 4）。

必要十分版の `signedProd_eq_unit` に ι := RowConfig L、M := ℤ[x][t]、
w := ι(κ(sgn_O(S↾_O)))、s := 軌道、f := 成分 ch(U)_{τ,S(τ)}、u := -1 を代入すると
具体版が出る。渡す仮定は次の 4 つだけである。

  w = u ^ (|O| - 1)          ← `shiftOrbitRestriction_sign`（符号が (-1)^{|O|-1} であること）
  ∀ τ ∈ O, ch(U)_{τ,S(τ)} = u ← `charMatrix_shiftMatrix_shift_entry`
  u * u = 1                   ← (-1)·(-1) = 1（`norm_num`）
  1 ≤ |O|                     ← 仮定 2 ≤ |O| から

**軌道であること・型の有限性・順序 ≺・値が多項式であること・`u` が `ι(-κ(1))` であることは
渡していない。** このことは、具体版の証明がそれらを使っていないという主張の裏取りになっている。

住処: ℤ のみ。ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitShiftRestrictionFactor
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.OrbitShiftRestrictionFactor

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 主張を、必要十分版から導いたもの。 -/
theorem orbitFactor_shiftMatrix_shift_of_two_le_from_necSuf {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) (hcard : 2 ≤ O.card) :
    orbitFactor L (charMatrix L (shiftMatrix L)) O (rowShift L)
      = constSecond (-(constPoly 1)) := by
  classical
  rw [constSecond_neg_one]
  show constSecond (constPoly (orbitPermSign L O (rowShift L)))
      * ∏ τ ∈ O, charMatrix L (shiftMatrix L) τ (rowShift L τ) = (-1 : SecondPoly)
  refine NecSuf.AlgebraicEigenvalue.signedProd_eq_unit _ O _ (-1 : SecondPoly) ?_ ?_ ?_ ?_
  · rw [shiftOrbitRestriction_sign hO]; simp [constSecond, constPoly]
  · exact fun τ hmem => charMatrix_shiftMatrix_shift_entry hO hmem hcard
  · norm_num
  · omega

end Ising2DLambda.AlgebraicEigenvalue
