/-
有限和の各項に含まれる有限積へ、同じ元を掛ける計算の必要十分版。
和と積の可換モノイド構造、および指定した因子による左乗法の零・加法の保存だけを使う。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Data.Fintype.Card

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

/-- 積の可換性は各積の分離と重みの移動に使う。
加法との両立性は c の冪による左乗法だけに要求する。
環・負号・体・順序・非空性・符号・置換は仮定しない。 -/
theorem weightedProduct_scale_necSuf
    {J S R : Type*} [Fintype J] [Fintype S] [AddCommMonoid R] [CommMonoid R]
    (c : R) (w : S → R) (a : S → J → R)
    (hzero : c ^ Fintype.card J * 0 = 0)
    (hadd : ∀ u v : R,
      c ^ Fintype.card J * (u + v) = c ^ Fintype.card J * u + c ^ Fintype.card J * v) :
    (∑ s : S, w s * ∏ i : J, c * a s i) =
      c ^ Fintype.card J * ∑ s : S, w s * ∏ i : J, a s i := by
  classical
  let φ : R →+ R :=
    { toFun := fun u => c ^ Fintype.card J * u
      map_zero' := hzero
      map_add' := hadd }
  calc
    (∑ s : S, w s * ∏ i : J, c * a s i) =
        ∑ s : S, w s * ((∏ _i : J, c) * ∏ i : J, a s i) := by
      refine Finset.sum_congr rfl ?_
      intro s _
      exact congrArg (w s * ·) Finset.prod_mul_distrib
    _ = ∑ s : S, w s * (c ^ Fintype.card J * ∏ i : J, a s i) := by
      refine Finset.sum_congr rfl ?_
      intro s _
      exact congrArg (fun z => w s * (z * ∏ i : J, a s i)) (Finset.prod_const c)
    _ = ∑ s : S, (w s * c ^ Fintype.card J) * ∏ i : J, a s i := by
      refine Finset.sum_congr rfl ?_
      intro s _
      exact (mul_assoc _ _ _).symm
    _ = ∑ s : S, (c ^ Fintype.card J * w s) * ∏ i : J, a s i := by
      refine Finset.sum_congr rfl ?_
      intro s _
      exact congrArg (· * ∏ i : J, a s i) (mul_comm (w s) (c ^ Fintype.card J))
    _ = ∑ s : S, c ^ Fintype.card J * (w s * ∏ i : J, a s i) := by
      refine Finset.sum_congr rfl ?_
      intro s _
      exact mul_assoc _ _ _
    _ = c ^ Fintype.card J * ∑ s : S, w s * ∏ i : J, a s i :=
      (map_sum φ (fun s => w s * ∏ i : J, a s i) univ).symm

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
