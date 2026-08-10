/-
主張「軌道の元の個数が 2 以上のとき、巡回シフトの制限の因子は単位元の加法についての逆元である」
の必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.OrbitShiftRestrictionFactor`）の証明は、
重みを `u` の冪へ書き換え、台の上で因子がすべて `u` に等しいことで積を `u ^ s.card` へ畳み、
指数を足してから `u * u = 1` で落とす。証明手順は具体版と同じ
（重みを書き換える → 積を冪へ畳む → 指数を足す → 二乗を落とす）。

  使っている性質                なぜ削れないか
  `hw : w = u ^ (s.card - 1)`   重みの形。これが無いと指数を足す段に入れない。
  `hf : ∀ i ∈ s, f i = u`       台の上で因子がすべて `u` に等しいこと。
                                これが無いと積を冪へ畳めない。
  `hu : u * u = 1`              二乗を落とす唯一の経路。これが無いと `u ^ (2k+1)` が残る。
  `hcard : 1 ≤ s.card`          指数の分解 `(s.card - 1) + s.card = 2*(s.card - 1) + 1` は
                                自然数の引き算なので、これが無いと成り立たない。
  `CommMonoid M`                有限積そのものに要る（並べる順序によらないこと）。

削れたもの: 添字が行配位であること、台が軌道であること、`f` が特性行列の成分であること、
`u` が `ι(-κ(1))` であること（`-1` であることも、加法や零元があることも使わない。
要るのは `u * u = 1` だけである）、重みが符号であること、順序 `≺`、
添字の型が有限であること、値が多項式であること（可換モノイドで足りる）。

住処: ここに ℝ / ℂ は現れない（添字は一般の型、値は一般の可換モノイド）。
-/
import Mathlib.Algebra.BigOperators.Ring.Finset

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

/-- 本体。重みが `u ^ (s.card - 1)` で、台の上で因子がすべて `u` に等しく、
`u * u = 1` かつ `1 ≤ s.card` ならば、重み付きの有限積は `u` である。 -/
theorem signedProd_eq_unit {ι : Type*} {M : Type*} [CommMonoid M]
    (w : M) (s : Finset ι) (f : ι → M) (u : M)
    (hw : w = u ^ (s.card - 1)) (hf : ∀ i ∈ s, f i = u)
    (hu : u * u = 1) (hcard : 1 ≤ s.card) :
    w * ∏ i ∈ s, f i = u := by
  -- 積を冪へ畳む。
  have hprod : ∏ i ∈ s, f i = u ^ s.card := by
    rw [Finset.prod_congr rfl hf, Finset.prod_const]
  -- 指数を足し、`2*(s.card - 1) + 1` の形へ直す。
  have hexp : (s.card - 1) + s.card = 2 * (s.card - 1) + 1 := by omega
  calc w * ∏ i ∈ s, f i
      = u ^ (s.card - 1) * u ^ s.card := by rw [hw, hprod]
    _ = u ^ ((s.card - 1) + s.card) := (pow_add u _ _).symm
    _ = u ^ (2 * (s.card - 1) + 1) := by rw [hexp]
    _ = (u * u) ^ (s.card - 1) * u := by
        rw [pow_succ, pow_mul, sq]
    _ = u := by rw [hu, one_pow, one_mul]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
