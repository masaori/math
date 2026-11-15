import Ising2DLambda.KacWard.SignedEvenSubgraphRationalSign
import Ising2DLambda.NecSuf.KacWard.SignedEvenSubgraphRationalSign
import Ising2DLambda.KacWard.SignedEvenSubgraphRationalSignFactorsFromNecSuf

/-!
具体版 `signedEvenSubgraphPolynomial_rational_sign`（`claim_signed_even_subgraph_rational_sign` の
積の符号の合成の段）を、必要十分版から得る導出版。

正の元の積は `K = R`（部分体なので可換環で零因子が無い）、有限積は `V = Qbar` と正の述語 `RPositive`、
符号の反映は `K = R`・`lt = <_R`・`e` を有理数の `R` への像に特殊化する（`hneg` は `<_R` の定義、
`hirr`・`hasymm` は三分法 `claim_real_algebraic_order_trichotomy` の具体版）。
合成は `V = Qbar`、`e = ℚ → Qbar`、`F` を代表元が `(1,1)` の一元軌道の因子の積、
`P'` を残りの因子の積に特殊化し、値の分解と所属は具体版の段から取る。
-/

namespace Ising2DLambda.KacWard

open Polynomial
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero
open Ising2DLambda.CriticalExponent
open Classical

theorem rPositive_mul_from_necSuf (data : RealClosedSubfieldData) {y y' : Qbar}
    (h : RPositive data y) (h' : RPositive data y') : RPositive data (y * y') := by
  obtain ⟨u, hu, hpu⟩ := h
  obtain ⟨v, hv, hpv⟩ := h'
  exact ⟨u * v, by rw [Subfield.coe_mul, hu, hv],
    Ising2DLambda.NecSuf.KacWard.square_pos_mul_necSuf hpu hpv⟩

theorem rPositive_prod_from_necSuf (data : RealClosedSubfieldData) {β : Type*} (A : Finset β)
    (f : β → Qbar) (h : ∀ i ∈ A, RPositive data (f i)) : RPositive data (∏ i ∈ A, f i) :=
  Ising2DLambda.NecSuf.KacWard.pos_prod_necSuf (RPositive data) (rPositive_one data)
    (fun _ _ ha hb => rPositive_mul_from_necSuf data ha hb) A f h

theorem rat_pos_of_rPositive_from_necSuf (data : RealClosedSubfieldData) {r : ℚ}
    (h : RPositive data (r : Qbar)) : 0 < r := by
  obtain ⟨D, hD, hpos⟩ := h
  have hDr : D = (Rat.castHom data.carrier) r := by
    apply Subtype.ext
    rw [hD]
    simp
  refine Ising2DLambda.NecSuf.KacWard.rat_pos_of_pos_necSuf (realAlgebraicLt data)
    (Rat.castHom data.carrier) (fun r hr => ?_) (fun x hx => ?_)
    (fun h0 => (realAlgebraicLt_trichotomy data 0 0).2.1 ⟨h0, rfl⟩)
    (fun a b hab hba => (realAlgebraicLt_trichotomy data a b).2.2.1 ⟨hab, hba⟩) (hDr ▸ hpos)
  · rw [Rat.coe_castHom, ← realClosedRat_eq_cast]
    exact positiveRational_realAlgebraic_positive data r hr
  · obtain ⟨w, hw0, hw⟩ := hx
    exact ⟨w, hw0, by rw [← hw]; ring⟩

theorem signedEvenSubgraphPolynomial_rational_sign_from_necSuf (data : RealClosedSubfieldData)
    {L : ℕ} [NeZero L] (z : Qbar) (hz4 : z ^ 4 = -1) (s : SpinStructure) (q : ℚ) (hq0 : 0 < q)
    (hq1 : q < 1) :
    (q ^ 2 + 2 * q - 1 < 0 →
        0 < ((signedEvenSubgraphPolynomial L (spinComponentFin s.1) (spinComponentFin s.2)).map
          (Int.castRingHom ℚ)).eval q) ∧
      (0 < q ^ 2 + 2 * q - 1 →
        (s = (false, false) →
            ((signedEvenSubgraphPolynomial L (spinComponentFin s.1) (spinComponentFin s.2)).map
              (Int.castRingHom ℚ)).eval q < 0) ∧
          (s ≠ (false, false) →
            0 < ((signedEvenSubgraphPolynomial L (spinComponentFin s.1) (spinComponentFin s.2)).map
              (Int.castRingHom ℚ)).eval q)) := by
  set F := ∏ O ∈ ((modeInversionOrbits L s).filter (fun O => O.card = 1)).filter
    (fun O => orbitRepresentative O = ((1 : Qbar), (1 : Qbar))), (oneElementOrbitFactor O).eval (q : Qbar)
  have hsplit := orbitExplicitProduct_eval_split L s (q : Qbar)
  rw [orbitExplicitProduct_eval_eq_rat z hz4 s q] at hsplit
  have hF11 : (oneElementOrbitFactor {((1 : Qbar), (1 : Qbar))}).eval (q : Qbar) =
      ((-(q ^ 2 + 2 * q - 1) : ℚ) : Qbar) := by
    rw [oneElementOrbitFactor_eval_eq_rat_cast, if_pos]
    · push_cast; ring
    · exact Finset.mem_singleton.mp (orbitRepresentative_mem (Finset.singleton_nonempty _))
  have hFval : F = (if s = (false, false) then ((-(q ^ 2 + 2 * q - 1) : ℚ) : Qbar) else 1) := by
    simp only [F]
    rw [oneElementOrbits_filter_one_one L s]
    split_ifs
    · rw [Finset.prod_singleton, hF11]
    · rfl
  have hcomp := Ising2DLambda.NecSuf.KacWard.sign_compose_necSuf (RPositive data)
    (fun _ _ ha hb => rPositive_mul_from_necSuf data ha hb) (Rat.castHom Qbar)
    (fun r hr => rPositive_rat data hr) (fun r hr => rat_pos_of_rPositive_from_necSuf data hr)
    (q ^ 2 + 2 * q - 1) _ F _ (orbitExplicitProduct_rest_pos data L s q hq0 hq1) hsplit
    (by
      rw [hFval]
      split_ifs
      · left; simp
      · right; rfl)
  refine ⟨hcomp.1, fun hc => ⟨fun hs => hcomp.2.1 hc (by rw [hFval, if_pos hs]; simp),
    fun hs => hcomp.2.2 (by rw [hFval, if_neg hs])⟩⟩

end Ising2DLambda.KacWard
