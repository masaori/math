/-
主張「符号は合成について乗法的である」の、線型順序を持つ有限集合の上の具体版が、
必要十分版 `NecSuf.AlgebraicEigenvalue.sign_comp`（三分律だけを仮定する二項関係の上の符号）の
特殊化として得られることを示す導出版。
-/
import Ising2DLambda.AlgebraicEigenvalue.PermutationSignFiniteOrderedSet
import Ising2DLambda.NecSuf.KacWard.PermutationSignOrbitProduct

namespace Ising2DLambda.AlgebraicEigenvalue

variable {J : Type*} [Fintype J] [LinearOrder J]

theorem finiteOrderedSign_comp_from_necSuf (φ ψ : Equiv.Perm J) :
    NecSuf.AlgebraicEigenvalue.sign (fun x y : J => x < y) (φ * ψ)
      = NecSuf.AlgebraicEigenvalue.sign (fun x y : J => x < y) φ
          * NecSuf.AlgebraicEigenvalue.sign (fun x y : J => x < y) ψ :=
  NecSuf.AlgebraicEigenvalue.sign_comp _ NecSuf.KacWard.trichotomous_of_linearOrder φ ψ

end Ising2DLambda.AlgebraicEigenvalue
