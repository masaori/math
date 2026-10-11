/-
零因子を持つ有限積の重み付き項を有限和から除く必要十分版。
積には可換モノイドと左零則、和の制限には加法可換モノイドだけを使う。
分配則・環・体・符号・置換は仮定しない。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

theorem weightedProduct_zero_of_factor_zero_necSuf
    {J R : Type*} [CommMonoid R] [Zero R]
    (t : Finset J) (w : R) (a : J → R) (j : J) (hj : j ∈ t)
    (ha : a j = 0) (hzero : ∀ r : R, 0 * r = 0) :
    w * (∏ i ∈ t, a i) = 0 := by
  classical
  have hProduct : (∏ i ∈ t, a i) = 0 := by
    calc
      (∏ i ∈ t, a i) = a j * ∏ i ∈ t.erase j, a i :=
        (Finset.mul_prod_erase t a hj).symm
      _ = 0 * ∏ i ∈ t.erase j, a i := congrArg (· * ∏ i ∈ t.erase j, a i) ha
      _ = 0 := hzero _
  have hRightZero : w * 0 = 0 := by
    calc
      w * 0 = 0 * w := mul_comm w 0
      _ = 0 := hzero w
  calc
    w * (∏ i ∈ t, a i) = w * 0 := congrArg (w * ·) hProduct
    _ = 0 := hRightZero

theorem weightedProduct_filter_zero_necSuf
    {S J R : Type*} [AddCommMonoid R] [CommMonoid R]
    (s : Finset S) (t : Finset J) (w : S → R) (a : S → J → R)
    (p : S → Prop) [DecidablePred p]
    (hzero : ∀ r : R, 0 * r = 0)
    (hexcluded : ∀ k ∈ s, ¬ p k → ∃ j ∈ t, a k j = 0) :
    (∑ k ∈ s, w k * ∏ i ∈ t, a k i) =
      ∑ k ∈ s.filter p, w k * ∏ i ∈ t, a k i := by
  classical
  have hTerm : ∀ k ∈ s.filter (fun k => ¬ p k), w k * (∏ i ∈ t, a k i) = 0 := by
    intro k hk
    obtain ⟨j, hj, hzeroj⟩ := hexcluded k (Finset.mem_filter.mp hk).1
      (Finset.mem_filter.mp hk).2
    exact weightedProduct_zero_of_factor_zero_necSuf t (w k) (a k) j hj hzeroj hzero
  calc
    (∑ k ∈ s, w k * ∏ i ∈ t, a k i) =
        (∑ k ∈ s.filter p, w k * ∏ i ∈ t, a k i) +
          ∑ k ∈ s.filter (fun k => ¬ p k), w k * ∏ i ∈ t, a k i :=
      (Finset.sum_filter_add_sum_filter_not s p (fun k => w k * ∏ i ∈ t, a k i)).symm
    _ = (∑ k ∈ s.filter p, w k * ∏ i ∈ t, a k i) +
        ∑ _k ∈ s.filter (fun k => ¬ p k), (0 : R) := by
      apply congrArg (_ + ·)
      exact Finset.sum_congr rfl hTerm
    _ = (∑ k ∈ s.filter p, w k * ∏ i ∈ t, a k i) + 0 :=
      congrArg (_ + ·) (Finset.sum_const_zero)
    _ = ∑ k ∈ s.filter p, w k * ∏ i ∈ t, a k i := add_zero _

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
