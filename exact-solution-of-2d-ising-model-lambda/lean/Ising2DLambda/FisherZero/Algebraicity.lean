/-
章「Fisher 零点」の「有限格子の Fisher 零点は代数的である」の具体版。
人手証明どおり、係数表示と多重度の総和から Z_L(1) = 2^(L^2) を出し、そこから Z_L != 0 を出し、Fisher 零点の定義を開く。
住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.FreeEntropy.AtOne
import Ising2DLambda.PartitionPolynomial.CoefficientRepresentation
import Ising2DLambda.PartitionPolynomial.CoefficientSum
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnity

namespace Ising2DLambda.FisherZero

open Ising2DLambda PartitionPolynomial AlgebraicEigenvalue

/-- 整係数多項式を代数的数で評価する写像（`def_qbar_polynomial_evaluation`）。 -/
noncomputable def qbarPolynomialEval (xi : Qbar) (f : Polynomial ℤ) : Qbar :=
  Polynomial.eval₂RingHom (Int.castRingHom Qbar) xi f

/-- 有限格子の Fisher 零点の全体（`def_finite_lattice_fisher_zeros`）。 -/
def FisherZeroSet (L : ℕ) [NeZero L] : Set Qbar :=
  {xi | qbarPolynomialEval xi (partitionPolynomial L) = 0}

theorem mem_fisherZero {L : ℕ} [NeZero L] {xi : Qbar} :
    xi ∈ FisherZeroSet L ↔ qbarPolynomialEval xi (partitionPolynomial L) = 0 := Iff.rfl

/-- 人手証明の第 1 の鎖。`Z_L(1) = Σ_m Ω_L(m) 1^m = Σ_m Ω_L(m) = 2^(L^2)`。 -/
theorem partitionPolynomial_eval_one_eq_two_pow (L : ℕ) [NeZero L] :
    Polynomial.aeval (1 : ℚ) (partitionPolynomial L) = ((2 ^ L ^ 2 : ℕ) : ℚ) := by
  -- 第 1 の等号: 係数表示（`claim_coefficient_representation`）。代入は和と積を保つ。
  rw [partitionPolynomial_eq_sum_multiplicity L, map_sum]
  -- 第 2 の等号: `1^m = 1`。
  have hterm : ∀ m ∈ Finset.range (2 * L ^ 2 + 1),
      Polynomial.aeval (1 : ℚ)
          (Polynomial.C (PartitionPolynomial.multiplicity L m : ℤ) * Polynomial.X ^ m)
        = ((PartitionPolynomial.multiplicity L m : ℕ) : ℚ) := by
    intro m _
    simp
  rw [Finset.sum_congr rfl hterm]
  -- 第 3 の等号: 多重度の総和（`claim_coefficient_sum`）。
  rw [← Nat.cast_sum, multiplicity_sum_eq_two_pow L]

/-- 人手証明の第 1 の鎖の結び。`Z_L(1) = 2^(L^2) != 0` なので `Z_L` は零多項式でない。 -/
theorem partitionPolynomial_ne_zero (L : ℕ) [NeZero L] : partitionPolynomial L ≠ 0 := by
  intro hzero
  have hvalue := partitionPolynomial_eval_one_eq_two_pow L
  rw [hzero, map_zero] at hvalue
  have hpow : (0 : ℚ) < ((2 ^ L ^ 2 : ℕ) : ℚ) := by positivity
  exact (ne_of_lt hpow) hvalue

/-- Fisher 零点は、零元でない整係数多項式 `Z_L` の根である。 -/
theorem fisherZero_algebraicity (L : ℕ) [NeZero L] (xi : Qbar) (hxi : xi ∈ FisherZeroSet L) :
    ∃ f : Polynomial ℤ, f ≠ 0 ∧ qbarPolynomialEval xi f = 0 := by
  exact ⟨partitionPolynomial L, partitionPolynomial_ne_zero L, (mem_fisherZero).1 hxi⟩

end Ising2DLambda.FisherZero
