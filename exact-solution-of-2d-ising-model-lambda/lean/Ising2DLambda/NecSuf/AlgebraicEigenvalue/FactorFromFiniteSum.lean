/-
「根を持つ多項式は一次式を因子に持つ」の必要十分版。

必要なのは可換環、有限和による表示、根における有限和が零であること、および各冪の差の
因数分解だけである。多項式、代数閉性、体、次数は使わない。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

theorem factor_from_finite_sum_necSuf {R : Type*} [CommRing R]
    (f x w : R) (a K : ℕ → R) (n : ℕ)
    (hf : f = ∑ k ∈ Finset.range (n + 1), a k * x ^ k)
    (hroot : (∑ k ∈ Finset.range (n + 1), a k * w ^ k) = 0)
    (hfactor : ∀ k : ℕ, x ^ k - w ^ k = (x - w) * K k) :
    ∃ g : R, f = (x - w) * g := by
  let g := ∑ k ∈ Finset.range (n + 1), a k * K k
  refine ⟨g, ?_⟩
  calc
    f = ∑ k ∈ Finset.range (n + 1), a k * x ^ k := hf
    _ = (∑ k ∈ Finset.range (n + 1), a k * x ^ k) - 0 := by ring
    _ = (∑ k ∈ Finset.range (n + 1), a k * x ^ k)
          - ∑ k ∈ Finset.range (n + 1), a k * w ^ k := by rw [hroot]
    _ = ∑ k ∈ Finset.range (n + 1), (a k * x ^ k - a k * w ^ k) := by
          rw [Finset.sum_sub_distrib]
    _ = ∑ k ∈ Finset.range (n + 1), a k * (x ^ k - w ^ k) := by
          refine Finset.sum_congr rfl (fun k _ => ?_)
          ring
    _ = ∑ k ∈ Finset.range (n + 1), a k * ((x - w) * K k) := by
          refine Finset.sum_congr rfl (fun k _ => ?_)
          rw [hfactor]
    _ = (x - w) * ∑ k ∈ Finset.range (n + 1), a k * K k := by
          rw [Finset.mul_sum]
          refine Finset.sum_congr rfl (fun k _ => ?_)
          ring
    _ = (x - w) * g := rfl

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
