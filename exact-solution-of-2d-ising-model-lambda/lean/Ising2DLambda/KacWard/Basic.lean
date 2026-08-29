/-
章「トーラス上の Kac--Ward 行列式」の具体版。
人手証明の `def_oriented_edges`・`def_edge_reversal`・`def_spin_structures` と
`claim_reversal_is_involution`・`claim_reversal_has_no_fixed_point` に対応する。
住処は有限集合と自然数であり、ℝ / ℂ は現れない。
-/
import Ising2DLambda.PartitionPolynomial.Basic
import Ising2DLambda.NecSuf.KacWard.Basic

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

def OrientedEdge (L : ℕ) : Type := Edge L × Bool

instance (L : ℕ) : Fintype (OrientedEdge L) := by
  unfold OrientedEdge
  infer_instance

instance (L : ℕ) : DecidableEq (OrientedEdge L) := by
  unfold OrientedEdge
  infer_instance

def reversal {L : ℕ} (e : OrientedEdge L) : OrientedEdge L :=
  (e.1, Ising2DLambda.NecSuf.KacWard.reverseBool e.2)

lemma reversal_involutive {L : ℕ} (e : OrientedEdge L) :
    reversal (reversal e) = e := by
  rcases e with ⟨edge, direction⟩
  simp only [reversal]
  rw [Ising2DLambda.NecSuf.KacWard.reverseBool_involutive]

lemma reversal_ne {L : ℕ} (e : OrientedEdge L) : reversal e ≠ e := by
  rcases e with ⟨edge, direction⟩
  intro h
  have hDirection : Ising2DLambda.NecSuf.KacWard.reverseBool direction = direction :=
    congrArg Prod.snd h
  exact Ising2DLambda.NecSuf.KacWard.reverseBool_ne direction hDirection

def SpinStructure : Type := Bool × Bool

instance : Fintype SpinStructure := by
  unfold SpinStructure
  infer_instance

lemma spinStructures_card : Fintype.card SpinStructure = 4 := by
  unfold SpinStructure
  exact Ising2DLambda.NecSuf.KacWard.card_bool_product

end Ising2DLambda.KacWard
