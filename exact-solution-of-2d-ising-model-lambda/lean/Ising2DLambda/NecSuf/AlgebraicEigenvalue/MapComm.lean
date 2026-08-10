/-
主張「評価で運んだシフト行列と転送行列は可換である」の必要十分版。

証明手順は具体版（`Ising2DLambda.AlgebraicEigenvalue.QbarShiftTransferComm`）と同じである
（積を保つことを右辺から左辺へ使って 1 つの像へ畳む → もとの側の可換性で入れ替える →
  積を保つことで開く）。

  使っている性質   なぜ削れないか
  `hmap_mul`       写像が積を保つこと `f (mulA a b) = mulB (f a) (f b)`。鎖の第 1・3 段。
                   具体版ではこれが `qbarMatrixEval_product` である。
                   削ると結論が偽になる（SageMath 側で、積を保たない写像で運ぶと
                   もとの側が可換でも行き先の可換性が破れる例を記録してある）。
  `hcomm`          もとの側の可換性 `mulA a b = mulA b a`。鎖の第 2 段。**これが本体である**
                   （削ると結論が偽になる。SageMath 側で、可換でない 2 つの行列を運ぶと
                   行き先でも可換でないことを記録してある）。

削れたもの: **行列であることも、値の型の代数構造も、添字の型の有限性も使っていない。**
`mulA`・`mulB` はそれぞれの型の上の勝手な二項演算でよく、結合則も単位元も分配則も
可換性（全体としての）も仮定していない。`f` は勝手な写像でよく、和を保つことも
環準同型であることも要求しない。

なお `hcomm` は「任意の 2 元が可換であること」ではなく、**その 2 元 a・b についてだけ**の
等式である。可換性を全体に要求していないことがここで見える。

住処: ここに ℝ / ℂ は現れない（型は勝手な型である）。
-/
import Mathlib.Logic.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 必要十分版。積を保つ写像は、もとの側で可換な 2 元を行き先でも可換な 2 元へ写す。 -/
theorem map_comm_necSuf
    {A B : Type*} (f : A → B) (mulA : A → A → A) (mulB : B → B → B)
    (hmap_mul : ∀ a b : A, f (mulA a b) = mulB (f a) (f b))
    (a b : A) (hcomm : mulA a b = mulA b a) :
    mulB (f a) (f b) = mulB (f b) (f a) :=
  calc mulB (f a) (f b)
      = f (mulA a b) := (hmap_mul a b).symm
        -- 第 1 段。写像が積を保つこと（右辺から左辺へ）。
    _ = f (mulA b a) := by
        -- 第 2 段。もとの側の可換性。
        rw [hcomm]
    _ = mulB (f b) (f a) := hmap_mul b a
        -- 第 3 段。写像が積を保つこと。

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
