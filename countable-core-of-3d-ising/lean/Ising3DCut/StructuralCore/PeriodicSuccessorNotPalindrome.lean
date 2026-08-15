/-
人手証明の主張「奇数軌道では多重度は回文でない」
（ラベル `claim_periodic_successor_not_palindrome`）の具体版。

有限周期後続系、辺、破れ数、多重度を人手証明と同じ順で定義し、定数配位による
下端の非空性、奇数軌道の有限積による全辺破れ配位の不存在、端点多重度の不一致を示す。

住処: 有限型、`Nat`、整数 ±1、有限積のみ。ℝ / ℂ は現れない。
-/
import Ising3DCut.NecSuf.NullModel.OddPeriodicCycle
import Ising3DCut.NullModel.PeriodicConstantUnbroken

namespace Ising3DCut.StructuralCore

open Ising3DCut.NullModel

noncomputable section

/-- 人手証明の「軌道長が一定の有限周期後続系」。`orbit_succ` は
`v_{k+1}=s_i(v_k)` を名前付きで保持する。 -/
structure PeriodicSuccessorSystem (V I : Type) [Fintype V] [Fintype I]
    (L : ℕ) where
  succ : I → V → V
  succ_bijective : ∀ i, Function.Bijective (succ i)
  orbit : I → V → Fin L → V
  orbit_zero : ∀ i a (hpos : 0 < L), orbit i a ⟨0, hpos⟩ = a
  orbit_injective : ∀ i a, Function.Injective (orbit i a)
  orbit_succ : ∀ i a k, orbit i a (finRotate L k) = succ i (orbit i a k)

variable {V I : Type} [Fintype V] [Fintype I] [DecidableEq V] [DecidableEq I]
variable [Nonempty V] [Nonempty I] {L : ℕ} (S : PeriodicSuccessorSystem V I L)

/-- 有限周期後続系の辺 `E=V×I`。 -/
abbrev PeriodicStructuralEdge := V × I

/-- 有限周期後続系の配位。 -/
abbrev PeriodicStructuralConfig := V → Spin

/-- 破れている辺の有限集合。 -/
def periodicStructuralBrokenSet (σ : PeriodicStructuralConfig (V := V)) :
    Finset (PeriodicStructuralEdge (V := V) (I := I)) :=
  Finset.univ.filter fun e => σ e.1 ≠ σ (S.succ e.2 e.1)

/-- 破れ数。 -/
def periodicStructuralBrokenCount (σ : PeriodicStructuralConfig (V := V)) : ℕ :=
  (periodicStructuralBrokenSet S σ).card

/-- 破れ数が `m` の配位の多重度。 -/
def periodicStructuralMultiplicity (m : ℕ) : ℕ :=
  (Finset.univ.filter fun σ : PeriodicStructuralConfig (V := V) =>
    periodicStructuralBrokenCount S σ = m).card

/-- 定数配位により下端の多重度は正である。 -/
lemma one_le_periodicStructuralMultiplicity_zero :
    1 ≤ periodicStructuralMultiplicity S 0 := by
  let σ : PeriodicStructuralConfig (V := V) := fun _ => ⟨1, Or.inl rfl⟩
  rw [periodicStructuralMultiplicity, Finset.one_le_card]
  refine ⟨σ, Finset.mem_filter.mpr ⟨Finset.mem_univ _, ?_⟩⟩
  simp [periodicStructuralBrokenCount, periodicStructuralBrokenSet, σ]

/-- 奇数軌道では全辺を破る配位は存在しない。 -/
lemma no_config_all_periodicStructural_edges_broken (hodd : Odd L)
    (σ : PeriodicStructuralConfig (V := V)) :
    periodicStructuralBrokenCount S σ ≠ Fintype.card (PeriodicStructuralEdge (V := V) (I := I)) := by
  intro hall
  let i : I := Classical.choice inferInstance
  let a : V := Classical.choice inferInstance
  have hset : periodicStructuralBrokenSet S σ = Finset.univ := by
    apply (Finset.card_eq_iff_eq_univ (periodicStructuralBrokenSet S σ)).mp
    simpa [periodicStructuralBrokenCount] using hall
  apply Ising3DCut.NecSuf.NullModel.no_odd_cycle_all_opposite hodd
      (fun k => (σ (S.orbit i a k)).1)
  · intro k
    exact (σ (S.orbit i a k)).2
  · intro k hvalue
    have hedge : (S.orbit i a k, i) ∈ periodicStructuralBrokenSet S σ := by
      rw [hset]
      exact Finset.mem_univ _
    have hbroken := (Finset.mem_filter.mp hedge).2
    apply hbroken
    rw [← S.orbit_succ i a k]
    exact Subtype.ext hvalue

/-- 奇数軌道では上端の多重度は零である。 -/
lemma periodicStructuralMultiplicity_full_eq_zero (hodd : Odd L) :
    periodicStructuralMultiplicity S
      (Fintype.card (PeriodicStructuralEdge (V := V) (I := I))) = 0 := by
  rw [periodicStructuralMultiplicity, Finset.card_eq_zero, Finset.filter_eq_empty_iff]
  intro σ _
  exact no_config_all_periodicStructural_edges_broken S hodd σ

/-- `claim_periodic_successor_not_palindrome` の具体版。 -/
theorem periodicStructuralMultiplicity_not_palindrome (hodd : Odd L) :
    periodicStructuralMultiplicity S 0 ≠
      periodicStructuralMultiplicity S
        (Fintype.card (PeriodicStructuralEdge (V := V) (I := I)) - 0) := by
  rw [Nat.sub_zero]
  intro heq
  have h1 := one_le_periodicStructuralMultiplicity_zero S
  rw [heq, periodicStructuralMultiplicity_full_eq_zero S hodd] at h1
  exact Nat.not_succ_le_zero 0 h1

end

end Ising3DCut.StructuralCore
