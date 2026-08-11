/-
主張「1 の冪根の全体にわたる冪の和は、1 の冪根の冪を掛けても動かない」の必要十分版。

証明手順は具体版（`Ising2DLambda.AlgebraicEigenvalue.RootOfUnityPowerSum`）と同じである。
すなわち、掛ける操作を有限和の各項へ配り（分配則）、各項を全単射で読み替え（写像との両立）、
添字を取り替えて（全単射）もとの和へ戻す。

  使っている性質                          なぜ削れないか
  `Fintype ι`                             有限和が定まること。無限和は書けない。
  `NonUnitalNonAssocSemiring R`           積が有限和へ分配されること（第 2 の等号）。
  `he : Function.Bijective e`             添字の取り替え（第 5 の等号）。
  `hcompat : ∀ z, c * f z = f (e z)`      第 3・第 4 の等号をまとめたもの。

削れたもの: 積の可換性・結合則・単位元・逆元の存在（`NonUnitalNonAssoc` で足りる）・
体であること・代数閉であること・値が代数的数であること（`Qbar`）・
`f` が冪の形であること・`c` が冪の形であること・`e` が「掛ける操作」であること・
`ι` が 1 の冪根の全体であること・`n` と `m` そのもの。

この版の眼目は、具体版が使っているのが**分配則 1 本と、全単射 1 つと、
「掛けることが全単射に沿う」という両立条件 1 本だけ**だと分かることである。
とくに `c * f z = f (e z)` は具体版では `(w z)^m = w^m z^m`（積の冪は冪の積）から来るが、
その中身はここでは要らない。1 の冪根であることも、冪であることも本質的ではない。

住処: ここに ℝ / ℂ は現れない（元は一般の半環の元）。
-/
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.BigOperators.Group.Finset.Defs
import Mathlib.Logic.Function.Defs

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open BigOperators

/-- 必要十分版の本体。有限型 `ι` 上の族 `f` と元 `c` について、`c` を掛ける操作が
全単射 `e` に沿う（`c * f z = f (e z)`）ならば、`c` を掛けても総和は動かない。 -/
theorem sum_mul_invariant_necSuf {ι R : Type*} [Fintype ι] [NonUnitalNonAssocSemiring R]
    (f : ι → R) (c : R) (e : ι → ι) (he : Function.Bijective e)
    (hcompat : ∀ z : ι, c * f z = f (e z)) :
    c * ∑ z : ι, f z = ∑ z : ι, f z := by
  calc c * ∑ z : ι, f z
      = ∑ z : ι, c * f z := Finset.mul_sum _ _ _
      -- 分配則。これが第 2 の等号である。
    _ = ∑ z : ι, f (e z) := Finset.sum_congr rfl (fun z _ => hcompat z)
      -- 両立条件。具体版の第 3・第 4 の等号をまとめたものである。
    _ = ∑ z : ι, f z := Fintype.sum_bijective e he (fun z => f (e z)) f (fun _ => rfl)
      -- 添字の取り替え。これが第 5 の等号である。

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
