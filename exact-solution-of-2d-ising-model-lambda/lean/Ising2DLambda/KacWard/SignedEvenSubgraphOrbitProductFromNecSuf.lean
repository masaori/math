import Ising2DLambda.KacWard.SignedEvenSubgraphOrbitProduct
import Ising2DLambda.NecSuf.KacWard.SignedEvenSubgraphOrbitProduct

/-!
具体版 `orbitExplicitProduct_eq_signedEvenSubgraphPolynomial`（`claim_signed_even_subgraph_orbit_product`）を、
必要十分版 `orbit_explicit_product_eq_squareRoot_necSuf` から得る導出版。

`R = Qbar[x]`、`K = Qbar`、`c = ` 定数項（`Polynomial.constantCoeff`）、`A, B, C` を元数一・二・四の軌道、
`F = F_O`、`g = Δ_O`、`D = D^{a,b}_L` に特殊化する。平方の段は `orbitExplicitProduct_sq`、
平方根 `S^{a,b}_L` と `S = Q` は `claim_determinant_polynomial_square_root_exists` の具体版から取る。
-/

namespace Ising2DLambda.KacWard

open Polynomial
open Ising2DLambda.AlgebraicEigenvalue
open Classical

/-- 定数項の写像 `ac_0 : Qbar[x] → Qbar`（単位元と積を保つ）。 -/
noncomputable def qbarConstantTermHom : QbarPoly →* Qbar :=
  (Polynomial.constantCoeff : QbarPoly →+* Qbar).toMonoidHom

theorem qbarConstantTermHom_apply (p : QbarPoly) : qbarConstantTermHom p = p.coeff 0 := rfl

/-- 明示積の定義を三つの積の形で書く。 -/
theorem orbitExplicitProduct_eq_three_products (L : ℕ) [NeZero L] (s : SpinStructure) :
    orbitExplicitProduct L s =
      (∏ O ∈ (modeInversionOrbits L s).filter (fun O => O.card = 1), oneElementOrbitFactor O) *
        (∏ O ∈ (modeInversionOrbits L s).filter (fun O => O.card = 2), orbitDispersion O) *
        (∏ O ∈ (modeInversionOrbits L s).filter (fun O => O.card = 4), orbitDispersion O ^ 2) :=
  rfl

theorem orbitExplicitProduct_eq_signedEvenSubgraphPolynomial_from_necSuf {L : ℕ} [NeZero L]
    (z : Qbar) (hz4 : z ^ 4 = -1) (s : SpinStructure) :
    orbitExplicitProduct L s =
      (signedEvenSubgraphPolynomial L (spinComponentFin s.1) (spinComponentFin s.2)).map
        (Int.castRingHom Qbar) := by
  obtain ⟨S, hS, -⟩ := kacWardDeterminant_existsUnique_qbarPolynomialSquareRoot (L := L) z hz4 s
  have hPP : orbitExplicitProduct L s * orbitExplicitProduct L s =
      kacWardDeterminant (kacWardTransitionMatrix L z s) := by
    rw [← pow_two]
    exact orbitExplicitProduct_sq z hz4 s
  rw [orbitExplicitProduct_eq_three_products] at hPP
  have hPS := Ising2DLambda.NecSuf.KacWard.orbit_explicit_product_eq_squareRoot_necSuf
      (β := Finset (Qbar × Qbar)) (R := QbarPoly) (K := Qbar)
      qbarConstantTermHom
      ((modeInversionOrbits L s).filter (fun O => O.card = 1))
      ((modeInversionOrbits L s).filter (fun O => O.card = 2))
      ((modeInversionOrbits L s).filter (fun O => O.card = 4))
      oneElementOrbitFactor orbitDispersion
      (kacWardDeterminant (kacWardTransitionMatrix L z s)) S
      (fun O _ => by rw [qbarConstantTermHom_apply, oneElementOrbitFactor_coeff_zero])
      (fun O => by rw [qbarConstantTermHom_apply, orbitDispersion, dispersionPolynomial_coeff_zero])
      hPP
      (by rw [qbarConstantTermHom_apply]; exact hS.1)
      hS.2
      (fun T U hT hU hTU => qbarPolynomialSquareRoot_unique T U
        (by rw [← qbarConstantTermHom_apply]; exact hT)
        (by rw [← qbarConstantTermHom_apply]; exact hU) hTU)
  exact (orbitExplicitProduct_eq_three_products L s).trans
    (hPS.trans (kacWardDeterminant_squareRoot_eq_signedEvenSubgraphPolynomial z hz4 s S hS))

end Ising2DLambda.KacWard
