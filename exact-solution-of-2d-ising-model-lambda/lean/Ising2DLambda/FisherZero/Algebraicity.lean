/-
章「Fisher 零点」の「有限格子の Fisher 零点は代数的である」の具体版。
人手証明どおり、Z_L(1) = 2^(L^2) から Z_L != 0 を出し、Fisher 零点の定義を開く。
住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.FreeEntropy.AtOne
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

/-- 人手証明の第 1 の鎖。`Z_L(1) = 2^(L^2) != 0` なので `Z_L` は零多項式でない。 -/
theorem partitionPolynomial_ne_zero (L : ℕ) [NeZero L] : partitionPolynomial L ≠ 0 := by
  intro hzero
  have hvalue := Ising2DLambda.FreeEntropy.partitionPolynomial_eval_one L
  rw [hzero, map_zero] at hvalue
  have hpow : (0 : ℚ) < ((2 ^ L ^ 2 : ℕ) : ℚ) := by positivity
  exact (ne_of_lt hpow) hvalue

/-- Fisher 零点は、零元でない整係数多項式 `Z_L` の根である。 -/
theorem fisherZero_algebraicity (L : ℕ) [NeZero L] (xi : Qbar) (hxi : xi ∈ FisherZeroSet L) :
    ∃ f : Polynomial ℤ, f ≠ 0 ∧ qbarPolynomialEval xi f = 0 := by
  exact ⟨partitionPolynomial L, partitionPolynomial_ne_zero L, (mem_fisherZero).1 hxi⟩

end Ising2DLambda.FisherZero
