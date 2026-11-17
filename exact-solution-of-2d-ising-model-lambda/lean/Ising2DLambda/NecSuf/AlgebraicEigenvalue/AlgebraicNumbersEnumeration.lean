/-
代数的数の列挙の必要十分版。係数の可算性、有限根集合、
全元の代数性だけを用い、代数閉性は用いない。
住処: 一般の可算体の代数的拡大。実数体と複素数体は使わない。
-/
import Mathlib.Data.Rat.Encodable
import Mathlib.Data.Finsupp.Encodable
import Mathlib.FieldTheory.IsAlgClosed.AlgebraicClosure
import Mathlib.Data.Set.Countable

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

variable (K A : Type*) [Field K] [Field A] [Algebra K A]
  [Algebra.IsAlgebraic K A] [Countable K]

include K

private instance polynomialCountable : Countable (Polynomial K) := by
  have : Countable (ℕ →₀ K) := inferInstance
  have : Countable (AddMonoidAlgebra K ℕ) :=
    (AddMonoidAlgebra.coeff_injective (R := K) (M := ℕ)).countable
  exact (Polynomial.toFinsuppIso K).injective.countable

private theorem algebraicCountable : Countable A := by
  letI : Countable (Polynomial K) := polynomialCountable K
  let roots : Polynomial K → Set A := fun p => p.rootSet A
  have hroots : (⋃ p : Polynomial K, roots p).Countable := by
    apply Set.countable_iUnion
    intro p
    exact (Polynomial.rootSet_finite p A).countable
  have hcover : (⋃ p : Polynomial K, roots p) = Set.univ := by
    ext z
    constructor
    · intro _; trivial
    · intro _
      obtain ⟨p, hp, hz⟩ := Algebra.IsAlgebraic.isAlgebraic (R := K) z
      exact Set.mem_iUnion.mpr ⟨p, (Polynomial.mem_rootSet).2 ⟨hp, hz⟩⟩
  rw [hcover] at hroots
  exact Set.countable_univ_iff.mp hroots

/-- 同じ列挙を一般の可算体の代数的拡大で構成する。 -/
theorem algebraicExtensionEnumeration :
    ∃ ξ : ℕ → A, Function.Surjective ξ := by
  letI : Countable A := algebraicCountable K A
  exact exists_surjective_nat A

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
