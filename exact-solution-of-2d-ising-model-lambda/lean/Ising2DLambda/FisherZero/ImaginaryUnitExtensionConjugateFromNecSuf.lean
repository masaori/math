/- 必要十分版を Qbar の部分体へ特殊化する導出。住処: Qbar。
零元・和・積の閉性は `Subfield` から、係数の二つの表示は各係数の `Lin_F(ω)` の表示と
共役の well-defined 性（`imaginaryUnitConj_apply`）から渡す。 -/
import Ising2DLambda.FisherZero.ImaginaryUnitExtensionConjugate
import Ising2DLambda.NecSuf.FisherZero.ImaginaryUnitExtensionConjugate

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_imaginary_unit_extension_conjugate_product_subfield_coefficient` を必要十分版から得る。 -/
theorem imaginaryUnitExtension_conjugateProduct_subfieldCoefficient_from_necSuf
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (omega : Qbar) (homega : omega * omega = -1) (g : QbarPoly)
    (hg : ∀ k : ℕ, g.coeff k ∈ imaginaryUnitLinearValues F omega) :
    g * imaginaryUnitConjPoly F omega g ∈ subfieldCoefficientPolynomials F := by
  choose a b ha hb hab using hg
  exact Ising2DLambda.NecSuf.FisherZero.imaginaryUnitExtension_conjugateProduct_subfieldCoefficient_necSuf
    (F : Set Qbar) F.zero_mem (fun _ _ hx hy => F.add_mem hx hy) (fun _ _ hx hy => F.mul_mem hx hy)
    omega homega a b ha hb g (imaginaryUnitConjPoly F omega g) hab
    (fun i => by
      rw [imaginaryUnitConjPoly_coeff F C hC omega homega, hab i,
        imaginaryUnitConj_apply F C hC omega homega _ _ (ha i) (hb i)])

end Ising2DLambda.FisherZero
