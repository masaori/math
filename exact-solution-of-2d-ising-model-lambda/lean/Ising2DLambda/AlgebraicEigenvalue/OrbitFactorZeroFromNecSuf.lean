/-
具体版が必要十分版の特殊化として得られることの明示（`lean/README.md` の要件 4）。

必要十分版の `orbitFactor_eq_zero_of_entry_zero` に ι := RowConfig L、S := ℤ[x][t]、
B := ch(U)、w := ι(κ(sgn_O(ψ)))、O := 軌道、g := ψ を代入すると具体版が出る。
渡す仮定は次の 2 つだけである。

  τ₁ ∈ O
  ch(U)_{τ₁,ψ(τ₁)} = 0   ← 既に示した `charMatrix_shiftMatrix_eq_zero_from_necSuf`

**軌道であること・ψ が全単射であること・型の有限性・順序 ≺・符号の性質は渡していない。**
このことは、具体版の証明がそれらを使っていないという主張の裏取りになっている。

住処: ℤ のみ。ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitFactorZero
import Ising2DLambda.AlgebraicEigenvalue.ShiftCharTermFromNecSuf
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.OrbitFactorZero

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 主張「行の添字にもその像にも当たらない値を取る軌道の上の全単射の因子は零元である」を、
必要十分版から導いたもの。 -/
theorem orbitFactor_shiftMatrix_eq_zero_from_necSuf (O : Finset (RowConfig L))
    (g : RowConfig L → RowConfig L) {τ₁ : RowConfig L} (hmem : τ₁ ∈ O)
    (h₁ : g τ₁ ≠ τ₁) (h₂ : g τ₁ ≠ rowShift L τ₁) :
    orbitFactor L (charMatrix L (shiftMatrix L)) O g = 0 := by
  unfold orbitFactor
  refine NecSuf.AlgebraicEigenvalue.orbitFactor_eq_zero_of_entry_zero
    (charMatrix L (shiftMatrix L)) _ O g (i₁ := τ₁) hmem ?_
  exact charMatrix_shiftMatrix_eq_zero_from_necSuf h₁ h₂

end Ising2DLambda.AlgebraicEigenvalue
