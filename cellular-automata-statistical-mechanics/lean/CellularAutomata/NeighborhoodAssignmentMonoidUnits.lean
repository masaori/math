/-
章「有限近傍割り当てモノイドの可逆元」の Lean 具体版。
人手証明の正本は
structured-latex/content/neighborhood-assignment-monoid-units.ts。

可逆性から各近傍が一元集合であること、置換との対応、逆向き、逆元の
一意性、個数と有限決定を、人手証明と同じ対象・仮定・順序で形式化する。
有限集合・有限部分集合・自然数だけを使い、R / C は現れない。
-/
import CellularAutomata.FiniteNeighborhoodAssignmentMonoid

namespace CellularAutomata.NeighborhoodAssignmentMonoidUnits

open CellularAutomata.ComposedNeighborhoodClosure
open CellularAutomata.FiniteNeighborhoodAssignmentMonoid

variable {V : Type} [Fintype V] [DecidableEq V]

/-- `def_invertible_neighborhood_assignment`。 -/
def IsInvertible (N : NeighborhoodAssignment V) : Prop :=
  ∃ M : NeighborhoodAssignment V,
    composedNeighborhood N M = identityNeighborhood V ∧
    composedNeighborhood M N = identityNeighborhood V

/-- `def_permutation_neighborhood_assignment` の P_sigma。 -/
def permutationNeighborhood (σ : Equiv.Perm V) : NeighborhoodAssignment V :=
  fun v => {σ v}

/-- 人手証明の前半。左右逆元を持つ N の各値は一元集合である。 -/
theorem value_is_singleton_of_inverse {N M : NeighborhoodAssignment V}
    (hNM : composedNeighborhood N M = identityNeighborhood V)
    (hMN : composedNeighborhood M N = identityNeighborhood V) (v : V) :
    ∃! u : V, u ∈ N v := by
  have hcompNM : composedNeighborhood N M v = {v} := by
    simpa [identityNeighborhood] using congrFun hNM v
  have hNv : (N v).Nonempty := by
    by_contra h
    have hempty : N v = ∅ := Finset.not_nonempty_iff_eq_empty.mp h
    simp [composedNeighborhood, hempty] at hcompNM
  obtain ⟨u, huN⟩ := hNv
  have hMu_sub : M u ⊆ {v} := by
    intro w hw
    have : w ∈ composedNeighborhood N M v :=
      Finset.mem_biUnion.mpr ⟨u, huN, hw⟩
    simpa [hcompNM] using this
  have hcompMN : composedNeighborhood M N u = {u} := by
    simpa [identityNeighborhood] using congrFun hMN u
  have hMu : (M u).Nonempty := by
    by_contra h
    have hempty : M u = ∅ := Finset.not_nonempty_iff_eq_empty.mp h
    simp [composedNeighborhood, hempty] at hcompMN
  have hMu_eq : M u = {v} := by
    exact Finset.Subset.antisymm hMu_sub (by
      intro w hw
      have hwv : w = v := Finset.mem_singleton.mp hw
      have hm := hMu.choose_spec
      have hmv : hMu.choose = v := Finset.mem_singleton.mp (hMu_sub hm)
      have hv : v ∈ M u := by simpa [hmv] using hm
      simpa [hwv] using hv)
  have hNv_eq : N v = {u} := by
    have hexpand : composedNeighborhood M N u = N v := by
      simp [composedNeighborhood, hMu_eq]
    exact hexpand.symm.trans hcompMN
  refine ⟨u, huN, ?_⟩
  intro w hw
  simpa [hNv_eq] using hw

/-- 可逆な N の一元値から得る自己写像。 -/
noncomputable def permutationFunctionOfInverse {N M : NeighborhoodAssignment V}
    (hNM : composedNeighborhood N M = identityNeighborhood V)
    (hMN : composedNeighborhood M N = identityNeighborhood V) : V → V :=
  fun v => (value_is_singleton_of_inverse hNM hMN v).choose

