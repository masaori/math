/-
「巻き付き二次符号の積と交差形式」の導出版: 具体版 `torusQuadraticSign_polarization` を、
必要十分版 `quadraticSign_polarization_necSuf` の `R = Bool`（`add = xor`・`mul = &&`）、
`α = !a`・`β = !b`、`M = ℤ`・`σ = parityToSign` への特殊化として得る。
右端は `parityToSign_xor_and` で整数の指数へ書き換える。
-/
import Ising2DLambda.KacWard.TorusQuadraticSignPolarization
import Ising2DLambda.NecSuf.KacWard.QuadraticSignPolarization

namespace Ising2DLambda.KacWard

theorem torusQuadraticParity_eq_quadraticForm (a b h v : Bool) :
    torusQuadraticParity a b h v =
      NecSuf.KacWard.quadraticForm xor (· && ·) (!a) (!b) h v := rfl

theorem torusQuadraticSign_polarization_from_necSuf (a b h₁ v₁ h₂ v₂ : Bool) :
    torusQuadraticSign a b (xor h₁ h₂) (xor v₁ v₂) =
      torusQuadraticSign a b h₁ v₁ * torusQuadraticSign a b h₂ v₂ *
        (-1 : ℤ) ^ (h₁.toNat * v₂.toNat + h₂.toNat * v₁.toNat) := by
  have key := NecSuf.KacWard.quadraticSign_polarization_necSuf (M := ℤ) xor (· && ·)
    Bool.xor_comm Bool.xor_assoc Bool.and_xor_distrib_left Bool.and_xor_distrib_right
    parityToSign parityToSign_xor (!a) (!b) h₁ v₁ h₂ v₂
  rw [← parityToSign_xor_and]
  exact key

end Ising2DLambda.KacWard
