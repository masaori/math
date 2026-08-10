/-
主張「シフト行列の特性行列の対角成分は、その軌道の元の個数で決まる」の必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.ShiftCharDiagonalEntry`）の証明は、
成分が 2 つの場合分けで与えられていること、その場合分けの条件が別の条件と同値であること、
そして一方の場合の値を送ると目的の値になることの 3 つだけを使う。証明手順は具体版と同じ
（同値で条件を移し、場合ごとに値を書き換える）。

  使っている性質                なぜ削れないか
  `hPQ : P ↔ Q`                 場合分けの条件を、判定したい条件へ移す唯一の経路。
  `hz : ¬P → v = z`             第一の場合で成分の値を決める。
  `ho : P → v = o`              第二の場合で成分の値を決める。
  `hfz : f z = x`               第一の場合で `f v` を目的の値 `x` へ落とす段
                                （具体版では `X + ι(-κ(0)) = X`）。

削れたもの: 値の側の代数構造（半環も加法も要らない。`f` は勝手な写像でよい）、
台が軌道であること、写像が巡回シフトであること、型の有限性、順序 `≺`、
そして「軌道の元の個数」という数え上げそのもの（`Q` は勝手な命題でよい）。

住処: ここに ℝ / ℂ は現れない（値は一般の型）。
-/
import Mathlib.Tactic.Common

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 人手証明の主張「2 つの場合で与えられた成分は、同値な条件で場合分けしても同じ値を取る」の
第一の場合（具体版の `|O| ≥ 2` の側）。 -/
theorem entry_of_not_right {α β : Type*} {P Q : Prop} {v z : α} {f : α → β} {x : β}
    (hPQ : P ↔ Q) (hz : ¬P → v = z) (hfz : f z = x) (hQ : ¬Q) : f v = x := by
  rw [hz (fun hP => hQ (hPQ.mp hP)), hfz]

/-- 同じ主張の第二の場合（具体版の `|O| = 1` の側）。 -/
theorem entry_of_right {α β : Type*} {P Q : Prop} {v o : α} {f : α → β}
    (hPQ : P ↔ Q) (ho : P → v = o) (hQ : Q) : f v = f o := by
  rw [ho (hPQ.mpr hQ)]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
