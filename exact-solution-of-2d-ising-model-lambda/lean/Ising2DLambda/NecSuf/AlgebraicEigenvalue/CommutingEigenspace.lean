/-
主張「可換な行列は固有空間を保つ」の必要十分版。

証明手順は具体版（`Ising2DLambda.AlgebraicEigenvalue.QbarCommutingEigenspace`）と同じである
（作用の積で `A·(B·v)` を `(AB)·v` へ畳む → 可換性で `(BA)·v` へ → 作用の積で開く →
  固有空間の条件を当てる → 作用がスカラー倍を保つことで `z ⊙ (B·v)` にする）。

  使っている性質            なぜ削れないか
  `hact_mul`                作用の積 `act (mul A B) v = act A (act B v)`。鎖の第 1・3 段。
                            具体版ではこれが `qbarAction_product` である。
  `hcomm`                   仮定 `AB = BA`。鎖の第 2 段。**これが本体である**
                            （削ると結論が偽になる。SageMath 側で反例を出してある）。
  `hact_smul`               作用がスカラー倍を保つこと。鎖の第 5 段。
                            具体版ではこれが `qbarAction_smul` である。

削れたもの: **行列であることも、値の型の代数構造も、添字の型の有限性も使っていない。**
`act` は「行列の型 M と ベクトルの型 V を受け取って V を返す勝手な写像」でよく、
`mul` は M の上の勝手な二項演算でよい。結合則も単位元も分配則も仮定していない
（`hact_mul` が 1 本あれば足りる）。スカラーの型も勝手な型でよい。

なお `hcomm` は「任意の 2 元が可換であること」ではなく、**その 2 つの行列 A・B についてだけ**
の等式である。可換性を全体に要求していないことがここで見える。

住処: ここに ℝ / ℂ は現れない（型は勝手な型である）。
-/
import Mathlib.Logic.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 必要十分版。作用が積と両立し、`A` と `B` が可換で、作用がスカラー倍を保つならば、
`A` の固有空間の条件は `B` の作用で閉じる。 -/
theorem commuting_preserves_eigenspace_necSuf
    {M V S : Type*} (act : M → V → V) (mul : M → M → M) (smul : S → V → V)
    (hact_mul : ∀ (A B : M) (v : V), act (mul A B) v = act A (act B v))
    (hact_smul : ∀ (B : M) (c : S) (v : V), act B (smul c v) = smul c (act B v))
    (A B : M) (hcomm : mul A B = mul B A)
    (z : S) (v : V) (hv : act A v = smul z v) :
    act A (act B v) = smul z (act B v) :=
  calc act A (act B v)
      = act (mul A B) v := (hact_mul A B v).symm
        -- 第 1 段。作用の積（右辺から左辺へ）。
    _ = act (mul B A) v := by
        -- 第 2 段。仮定 AB = BA。
        rw [hcomm]
    _ = act B (act A v) := hact_mul B A v
        -- 第 3 段。作用の積。
    _ = act B (smul z v) := by
        -- 第 4 段。固有空間の条件（v ∈ E_A(z)）。
        rw [hv]
    _ = smul z (act B v) := hact_smul B z v
        -- 第 5 段。作用がスカラー倍を保つこと。

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
