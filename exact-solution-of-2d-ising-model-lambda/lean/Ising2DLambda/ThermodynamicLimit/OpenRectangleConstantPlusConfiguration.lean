/-
章「熱力学極限」の「開境界長方形の全て正の定数配位」（`def_open_rectangle_constant_plus_configuration`）と
「開境界長方形の全て正の定数配位の破れボンド数は零である」（`claim_open_rectangle_constant_plus_breaks_no_bond`）
の具体版（人手証明と 1 対 1 に対応させる）。

  人手証明の段                                          このファイル
  τ_+ : V^op_{a,b} → {+1,-1}、すべての頂点に +1          openAllPlusConfig
  b^op_{a,b}(τ_+) = |{e | τ_+(∂₀e) ≠ τ_+(∂₁e)}| = |∅| = 0  openAllPlusConfig_openBrokenBondCount_eq_zero

住処: ℕ のみ（有限集合の上の写像と数え上げ）。ℝ / ℂ は現れない。
もとは `OpenRectangleValueAtLeastOne.lean`（実数側の値の下界 1）に置いていたが、
正の有理点での値の下界 1（`OpenRectangleValueGeOneRational.lean`）からも引くので、
実数体に依らないこのファイルへ切り出した。
-/
import Ising2DLambda.ThermodynamicLimit.OpenRectangle

namespace Ising2DLambda.ThermodynamicLimit

open Finset

variable (a b : ℕ)

/-- `def_open_rectangle_constant_plus_configuration`。全ての頂点に +1 を割り当てる配位 τ_+。 -/
def openAllPlusConfig : OpenConfig a b := fun _ => ⟨1, Or.inl rfl⟩

/-- `claim_open_rectangle_constant_plus_breaks_no_bond`。定数配位では各辺の両端の値が等しい。 -/
theorem openAllPlusConfig_openBrokenBondCount_eq_zero :
    openBrokenBondCount a b (openAllPlusConfig a b) = 0 := by
  unfold openBrokenBondCount openBrokenBondSet
  have hfilter :
      (univ.filter fun e : OpenEdge a b =>
        openAllPlusConfig a b (openBoundary0 a b e) ≠
          openAllPlusConfig a b (openBoundary1 a b e)) = ∅ := by
    ext e
    simp [openAllPlusConfig]
  rw [hfilter, card_empty]

end Ising2DLambda.ThermodynamicLimit
