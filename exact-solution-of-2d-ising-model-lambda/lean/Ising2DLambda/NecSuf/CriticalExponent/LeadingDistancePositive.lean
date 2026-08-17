/-
`claim_leading_distance_positive` の必要十分版。

具体版が使う本質は次だけである。
  - 選ばれた値 d は、ある点 xi の距離値である。
  - 距離値が零であることは xi が基準点 xc であることと同値である。
  - 基準点は候補集合に属さない。
  - 各距離値はある元の平方として書ける。
  - 零でない元の平方である値は零元より大きい。

体・順序の三分法・有限集合・最小性は、この正値性の論法自体には要らない。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2DLambda.NecSuf.CriticalExponent

theorem leadingDistance_positive_necSuf
    {P X Y : Type*}
    [Zero X] [Zero Y]
    (candidate : P → Prop)
    (distance : P → X)
    (criticalPoint : P)
    (square : Y → X)
    (lt : X → X → Prop)
    (d : X)
    (hdMem : ∃ xi, candidate xi ∧ distance xi = d)
    (hdistanceZero : ∀ xi, distance xi = 0 ↔ xi = criticalPoint)
    (hcritical : ¬ candidate criticalPoint)
    (hsquare : ∀ xi, ∃ w, distance xi = square w)
    (hsquareZero : square 0 = 0)
    (hltSquare : ∀ y w, w ≠ 0 → y = square w → lt 0 y) :
    lt 0 d := by
  obtain ⟨xi, hxi, hxiDist⟩ := hdMem
  have hdne : d ≠ 0 := by
    intro hd0
    have hdist0 : distance xi = 0 := hxiDist.trans hd0
    have hxic : xi = criticalPoint := (hdistanceZero xi).1 hdist0
    exact hcritical (hxic ▸ hxi)
  obtain ⟨w, hw⟩ := hsquare xi
  have hdSq : d = square w := hxiDist.symm.trans hw
  have hwne : w ≠ 0 := by
    intro hw0
    apply hdne
    calc
      d = square w := hdSq
      _ = square 0 := by rw [hw0]
      _ = 0 := hsquareZero
  exact hltSquare d w hwne hdSq

end Ising2DLambda.NecSuf.CriticalExponent
