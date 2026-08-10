/-
具体版が必要十分版の特殊化として得られることの明示（`lean/README.md` の要件 4）。

必要十分版の `unitSignProd_eq_pow` / `unitSignProd_eq_single` に ι := RowConfig L、
M := ℤ[x][t]、w := ι(κ(sgn_O(id_O)))、s := 軌道、f := 対角成分 を代入すると具体版が出る。
渡す仮定は次のものだけである。

  w = 1                      ← `orbitPermSign_id`（と `ι(κ(1))` が単位元であること）
  ∀ τ ∈ O, ch(U)_{τ,τ} = t   ← 既に示した `charMatrix_shiftMatrix_diag_of_two_le`（第一の場合）
  O = {τ₁}                   ← `O.card = 1` から取れる 1 元集合の表示（第二の場合）

**軌道であること・型の有限性・順序 ≺・値が多項式であること・符号が ±1 であることは
渡していない。** このことは、具体版の証明がそれらを使っていないという主張の裏取りになっている。

住処: ℤ のみ。ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitIdentityFactor
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.OrbitIdentityFactor

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 第一の場合を、必要十分版から導いたもの。 -/
theorem orbitFactor_shiftMatrix_id_of_two_le_from_necSuf {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) (hcard : 2 ≤ O.card) :
    orbitFactor L (charMatrix L (shiftMatrix L)) O (fun τ => τ)
      = Polynomial.X ^ O.card := by
  classical
  unfold orbitFactor
  refine NecSuf.AlgebraicEigenvalue.unitSignProd_eq_pow _ O _ Polynomial.X ?_ ?_
  · rw [orbitPermSign_id O, constPoly_one, show constSecond (1 : Polynomial ℤ) = 1 from map_one _]
  · exact fun τ hmem => charMatrix_shiftMatrix_diag_of_two_le hO hmem hcard

/-- 第二の場合を、必要十分版から導いたもの。 -/
theorem orbitFactor_shiftMatrix_id_of_card_one_from_necSuf {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) (hcard : O.card = 1) :
    orbitFactor L (charMatrix L (shiftMatrix L)) O (fun τ => τ)
      = Polynomial.X + constSecond (-(constPoly 1)) := by
  classical
  obtain ⟨τ₁, hs⟩ := Finset.card_eq_one.mp hcard
  have hmem : τ₁ ∈ O := by rw [hs]; exact Finset.mem_singleton_self τ₁
  have hsingle : orbitFactor L (charMatrix L (shiftMatrix L)) O (fun τ => τ)
      = charMatrix L (shiftMatrix L) τ₁ τ₁ := by
    unfold orbitFactor
    refine NecSuf.AlgebraicEigenvalue.unitSignProd_eq_single _ O _ τ₁ ?_ hs
    rw [orbitPermSign_id O, constPoly_one, show constSecond (1 : Polynomial ℤ) = 1 from map_one _]
  rw [hsingle]
  exact charMatrix_shiftMatrix_diag_of_card_one hO hmem hcard

end Ising2DLambda.AlgebraicEigenvalue
