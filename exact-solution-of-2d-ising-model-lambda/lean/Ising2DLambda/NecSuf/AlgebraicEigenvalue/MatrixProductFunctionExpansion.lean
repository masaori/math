/-
多項式行列積の行列式の添字写像展開から、行列式・符号・置換・順序を外した必要十分版。
有限行添字と任意の有限重み添字について、行列積の成分展開から因子の括り出しまでを辿る。
可換半環の分配則・結合則・交換則を使い、減法・除法・非空性は仮定しない。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.ShiftCharOrbitProduct
import Mathlib.Data.Matrix.Mul

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

/-- 有限性は和と積を定め、分配則は各成分の和を写像全体へ開くために必要である。
乗法の交換則は二つの積を分離し、重みを左の積の右へ運ぶ段で使う。
重みも列指定も任意であり、符号や置換の性質は要求しない。
DecidableEq J は有限写像型 J → J の列挙を定理の型に置くために用いる。 -/
theorem matrixProduct_functionExpansion_necSuf
    {J S R : Type*} [Fintype J] [DecidableEq J] [Fintype S] [CommSemiring R]
    (A B : Matrix J J R) (w : S → R) (columns : S → J → J) :
    (∑ s : S, w s * ∏ i : J, (A * B) i (columns s i)) =
      ∑ f : J → J, (∏ i : J, A i (f i)) *
        (∑ s : S, w s * ∏ i : J, B (f i) (columns s i)) := by
  classical
  calc
    (∑ s : S, w s * ∏ i : J, (A * B) i (columns s i)) = ∑ s : S, w s * ∏ i : J, ∑ j : J, A i j * B j (columns s i) := by
      simp only [Matrix.mul_apply]
    _ = ∑ s : S, w s * ∑ f : J → J, ∏ i : J, A i (f i) * B (f i) (columns s i) := by
      refine Finset.sum_congr rfl ?_
      intro s _
      exact congrArg (w s * ·) (prod_sum_eq_sum_prod_pi (fun i j => A i j * B j (columns s i)))
    _ = ∑ s : S, ∑ f : J → J, w s * ∏ i : J, A i (f i) * B (f i) (columns s i) := by
      refine Finset.sum_congr rfl ?_
      intro s _
      exact Finset.mul_sum _ _ _
    _ = ∑ f : J → J, ∑ s : S, w s * ∏ i : J, A i (f i) * B (f i) (columns s i) :=
      Finset.sum_comm
    _ = ∑ f : J → J, ∑ s : S, w s * ((∏ i : J, A i (f i)) * (∏ i : J, B (f i) (columns s i))) := by
      refine Finset.sum_congr rfl ?_
      intro f _
      refine Finset.sum_congr rfl ?_
      intro s _
      exact congrArg (w s * ·) (Finset.prod_mul_distrib)
    _ = ∑ f : J → J, ∑ s : S, (w s * (∏ i : J, A i (f i))) * (∏ i : J, B (f i) (columns s i)) := by
      refine Finset.sum_congr rfl ?_
      intro f _
      refine Finset.sum_congr rfl ?_
      intro s _
      exact (mul_assoc _ _ _).symm
    _ = ∑ f : J → J, ∑ s : S, ((∏ i : J, A i (f i)) * w s) * (∏ i : J, B (f i) (columns s i)) := by
      refine Finset.sum_congr rfl ?_
      intro f _
      refine Finset.sum_congr rfl ?_
      intro s _
      exact congrArg (· * (∏ i : J, B (f i) (columns s i))) (mul_comm (w s) (∏ i : J, A i (f i)))
    _ = ∑ f : J → J, ∑ s : S, (∏ i : J, A i (f i)) * (w s * (∏ i : J, B (f i) (columns s i))) := by
      refine Finset.sum_congr rfl ?_
      intro f _
      refine Finset.sum_congr rfl ?_
      intro s _
      exact mul_assoc _ _ _
    _ = ∑ f : J → J, (∏ i : J, A i (f i)) * (∑ s : S, w s * (∏ i : J, B (f i) (columns s i))) := by
      refine Finset.sum_congr rfl ?_
      intro f _
      exact (Finset.mul_sum _ _ _).symm

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
