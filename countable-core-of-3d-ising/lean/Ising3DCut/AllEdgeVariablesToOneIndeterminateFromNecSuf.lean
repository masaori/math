import Ising3DCut.NecSuf.AllEdgeVariablesToOneIndeterminate
import Ising3DCut.AllEdgeVariablesToOneIndeterminate

/-!
必要十分版（可換半環 `R`）を `R := ℤ` へ特殊化して、具体版の第一歩を導出する。
具体版と必要十分版の `κ_L` は同じ `eval₂Hom` なので定義的に一致する。
-/

namespace Ising3DCut

variable {Configuration Edge : Type*} [Fintype Configuration]

theorem allEdgesToOneIndeterminate_multivariatePartitionPolynomial_fromNecSuf
    (broken : Configuration → Finset Edge) :
    allEdgesToOneIndeterminate (multivariatePartitionPolynomial broken) =
      ∑ σ : Configuration, (Polynomial.X : Polynomial ℤ) ^ (broken σ).card :=
  NecSuf.allEdgesToOneIndeterminate_multivariatePartitionPolynomial (R := ℤ) broken

end Ising3DCut
