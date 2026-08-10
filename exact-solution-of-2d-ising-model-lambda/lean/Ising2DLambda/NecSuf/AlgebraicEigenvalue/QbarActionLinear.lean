/-
主張「行列の作用は列ベクトルの和を保つ」「行列の作用は列ベクトルのスカラー倍を保つ」の
必要十分版。

証明手順は具体版（`Ising2DLambda.AlgebraicEigenvalue.QbarActionLinear`）と同じである
（和: 作用の定義で開く → 分配則 → 有限和の項ごとの分割。
  倍: 作用の定義で開く → 結合則 → 可換性 → 結合則 → 分配則で外へ出す）。

  使っている性質                    なぜ削れないか
  `Fintype ι`                       有限和 `∑ j, …` を取るのに要る。
  和の側 `NonUnitalNonAssocSemiring` 元と 2 元の和の積についての分配則（第 3 段）と、
                                    加法が可換モノイドであること（第 4 段の項ごとの分割）。
                                    **積の結合則も可換性も使っていない**ので、
                                    `NonUnitalSemiring` まで強めていない。
  倍の側 `NonUnitalCommSemiring`    積の結合則（第 3・5 段）と可換性（第 4 段）、
                                    および元と有限和の積についての分配則（第 6 段）。
                                    可換性は `z` を成分の左へ移す段で実際に要る
                                    （成分と `z` の積の順を入れ替えないと外へ出せない）。

削れたもの: 積の単位元・加法の逆元・零元でない元の逆元・体であること・
値が代数的数であること（`Qbar`）・添字が行配位であること・順序 ≺。

**2 つの主張で仮定が違うことがこの必要十分版の眼目である。** 和を保つことは可換性も
結合則も要求せず、スカラー倍を保つことだけが可換性を要求する。

住処: ここに ℝ / ℂ は現れない（値は一般の半環の元）。
-/
import Mathlib.Algebra.BigOperators.Ring.Finset

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

/-- 必要十分版（その 1）。人手証明の鎖の第 2 段から第 5 段までを、有限和の等式として
書いたものである（第 1 段と第 6 段は定義そのもの）。 -/
theorem action_add_necSuf
    {ι M : Type*} [Fintype ι] [NonUnitalNonAssocSemiring M]
    (A : ι → ι → M) (v w : ι → M) (i : ι) :
    (∑ j : ι, A i j * (v j + w j))
      = (∑ j : ι, A i j * v j) + ∑ j : ι, A i j * w j :=
  calc (∑ j : ι, A i j * (v j + w j))
      = ∑ j : ι, (A i j * v j + A i j * w j) := by
        -- 第 3 段。元と 2 元の和の積についての分配則。
        exact sum_congr rfl fun j _ => mul_add _ _ _
    _ = (∑ j : ι, A i j * v j) + ∑ j : ι, A i j * w j := by
        -- 第 4 段。有限和の項ごとの分割。
        exact sum_add_distrib

/-- 必要十分版（その 2）。人手証明の鎖の第 2 段から第 7 段までを、有限和の等式として
書いたものである（第 1 段と第 8 段は定義そのもの）。 -/
theorem action_smul_necSuf
    {ι M : Type*} [Fintype ι] [NonUnitalCommSemiring M]
    (A : ι → ι → M) (z : M) (v : ι → M) (i : ι) :
    (∑ j : ι, A i j * (z * v j)) = z * ∑ j : ι, A i j * v j :=
  calc (∑ j : ι, A i j * (z * v j))
      = ∑ j : ι, (A i j * z) * v j := by
        -- 第 3 段。積の結合則。
        exact sum_congr rfl fun j _ => (mul_assoc _ _ _).symm
    _ = ∑ j : ι, (z * A i j) * v j := by
        -- 第 4 段。積の可換性。
        exact sum_congr rfl fun j _ => by rw [mul_comm (A i j) z]
    _ = ∑ j : ι, z * (A i j * v j) := by
        -- 第 5 段。積の結合則。
        exact sum_congr rfl fun j _ => mul_assoc _ _ _
    _ = z * ∑ j : ι, A i j * v j := by
        -- 第 6 段。元と有限和の積についての分配則。
        exact (mul_sum _ _ _).symm

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
