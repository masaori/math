import Ising2DLambda.KacWard.SignedEvenSubgraphOrbitProductSquare
import Ising2DLambda.NecSuf.KacWard.SignedEvenSubgraphOrbitProductSquare

/-!
具体版 `orbitExplicitProduct_sq`（`claim_signed_even_subgraph_orbit_product` の平方の段）を、
必要十分版 `orbit_explicit_product_sq_necSuf` から得る導出版。

`α = Qbar × Qbar`、`R = Qbar[x]`、`K = 𝒦`（`FourierModePair` の値の像）、`orbit p = O(p)`、
`f p = Δ(x; p)`、`g = Δ_O`、`F = F_O` に特殊化し、最後に `claim_dispersion_mode_product` の具体版で
全モードの積を `D^{a,b}_L` へ移す。
-/

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open Classical

theorem orbitExplicitProduct_sq_from_necSuf {L : ℕ} [NeZero L] (z : Qbar) (hz4 : z ^ 4 = -1)
    (s : SpinStructure) :
    orbitExplicitProduct L s ^ 2 = kacWardDeterminant (kacWardTransitionMatrix L z s) := by
  have hL : 1 ≤ L := Nat.one_le_iff_ne_zero.mpr (NeZero.ne L)
  set K : Finset (Qbar × Qbar) := Finset.univ.image (fun m : FourierModePair L s => m.1)
  have hK : ∀ p ∈ K, ∃ m : FourierModePair L s, m.1 = p := fun p hp => by simpa [K] using hp
  have hM : K.image (fun p => modeInversionOrbit p.1 p.2) = modeInversionOrbits L s := by
    rw [Finset.image_image]
    rfl
  have key := Ising2DLambda.NecSuf.KacWard.orbit_explicit_product_sq_necSuf K
    (fun p => modeInversionOrbit p.1 p.2) (fun p => dispersionPolynomial p.1 p.2)
    orbitDispersion oneElementOrbitFactor
    (fun p _ => mem_modeInversionOrbit_self p.1 p.2)
    (fun p hp q hq => by
      obtain ⟨m, rfl⟩ := hK p hp
      obtain ⟨hmem, -, -⟩ := mode_inversion_orbit_cardinality hL s m.2.1 m.2.2
      exact Finset.mem_image.mpr
        ⟨(⟨q, hmem q hq⟩ : FourierModePair L s), Finset.mem_univ _, rfl⟩)
    (fun p hp q hq => by
      obtain ⟨m, rfl⟩ := hK p hp
      exact modeInversionOrbit_eq_of_mem (fourierModePair_ne_zero m).1
        (fourierModePair_ne_zero m).2 hq)
    (fun p hp q hq => by
      obtain ⟨m, rfl⟩ := hK p hp
      exact dispersion_eq_of_mem_modeInversionOrbit m hq)
    (fun p hp => by
      obtain ⟨m, rfl⟩ := hK p hp
      exact orbitDispersion_eq m)
    (fun p hp => by
      obtain ⟨m, rfl⟩ := hK p hp
      exact (mode_inversion_orbit_cardinality hL s m.2.1 m.2.2).2.1)
    (fun p hp h1 => by
      obtain ⟨m, rfl⟩ := hK p hp
      rw [oneElementOrbitFactor_sq (Finset.mem_image_of_mem _ (Finset.mem_univ m)) h1,
        orbitDispersion_eq m])
  calc orbitExplicitProduct L s ^ 2
      = ∏ p ∈ K, dispersionPolynomial p.1 p.2 := by
        -- 必要十分版の結論の軌道の集合 `K.image O` は `𝔐^{a,b}_L` である
        unfold orbitExplicitProduct
        rw [← hM]
        convert key
    _ = ∏ m : FourierModePair L s, dispersionPolynomial m.1.1 m.1.2 :=
        Finset.prod_image (f := fun p : Qbar × Qbar => dispersionPolynomial p.1 p.2)
          (s := Finset.univ) (g := fun m : FourierModePair L s => m.1)
          (fun a _ b _ h => Subtype.ext h)
    _ = kacWardDeterminant (kacWardTransitionMatrix L z s) := (dispersion_mode_product z hz4 s).symm

end Ising2DLambda.KacWard
