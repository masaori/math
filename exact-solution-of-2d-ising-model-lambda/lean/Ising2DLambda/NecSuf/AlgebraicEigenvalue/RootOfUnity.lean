/-
主張「約数を指数として 1 になる代数的数は、その倍数を指数としても 1 になる」の必要十分版。

証明手順は具体版（`Ising2DLambda.AlgebraicEigenvalue.RootOfUnity`）と同じ 4 段の鎖である
（n = d k を取る → 指数法則 → z^d = 1 の代入 → 単位元の反復積）。

  使っている性質      なぜ削れないか
  `Monoid M`          冪 `z ^ n` が定義され、指数法則 `pow_mul` が成り立つのに要る。
                      これより弱い構造（半群）では `z ^ 0 = 1` が書けず、
                      `k = 0` の場合（n = 0）に主張が言えない。

削れたもの: 体であること・可換性・逆元の存在・標数 0・代数閉であること・
値が代数的数であること（すなわち `Qbar` であること）・型の可算性。
すなわちこの段は**代数的数の話を一切使っていない**。1 の冪根であることも、
`d` や `n` が 0 でないことも使わない。

住処: ここに ℝ / ℂ は現れない（値は一般のモノイド、指数は ℕ）。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 必要十分版の本体。モノイドの元 `z` が `z ^ d = 1` を満たし `d ∣ n` ならば `z ^ n = 1`。 -/
theorem pow_eq_one_of_dvd_necSuf {M : Type*} [Monoid M] {z : M} {d n : ℕ}
    (hd : d ∣ n) (hz : z ^ d = 1) : z ^ n = 1 := by
  obtain ⟨k, hk⟩ := hd
  calc z ^ n
      = z ^ (d * k) := by rw [hk]
    _ = (z ^ d) ^ k := by rw [pow_mul]
    _ = (1 : M) ^ k := by rw [hz]
    _ = 1 := one_pow k

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
