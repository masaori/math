/-
「非負有理数倍は有理係数の対数順序群の順序を保つ」の必要十分版。

具体版が使うのは次だけである。添字 `i`（共通分母）と元 `x` に証人 `w` を対応させる関係 `Rep`、
良い添字 `Good`（`N ≥ 1`）、証人の住処 `Y`（`Λ`）の関係 `le`、`X` 上の作用 `sX c`（`c·`）、
`Y` 上の作用 `sY c`（`num(c)·`）、添字の変換 `sI c`（`den(c)·`）について、
(1) 良い添字を `sI c` で送っても良いこと（`den(c) N ≥ 1`）、
(2) `Rep i x w` なら `Rep (sI c i) (sX c x) (sY c w)`（六段の鎖）、
(3) `le` が `sY c` で保たれること（正整数倍不変性と反射律）。
順序・対数順序群・共通分母の中身、有理数の既約分数表示は本質でない。
`c` の非負性は (3) の中にだけ入る（`sY c` が順序を保つ理由）ので、ここでは仮定として現れない。
-/
import Ising2DLambda.NecSuf.ThermodynamicLimit.RationalLogOrderGroupLinearOrder

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

variable {I X Y C : Type*}

/-- 作用による単調性。仮定の証人を `sY c` で送り、添字を `sI c` で送る。 -/
theorem indexedLE_scale_necSuf
    (Rep : I → X → Y → Prop) (Good : I → Prop) (le : Y → Y → Prop)
    (sI : C → I → I) (sX : C → X → X) (sY : C → Y → Y) (c : C)
    (hgood : ∀ i : I, Good i → Good (sI c i))
    (hrep : ∀ (i : I) (x : X) (w : Y), Rep i x w → Rep (sI c i) (sX c x) (sY c w))
    (hmono : ∀ a b : Y, le a b → le (sY c a) (sY c b))
    {x y : X} (h : indexedLE Rep Good le x y) :
    indexedLE Rep Good le (sX c x) (sX c y) := by
  obtain ⟨i, wx, wy, hi, hx, hy, hle⟩ := h
  exact ⟨sI c i, sY c wx, sY c wy, hgood i hi, hrep i x wx hx, hrep i y wy hy, hmono wx wy hle⟩

end Ising2DLambda.NecSuf.ThermodynamicLimit
