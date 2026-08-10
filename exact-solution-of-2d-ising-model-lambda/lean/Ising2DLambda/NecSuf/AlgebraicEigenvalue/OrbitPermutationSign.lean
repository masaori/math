/-
定義「軌道の上の全単射の符号」と主張「軌道を保つ置換の符号は軌道ごとの符号の積である」の
必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.OrbitPermutationSign`）の証明が実際に使っているのは
次だけである。証明手順は具体版と同じ（同じ 10 段の式変形）。

  使っている性質                            どこで
  値の側が可換モノイドであること              有限積を取る段・積の順序を入れ替える段
  u * u = 1                                  またぐ項 `u^{2k}` を落とす段
  指数の分解 n = (Σ_{i∈s} f i) + 2 k         代入の段（人手証明の転倒数の分解と偶数性）

削れなかった仮定と、その理由。

1. `hu : u * u = 1`。またぐ項が消える段の本体である。**`u` について使っているのはこれだけ**で、
   `u = -1` であることも、`u ≠ 1` であることも、値の側に加法や引き算があることも使わない。
   すなわち人手証明が `(-1)^2 = 1` としか書いていないことが、そのまま仮定の形で出ている。
2. `hn : n = (∑ i ∈ s, f i) + 2 * k`。人手証明が前 2 セクションから代入する等式そのものである。
   `f` にも `s` にも `k` にも他の要求は無い（`f` が転倒数であることも、`s` が軌道の全体で
   あることも使わない）。

具体版との差で言えば、次はいずれも使っていない。

* 値の側が環であること・整数であること・零元があること。可換モノイドで足りる。
* 添字が有限型であること・相等が判定できること（`s : Finset β` の外に何も要らない）。
* 族の元が軌道であること・置換であること・順序 `≺` があること。
  順序は人手証明では `f` を作る側（転倒数）にしか現れず、この段には入ってこない。

mathlib の `Equiv.Perm.sign` は引いていない。使ったのは `pow_add` / `pow_mul` /
`Finset.prod_pow_eq_pow_sum` だけであり、いずれも人手証明の 1 段に 1 つ対応する。

住処: ここに ℝ / ℂ は現れない（指数は ℕ、値は一般の可換モノイド）。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

variable {β : Type*} {M : Type*} [CommMonoid M]

/-- 人手証明の主張「軌道を保つ置換の符号は、軌道ごとの符号の積である」の必要十分版。

指数が「族にわたる和」と「偶数」の和に分かれていれば、冪は族ごとの冪の積に等しい。
`u` に要求するのは `u * u = 1` だけである。 -/
theorem pow_eq_prod_pow_of_even_remainder (u : M) (hu : u * u = 1) (s : Finset β) (f : β → ℕ)
    (n k : ℕ) (hn : n = (∑ i ∈ s, f i) + 2 * k) :
    u ^ n = ∏ i ∈ s, u ^ f i := by
  calc u ^ n
      = u ^ ((∑ i ∈ s, f i) + 2 * k) := by rw [hn]
    _ = u ^ (∑ i ∈ s, f i) * u ^ (2 * k) := pow_add _ _ _
    _ = u ^ (∑ i ∈ s, f i) * (u ^ 2) ^ k := by rw [pow_mul]
    _ = u ^ (∑ i ∈ s, f i) * (1 : M) ^ k := by rw [pow_two, hu]
    _ = u ^ (∑ i ∈ s, f i) * (1 : M) := by rw [one_pow]
    _ = u ^ (∑ i ∈ s, f i) := mul_one _
    _ = ∏ i ∈ s, u ^ f i := (Finset.prod_pow_eq_pow_sum s f u).symm

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
