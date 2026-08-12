/-
「高温展開の多項式は四つのセクター多項式の和である」の必要十分版。
具体版と同じく、有限集合をラベルの値ごとの重なりのない部分集合へ分けて有限和を分割する。

証明は各項を「その項のラベルでだけ元の重み、それ以外で零」となる有限和へ開き、
二つの有限和の順序を交換してから、各ラベルのファイバーへ絞る。要るのは有限な
ラベル型と、値の側が可換加法モノイドであることだけである。ラベルが巻き付き偶奇で
あることも、重みが多項式であることも使わない。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

open Finset

/-- 有限和は、有限なラベル型の各ファイバーにわたる有限和の和へ分割できる。 -/
theorem sum_eq_sum_label_fibers_necSuf
    {A I M : Type*} [DecidableEq A] [Fintype I] [DecidableEq I] [AddCommMonoid M]
    (source : Finset A) (label : A → I) (weight : A → M) :
    ∑ a ∈ source, weight a =
      ∑ i : I, ∑ a ∈ source.filter (fun a => label a = i), weight a := by
  classical
  calc
    ∑ a ∈ source, weight a =
        ∑ a ∈ source, ∑ i : I, if label a = i then weight a else 0 := by
      apply Finset.sum_congr rfl
      intro a _
      simpa [eq_comm] using
        (Fintype.sum_ite_eq (label a) (fun _ : I => weight a))
    _ = ∑ i : I, ∑ a ∈ source, if label a = i then weight a else 0 := by
      exact Finset.sum_comm
    _ = ∑ i : I, ∑ a ∈ source.filter (fun a => label a = i), weight a := by
      apply Finset.sum_congr rfl
      intro i _
      rw [Finset.sum_filter]

end Ising2DLambda.NecSuf.FisherZero
