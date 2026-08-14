/- 実対数の自然数冪の具体版が必要十分版の特殊化として得られることを示す。 -/
import Ising2DLambda.ThermodynamicLimit.RealLogNaturalPower
import Ising2DLambda.NecSuf.ThermodynamicLimit.RealLogNaturalPower

namespace Ising2DLambda.ThermodynamicLimit

/-- 正の実数・実対数・自然数の実数埋め込みを必要十分版へ渡した導出。 -/
theorem realLogarithm_naturalPower_from_necSuf (u : StrictlyPositiveReal) :
    ∀ n : ℕ,
      realLogarithm ⟨u.1 ^ n, pow_pos u.2 n⟩ = (n : ℝ) * realLogarithm u := by
  let power : ℕ → StrictlyPositiveReal := fun n => ⟨u.1 ^ n, pow_pos u.2 n⟩
  apply NecSuf.ThermodynamicLimit.naturalPower_map_necSuf
    (⟨1, zero_lt_one⟩ : StrictlyPositiveReal) (· * ·) u power
    (0 : ℝ) (1 : ℝ) (· + ·) (fun n : ℕ => (n : ℝ))
    (0 : ℝ) (· + ·) (· * ·) realLogarithm
  · ext
    simp [power]
  · intro k
    ext
    simp [power, pow_succ]
  · exact realLogarithm_one
  · intro x
    exact realLogarithm_mul x u
  · intro y
    exact zero_mul y
  · intro y
    exact one_mul y
  · intro c d y
    exact (add_mul c d y).symm
  · exact Nat.cast_zero
  · exact Nat.cast_one
  · intro k
    exact Nat.cast_add k 1

end Ising2DLambda.ThermodynamicLimit
