/-
代数的数の列挙の具体版。人手証明と同じく、有理係数多項式の
可算性、各多項式の根の有限性、全根集合による被覆の順に示す。
住処: Qbar。実数体と複素数体は使わない。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnity
import Mathlib.Data.Rat.Encodable
import Mathlib.Data.Finsupp.Encodable
import Mathlib.Data.Set.Countable

namespace Ising2DLambda.AlgebraicEigenvalue

private instance : Countable (Polynomial ℚ) := by
  -- 有理係数多項式は、有限個の自然数添字の有理係数として符号化できる。
  have : Countable (ℕ →₀ ℚ) := inferInstance
  have : Countable (AddMonoidAlgebra ℚ ℕ) :=
    (AddMonoidAlgebra.coeff_injective (R := ℚ) (M := ℕ)).countable
  exact (Polynomial.toFinsuppIso ℚ).injective.countable

private theorem qbar_countable : Countable Qbar := by
  let roots : Polynomial ℚ → Set Qbar := fun p => p.rootSet Qbar
  -- 零でない多項式の根は有限である。零多項式の rootSet は空集合になる。
  have hroots : (⋃ p : Polynomial ℚ, roots p).Countable := by
    apply Set.countable_iUnion
    intro p
    exact (Polynomial.rootSet_finite p Qbar).countable
  -- 代数閉包の各元は、ある零でない有理係数多項式の根である。
  have hcover : (⋃ p : Polynomial ℚ, roots p) = Set.univ := by
    ext z
    constructor
    · intro _; trivial
    · intro _
      obtain ⟨p, hp, hz⟩ := Algebra.IsAlgebraic.isAlgebraic (R := ℚ) z
      exact Set.mem_iUnion.mpr ⟨p, (Polynomial.mem_rootSet).2 ⟨hp, hz⟩⟩
  rw [hcover] at hroots
  exact Set.countable_univ_iff.mp hroots

/-- `claim_algebraic_numbers_enumeration` の具体版。 -/
theorem algebraicNumbersEnumeration :
    ∃ ξ : ℕ → Qbar, Function.Surjective ξ := by
  letI : Countable Qbar := qbar_countable
  exact exists_surjective_nat Qbar

end Ising2DLambda.AlgebraicEigenvalue
