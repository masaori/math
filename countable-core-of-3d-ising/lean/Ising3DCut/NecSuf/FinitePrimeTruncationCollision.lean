/-
「有限個の素数への切り詰めは値の衝突を持つ」の Lean 必要十分版。

具体版（`Ising3DCut/LimitQuantity/FinitePrimeTruncationCollision.lean`）と手順を同じにしたまま、
仮定を具体版の証明が実際に使っている性質だけへ削る。具体版が使ったのは次の三つである。

* 「素数は無限に多く存在する」——ここでは添字の型 `ι` が有限集合で尽くせないこと
  （`Infinite ι`）だけを仮定する。素数であること・自然数であることは使っていない。
* 「相異なる素数 `p ≠ r` について `v_p(r) = 0 = v_p(1)`」——付値が `0` であることは使わず、
  `i ≠ j` のとき第 `i` 座標が `witness j` と `base` とで一致することだけを仮定する。
  値の側の型 `M` に構造は要らない（零元も順序も使わない）。
* 「`r ≥ 2` より `1 ≠ r`」——`2 ≤ r` という具体的な理由は使わず、
  `witness j ≠ base` であることだけを仮定する。

`ℚ` の正値性は具体版の主張の飾りであり、衝突を作る論法そのものには使っていない。
ここでは正値性に当たるものを述語 `Good` として置き、`base` と各 `witness j` が
それを満たすことだけを仮定する（`Good := fun _ => True` と置けば落ちる）。
-/
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Fintype.EquivFin

namespace Ising3DCut.NecSuf

/-- 有限個の座標への切り詰めは値の衝突を持つ。

`S` は切り詰めて残す座標の有限集合、`coord i x` は `x` の第 `i` 座標、
`base` と `witness j` は衝突させる二つの元、`Good` は主張が課す付帯条件である。 -/
theorem finite_coordinate_truncation_has_a_value_collision
    {ι A M : Type*} [Infinite ι]
    (coord : ι → A → M) (Good : A → Prop)
    (base : A) (witness : ι → A)
    (hbase : Good base) (hwitness : ∀ j, Good (witness j))
    (hne : ∀ j, witness j ≠ base)
    (hagree : ∀ i j, i ≠ j → coord i (witness j) = coord i base)
    (S : Finset ι) :
    ∃ u w : A, Good u ∧ Good w ∧ u ≠ w ∧
      (fun i : {i // i ∈ S} => coord i u) = fun i : {i // i ∈ S} => coord i w := by
  -- 第一段: `S` に属さない添字 `j` を取る（`ι` は有限集合で尽くせない）。
  obtain ⟨j, hjS⟩ := Infinite.exists_notMem_finset S
  -- 第二段: `u := base`, `w := witness j` と置く。いずれも `Good` を満たす。
  refine ⟨base, witness j, hbase, hwitness j, ?_, ?_⟩
  · -- 第四段: `witness j ≠ base` なので `base ≠ witness j`。
    exact (hne j).symm
  · -- 第三段: すべての `i ∈ S` で第 `i` 座標が一致する（`i ∈ S`, `j ∉ S` より `i ≠ j`）。
    funext i
    have hij : (i : ι) ≠ j := fun h => hjS (h ▸ i.2)
    exact (hagree _ _ hij).symm

end Ising3DCut.NecSuf
