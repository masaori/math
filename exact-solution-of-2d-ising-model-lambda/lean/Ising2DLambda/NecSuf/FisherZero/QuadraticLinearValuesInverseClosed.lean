import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

/-- 逆元の表示に要るのは体、係数集合の四則閉性とノルムの非零性である。 -/
theorem quadraticLinearValues_inv_mem_necSuf {K : Type*} [Field K] (S : Set K)
    (hsub : ∀ x y : K, x ∈ S → y ∈ S → x - y ∈ S)
    (hmul : ∀ x y : K, x ∈ S → y ∈ S → x * y ∈ S)
    (hdiv : ∀ x y : K, x ∈ S → y ∈ S → x / y ∈ S)
    (hneg : ∀ x : K, x ∈ S → -x ∈ S)
    (a b : K) (ha : a ∈ S) (hb : b * b = a)
    (hnorm : ∀ u v : K, u ∈ S → v ∈ S → u + v * b ≠ 0 →
      u * u - a * (v * v) ≠ 0)
    (y : K) (hy : ∃ u v : K, u ∈ S ∧ v ∈ S ∧ y = u + v * b) (hy0 : y ≠ 0) :
    ∃ u v : K, u ∈ S ∧ v ∈ S ∧ y⁻¹ = u + v * b := by
  obtain ⟨u, v, hu, hv, rfl⟩ := hy
  let n : K := u * u - a * (v * v)
  have hnS : n ∈ S := hsub _ _ (hmul _ _ hu hu) (hmul _ _ ha (hmul _ _ hv hv))
  have hn0 : n ≠ 0 := hnorm u v hu hv hy0
  refine ⟨u / n, -(v / n), hdiv _ _ hu hnS, hneg _ (hdiv _ _ hv hnS), ?_⟩
  have hprod : (u + v * b) * (u / n + -(v / n) * b) = 1 := by
    calc
      (u + v * b) * (u / n + -(v / n) * b) = (u + v * b) * (u - v * b) / n := by ring
      _ = (u * u - b * b * (v * v)) / n := by ring
      _ = n / n := by rw [hb]
      _ = 1 := div_self hn0
  exact inv_eq_of_mul_eq_one_right hprod

end Ising2DLambda.NecSuf.FisherZero
