/-
章「Fisher 零点」の「同じ破れた辺の集合を与える配位は全スピン反転を除いて一意である」の具体版。
人手証明と同じく、横向き・縦向きの辺を有限回たどって、基点との一致が全頂点で一定であることを示す。
住処: Z。R / C は現れない。
-/
import Ising2DLambda.FisherZero.GlobalSpinReversal
import Ising2DLambda.TransferMatrix.Basic

namespace Ising2DLambda.FisherZero

open Ising2DLambda.PartitionPolynomial Ising2DLambda.TransferMatrix

private theorem agreement_iff_of_same_difference (a b c d : SpinValue)
    (h : a ≠ b ↔ c ≠ d) : (c = a ↔ d = b) := by
  rcases a with ⟨a, ha | ha⟩ <;> subst a <;>
    rcases b with ⟨b, hb | hb⟩ <;> subst b <;>
    rcases c with ⟨c, hc | hc⟩ <;> subst c <;>
    rcases d with ⟨d, hd | hd⟩ <;> subst d <;>
    simp_all
  all_goals constructor <;> intro hx <;> exact hx.symm

theorem spinValue_eq_or_reversal (a b : SpinValue) :
    b = a ∨ b = spinReversal a := by
  rcases a with ⟨a, ha | ha⟩ <;> subst a <;>
    rcases b with ⟨b, hb | hb⟩ <;> subst b <;> simp [spinReversal]

theorem sameBrokenEdges_constantAgreement (L : ℕ) [NeZero L] (σ τ : Config L)
    (hbroken : ∀ e : Edge L,
      σ (boundary0 L e) ≠ σ (boundary1 L e) ↔
        τ (boundary0 L e) ≠ τ (boundary1 L e)) :
    ∀ v w : Vertex L, (τ v = σ v ↔ τ w = σ w) := by
  have hedge : ∀ e : Edge L,
      (τ (boundary0 L e) = σ (boundary0 L e) ↔
        τ (boundary1 L e) = σ (boundary1 L e)) := by
    intro e
    exact agreement_iff_of_same_difference
      (σ (boundary0 L e)) (σ (boundary1 L e))
      (τ (boundary0 L e)) (τ (boundary1 L e)) (hbroken e)

  have hhorizontal (i j : ZMod L) :
      (τ (i, j) = σ (i, j) ↔ τ (i, j + 1) = σ (i, j + 1)) := by
    simpa [edgeOfRow_boundary0, edgeOfRow_boundary1_horizontal] using
      hedge (edgeOfRow L false i j)

  have hvertical (i j : ZMod L) :
      (τ (i, j) = σ (i, j) ↔ τ (i + 1, j) = σ (i + 1, j)) := by
    simpa [edgeOfRow_boundary0, edgeOfRow_boundary1_vertical] using
      hedge (edgeOfRow L true i j)

  have hrow (i : ZMod L) : ∀ n : ℕ,
      (τ (i, (n : ZMod L)) = σ (i, (n : ZMod L)) ↔ τ (i, 0) = σ (i, 0)) := by
    intro n
    induction n with
    | zero => simp
    | succ n ih =>
        have hstep := (hhorizontal i (n : ZMod L)).symm.trans ih
        simpa [Nat.cast_succ] using hstep

  have hcolumn : ∀ n : ℕ,
      (τ ((n : ZMod L), 0) = σ ((n : ZMod L), 0) ↔ τ (0, 0) = σ (0, 0)) := by
    intro n
    induction n with
    | zero => simp
    | succ n ih =>
        have hstep := (hvertical (n : ZMod L) 0).symm.trans ih
        simpa [Nat.cast_succ] using hstep

  intro v w
  have hv : τ v = σ v ↔ τ (0, 0) = σ (0, 0) := by
    calc
      τ v = σ v ↔ τ (v.1, 0) = σ (v.1, 0) := by
        simpa [ZMod.natCast_rightInverse] using hrow v.1 v.2.val
      _ ↔ τ (0, 0) = σ (0, 0) := by
        simpa [ZMod.natCast_rightInverse] using hcolumn v.1.val
  have hw : τ w = σ w ↔ τ (0, 0) = σ (0, 0) := by
    calc
      τ w = σ w ↔ τ (w.1, 0) = σ (w.1, 0) := by
        simpa [ZMod.natCast_rightInverse] using hrow w.1 w.2.val
      _ ↔ τ (0, 0) = σ (0, 0) := by
        simpa [ZMod.natCast_rightInverse] using hcolumn w.1.val
  exact hv.trans hw.symm

theorem sameBrokenEdges_eq_or_globalSpinReversal (L : ℕ) [NeZero L] (σ τ : Config L)
    (hbroken : ∀ e : Edge L,
      σ (boundary0 L e) ≠ σ (boundary1 L e) ↔
        τ (boundary0 L e) ≠ τ (boundary1 L e)) :
    τ = σ ∨ τ = globalSpinReversal L σ := by
  have hconstant := sameBrokenEdges_constantAgreement L σ τ hbroken
  classical
  let base : Vertex L := (0, 0)
  by_cases hbase : τ base = σ base
  · left
    funext v
    exact (hconstant v base).mpr hbase
  · right
    funext v
    rcases spinValue_eq_or_reversal (σ v) (τ v) with heq | hreverse
    · exact False.elim (hbase ((hconstant v base).mp heq))
    · exact hreverse

end Ising2DLambda.FisherZero
