import Ising2DLambda.KacWard.LocalPairingTaggedMatchingCorrespondence
import Ising2DLambda.NecSuf.KacWard.LocalPairingTaggedMatchingCorrespondence

/-!
具体版 `nonzeroTaggedMatchings_sum_eq_localPairing_sum` を、必要十分版を半辺 `OrientedEdge L`・
頂点 `Vertex L`・方向番号 `Fin 4`・全単射 `portEquiv`・選択集合 `selectedPortNumbers P`・
項の集合 `nonzeroTaggedMatchings z s P`・相手 `perfectMatchingMate x.1`・構成
`localPairingTaggedMatching P` に特殊化して得る導出版。
-/

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue Ising2DLambda.PartitionPolynomial
  Ising2DLambda.TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 具体版の局所対合の選択集合は、必要十分版の局所対合の選択集合を `Fin 4` に特殊化したものである。 -/
theorem vertexLocalPairingChoices_eq_necSuf (P : Finset (Edge L)) :
    vertexLocalPairingChoices P = Fintype.piFinset (fun v =>
      Ising2DLambda.NecSuf.KacWard.localInvolutionChoices (selectedPortNumbers P v)) := by
  ext κ
  simp only [vertexLocalPairingChoices, Fintype.mem_piFinset, localPairingChoices,
    Ising2DLambda.NecSuf.KacWard.localInvolutionChoices, Finset.mem_filter]

theorem nonzeroTaggedMatchings_sum_eq_localPairing_sum_from_necSuf {M : Type*}
    [AddCommMonoid M]
    (z : Qbar) (hz : z ^ (4 : ℕ) = -1) (s : SpinStructure) (P : Finset (Edge L))
    (g : PerfectMatching (OrientedEdge L) × Finset (OrientedEdge L × OrientedEdge L) → M)
    (f : (Vertex L → Fin 4 → Fin 4) → M)
    (hgf : ∀ κ hκ, g (localPairingTaggedMatching P κ hκ) = f κ) :
    ∑ x ∈ nonzeroTaggedMatchings z s P, g x = ∑ κ ∈ vertexLocalPairingChoices P, f κ := by
  classical
  -- 非零項の選んだ半辺の相手は、同じ始点の選んだ半辺である
  have hshort : ∀ x ∈ nonzeroTaggedMatchings z s P, ∀ v i, i ∈ selectedPortNumbers P v →
      (perfectMatchingMate x.1 (portEquiv.symm (v, i))).1 ∈ P ∧
        orientedSource (perfectMatchingMate x.1 (portEquiv.symm (v, i))) = v := by
    intro x hx v i hi
    obtain ⟨_, ht, hterm, hP⟩ := Finset.mem_filter.mp hx
    have hh : (portEquiv.symm (v, i)).1 ∈ taggedComplementEdges x.1 x.2 :=
      hP ▸ (mem_selectedPortNumbers_iff P v i).mp hi
    have hsrc : orientedSource (portEquiv.symm (v, i)) = v := by
      have h₀ := congrArg Prod.fst (Equiv.apply_symm_apply portEquiv (v, i))
      rw [portEquiv_apply] at h₀
      exact h₀
    obtain ⟨hsel, hsrc'⟩ := nonzeroTaggedMatching_mate_short z s x.1 x.2 ht hterm _ hh
    exact ⟨hP ▸ hsel, hsrc'.trans hsrc⟩
  have hcast : ∀ κ, κ ∈ Fintype.piFinset (fun v =>
      Ising2DLambda.NecSuf.KacWard.localInvolutionChoices (selectedPortNumbers P v)) →
      κ ∈ vertexLocalPairingChoices P := by
    intro κ hκ
    rw [vertexLocalPairingChoices_eq_necSuf]
    exact hκ
  rw [vertexLocalPairingChoices_eq_necSuf]
  exact Ising2DLambda.NecSuf.KacWard.sum_over_terms_eq_sum_over_local_involutions
    portEquiv (selectedPortNumbers P) (nonzeroTaggedMatchings z s P)
    (fun x => perfectMatchingMate x.1)
    (fun κ hκ => localPairingTaggedMatching P κ (hcast κ hκ))
    (fun κ hκ => localPairingTaggedMatching_mem z hz s P κ (hcast κ hκ))
    (fun κ hκ v i hi => localPairingTaggedMatching_mate P κ (hcast κ hκ) v i hi)
    (fun x hx v i hi => by
      rw [portEquiv_apply]
      exact (hshort x hx v i hi).2)
    (fun x hx v i hi => by
      have hm : (v, (portEquiv (perfectMatchingMate x.1 (portEquiv.symm (v, i)))).2) =
          portEquiv (perfectMatchingMate x.1 (portEquiv.symm (v, i))) := by
        refine Prod.ext ?_ rfl
        change v = (portEquiv (perfectMatchingMate x.1 (portEquiv.symm (v, i)))).1
        rw [portEquiv_apply]
        exact (hshort x hx v i hi).2.symm
      rw [mem_selectedPortNumbers_iff, hm, Equiv.symm_apply_apply]
      exact (hshort x hx v i hi).1)
    (fun x _ v i _ => perfectMatchingMate_ne x.1 _)
    (fun x _ v i _ => perfectMatchingMate_involutive x.1 _)
    (fun x hx κ hκ hmate => localPairingTaggedMatching_eq_of_mate z s P x hx κ (hcast κ hκ) hmate)
    g f (fun κ hκ => hgf κ (hcast κ hκ))

end Ising2DLambda.KacWard
