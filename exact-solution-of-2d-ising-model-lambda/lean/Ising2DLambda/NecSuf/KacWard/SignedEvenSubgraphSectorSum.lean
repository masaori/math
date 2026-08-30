/-
必要十分版: ラベルだけで決まる係数を持つ有限和を、ラベルの各ファイバーへ分ける。

人手証明が使うのは、有限なラベル型、有限和、ラベル上で一定な係数、分配則だけである。
偶部分グラフ、巻き付き偶奇、多項式は現れない。
-/
import Ising2DLambda.NecSuf.FisherZero.HighTemperatureSectorDecomposition

namespace Ising2DLambda.NecSuf.KacWard

open Finset

/-- ラベルだけで決まる係数を持つ有限和は、各ファイバーの和の係数付き和に等しい。 -/
theorem weightedSum_eq_sum_label_fibers_necSuf
    {A I R : Type*} [DecidableEq A] [Fintype I] [DecidableEq I] [CommSemiring R]
    (source : Finset A) (label : A → I) (coefficient : I → R) (weight : A → R) :
    ∑ a ∈ source, coefficient (label a) * weight a =
      ∑ i : I, coefficient i * ∑ a ∈ source.filter (fun a => label a = i), weight a := by
  classical
  calc
    ∑ a ∈ source, coefficient (label a) * weight a =
        ∑ i : I, ∑ a ∈ source.filter (fun a => label a = i),
          coefficient (label a) * weight a := by
      exact Ising2DLambda.NecSuf.FisherZero.sum_eq_sum_label_fibers_necSuf
        source label (fun a => coefficient (label a) * weight a)
    _ = ∑ i : I, coefficient i * ∑ a ∈ source.filter (fun a => label a = i), weight a := by
      apply Finset.sum_congr rfl
      intro i _
      rw [Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro a ha
      rw [Finset.mem_filter] at ha
      rw [ha.2]

end Ising2DLambda.NecSuf.KacWard
