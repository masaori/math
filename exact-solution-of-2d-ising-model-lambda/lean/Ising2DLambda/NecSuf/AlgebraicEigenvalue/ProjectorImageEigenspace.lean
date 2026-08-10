/-
主張「落とす写像の像は固有空間に入る」の必要十分版。

証明手順は具体版（`Ising2DLambda.AlgebraicEigenvalue.QbarProjectorEigenspace`）と同じである
（添字を 1 つずらして境界の 2 項を取り出し、境界の項が等しいことで消す）。

人手証明の鎖のうち、この段の中身は次の 3 つだけである。

  人手証明                                        ここでの対応
  添字のずらし（j = k+1）と j=L の項の分離        Finset.sum_range_succ'
  k=0 の項の復帰                                  Finset.sum_range_succ
  準備 2（a_L = a_0）と準備 3（z^{L+1} = z）      仮説 h_bdry（境界の 2 項が等しいこと）

  使っている性質                     なぜ削れないか
  AddCommMonoid V                    有限和を取るのに要る（Finset.sum の土台）。
  IsCancelAdd V                      最後に両辺から同じ境界項を消す段そのもの。
                                     消せないと LHS + g 0 = RHS + g 0 から LHS = RHS が出ない。
  h_bdry : g (n+1) = g 0             準備 2・準備 3 を使う唯一の場所。これが無ければ主張は偽
                                     （そのために具体版で A^L = I と z^L = 1 を仮定している）。

削れたもの: 行列であること・スカラー倍・乗法・冪・係数が冪の形であること・
値が代数的数であること・添字の型の有限性・環の分配則・単位元・零元・可換な積。
すなわちこの段は「和と、境界の 2 項が一致すること」しか使っていない。

mathlib からは有限和 `Finset.sum` と、その最初／最後の項を取り出す 2 つの補題だけを引いている
（人手証明の「1 項を分ける」「1 項を戻す」に 1 対 1 で対応する）。

住処: ここに ℝ / ℂ は現れない（値は勝手な型の元）。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

/-- 必要十分版。境界の 2 項が等しい族については、添字を 1 つずらしても有限和が変わらない。 -/
theorem projector_image_eigenspace_necSuf
    {V : Type*} [AddCommMonoid V] [IsCancelAdd V]
    (n : ℕ) (g : ℕ → V) (h_bdry : g (n + 1) = g 0) :
    ∑ k ∈ range (n + 1), g (k + 1) = ∑ k ∈ range (n + 1), g k := by
  have h_shift : (∑ k ∈ range (n + 1), g (k + 1)) + g 0
      = ∑ i ∈ range (n + 1 + 1), g i := (sum_range_succ' g (n + 1)).symm
    -- 添字のずらし（j = k+1）と、そこで外へ出る k=0 の項。
  have h_last : (∑ k ∈ range (n + 1), g k) + g (n + 1)
      = ∑ i ∈ range (n + 1 + 1), g i := (sum_range_succ g (n + 1)).symm
    -- j = L（= n+1）の項の分離。
  have h : (∑ k ∈ range (n + 1), g (k + 1)) + g 0
      = (∑ k ∈ range (n + 1), g k) + g 0 := by
    rw [h_shift, ← h_last, h_bdry]
    -- 境界の 2 項が等しいこと（準備 2・準備 3）。
  exact add_right_cancel h

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
