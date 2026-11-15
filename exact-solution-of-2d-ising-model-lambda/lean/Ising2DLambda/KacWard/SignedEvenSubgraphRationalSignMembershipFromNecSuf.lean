import Ising2DLambda.KacWard.SignedEvenSubgraphRationalSignMembership
import Ising2DLambda.KacWard.ModeInversionOrbitCardinalityFromNecSuf
import Ising2DLambda.NecSuf.KacWard.SignedEvenSubgraphRationalSignMembership

/-!
具体版 `oneOne_mem_twistedModes_iff`・`modeInversionOrbit_one_one`・
`eq_one_one_of_one_one_mem_modeInversionOrbit`・`singleton_one_one_mem_modeInversionOrbits_iff`・
`orbitRepresentative_eq_one_one_iff`・`oneElementOrbits_filter_one_one`
（`claim_signed_even_subgraph_rational_sign` のモード `(1,1)` の所属の段）を、必要十分版から得る導出版。

所属の三行は `K = Qbar`（`1 ≠ −1` は `qbar_one_ne_neg_one`）に、軌道の二つは `K = Qbar` に特殊化する。
`{(1,1)} ∈ 𝔐` は `κ = 𝒦`、`val m = m`、`orb m = O(m)`、`p = (1,1)`、`P = ((a,b) = (0,0))` に、
代表元の段は `M = 𝔐`、`rep = orbitRepresentative` に特殊化する。
-/

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open Classical

theorem oneOne_mem_twistedModes_iff_from_necSuf (L : ℕ) (s : SpinStructure) :
    ((1 : Qbar) ∈ horizontalTwistedModes L s ∧ (1 : Qbar) ∈ verticalTwistedModes L s) ↔
      s = (false, false) :=
  Ising2DLambda.NecSuf.KacWard.one_one_mem_modes_iff_necSuf qbar_one_ne_neg_one L s

theorem modeInversionOrbit_one_one_from_necSuf :
    modeInversionOrbit 1 1 = {((1 : Qbar), (1 : Qbar))} := by
  rw [modeInversionOrbit_from_necSuf]
  convert Ising2DLambda.NecSuf.KacWard.modeInversionOrbit_one_one_necSuf (K := Qbar)

theorem eq_one_one_of_one_one_mem_modeInversionOrbit_from_necSuf {varpi varsigma : Qbar}
    (h : ((1 : Qbar), (1 : Qbar)) ∈ modeInversionOrbit varpi varsigma) :
    varpi = 1 ∧ varsigma = 1 := by
  rw [modeInversionOrbit_from_necSuf] at h
  exact Ising2DLambda.NecSuf.KacWard.eq_one_one_of_mem_orbit_necSuf (by convert h)

theorem singleton_one_one_mem_modeInversionOrbits_iff_from_necSuf (L : ℕ) [NeZero L]
    (s : SpinStructure) :
    ({((1 : Qbar), (1 : Qbar))} : Finset (Qbar × Qbar)) ∈ modeInversionOrbits L s ↔
      s = (false, false) := by
  have hL : 1 ≤ L := Nat.one_le_iff_ne_zero.mpr (NeZero.ne L)
  refine Ising2DLambda.NecSuf.KacWard.singleton_mem_orbits_iff_necSuf
    (fun m : FourierModePair L s => m.1) (fun m => modeInversionOrbit m.1.1 m.1.2)
    ((1 : Qbar), (1 : Qbar)) (s = (false, false)) ?_ ?_ ?_
  · -- 軌道の元はモードの点（`claim_mode_inversion_orbit_cardinality`）
    intro m x hx
    exact ⟨⟨x, (mode_inversion_orbit_cardinality hL s m.2.1 m.2.2).1 x hx⟩, rfl⟩
  · -- `(1,1)` がモードの点であることと `(a,b) = (0,0)` の同値
    rw [← oneOne_mem_twistedModes_iff_from_necSuf L s]
    constructor
    · rintro ⟨m, hm⟩
      obtain ⟨hU, hW⟩ := m.2
      have h1 : m.1.1 = 1 := congrArg Prod.fst hm
      have h2 : m.1.2 = 1 := congrArg Prod.snd hm
      exact ⟨h1 ▸ hU, h2 ▸ hW⟩
    · intro h
      exact ⟨⟨_, h⟩, rfl⟩
  · -- `(1,1)` の軌道は `{(1,1)}`
    intro m hm
    rw [show m.1.1 = 1 from congrArg Prod.fst hm, show m.1.2 = 1 from congrArg Prod.snd hm]
    exact modeInversionOrbit_one_one_from_necSuf

theorem orbitRepresentative_eq_one_one_iff_from_necSuf {L : ℕ} [NeZero L] {s : SpinStructure}
    {O : Finset (Qbar × Qbar)} (hO : O ∈ modeInversionOrbits L s) :
    orbitRepresentative O = ((1 : Qbar), (1 : Qbar)) ↔ O = {((1 : Qbar), (1 : Qbar))} := by
  obtain ⟨m, rfl⟩ := mem_modeInversionOrbits hO
  refine Ising2DLambda.NecSuf.KacWard.rep_eq_iff_necSuf _ orbitRepresentative _
    (orbitRepresentative_mem ⟨_, mem_modeInversionOrbit_self m.1.1 m.1.2⟩) ?_
  intro h
  obtain ⟨h1, h2⟩ := eq_one_one_of_one_one_mem_modeInversionOrbit_from_necSuf h
  rw [h1, h2, modeInversionOrbit_one_one_from_necSuf]

theorem oneElementOrbits_filter_one_one_from_necSuf (L : ℕ) [NeZero L] (s : SpinStructure) :
    ((modeInversionOrbits L s).filter (fun O => O.card = 1)).filter
        (fun O => orbitRepresentative O = ((1 : Qbar), (1 : Qbar))) =
      if s = (false, false) then {{((1 : Qbar), (1 : Qbar))}} else ∅ := by
  refine Ising2DLambda.NecSuf.KacWard.one_element_filter_rep_necSuf (modeInversionOrbits L s)
    orbitRepresentative ((1 : Qbar), (1 : Qbar)) (s = (false, false)) ?_ ?_
    (singleton_one_one_mem_modeInversionOrbits_iff_from_necSuf L s)
  · intro O hO
    obtain ⟨m, rfl⟩ := mem_modeInversionOrbits hO
    exact orbitRepresentative_mem ⟨_, mem_modeInversionOrbit_self m.1.1 m.1.2⟩
  · intro O hO h
    obtain ⟨m, rfl⟩ := mem_modeInversionOrbits hO
    obtain ⟨h1, h2⟩ := eq_one_one_of_one_one_mem_modeInversionOrbit_from_necSuf h
    rw [h1, h2, modeInversionOrbit_one_one_from_necSuf]

end Ising2DLambda.KacWard