theorem value_eq_permutationFunction_singleton {N M : NeighborhoodAssignment V}
    (hNM : composedNeighborhood N M = identityNeighborhood V)
    (hMN : composedNeighborhood M N = identityNeighborhood V) (v : V) :
    N v = {permutationFunctionOfInverse hNM hMN v} := by
  ext u
  constructor
  · intro hu
    obtain ⟨w, hw, hunique⟩ := value_is_singleton_of_inverse hNM hMN v
    have huw : u = w := hunique u hu
    have hchoose : permutationFunctionOfInverse hNM hMN v = w := by
      apply hunique
      exact (value_is_singleton_of_inverse hNM hMN v).choose_spec.1
    simpa [huw, hchoose]
  · intro hu
    have huv : u = permutationFunctionOfInverse hNM hMN v := Finset.mem_singleton.mp hu
    subst huv
    exact (value_is_singleton_of_inverse hNM hMN v).choose_spec.1

theorem permutationFunction_injective {N M : NeighborhoodAssignment V}
    (hNM : composedNeighborhood N M = identityNeighborhood V)
    (hMN : composedNeighborhood M N = identityNeighborhood V) :
    Function.Injective (permutationFunctionOfInverse hNM hMN) := by
  intro v v' hv
  have hMv : M (permutationFunctionOfInverse hNM hMN v) = {v} := by
    calc
      M (permutationFunctionOfInverse hNM hMN v) = composedNeighborhood N M v := by
        symm
        simp [composedNeighborhood, value_eq_permutationFunction_singleton hNM hMN]
      _ = {v} := by simpa [identityNeighborhood] using congrFun hNM v
  have hMv' : M (permutationFunctionOfInverse hNM hMN v') = {v'} := by
    calc
      M (permutationFunctionOfInverse hNM hMN v') = composedNeighborhood N M v' := by
        symm
        simp [composedNeighborhood, value_eq_permutationFunction_singleton hNM hMN]
      _ = {v'} := by simpa [identityNeighborhood] using congrFun hNM v'
  rw [hv, hMv'] at hMv
  exact Finset.singleton_injective hMv.symm

/-- 人手証明の全射性の段。N と M の役割を交換して得る一元値を右逆像に取る。 -/
theorem permutationFunction_surjective_by_role_swap {N M : NeighborhoodAssignment V}
    (hNM : composedNeighborhood N M = identityNeighborhood V)
    (hMN : composedNeighborhood M N = identityNeighborhood V) :
    Function.Surjective (permutationFunctionOfInverse hNM hMN) := by
  intro u
  let τ := permutationFunctionOfInverse hMN hNM
  refine ⟨τ u, ?_⟩
  have hNτ : N (τ u) = {u} := by
    calc
      N (τ u) = composedNeighborhood M N u := by
        symm
        simp [composedNeighborhood, τ, value_eq_permutationFunction_singleton hMN hNM]
      _ = {u} := by simpa [identityNeighborhood] using congrFun hMN u
  have hNσ :
      N (τ u) = {permutationFunctionOfInverse hNM hMN (τ u)} :=
    value_eq_permutationFunction_singleton hNM hMN (τ u)
  exact Finset.singleton_injective (hNσ.symm.trans hNτ)

/-- 人手証明で構成した置換。 -/
noncomputable def permutationOfInverse {N M : NeighborhoodAssignment V}
    (hNM : composedNeighborhood N M = identityNeighborhood V)
    (hMN : composedNeighborhood M N = identityNeighborhood V) : Equiv.Perm V :=
  Equiv.ofBijective (permutationFunctionOfInverse hNM hMN)
    ⟨permutationFunction_injective hNM hMN,
      permutationFunction_surjective_by_role_swap hNM hMN⟩

theorem neighborhood_eq_permutationNeighborhood_of_inverse {N M : NeighborhoodAssignment V}
    (hNM : composedNeighborhood N M = identityNeighborhood V)
    (hMN : composedNeighborhood M N = identityNeighborhood V) :
    N = permutationNeighborhood (permutationOfInverse hNM hMN) := by
  funext v
  rw [value_eq_permutationFunction_singleton hNM hMN]
  rfl

/-- 人手証明の逆向き。置換が定める一元近傍割り当ては逆置換を逆元に持つ。 -/
theorem permutationNeighborhood_inverse_laws (σ : Equiv.Perm V) :
    composedNeighborhood (permutationNeighborhood σ) (permutationNeighborhood σ⁻¹) =
        identityNeighborhood V ∧
      composedNeighborhood (permutationNeighborhood σ⁻¹) (permutationNeighborhood σ) =
        identityNeighborhood V := by
  constructor <;> funext v <;>
    simp [composedNeighborhood, permutationNeighborhood, identityNeighborhood]

/-- `claim_invertible_neighborhood_assignments_are_permutations`。 -/
theorem isInvertible_iff_exists_permutation (N : NeighborhoodAssignment V) :
    IsInvertible N ↔ ∃! σ : Equiv.Perm V, N = permutationNeighborhood σ := by
  constructor
  · rintro ⟨M, hNM, hMN⟩
    let σ := permutationOfInverse hNM hMN
    refine ⟨σ, neighborhood_eq_permutationNeighborhood_of_inverse hNM hMN, ?_⟩
    intro τ hNτ
    apply Equiv.ext
    intro v
    have hσ := congrFun (neighborhood_eq_permutationNeighborhood_of_inverse hNM hMN) v
    have hτ := congrFun hNτ v
    simp [permutationNeighborhood] at hσ hτ
    exact (Finset.singleton_injective (hσ.symm.trans hτ)).symm
  · rintro ⟨σ, hN, -⟩
    subst N
    exact ⟨permutationNeighborhood σ⁻¹, permutationNeighborhood_inverse_laws σ⟩

/-- `claim_invertible_neighborhood_assignment_inverse_unique`。 -/
theorem inverse_unique {N M M' : NeighborhoodAssignment V}
    (hM : composedNeighborhood N M = identityNeighborhood V ∧
      composedNeighborhood M N = identityNeighborhood V)
    (hM' : composedNeighborhood N M' = identityNeighborhood V ∧
      composedNeighborhood M' N = identityNeighborhood V) : M = M' := by
  calc
    M = composedNeighborhood M (identityNeighborhood V) := (composedNeighborhood_identity M).symm
    _ = composedNeighborhood M (composedNeighborhood N M') := by rw [hM'.1]
    _ = composedNeighborhood (composedNeighborhood M N) M' :=
      (composedNeighborhood_assoc M N M').symm
    _ = composedNeighborhood (identityNeighborhood V) M' := by rw [hM.2]
    _ = M' := identity_composedNeighborhood M'

/-- 可逆元を置換から重複なく列挙する有限表。 -/
noncomputable def unitTable : Finset (NeighborhoodAssignment V) := by
  classical
  exact Finset.univ.image permutationNeighborhood

theorem mem_unitTable_iff (N : NeighborhoodAssignment V) :
    N ∈ unitTable ↔ IsInvertible N := by
  classical
  rw [unitTable, Finset.mem_image]
  constructor
  · rintro ⟨σ, -, rfl⟩
    exact ⟨permutationNeighborhood σ⁻¹, permutationNeighborhood_inverse_laws σ⟩
  · intro hN
    obtain ⟨σ, hσ, -⟩ := (isInvertible_iff_exists_permutation N).mp hN
    exact ⟨σ, Finset.mem_univ _, hσ.symm⟩

theorem permutationNeighborhood_injective :
    Function.Injective (permutationNeighborhood : Equiv.Perm V → NeighborhoodAssignment V) := by
  intro σ τ h
  apply Equiv.ext
  intro v
  have hv := congrFun h v
  simpa [permutationNeighborhood] using Finset.singleton_injective hv

/-- `claim_invertible_neighborhood_assignment_cardinality_decidable` の個数公式。 -/
theorem card_unitTable : (unitTable (V := V)).card = (Fintype.card V).factorial := by
  classical
  rw [unitTable,
    Finset.card_image_of_injective _ (permutationNeighborhood_injective (V := V)),
    Finset.card_univ, Fintype.card_perm]

end CellularAutomata.NeighborhoodAssignmentMonoidUnits
