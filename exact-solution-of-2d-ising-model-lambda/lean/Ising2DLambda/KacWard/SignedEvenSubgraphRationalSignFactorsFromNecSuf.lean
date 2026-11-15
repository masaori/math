import Ising2DLambda.KacWard.SignedEvenSubgraphRationalSignFactors
import Ising2DLambda.NecSuf.KacWard.SignedEvenSubgraphRationalSignFactors

/-!
具体版 `orbitDispersion_pos_at_rationalPoint`・`oneElementOrbitFactor_eval_at_rationalPoint`
（`claim_signed_even_subgraph_rational_sign` の因子の符号の段）を、必要十分版から得る導出版。

分散因子の段は `lt = <_R`（推移律は `claim_real_algebraic_order_transitive` の具体版）、
`emb` を `R ⊂ Qbar` の包含、`z = 0`、`P = (q²+2q−1)²`、`f O = Δ_O(q)`、`g m = Δ(q; m)` に特殊化する。
一元軌道の段は `K = ℚ`、`c₁` を「代表元が `(1,1)`」、`c₂` を「代表元が `(−1,−1)`」に特殊化し、
`F_O(q)` が三つの場合の有理数の包含であることで具体版の形へ戻す。
-/

namespace Ising2DLambda.KacWard

open Polynomial
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero
open Ising2DLambda.CriticalExponent
open Classical

theorem orbitDispersion_pos_at_rationalPoint_from_necSuf (data : RealClosedSubfieldData) {L : ℕ}
    [NeZero L] {s : SpinStructure} {O : Finset (Qbar × Qbar)} (hO : O ∈ modeInversionOrbits L s)
    (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) :
    ∃ D : data.carrier,
      (D : Qbar) = (orbitDispersion O).eval (q : Qbar) ∧ realAlgebraicLt data 0 D := by
  have hL : 1 ≤ L := Nat.one_le_iff_ne_zero.mpr (NeZero.ne L)
  exact Ising2DLambda.NecSuf.KacWard.orbit_dispersion_pos_necSuf
    (realAlgebraicLt data) (realAlgebraicLt_trans data) (fun D : data.carrier => (D : Qbar)) 0
    (realClosedRat data (q ^ 2 + 2 * q - 1) * realClosedRat data (q ^ 2 + 2 * q - 1))
    (fun O' => (orbitDispersion O').eval (q : Qbar))
    (fun m : FourierModePair L s => (dispersionPolynomial m.1.1 m.1.2).eval (q : Qbar)) O
    (by
      obtain ⟨m, rfl⟩ := mem_modeInversionOrbits hO
      exact ⟨m, by rw [orbitDispersion_eq m]⟩)
    (fun m => dispersion_positive_at_rationalPoint data L hL s m.1.1 m.1.2 m.2.1 m.2.2 q hq0 hq1)

/-- `F_O(q)` は三つの場合の有理数の包含である。 -/
theorem oneElementOrbitFactor_eval_eq_rat_cast (O : Finset (Qbar × Qbar)) (q : ℚ) :
    (oneElementOrbitFactor O).eval (q : Qbar) =
      (((if orbitRepresentative O = (1, 1) then 1 - 2 * q - q ^ 2
        else if orbitRepresentative O = (-1, -1) then 1 + 2 * q - q ^ 2 else 1 + q ^ 2 : ℚ)) : Qbar) := by
  unfold oneElementOrbitFactor
  split_ifs <;>
    simp only [eval_sub, eval_add, eval_mul, eval_pow, eval_X, eval_one, eval_ofNat] <;>
    push_cast <;> ring

theorem oneElementOrbitFactor_eval_at_rationalPoint_from_necSuf (O : Finset (Qbar × Qbar)) (q : ℚ)
    (hq0 : 0 < q) (hq1 : q < 1) :
    (orbitRepresentative O = (1, 1) ∧
        (oneElementOrbitFactor O).eval (q : Qbar) = ((-(q ^ 2 + 2 * q - 1) : ℚ) : Qbar)) ∨
      (orbitRepresentative O ≠ (1, 1) ∧
        ∃ r : ℚ, 0 < r ∧ (oneElementOrbitFactor O).eval (q : Qbar) = (r : Qbar)) := by
  rcases Ising2DLambda.NecSuf.KacWard.one_element_factor_sign_necSuf q hq0 hq1
      (orbitRepresentative O = (1, 1)) (orbitRepresentative O = (-1, -1)) with
    ⟨h1, hval⟩ | ⟨h1, hpos⟩
  · exact Or.inl ⟨h1, by rw [oneElementOrbitFactor_eval_eq_rat_cast, hval]⟩
  · exact Or.inr ⟨h1, _, hpos, oneElementOrbitFactor_eval_eq_rat_cast O q⟩

end Ising2DLambda.KacWard
