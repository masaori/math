/-
章「熱力学極限」の「全て正の定数配位」（`def_constant_plus_configuration`）と
「全て正の定数配位の破れボンド数は零である」（`claim_constant_plus_breaks_no_bond`）の具体版。

どちらも有限集合の上の写像だけで書けており、実数体を使わない。
（以前は削除済みの実数値経路のファイルに同居していたが、本文から実数値経路を消したので
可算側だけのこのファイルへ切り出した。）
-/
import Ising2DLambda.PartitionPolynomial.Basic

namespace Ising2DLambda.ThermodynamicLimit

open Finset PartitionPolynomial

variable (L : ℕ) [NeZero L]

/-- `def_constant_plus_configuration`: 人手証明の定数配位 `σ₊`（各頂点に +1）。 -/
def allPlusConfig : Config L := fun _ => ⟨1, Or.inl rfl⟩

/-- `claim_constant_plus_breaks_no_bond`: 定数配位では各辺の両端の値が等しいので破れボンド数は 0。 -/
theorem allPlusConfig_brokenBondCount_eq_zero :
    brokenBondCount L (allPlusConfig L) = 0 := by
  unfold brokenBondCount
  have hfilter :
      (univ.filter fun e : Edge L =>
        allPlusConfig L (boundary0 L e) ≠ allPlusConfig L (boundary1 L e)) = ∅ := by
    ext e
    simp [allPlusConfig]
  rw [hfilter, card_empty]

end Ising2DLambda.ThermodynamicLimit
