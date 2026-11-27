/-
主張「全単射で移した置換の符号はもとの置換の符号に等しい」の具体版が、必要十分版
`NecSuf.AlgebraicEigenvalue.sign_permCongr`（三分律だけを仮定する二つの二項関係の上の符号）の
特殊化として得られることを示す導出版。
-/
import Ising2DLambda.AlgebraicEigenvalue.PermutationSignTransport
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PermutationSignTransport
import Ising2DLambda.NecSuf.KacWard.PermutationSignOrbitProduct

namespace Ising2DLambda.AlgebraicEigenvalue

variable {J K : Type*} [Fintype J] [LinearOrder J] [Fintype K] [LinearOrder K]

theorem finiteOrderedSign_permCongr_from_necSuf (d : J ≃ K) (σ : Equiv.Perm J) :
    IndependentFiniteOrderedSign.finiteOrderedSign (d.permCongr σ) =
      IndependentFiniteOrderedSign.finiteOrderedSign σ :=
  NecSuf.AlgebraicEigenvalue.sign_permCongr (fun x y : J => x < y) (fun x y : K => x < y)
    NecSuf.KacWard.trichotomous_of_linearOrder NecSuf.KacWard.trichotomous_of_linearOrder d σ

end Ising2DLambda.AlgebraicEigenvalue
