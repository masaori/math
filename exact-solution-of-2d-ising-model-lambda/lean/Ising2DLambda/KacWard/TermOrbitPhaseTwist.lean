/-
章「トーラス上の Kac--Ward 行列式」の
「非後退置換の置換項は軌道ごとの符号と回転位相の冪の積である」
（`claim_kac_ward_term_orbit_phase_twist_product`）の具体版。

閉路軌道表示から始め、定数多項式埋め込みの乗法性を各軌道の有限積へ繰り返し、
既知の軌道成分積の位相・ねじれ表示を代入する。
-/
import Ising2DLambda.KacWard.SignedOrbitTerm
import Ising2DLambda.KacWard.MovedOrbitWeightPhaseTwist
import Ising2DLambda.NecSuf.KacWard.TermOrbitPhaseTwist

namespace Ising2DLambda.KacWard

open Finset Polynomial
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.NecSuf.KacWard

/-- 非後退置換の置換項へ、各軌道の切断線偶奇と循環総回転数を代入する。 -/
theorem kacWardSignedPermutationTerm_orbit_phase_twist {ι : Type} [Fintype ι]
    [LinearOrder ι]
    (a b : Bool) (horizontal vertical : ι → Bool)
    (M : ι → ι → Qbar) (σ : Equiv.Perm ι)
    (turns : Finset ι → List Turn) (closing : Finset ι → Turn) {z : Qbar}
    (hdiag : ∀ e, M e e = 0)
    (horbitPhase : ∀ O ∈ movedEdgeOrbitSet σ,
      (∏ e ∈ O, M e (σ e)) =
        (boolSign (Bool.xor (a && parity horizontal O.toList)
            (b && parity vertical O.toList)) : Qbar) *
          z ^ (((turns O).map turnValue).sum + turnValue (closing O))) :
    kacWardSignedPermutationTerm M σ =
      ∏ O ∈ movedEdgeOrbitSet σ,
        (-(Polynomial.X ^ O.card) * Polynomial.C
          ((boolSign (Bool.xor (a && parity horizontal O.toList)
              (b && parity vertical O.toList)) : Qbar) *
            z ^ (((turns O).map turnValue).sum + turnValue (closing O)))) := by
  exact Ising2DLambda.NecSuf.KacWard.termOrbitPhaseTwist_necSuf
    (movedEdgeOrbitSet σ) id (fun _ e => M e (σ e))
    (fun O =>
      (boolSign (Bool.xor (a && parity horizontal O.toList)
          (b && parity vertical O.toList)) : Qbar) *
        z ^ (((turns O).map turnValue).sum + turnValue (closing O)))
    (fun O => -(Polynomial.X ^ O.card)) Polynomial.C
    (kacWardSignedPermutationTerm M σ) Polynomial.C_1 (fun _ _ => Polynomial.C_mul)
    (kacWardSignedPermutationTerm_orbit_product M σ hdiag) horbitPhase

end Ising2DLambda.KacWard
