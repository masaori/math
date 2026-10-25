import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PerfectMatching

namespace Ising2DLambda.NecSuf.KacWard

/-- A localMate pairing on selected points and a reversal pairing on their complement
    join to a fixed-point-free involution.  Preservation of the selected set is
    exactly what prevents a point from changing branch on the second step. -/
noncomputable def splicePairings {J : Type*}
    (selected : J → Prop)
    (localMate reverse : J → J)
    (hlocalSelected : ∀ j, selected j → selected (localMate j))
    (hlocalInvolutive : ∀ j, selected j → localMate (localMate j) = j)
    (hlocalNe : ∀ j, selected j → localMate j ≠ j)
    (hreverseOutside : ∀ j, ¬ selected j → ¬ selected (reverse j))
    (hreverseInvolutive : ∀ j, ¬ selected j → reverse (reverse j) = j)
    (hreverseNe : ∀ j, ¬ selected j → reverse j ≠ j) :
    {τ : J → J // (∀ j, τ j ≠ j) ∧ Function.Involutive τ} := by
  classical
  let τ : J → J := fun j => if selected j then localMate j else reverse j
  have hne : ∀ j, τ j ≠ j := by
    intro j
    by_cases hj : selected j
    · simpa [τ, hj] using hlocalNe j hj
    · simpa [τ, hj] using hreverseNe j hj
  have hinv : Function.Involutive τ := by
    intro j
    by_cases hj : selected j
    · have hnext := hlocalSelected j hj
      simp [τ, hj, hnext, hlocalInvolutive j hj]
    · have hnext := hreverseOutside j hj
      simp [τ, hj, hnext, hreverseInvolutive j hj]
  exact ⟨τ, hne, hinv⟩

/-- The two-point orbits of the spliced involution partition the index set. -/
noncomputable def splicePairingMatching {J : Type*}
    (selected : J → Prop) (localMate reverse : J → J)
    (hlocalSelected : ∀ j, selected j → selected (localMate j))
    (hlocalInvolutive : ∀ j, selected j → localMate (localMate j) = j)
    (hlocalNe : ∀ j, selected j → localMate j ≠ j)
    (hreverseOutside : ∀ j, ¬ selected j → ¬ selected (reverse j))
    (hreverseInvolutive : ∀ j, ¬ selected j → reverse (reverse j) = j)
    (hreverseNe : ∀ j, ¬ selected j → reverse j ≠ j) :
    Ising2DLambda.NecSuf.AlgebraicEigenvalue.PerfectMatching J :=
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.involutionToPerfectMatching
    (splicePairings selected localMate reverse hlocalSelected hlocalInvolutive
      hlocalNe hreverseOutside hreverseInvolutive hreverseNe)

/-- Only branch preservation and a mate equation are needed for pair support. -/
theorem splice_pair_support {J : Type*} (selected : J → Prop)
    [DecidablePred selected]
    (localMate reverse : J → J) (source : J → J')
    (hlocalSelected : ∀ j, selected j → selected (localMate j))
    (hlocalSource : ∀ j, selected j → source (localMate j) = source j)
    (hreverseOutside : ∀ j, ¬ selected j → ¬ selected (reverse j))
    (p : J × J)
    (hmate : p.2 = if selected p.1 then localMate p.1 else reverse p.1) :
    (selected p.1 → p.2 = localMate p.1 ∧ selected p.2 ∧
      source p.2 = source p.1) ∧
    (¬ selected p.1 → p.2 = reverse p.1 ∧ ¬ selected p.2) := by
  classical
  constructor
  · intro hp
    have hpair : p.2 = localMate p.1 := by simpa [hp] using hmate
    exact ⟨hpair, hpair ▸ hlocalSelected p.1 hp,
      hpair ▸ hlocalSource p.1 hp⟩
  · intro hp
    have hpair : p.2 = reverse p.1 := by simpa [hp] using hmate
    exact ⟨hpair, hpair ▸ hreverseOutside p.1 hp⟩

end Ising2DLambda.NecSuf.KacWard
