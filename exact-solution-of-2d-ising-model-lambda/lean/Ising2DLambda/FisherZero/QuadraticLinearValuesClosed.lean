import Ising2DLambda.FisherZero.QuadraticNormNonzero
import Ising2DLambda.FisherZero.SubfieldPolynomialValuesSubfield

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 部分体の係数による一次式の値の全体。 -/
def quadraticLinearValues (F : Subfield Qbar) (b : Qbar) : Set Qbar :=
  {y | ∃ u v : Qbar, u ∈ F ∧ v ∈ F ∧ y = u + v * b}

/-- 平方根の一次式の値の全体は零・単位元を含み、和・符号反転・積で閉じる。 -/
theorem quadraticLinearValues_ringClosed (F : Subfield Qbar) (a b : Qbar)
    (ha : a ∈ F) (hb : b * b = a) :
    (0 : Qbar) ∈ quadraticLinearValues F b ∧
    (1 : Qbar) ∈ quadraticLinearValues F b ∧
    (∀ y z : Qbar, y ∈ quadraticLinearValues F b →
      z ∈ quadraticLinearValues F b → y + z ∈ quadraticLinearValues F b) ∧
    (∀ y : Qbar, y ∈ quadraticLinearValues F b → -y ∈ quadraticLinearValues F b) ∧
    (∀ y z : Qbar, y ∈ quadraticLinearValues F b →
      z ∈ quadraticLinearValues F b → y * z ∈ quadraticLinearValues F b) := by
  constructor
  · exact ⟨0, 0, F.zero_mem, F.zero_mem, by ring⟩
  constructor
  · exact ⟨1, 0, F.one_mem, F.zero_mem, by ring⟩
  constructor
  · intro y z hy hz
    obtain ⟨u, v, hu, hv, rfl⟩ := hy
    obtain ⟨w, t, hw, ht, rfl⟩ := hz
    exact ⟨u + w, v + t, F.add_mem hu hw, F.add_mem hv ht, by ring⟩
  constructor
  · intro y hy
    obtain ⟨u, v, hu, hv, rfl⟩ := hy
    exact ⟨-u, -v, F.neg_mem hu, F.neg_mem hv, by ring⟩
  · intro y z hy hz
    obtain ⟨u, v, hu, hv, rfl⟩ := hy
    obtain ⟨w, t, hw, ht, rfl⟩ := hz
    refine ⟨u * w + a * (v * t), u * t + v * w,
      F.add_mem (F.mul_mem hu hw) (F.mul_mem ha (F.mul_mem hv ht)),
      F.add_mem (F.mul_mem hu ht) (F.mul_mem hv hw), ?_⟩
    rw [← hb]
    ring

end Ising2DLambda.FisherZero
