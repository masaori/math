/-
章「トーラス上の Kac--Ward 行列式」の
「置換項は閉路軌道ごとの符号付き重みの積である」の具体版。

置換項の軌道重み分解と置換符号の軌道分解を結び、各軌道について
`(-1)^(|C|-1) (-x)^|C| = -x^|C|` と整理する。
-/
import Ising2DLambda.KacWard.TermOrbitWeightFactorization
import Ising2DLambda.KacWard.PermutationSignOrbitProduct
import Ising2DLambda.NecSuf.KacWard.SignedOrbitTerm

namespace Ising2DLambda.KacWard

open Finset Polynomial
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.NecSuf.AlgebraicEigenvalue

variable {ι : Type} [Fintype ι] [LinearOrder ι]

/-- 人手証明の置換項 `T_σ(x)`。 -/
noncomputable def kacWardSignedPermutationTerm
    (M : Matrix ι ι Qbar) (σ : Equiv.Perm ι) : QbarPoly :=
  Polynomial.C ((sign (fun x y : ι => x < y) σ : ℤ) : Qbar) *
    kacWardDeterminantEntryProduct M σ

/-- 置換項は動く各軌道の `-x^|C|` 倍の重みの積である。 -/
theorem kacWardSignedPermutationTerm_orbit_product
    (M : Matrix ι ι Qbar) (σ : Equiv.Perm ι)
    (hdiag : ∀ e, M e e = 0) :
    kacWardSignedPermutationTerm M σ =
      ∏ O ∈ movedEdgeOrbitSet σ,
        (-(Polynomial.X ^ O.card) * ∏ e ∈ O, Polynomial.C (M e (σ e))) := by
  classical
  rw [kacWardSignedPermutationTerm,
    kacWardEntryProduct_orbit_factorization M σ,
    sign_movedEdgeOrbit_product σ]
  have hfixed :
      (∏ e ∈ univ.filter fun e => σ e = e, kacWardPolynomialMatrix M e (σ e)) = 1 := by
    apply Finset.prod_eq_one
    intro e he
    have hfix : σ e = e := (mem_filter.mp he).2
    simp [hfix, kacWardPolynomialMatrix, hdiag]
  rw [hfixed, one_mul]
  change
    (Polynomial.C.comp (Int.castRingHom Qbar))
        (∏ O ∈ movedEdgeOrbitSet σ, (-1 : ℤ) ^ (O.card - 1)) *
        (∏ O ∈ movedEdgeOrbitSet σ,
          (-Polynomial.X : QbarPoly) ^ O.card *
            ∏ e ∈ O, Polynomial.C (M e (σ e))) = _
  rw [map_prod]
  simp only [map_pow, map_neg, map_one]
  exact Ising2DLambda.NecSuf.KacWard.signedOrbitWeights_combine
    (movedEdgeOrbitSet σ) Finset.card
    (fun O => ∏ e ∈ O, Polynomial.C (M e (σ e))) Polynomial.X
    (fun O hO => Finset.card_pos.mpr ((movedEdgeOrbitSet_partition σ).1 O hO))

/-- 行列式の置換展開は、各置換の閉路軌道重みの積の和になる。 -/
theorem kacWardSignedPermutationSum_orbit_product
    (M : Matrix ι ι Qbar) (hdiag : ∀ e, M e e = 0) :
    (∑ σ : Equiv.Perm ι, kacWardSignedPermutationTerm M σ) =
      ∑ σ : Equiv.Perm ι, ∏ O ∈ movedEdgeOrbitSet σ,
        (-(Polynomial.X ^ O.card) * ∏ e ∈ O, Polynomial.C (M e (σ e))) := by
  apply Finset.sum_congr rfl
  intro σ _
  exact kacWardSignedPermutationTerm_orbit_product M σ hdiag

/-- 導出版: 必要十分版の有限積恒等式から同じ表示を得る。 -/
theorem kacWardSignedPermutationTerm_orbit_product_from_necSuf
    (M : Matrix ι ι Qbar) (σ : Equiv.Perm ι)
    (hdiag : ∀ e, M e e = 0) :
    kacWardSignedPermutationTerm M σ =
      ∏ O ∈ movedEdgeOrbitSet σ,
        (-(Polynomial.X ^ O.card) * ∏ e ∈ O, Polynomial.C (M e (σ e))) :=
  kacWardSignedPermutationTerm_orbit_product M σ hdiag

end Ising2DLambda.KacWard
