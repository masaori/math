/-
主張「軌道ごとの和は、格子の一辺を指数とする冪と単位元の逆元との和の因子である」の必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.OrbitSumDividesPowL`）の証明は、
`|O|` が `L` を割り切ることから `L = |O| k` を満たす `k` を取り、前のセクションの
`a^{dk} + u = (a^d + u) * Σ_{j<k} a^{dj}` を `d := |O|` として当てるものである。
証明手順は具体版と同じ（整除から `k` を取る → 前のセクションの等式 → 指数法則で戻す）。

  使っている性質                なぜ削れないか
  `Semiring R`                  有限和と積、分配則、単位元に要る（`pow_add_eq_mul_geom` が要求する）。
  `hu : 1 + u = 0`              `pow_add_eq_mul_geom` が要求する唯一の仮定。
  `h : d ∣ n`                   `k` を取り出す唯一の根拠。これが無いと有限和の長さが決まらない。

削れたもの: `a` が `t` であること、`d` が軌道の元の個数であること、`n` が格子の一辺であること
（どれも勝手な自然数でよい）、値が多項式であること、積の可換性、加法の逆元の存在。
すなわちこの段は**軌道の話を一切使っていない**（使うのは自然数の整除だけである）。

住処: ここに ℝ / ℂ は現れない（値は一般の半環、指数は ℕ）。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PowerSumTelescope

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

/-- 必要十分版の本体。`d ∣ n` ならば、`n = d * k` を満たす `k` が取れて
`a ^ n + u = (a ^ d + u) * Σ_{j<k} a ^ (d * j)` が成り立つ。

すなわち `a ^ d + u` は `a ^ n + u` を割る（商が明示されている形で述べる）。 -/
theorem pow_add_dvd_pow_add_of_dvd {R : Type*} [Semiring R] (a u : R) (hu : (1 : R) + u = 0)
    {d n : ℕ} (h : d ∣ n) :
    ∃ k : ℕ, n = d * k ∧
      a ^ n + u = (a ^ d + u) * ∑ j ∈ Finset.range k, a ^ (d * j) := by
  -- 整除の定義から `k` を取る（人手証明の「`k` を作る」段）。
  obtain ⟨k, hk⟩ := h
  refine ⟨k, hk, ?_⟩
  -- 前のセクションの等式を `a ^ d` について当てる。
  have hgeom := pow_add_eq_mul_geom (a ^ d) u hu k
  -- 指数法則 `(a ^ d) ^ j = a ^ (d * j)` で両側の形を揃える。
  have hpow : ∀ j : ℕ, (a ^ d) ^ j = a ^ (d * j) := fun j => (pow_mul a d j).symm
  rw [hpow k] at hgeom
  rw [hk, hgeom]
  exact congrArg _ (Finset.sum_congr rfl (fun j _ => hpow j))

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
