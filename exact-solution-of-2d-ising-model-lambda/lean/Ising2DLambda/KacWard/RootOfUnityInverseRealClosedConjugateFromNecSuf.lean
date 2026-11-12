/-
`claim_root_of_unity_inverse_is_real_closed_conjugate` の具体版が、必要十分版
`rootOfUnity_inverse_conj_necSuf` の R := 実閉部分体、K := Q̄、ι := 包含、ω := 固定した虚数単位への
特殊化として得られること。二つの平方の和が平方であること・推移律・三分法は本文の主張の具体版から与える。
`ζ^{-1}` は両側逆元 `conj_R(ζ)` の一意性から得る。住処: Qbar。実数体・複素数体は現れない。
-/
import Ising2DLambda.KacWard.RootOfUnityInverseRealClosedConjugate
import Ising2DLambda.NecSuf.KacWard.RootOfUnityInverseRealClosedConjugate

namespace Ising2DLambda.KacWard

open Ising2DLambda.FisherZero
open Ising2DLambda.AlgebraicEigenvalue

/-- 具体版の `conj_R` は必要十分版の共役の特殊化である。 -/
theorem realClosedConj_eq_conjOf (data : RealClosedSubfieldData) :
    realClosedConj data =
      Ising2DLambda.NecSuf.KacWard.conjOf data.carrier.subtype data.omega
        data.unique_decomposition := rfl

theorem rootOfUnity_inverse_realClosedConj_from_necSuf (data : RealClosedSubfieldData)
    (n : ℕ) (hn : 0 < n) (z : Qbar) (hz : z ∈ RootOfUnity n) (a b : data.carrier)
    (h : z = (a : Qbar) + (b : Qbar) * data.omega) :
    a * a + b * b = 1 ∧ z⁻¹ = realClosedConj data z ∧
      realClosedConj data z = (a : Qbar) - (b : Qbar) * data.omega := by
  obtain ⟨hN, hinv, hconj⟩ :=
    Ising2DLambda.NecSuf.KacWard.rootOfUnity_inverse_conj_necSuf data.carrier.subtype data.omega
      data.omega_sq data.unique_decomposition
      (fun u v => realClosed_sum_of_two_squares_is_square data u v)
      (fun a b c => realAlgebraicLt_trans data a b c)
      (fun a b => (realAlgebraicLt_trichotomy data a b).1)
      n hn z hz a b h
  rw [← realClosedConj_eq_conjOf] at hinv hconj
  exact ⟨hN, (inv_eq_of_mul_eq_one_right hinv), hconj⟩

end Ising2DLambda.KacWard
