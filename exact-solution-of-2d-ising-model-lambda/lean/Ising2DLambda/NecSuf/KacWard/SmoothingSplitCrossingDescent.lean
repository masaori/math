/-
「平滑化で分けた二本の横断数の和は真に減る」の必要十分版。
閉歩道や格子は使わず、分割等式、平滑化更新式、選んだ横断が
二軸の直進通過を一つずつ含むことだけから自然数の狭義減少を得る。
-/
import Mathlib.Data.Fintype.Card

namespace Ising2DLambda.NecSuf.KacWard

/-- 横断する二つの通過が軸の異なる直進通過なら、どちらの軸の直進通過数も一以上である。
軸の値域について使うのは「相異なる二元があれば、どの元もそのどちらかに等しい」ことだけ
（軸が三つ以上あると、選んだ二通過のどちらの軸でもない軸の直進通過数は零になりうる）。 -/
theorem crossing_straightVisitCount_pos_necSuf {ι V α : Type} [Fintype ι]
    (vertex : ι → V) (straight : ι → Prop) (axis : ι → α)
    [DecidableEq V] [DecidablePred straight] [DecidableEq α]
    (htwo : ∀ x y z : α, x ≠ y → z = x ∨ z = y)
    (k l : ι) (hv : vertex k = vertex l) (hk : straight k) (hl : straight l)
    (haxis : axis k ≠ axis l) (a : α) :
    1 ≤ (Finset.univ.filter fun r =>
      vertex r = vertex k ∧ straight r ∧ axis r = a).card := by
  rcases htwo _ _ a haxis with ha | ha
  · exact Finset.card_pos.mpr ⟨k, Finset.mem_filter.mpr ⟨Finset.mem_univ _, rfl, hk, ha.symm⟩⟩
  · exact Finset.card_pos.mpr ⟨l, Finset.mem_filter.mpr ⟨Finset.mem_univ _, hv.symm, hl, ha.symm⟩⟩

/-- 分割等式と更新式で、二本の横断数の和は元の横断数より小さくなる。 -/
theorem smoothing_split_crossing_descent_necSuf
    (original smoothed split mutualCrossings axisZero axisOne : ℕ)
    (hpartition : split + mutualCrossings = smoothed)
    (hupdate : original + 1 = smoothed + axisZero + axisOne)
    (haxisZero : 1 ≤ axisZero) (haxisOne : 1 ≤ axisOne) :
    split < original := by
  omega

end Ising2DLambda.NecSuf.KacWard
