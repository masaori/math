/-
主張「固有空間は和で閉じる」「固有空間はスカラー倍で閉じる」の必要十分版。

証明手順は具体版（`Ising2DLambda.AlgebraicEigenvalue.QbarEigenspace`）と同じである
（和: 作用が和を保つことで開く → 固有空間の条件を 2 度当てる → スカラー倍を和へ配る。
  倍: 作用がスカラー倍を保つことで開く → 固有空間の条件を当てる → 2 つのスカラー倍を入れ替える）。

  使っている性質                なぜ削れないか
  和: `hact_add`                作用が和を保つこと。鎖の第 1 段。
  和: `hsmul_add`               スカラー倍が和へ配ること（`z ⊙ (v ⊕ w) = (z ⊙ v) ⊕ (z ⊙ w)`）。
                                鎖の第 2 段から第 6 段までをまとめたもの。
                                具体版ではこれが値の側の分配則から出る。
  倍: `hact_smul`               作用がスカラー倍を保つこと。鎖の第 1 段。
  倍: `hsmul_comm`              2 つのスカラー倍が交換できること
                                （`c ⊙ (z ⊙ v) = z ⊙ (c ⊙ v)`）。鎖の第 5 段から第 7 段まで。
                                具体版ではこれが値の側の積の結合則と可換性から出る。

削れたもの: **値の型にも列ベクトルの型にも代数構造を一切仮定していない。** 半環も、
有限和も、添字の型が有限であることも、値が代数的数であることも、添字が行配位であることも、
行列であることさえ使っていない。作用は `V → V` の勝手な写像でよい。

**2 つの主張で仮定が違うことがこの必要十分版の眼目である。** 和で閉じることは
スカラー倍どうしの交換を要求せず、スカラー倍で閉じることだけがそれを要求する
（具体版ではそこが積の可換性である）。

住処: ここに ℝ / ℂ は現れない（型は勝手な型である）。
-/
import Mathlib.Logic.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 必要十分版（その 1）。作用が和を保ち、スカラー倍が和へ配るならば、
固有空間の条件は和で閉じる。 -/
theorem eigenspace_add_necSuf
    {V S : Type*} (act : V → V) (add : V → V → V) (smul : S → V → V)
    (hact_add : ∀ v w : V, act (add v w) = add (act v) (act w))
    (hsmul_add : ∀ (z : S) (v w : V), smul z (add v w) = add (smul z v) (smul z w))
    (z : S) (v w : V)
    (hv : act v = smul z v) (hw : act w = smul z w) :
    act (add v w) = smul z (add v w) :=
  calc act (add v w)
      = add (act v) (act w) := hact_add v w
        -- 第 1 段。作用が和を保つこと。
    _ = add (smul z v) (smul z w) := by
        -- 第 3 段。固有空間の条件（v, w ∈ E_A(z)）。
        rw [hv, hw]
    _ = smul z (add v w) := (hsmul_add z v w).symm
        -- 第 5 段。スカラー倍が和へ配ること。

/-- 必要十分版（その 2）。作用がスカラー倍を保ち、2 つのスカラー倍が交換できるならば、
固有空間の条件はスカラー倍で閉じる。 -/
theorem eigenspace_smul_necSuf
    {V S : Type*} (act : V → V) (smul : S → V → V)
    (hact_smul : ∀ (c : S) (v : V), act (smul c v) = smul c (act v))
    (hsmul_comm : ∀ (c z : S) (v : V), smul c (smul z v) = smul z (smul c v))
    (z c : S) (v : V) (hv : act v = smul z v) :
    act (smul c v) = smul z (smul c v) :=
  calc act (smul c v)
      = smul c (act v) := hact_smul c v
        -- 第 1 段。作用がスカラー倍を保つこと。
    _ = smul c (smul z v) := by
        -- 第 3 段。固有空間の条件（v ∈ E_A(z)）。
        rw [hv]
    _ = smul z (smul c v) := hsmul_comm c z v
        -- 第 5 段から第 7 段。2 つのスカラー倍の交換（具体版では積の結合則と可換性）。

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
