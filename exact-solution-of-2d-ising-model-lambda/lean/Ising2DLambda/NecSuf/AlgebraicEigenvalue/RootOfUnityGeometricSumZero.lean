/-
主張「1 でない 1 の冪根の、冪の有限和は零元である」の必要十分版。

証明手順は具体版（`Ising2DLambda.AlgebraicEigenvalue.RootOfUnityGeometricSumZero`）と同じである。
すなわち鎖 `(z-1) Σ_{k<n} z^k = z^n - 1 = 1 - 1 = 0` を作り、そこへ
「積が零元ならば零元でない方で割れる」の必要十分版を当てる。

  使っている性質                なぜ削れないか
  `Ring R`                      引き算がないと `z - 1` も `z^n - 1` も書けない（伸縮の等式）。
  `hinv : inv * (z - 1) = 1`    最後の段。`z - 1` が左から割れることだけを仮定として受け取る。
  `hz : z ^ n = 1`              鎖の第 2 段。

削れたもの: 体であること・可換であること・代数閉であること・値が代数的数であること（`Qbar`）・
仮定 `z ≠ 1`（具体版では、体であることを使ってここから左逆元を作る）・
`z - 1` 以外の元が逆元を持つこと。

この版の眼目は、**仮定が「`z ≠ 1`」ではなく「`z - 1` が左逆元を持つこと」で足りる**ことである。
`z ≠ 1` から左逆元が出るのは体だからであって、この段自身が体を要求しているわけではない。
可換でない環でも、`z - 1` が可逆でありさえすれば同じ 3 段の鎖で結論が出る。

住処: ここに ℝ / ℂ は現れない（元は一般の環の元、指数は ℕ）。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarGeometricTelescope
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarNoZeroDivisors

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open BigOperators

/-- 必要十分版の本体。環 `R` の元 `z` について `z ^ n = 1` であり、`z - 1` が左逆元 `inv` を
持つならば、`Σ_{k<n} z^k = 0`。 -/
theorem geometric_sum_zero_necSuf {R : Type*} [Ring R] {z inv : R} {n : ℕ}
    (hinv : inv * (z - 1) = 1) (hz : z ^ n = 1) :
    (∑ k ∈ Finset.range n, z ^ k) = 0 := by
  have hchain : (z - 1) * (∑ k ∈ Finset.range n, z ^ k) = 0 :=
    calc (z - 1) * (∑ k ∈ Finset.range n, z ^ k)
        = z ^ n - 1 := geometric_telescope_necSuf z n   -- 第 1 段。伸縮の等式。
      _ = 1 - 1 := by rw [hz]                           -- 第 2 段。z^n = 1。
      _ = 0 := sub_self 1                               -- 第 3 段。同じ元の差は零元。
  exact no_zero_divisors_necSuf (M := R) hinv hchain

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
