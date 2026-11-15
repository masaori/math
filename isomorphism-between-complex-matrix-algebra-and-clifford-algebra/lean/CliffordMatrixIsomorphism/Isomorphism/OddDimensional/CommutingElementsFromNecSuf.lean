/-
`Isomorphism/OddDimensional/CommutingElements.lean` の具体版が、必要十分版の K := ℂ、n := -1_ℂ への特殊化から
得られることを示す導出版。具体版のファイルは必要十分版を引かない。

  具体版の主張                               必要十分版の主張（NecSuf.AlgebraOver.…）
  mul_comm_of_anticommute_both               mul_comm_of_anticommute_both
  commutingElements                          commutingElements（`commutingElements_eq_necSuf`、定義が同じ）
  commutingElements_isSubalgebra             commutingElements_isSubalgebra
  mul_comm_of_mul_comm_on_generators         mul_comm_of_mul_comm_on_generators

具体版の ℂ-代数 SA は、必要十分版の K := ℂ の代数 `SA.toNecSuf` として読む（`ComplexAlgebraFromNecSuf.lean`）。
ℂ から渡す性質は、0 + 0 = 0 の `add_zero 0`、1 + (-1) = 0 の `add_neg_cancel 1`、(-1)·(-1) = 1 だけである。
-/
import CliffordMatrixIsomorphism.Isomorphism.OddDimensional.CommutingElements
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexAlgebra.ComplexAlgebraFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.OddDimensional.CommutingElements

namespace CliffordMatrixIsomorphism.ComplexAlgebra

universe u

variable {A : Type u}

/-- 本文 `claim_element_anticommuting_with_two_elements_commutes_with_their_product` を必要十分版から得る。 -/
theorem mul_comm_of_anticommute_both_of_necSuf (SA : ComplexAlgebra A) (y p r : A)
    (hp : SA.add (SA.mul y p) (SA.mul p y) = SA.zero)
    (hr : SA.add (SA.mul y r) (SA.mul r y) = SA.zero) :
    SA.mul y (SA.mul p r) = SA.mul (SA.mul p r) y :=
  NecSuf.AlgebraOver.mul_comm_of_anticommute_both (_root_.add_zero (0 : ℂ)) (-1) (add_neg_cancel 1)
    (by norm_num) SA.toNecSuf y p r hp hr

/-- 本文 `def_elements_commuting_with_fixed_element`：具体版の C_y は必要十分版の C_y と同じ集合である。 -/
theorem commutingElements_eq_necSuf (SA : ComplexAlgebra A) (y : A) :
    commutingElements SA y = NecSuf.AlgebraOver.commutingElements SA.toNecSuf y := rfl

/-- 本文 `claim_elements_commuting_with_fixed_element_form_subalgebra` を必要十分版から得る。 -/
theorem commutingElements_isSubalgebra_of_necSuf (SA : ComplexAlgebra A) (y : A) :
    IsSubalgebra SA (commutingElements SA y) := by
  rw [isSubalgebra_iff_necSuf, commutingElements_eq_necSuf]
  exact NecSuf.AlgebraOver.commutingElements_isSubalgebra SA.toNecSuf y

/-- 本文 `claim_element_commuting_with_generating_subset_commutes_with_every_element` を必要十分版から得る。 -/
theorem mul_comm_of_mul_comm_on_generators_of_necSuf (SA : ComplexAlgebra A) {X : Set A}
    (hX : GeneratesAlgebra SA X) (y : A) (h : ∀ x : A, x ∈ X → SA.mul y x = SA.mul x y) (a : A) :
    SA.mul y a = SA.mul a y :=
  NecSuf.AlgebraOver.mul_comm_of_mul_comm_on_generators SA.toNecSuf ((generatesAlgebra_iff_necSuf SA X).1 hX) y h a

end CliffordMatrixIsomorphism.ComplexAlgebra
