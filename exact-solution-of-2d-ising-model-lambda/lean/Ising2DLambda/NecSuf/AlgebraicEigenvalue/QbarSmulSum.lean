/-
主張「スカラー倍は列ベクトルの有限和を保つ」の必要十分版。

証明手順は具体版（`Ising2DLambda.AlgebraicEigenvalue.QbarSmulSum`）と同じである
（スカラー倍と有限和の定義で開く → 元と有限和の積についての分配則 → 定義へ戻す）。

  使っている性質                     なぜ削れないか
  `NonUnitalNonAssocSemiring M`      元と有限和の積についての分配則（第 3 段。`Finset.mul_sum`
                                     は `mul_add` と `mul_zero` から出る）。
                                     **積の結合則も可換性も使っていない。**

削れたもの: 添字の型 `ι` の有限性・**点の型 `κ` の有限性**（作用の版
`action_sum_necSuf` は作用に現れる有限和のために `Fintype κ` を要したが、この段は各点ごとに
独立な等式なので要らない）・有限和の順序の入れ替え（和が 1 つしか現れない）・積の単位元・
加法の逆元・零元でない元の逆元・体であること・値が代数的数であること（`Qbar`）・
添字が行配位であること・順序 ≺。

住処: ここに ℝ / ℂ は現れない（値は一般の半環の元）。
-/
import Mathlib.Algebra.BigOperators.Ring.Finset

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

/-- 必要十分版。人手証明の鎖の第 2 段から第 4 段までを、有限和の等式として書いたものである
（第 1 段と第 5 段は定義そのもの）。 -/
theorem smul_sum_necSuf
    {ι M : Type*} [NonUnitalNonAssocSemiring M]
    (z : M) (s : Finset ι) (v : ι → M) :
    z * (∑ i ∈ s, v i) = ∑ i ∈ s, z * v i :=
  -- 第 3 段。元と有限和の積についての分配則。
  mul_sum _ _ _

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
