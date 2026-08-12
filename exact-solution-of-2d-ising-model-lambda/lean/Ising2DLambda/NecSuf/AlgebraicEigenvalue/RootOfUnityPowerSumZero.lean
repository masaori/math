/-
主張「冪が 1 でない 1 の冪根があるとき、冪の和は零元である」の必要十分版。

証明手順は具体版（`Ising2DLambda.AlgebraicEigenvalue.RootOfUnityPowerSumZero`）と同じである。
すなわち鎖 `(a - 1) S = a S - 1·S = a S - S = S - S = 0` を作り、そこへ
「積が零元ならば零元でない方で割れる」の必要十分版を当てる。

  使っている性質                なぜ削れないか
  `Ring R`                      引き算がないと `a - 1` が書けない（鎖の第 1 段の分配則と第 4 段の差）。
  `hinv : inv * (a - 1) = 1`    最後の段。`a - 1` が左から割れることだけを仮定として受け取る。
  `hS : a * S = S`              鎖の第 3 段。和の不変性を、和の構造を忘れて 1 本の等式として受け取る。

削れたもの: 体であること・可換であること・代数閉であること・値が代数的数であること（`Qbar`）・
`S` が μ_n にわたる冪の和であること（勝手な元でよい）・`a` が冪 `w^m` であること・
仮定 `a ≠ 1`（具体版では、体であることを使ってここから左逆元を作る）。

この版の眼目は 2 つある。第 1 に、**`S` の和としての作り方も `a` の冪としての作り方も
一切使っていない**——「`a` 倍で動かない元は、`a - 1` が左可逆なら零元である」という
1 本の言明である。第 2 に、仮定が「`a ≠ 1`」ではなく「`a - 1` が左逆元を持つこと」で
足りる（`a ≠ 1` から左逆元が出るのは体だからであって、この段自身が体を要求しているわけではない）。

住処: ここに ℝ / ℂ は現れない（元は一般の環の元）。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarNoZeroDivisors
import Mathlib.Algebra.Ring.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 必要十分版の本体。環 `R` の元 `a`・`S` について `a * S = S` であり、`a - 1` が
左逆元 `inv` を持つならば、`S = 0`。 -/
theorem power_sum_zero_necSuf {R : Type*} [Ring R] {a S inv : R}
    (hinv : inv * (a - 1) = 1) (hS : a * S = S) : S = 0 := by
  have hchain : (a - 1) * S = 0 :=
    calc (a - 1) * S
        = a * S - 1 * S := sub_mul _ _ _   -- 第 1 段。分配則。
      _ = a * S - S := by rw [one_mul]     -- 第 2 段。1 は積の単位元。
      _ = S - S := by rw [hS]              -- 第 3 段。不変性（仮定）。
      _ = 0 := sub_self _                  -- 第 4 段。同じ元の差は零元。
  exact no_zero_divisors_necSuf (M := R) hinv hchain

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
