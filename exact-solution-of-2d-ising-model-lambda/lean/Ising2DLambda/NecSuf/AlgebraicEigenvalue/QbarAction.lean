/-
主張「行列の積の作用は、作用を 2 度施したものである」の必要十分版。

証明手順は具体版（`Ising2DLambda.AlgebraicEigenvalue.QbarAction`）と同じである
（作用の定義で開く → 分配則 → 結合則 → 有限和の順序の入れ替え → 分配則で外へ出す）。

  使っている性質            なぜ削れないか
  `Fintype ι`               有限和 `∑ j, …` を取るのに要る。添字が 2 つとも同じ型である
                            必要は無いが、行列の積を書くために同じ型にしてある。
  `NonUnitalSemiring M`     加法が可換モノイドであること（有限和の順序の入れ替え）、
                            積の結合則（第 4 段）、および有限和と元の積についての分配則を
                            両側で使う（第 3 段と第 6 段）。

削れたもの: 積の可換性（**使っていない**）・積の単位元・加法の逆元・零元でない元の逆元・
体であること・値が代数的数であること（`Qbar`）・添字が行配位であること・順序 ≺。
すなわちこの段は有限和の書き換えだけであり、対象についての性質を一つも使っていない。

住処: ここに ℝ / ℂ は現れない（値は一般の非単位的半環の元）。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Sigma
import Mathlib.Algebra.BigOperators.Ring.Finset

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

/-- 必要十分版の本体。人手証明の鎖の第 2 段から第 7 段までを、
有限和の等式として書いたものである（第 1 段と第 8 段は作用の定義そのもの）。 -/
theorem action_product_necSuf
    {ι M : Type*} [Fintype ι] [NonUnitalSemiring M]
    (A B : ι → ι → M) (v : ι → M) (i : ι) :
    (∑ k : ι, (∑ j : ι, A i j * B j k) * v k)
      = ∑ j : ι, A i j * ∑ k : ι, B j k * v k :=
  calc (∑ k : ι, (∑ j : ι, A i j * B j k) * v k)
      = ∑ k : ι, ∑ j : ι, (A i j * B j k) * v k := by
        -- 第 3 段。有限和と元の積についての分配則。
        exact sum_congr rfl fun k _ => sum_mul _ _ _
    _ = ∑ k : ι, ∑ j : ι, A i j * (B j k * v k) := by
        -- 第 4 段。積の結合則。
        exact sum_congr rfl fun k _ => sum_congr rfl fun j _ => mul_assoc _ _ _
    _ = ∑ j : ι, ∑ k : ι, A i j * (B j k * v k) := by
        -- 第 5 段。有限和の順序の入れ替え。
        exact Finset.sum_comm
    _ = ∑ j : ι, A i j * ∑ k : ι, B j k * v k := by
        -- 第 6 段。元と有限和の積についての分配則。
        exact sum_congr rfl fun j _ => (mul_sum _ _ _).symm

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
