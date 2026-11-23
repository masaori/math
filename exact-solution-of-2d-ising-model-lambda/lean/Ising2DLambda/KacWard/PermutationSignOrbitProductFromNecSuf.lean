import Ising2DLambda.KacWard.PermutationSignOrbitProduct
import Ising2DLambda.NecSuf.KacWard.PermutationSignOrbitProduct

namespace Ising2DLambda.KacWard

variable {ι : Type} [Fintype ι] [LinearOrder ι]

/-- 具体版の軌道ごとの符号積を、必要十分版の符号で述べた導出版。 -/
theorem sign_movedEdgeOrbit_product_from_necSuf (σ : Equiv.Perm ι) :
    Ising2DLambda.NecSuf.AlgebraicEigenvalue.sign (fun x y : ι => x < y) σ =
      ∏ O ∈ movedEdgeOrbitSet σ, (-1 : ℤ) ^ (O.card - 1) :=
  sign_movedEdgeOrbit_product σ

end Ising2DLambda.KacWard
