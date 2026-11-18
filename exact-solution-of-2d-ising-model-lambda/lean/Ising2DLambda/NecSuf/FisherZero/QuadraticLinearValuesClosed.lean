import Ising2DLambda.FisherZero.QuadraticLinearValuesClosed

namespace Ising2DLambda.NecSuf.FisherZero

/-- 必要なのは可換環と係数集合の零・単位元・和・符号反転・積の閉性だけである。 -/
theorem quadraticLinearValues_ringClosed_necSuf {K : Type*} [CommRing K]
    (S : Set K) (hzero : (0 : K) ∈ S) (hone : (1 : K) ∈ S)
    (hadd : ∀ x y : K, x ∈ S → y ∈ S → x + y ∈ S)
    (hneg : ∀ x : K, x ∈ S → -x ∈ S)
    (hmul : ∀ x y : K, x ∈ S → y ∈ S → x * y ∈ S)
    (a b : K) (ha : a ∈ S) (hb : b * b = a) :
    (0 : K) ∈ {y | ∃ u v : K, u ∈ S ∧ v ∈ S ∧ y = u + v * b} ∧
    (1 : K) ∈ {y | ∃ u v : K, u ∈ S ∧ v ∈ S ∧ y = u + v * b} ∧
    (∀ y z : K, y ∈ {q | ∃ u v : K, u ∈ S ∧ v ∈ S ∧ q = u + v * b} →
      z ∈ {q | ∃ u v : K, u ∈ S ∧ v ∈ S ∧ q = u + v * b} →
      y + z ∈ {q | ∃ u v : K, u ∈ S ∧ v ∈ S ∧ q = u + v * b}) ∧
    (∀ y : K, y ∈ {q | ∃ u v : K, u ∈ S ∧ v ∈ S ∧ q = u + v * b} →
      -y ∈ {q | ∃ u v : K, u ∈ S ∧ v ∈ S ∧ q = u + v * b}) ∧
    (∀ y z : K, y ∈ {q | ∃ u v : K, u ∈ S ∧ v ∈ S ∧ q = u + v * b} →
      z ∈ {q | ∃ u v : K, u ∈ S ∧ v ∈ S ∧ q = u + v * b} →
      y * z ∈ {q | ∃ u v : K, u ∈ S ∧ v ∈ S ∧ q = u + v * b}) := by
  constructor
  · exact ⟨0, 0, hzero, hzero, by ring⟩
  constructor
  · exact ⟨1, 0, hone, hzero, by ring⟩
  constructor
  · intro y z hy hz
    obtain ⟨u, v, hu, hv, rfl⟩ := hy
    obtain ⟨w, t, hw, ht, rfl⟩ := hz
    exact ⟨u + w, v + t, hadd u w hu hw, hadd v t hv ht, by ring⟩
  constructor
  · intro y hy
    obtain ⟨u, v, hu, hv, rfl⟩ := hy
    exact ⟨-u, -v, hneg u hu, hneg v hv, by ring⟩
  · intro y z hy hz
    obtain ⟨u, v, hu, hv, rfl⟩ := hy
    obtain ⟨w, t, hw, ht, rfl⟩ := hz
    refine ⟨u * w + a * (v * t), u * t + v * w,
      hadd _ _ (hmul u w hu hw) (hmul a (v * t) ha (hmul v t hv ht)),
      hadd _ _ (hmul u t hu ht) (hmul v w hv hw), ?_⟩
    rw [← hb]
    ring

end Ising2DLambda.NecSuf.FisherZero
