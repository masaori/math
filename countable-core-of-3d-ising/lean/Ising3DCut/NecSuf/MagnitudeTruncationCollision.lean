/-
「大きさによる切り詰めは値の衝突を持つ」の Lean 必要十分版。

具体版（`Ising3DCut/LimitQuantity/MagnitudeTruncationCollision.lean`）と手順を同じにしたまま、
仮定を具体版の証明が実際に使っている性質だけへ削る。具体版が使ったのは次の四つである。

* 「`u := 2 ^ N`, `w := 2 ^ (N + 1)` はいずれも正の有理数である」——正値性は主張の飾りであり、
  衝突を作る論法そのものには使っていない。ここでは述語 `Good` として置き、
  二つの元がそれを満たすことだけを仮定する（`Good := fun _ => True` と置けば落ちる）。
* 「`2 ^ N < 2 ^ (N + 1)` より `u ≠ w`」——大小関係は使わず、`u ≠ w` だけを仮定する。
* 「素数 `2` での成分は `N` と `N + 1` であり、高さ `N` で頭打ちにするとともに `N` になる」
  ——素数であること・付値であること・その値が `N` と `N + 1` であることは使っていない。
  使ったのは、**その添字での二つの座標がいずれも頭打ちの高さ以上である**ことだけである。
* 「`2` 以外の素数では `v_p = 0` でともに `0`」——値が `0` であることは使わず、
  **残りの添字では二つの座標が一致する**ことだけを仮定する。

値の側に要る構造は `min` を取れることだけなので `LinearOrder` に留める
（零元・加法・整数であることはいずれも落とせた）。
添字の型には何も仮定しない（具体版は素数の部分型だったが、有限性も無限性も使っていない）。
-/
import Mathlib.Order.MinMax

namespace Ising3DCut.NecSuf

/-- 大きさによる切り詰めは値の衝突を持つ。

`coord i x` は `x` の第 `i` 座標、`cap` は頭打ちの高さ、`d` は二つの座標が食い違う唯一の添字、
`Good` は主張が課す付帯条件である。 -/
theorem magnitude_truncation_has_a_value_collision
    {ι A M : Type*} [LinearOrder M]
    (coord : ι → A → M) (Good : A → Prop) (cap : M) (d : ι)
    (u w : A) (hu : Good u) (hw : Good w) (hne : u ≠ w)
    (hcapu : cap ≤ coord d u) (hcapw : cap ≤ coord d w)
    (hagree : ∀ i, i ≠ d → coord i u = coord i w) :
    ∃ u' w' : A, Good u' ∧ Good w' ∧ u' ≠ w' ∧
      (fun i => min (coord i u') cap) = fun i => min (coord i w') cap := by
  -- 第一段: 二つの元をそのまま証人に取る。いずれも `Good` を満たす。
  refine ⟨u, w, hu, hw, hne, ?_⟩
  -- 第二段・第三段: 各添字での成分を比べる。
  funext i
  by_cases hi : i = d
  · -- 第二段: 食い違う添字 `d` での成分。二つともに頭打ちの高さ以上なので、
    -- 頭打ちの後はともに `cap` になる。
    subst hi
    rw [min_eq_right hcapu, min_eq_right hcapw]
  · -- 第三段: それ以外の添字での成分。座標が一致するので頭打ちの後も一致する。
    rw [hagree i hi]

end Ising3DCut.NecSuf
