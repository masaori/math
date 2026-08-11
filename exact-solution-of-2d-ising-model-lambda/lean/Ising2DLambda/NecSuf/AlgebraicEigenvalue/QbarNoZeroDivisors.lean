/-
主張「代数的数の積が零元ならば、零元でない方で割って他方が零元と分かる」の必要十分版。

証明手順は具体版（`Ising2DLambda.AlgebraicEigenvalue.QbarNoZeroDivisors`）と同じである。
すなわち `b = 1 b = (a⁻¹ a) b = a⁻¹ (a b) = a⁻¹ 0 = 0` の 5 段の鎖である。

  使っている性質                なぜ削れないか
  `MonoidWithZero M`            積が結合的であること（第 3 段）、積の単位元があること（第 1 段）、
                                零元との積が零元であること（第 5 段）。
  `hinv : ainv * a = 1`         第 2 段。`a` の左逆元を仮定として受け取る。

削れたもの: 体であること・可換であること・代数閉であること・値が代数的数であること（`Qbar`）・
加法についての性質（和も引き算も証明に現れない）・`a ≠ 0`（左逆元を持つことだけが要る。
具体版ではそれを `a ≠ 0` から作る）・`a` 以外の元が逆元を持つこと。

この版の眼目は、**逆元を「すべての零でない元が持つ」形ではなく、
`a` 1 つについての仮定として受け取れば足りる**ことである。すなわちこの段は
「零因子が無いこと」という体の性質ではなく、`a` が左から割れることだけを使っている。

住処: ここに ℝ / ℂ は現れない（元は一般のモノイドの元）。
-/
import Mathlib.Algebra.GroupWithZero.Defs

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 必要十分版の本体。零元を持つモノイド `M` の元 `a` が左逆元 `ainv` を持つとき、
`a * b = 0` ならば `b = 0`。 -/
theorem no_zero_divisors_necSuf {M : Type*} [MonoidWithZero M] {a b ainv : M}
    (hinv : ainv * a = 1) (hab : a * b = 0) : b = 0 := by
  calc b
      = 1 * b := (one_mul b).symm            -- 第 1 段。1 は積の単位元。
    _ = (ainv * a) * b := by rw [hinv]       -- 第 2 段。左逆元の性質。
    _ = ainv * (a * b) := mul_assoc _ _ _    -- 第 3 段。積の結合則。
    _ = ainv * 0 := by rw [hab]              -- 第 4 段。仮定 a b = 0。
    _ = 0 := mul_zero _                      -- 第 5 段。零元との積は零元。

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
