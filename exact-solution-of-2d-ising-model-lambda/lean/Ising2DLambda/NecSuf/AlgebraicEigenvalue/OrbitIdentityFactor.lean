/-
主張「恒等写像の因子は、その軌道の元の個数で決まる」の必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.OrbitIdentityFactor`）の証明は、重みが単位元で
あることで積だけを残し、そのあと 2 つの場合それぞれで有限積を計算する。証明手順は具体版と同じ
（単位元を落とす → 各因子を書き換える → 積を閉じた形にする）。

  使っている性質                なぜ削れないか
  `hw : w = 1`                  重みを落とす唯一の経路。これが無いと積の前の因子が残る。
  `hf : ∀ i ∈ s, f i = c`       第一の場合で、すべての因子が同じ値であること。
                                これが無いと積を冪へ畳めない。
  `hs : s = {a}`                第二の場合で、積が 1 つの因子であること。
  `CommMonoid M`                有限積そのものに要る（並べる順序によらないこと）。

削れたもの: 添字が行配位であること、台が軌道であること、`f` が特性行列の対角成分であること、
`w` が符号であること（±1 であることも乗法的であることも使わない）、順序 `≺`、
添字の型が有限であること、値が多項式であること（可換モノイドで足りる。加法も零元も要らない）。

住処: ここに ℝ / ℂ は現れない（添字は一般の型、値は一般の可換モノイド）。
-/
import Mathlib.Algebra.BigOperators.Ring.Finset

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

/-- 第一の場合の本体。重みが単位元で、台の上で因子がすべて `c` に等しいならば、
重み付きの有限積は `c` の `s.card` 乗である。 -/
theorem unitSignProd_eq_pow {ι : Type*} {M : Type*} [CommMonoid M]
    (w : M) (s : Finset ι) (f : ι → M) (c : M)
    (hw : w = 1) (hf : ∀ i ∈ s, f i = c) :
    w * ∏ i ∈ s, f i = c ^ s.card := by
  rw [hw, one_mul, Finset.prod_congr rfl hf, Finset.prod_const]

/-- 第二の場合の本体。重みが単位元で、台が 1 元集合 `{a}` ならば、
重み付きの有限積は `f a` である。 -/
theorem unitSignProd_eq_single {ι : Type*} {M : Type*} [CommMonoid M]
    (w : M) (s : Finset ι) (f : ι → M) (a : ι)
    (hw : w = 1) (hs : s = {a}) :
    w * ∏ i ∈ s, f i = f a := by
  rw [hw, one_mul, hs, Finset.prod_singleton]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
