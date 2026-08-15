/-
「有理数倍と埋め込みを通した順序の移送」の必要十分版。

具体版が使うのは次だけである。添字 `i` と元 `x` に証人 `w` を対応させる関係 `Rep`、良い添字 `Good`、
証人の住処の関係 `le` について、
(1) 二つの良い添字の間で `le` の真偽が一致すること（順序判定の共通分母からの独立性）、
(2) 二元 `x, y` に共通の良い添字 `i` とそこでの証人 `a, b` が与えられていること
（`N = L^2`、証人 `λ, μ`）。
このとき `indexedLE x y ↔ le a b`。有理数倍・埋め込み・対数順序群の中身は本質でない。
-/
import Ising2DLambda.NecSuf.ThermodynamicLimit.RationalLogOrderGroupLinearOrder

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

variable {I X Y : Type*}

/-- 共通の良い添字での証人の比較が、添字付き関係そのものと一致する。
→ は独立性で与えられた添字へ移す。← は定義の ∃ 形にその添字と証人を入れる。 -/
theorem indexedLE_iff_of_common_good_index_necSuf
    (Rep : I → X → Y → Prop) (Good : I → Prop) (le : Y → Y → Prop)
    (hind : ∀ (i j : I) (x y : X) (wx wy wx' wy' : Y), Good i → Good j →
      Rep i x wx → Rep i y wy → Rep j x wx' → Rep j y wy' → (le wx wy ↔ le wx' wy'))
    {x y : X} {i : I} {a b : Y} (hi : Good i) (ha : Rep i x a) (hb : Rep i y b) :
    indexedLE Rep Good le x y ↔ le a b := by
  constructor
  · rintro ⟨j, ux, uy, hj, hux, huy, hle⟩
    exact (hind j i x y ux uy a b hj hi hux huy ha hb).mp hle   -- 独立性
  · intro h
    exact ⟨i, a, b, hi, ha, hb, h⟩

end Ising2DLambda.NecSuf.ThermodynamicLimit
