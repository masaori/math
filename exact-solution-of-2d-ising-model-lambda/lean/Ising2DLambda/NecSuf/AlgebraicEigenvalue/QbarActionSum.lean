/-
主張「行列の作用は列ベクトルの有限和を保つ」の必要十分版。

証明手順は具体版（`Ising2DLambda.AlgebraicEigenvalue.QbarActionSum`）と同じである
（作用の定義で開く → 元と有限和の積についての分配則 → 有限和の順序の入れ替え）。

  使っている性質                     なぜ削れないか
  `Fintype κ`                        作用に現れる有限和 `∑ j, …` を取るのに要る。
  `NonUnitalNonAssocSemiring M`      元と有限和の積についての分配則（第 3 段。`Finset.mul_sum`
                                     は `mul_add` と `mul_zero` から出る）と、加法が可換モノイド
                                     であること（第 4 段の順序の入れ替え）。
                                     **積の結合則も可換性も使っていない。**

削れたもの: 外側の添字の型 `ι` の有限性（和を取るのは `Finset s` の上なので、型が有限である
必要はない）・積の単位元・加法の逆元・零元でない元の逆元・体であること・値が代数的数である
こと（`Qbar`）・添字が行配位であること・順序 ≺。

2 元の和の版（`action_add_necSuf`）と仮定がまったく同じであることが、この必要十分版の
眼目である。すなわち項の個数を増やしても新しい性質は要らない。

住処: ここに ℝ / ℂ は現れない（値は一般の半環の元）。
-/
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.BigOperators.Group.Finset.Sigma

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

/-- 必要十分版。人手証明の鎖の第 2 段から第 5 段までを、有限和の等式として書いたものである
（第 1 段と第 6 段は定義そのもの）。 -/
theorem action_sum_necSuf
    {ι κ M : Type*} [Fintype κ] [NonUnitalNonAssocSemiring M]
    (A : κ → κ → M) (s : Finset ι) (v : ι → κ → M) (i : κ) :
    (∑ j : κ, A i j * ∑ k ∈ s, v k j) = ∑ k ∈ s, ∑ j : κ, A i j * v k j :=
  calc (∑ j : κ, A i j * ∑ k ∈ s, v k j)
      = ∑ j : κ, ∑ k ∈ s, A i j * v k j := by
        -- 第 3 段。元と有限和の積についての分配則。
        exact sum_congr rfl fun j _ => mul_sum _ _ _
    _ = ∑ k ∈ s, ∑ j : κ, A i j * v k j := by
        -- 第 4 段。有限和の順序の入れ替え。
        exact sum_comm

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
