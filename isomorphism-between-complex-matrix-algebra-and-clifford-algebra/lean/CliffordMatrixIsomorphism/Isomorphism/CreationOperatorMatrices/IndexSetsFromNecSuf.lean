/-
章「同型の証明」の、個数 N_i(T) の二つの主張が、必要十分版の特殊化として得られることを示す導出版。
個数と集合の操作は ℂ を含まず、具体版と必要十分版に同じ式で別に置いてあるので、主張の式は定義により一致する
（個数 N_i(T) は再帰の定義なので、各宣言で smartUnfolding を切って定義どおりに展開させる）。
-/
import CliffordMatrixIsomorphism.Isomorphism.CreationOperatorMatrices.CountAndSign
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.CreationOperatorMatrices.CountAndSign

namespace CliffordMatrixIsomorphism.Isomorphism

open CliffordMatrixIsomorphism.ComplexMatrixAlgebra

set_option smartUnfolding false in
/-- 本文 `claim_count_below_index_after_adding_one_element` を、必要十分版から得たもの。 -/
theorem countBelow_unionSingleton_of_necSuf {M : ℕ} (T : PowerSet M) (j : ℕ) (hj : 1 ≤ j ∧ j ≤ M)
    (hjT : j ∉ T.1) :
    ∀ i : ℕ, 1 ≤ i → i ≤ M →
      (j < i → countBelow (unionSingleton T j hj) i = countBelow T i + 1)
        ∧ (i ≤ j → countBelow (unionSingleton T j hj) i = countBelow T i) :=
  NecSuf.Isomorphism.countBelow_unionSingleton T j hj hjT

set_option smartUnfolding false in
/-- 本文 `claim_count_below_index_vanishes_without_smaller_elements` を、必要十分版から得たもの。 -/
theorem countBelow_eq_zero_of_forall_ge_of_necSuf {M : ℕ} (T : PowerSet M) :
    ∀ i : ℕ, 1 ≤ i → i ≤ M → (∀ t : ℕ, t ∈ T.1 → i ≤ t) → countBelow T i = 0 :=
  NecSuf.Isomorphism.countBelow_eq_zero_of_forall_ge T

end CliffordMatrixIsomorphism.Isomorphism
