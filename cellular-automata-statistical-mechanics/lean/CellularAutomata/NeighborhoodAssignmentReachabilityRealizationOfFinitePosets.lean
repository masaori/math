/-
章「有限半順序の相互到達成分商としての実現」の Lean 具体版。
人手証明の正本は
structured-latex/content/neighborhood-assignment-reachability-realization-of-finite-posets.ts。

対応表（人手証明 → この file）
  def_partial_order（この章で使う形）
    `IsPartialOrderOnUniv`
  def_partial_order_neighborhood_assignment
    `assignmentOfRelation`, `mem_assignmentOfRelation`
  claim_partial_order_neighborhood_assignment_reflexive
    `assignmentOfRelation_self_mem`
  claim_partial_order_neighborhood_assignment_transitive
    `assignmentOfRelation_isTransitive`
  claim_partial_order_neighborhood_assignment_closure_eq
    `assignmentOfRelation_closure_eq`
  claim_partial_order_neighborhood_assignment_preorder_eq
    `reaches_assignmentOfRelation_iff`
  claim_partial_order_neighborhood_assignment_component_singleton
    `mutualComponent_assignmentOfRelation`
  claim_partial_order_neighborhood_assignment_quotient_singletons
    `componentSet_assignmentOfRelation`
  def_partial_order_quotient_realization_map
    `realizationMap`, `realizationMap_mem_componentSet`
  claim_partial_order_quotient_realization_map_bijective
    `realizationMap_injective`, `realizationMap_surjective_onto_componentSet`
  claim_partial_order_quotient_realization_order
    `componentReaches_realizationMap_iff`
  claim_partial_order_quotient_realization_finite_decidable
    `instDecidableMemAssignmentOfRelation`, `relationScan`, `card_relationScan`,
    `singletonScan`, `card_singletonScan`

人手証明どおり、商は既に定義済みの成分割り当ての像 `componentSet` として取り、
`V` と `𝒬(N_R)` の行き来は実現写像 `realizationMap` 一本だけを通す。同一視をしない。

比較回数のコストモデル自体は前章までと同じく形式化していない。形式化しているのは、
関係への所属が決定可能であること（`instDecidableMemAssignmentOfRelation`）と、
人手証明が数える所属判定の組の総数が `|V|²`（`card_relationScan`）、
書き出す一元集合の個数が `|V|`（`card_singletonScan`）であることである。

住処: 有限型、有限部分集合、有限写像、自然数だけ。ℝ / ℂ は現れない。
-/
import CellularAutomata.NeighborhoodAssignmentReachabilityQuotientOrder

namespace CellularAutomata.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets

open CellularAutomata.FiniteNeighborhoodAssignmentMonoid
open CellularAutomata.NeighborhoodAssignmentCompositionIdempotents
open CellularAutomata.NeighborhoodAssignmentReachabilityClosure
open CellularAutomata.NeighborhoodAssignmentReachabilityPreorder
open CellularAutomata.NeighborhoodAssignmentReachabilityQuotientOrder
open CellularAutomata.OrderedNeighborhoodAssignmentMonoid

variable {V : Type} [Fintype V] [DecidableEq V]

/-- `def_partial_order` を、この章で使う「舞台の全体 `V` 上の部分順序」の形で書いたもの。
    反射性・反対称性・推移性の 3 条件の連言であり、前章までの `IsPartialOrderOn` と同じ 3 条件を
    `X = V` の場合に述べている。 -/
def IsPartialOrderOnUniv (R : V → V → Prop) : Prop :=
  (∀ v : V, R v v) ∧
    (∀ v w : V, R v w → R w v → v = w) ∧
    (∀ v u w : V, R v u → R u w → R v w)

/-- `def_partial_order_neighborhood_assignment` の近傍割り当て
    `N_R(v) = { w ∈ V | (v,w) ∈ R }`。 -/
def assignmentOfRelation (R : V → V → Prop) [DecidableRel R] :
    NeighborhoodAssignment V :=
  fun v => Finset.univ.filter (fun w => R v w)

/-- 近傍への所属は関係への所属そのものである。 -/
@[simp] theorem mem_assignmentOfRelation (R : V → V → Prop) [DecidableRel R] (v w : V) :
    w ∈ assignmentOfRelation R v ↔ R v w := by
  simp [assignmentOfRelation]

/-- `claim_partial_order_neighborhood_assignment_reflexive`。
    人手証明どおり、部分順序の反射性から近傍の定義へ一段で移る。 -/
theorem assignmentOfRelation_self_mem (R : V → V → Prop) [DecidableRel R]
    (hR : IsPartialOrderOnUniv R) (v : V) : v ∈ assignmentOfRelation R v := by
  have hRefl : R v v := hR.1 v
  exact (mem_assignmentOfRelation R v v).mpr hRefl

/-- `claim_partial_order_neighborhood_assignment_transitive`。
    人手証明どおり、近傍への所属を関係へ戻し、部分順序の推移性を使い、近傍へ戻す。 -/
theorem assignmentOfRelation_isTransitive (R : V → V → Prop) [DecidableRel R]
    (hR : IsPartialOrderOnUniv R) : IsTransitive (assignmentOfRelation R) := by
  intro v u w hu hw
  have hvu : R v u := (mem_assignmentOfRelation R v u).mp hu
  have huw : R u w := (mem_assignmentOfRelation R u w).mp hw
  have hvw : R v w := hR.2.2 v u w hvu huw
  exact (mem_assignmentOfRelation R v w).mpr hvw

/-- `claim_partial_order_neighborhood_assignment_closure_eq`。
    人手証明どおり、閉包の最小性で `N_R* ⊑ N_R`、閉包がもとを含むことで `N_R ⊑ N_R*`、
    点ごとの包含順序の反対称性で等号を得る。 -/
theorem assignmentOfRelation_closure_eq (R : V → V → Prop) [DecidableRel R]
    (hR : IsPartialOrderOnUniv R) :
    reachabilityClosure (assignmentOfRelation R) = assignmentOfRelation R := by
  have hSelfRefl : PointwiseInclusion (assignmentOfRelation R) (assignmentOfRelation R) :=
    pointwiseInclusion_refl (assignmentOfRelation R)
  have hMin : PointwiseInclusion (reachabilityClosure (assignmentOfRelation R))
      (assignmentOfRelation R) :=
    reachabilityClosure_minimal (assignmentOfRelation R) (assignmentOfRelation R)
      (assignmentOfRelation_self_mem R hR) (assignmentOfRelation_isTransitive R hR) hSelfRefl
  have hContains : PointwiseInclusion (assignmentOfRelation R)
      (reachabilityClosure (assignmentOfRelation R)) :=
    reachabilityClosure_contains_original (assignmentOfRelation R)
  exact pointwiseInclusion_antisymm hMin hContains

/-- `claim_partial_order_neighborhood_assignment_preorder_eq`。
    到達関係の定義、閉包の一致、近傍の定義を人手証明と同じ順で使う。 -/
theorem reaches_assignmentOfRelation_iff (R : V → V → Prop) [DecidableRel R]
    (hR : IsPartialOrderOnUniv R) (v w : V) :
    Reaches (assignmentOfRelation R) v w ↔ R v w := by
  calc Reaches (assignmentOfRelation R) v w
      ↔ w ∈ reachabilityClosure (assignmentOfRelation R) v :=
        reaches_iff_mem_closure (assignmentOfRelation R) v w
    _ ↔ w ∈ assignmentOfRelation R v := by rw [assignmentOfRelation_closure_eq R hR]
    _ ↔ R v w := mem_assignmentOfRelation R v w

/-- `claim_partial_order_neighborhood_assignment_component_singleton`。
    人手証明どおり、成分への所属を相互到達へ、相互到達を関係の両向きへ移し、
    部分順序の反対称性と反射性で一元集合の所属と同値にする。 -/
theorem mutualComponent_assignmentOfRelation (R : V → V → Prop) [DecidableRel R]
    (hR : IsPartialOrderOnUniv R) (v : V) :
    mutualComponent (assignmentOfRelation R) v = {v} := by
  ext w
  constructor
  · intro hw
    have hMutual : MutuallyReaches (assignmentOfRelation R) v w :=
      (mem_mutualComponent_iff (assignmentOfRelation R) v w).mp hw
    have hvw : R v w := (reaches_assignmentOfRelation_iff R hR v w).mp hMutual.1
    have hwv : R w v := (reaches_assignmentOfRelation_iff R hR w v).mp hMutual.2
    have hEq : v = w := hR.2.1 v w hvw hwv
    exact Finset.mem_singleton.mpr hEq.symm
  · intro hw
    have hEq : w = v := Finset.mem_singleton.mp hw
    subst hEq
    exact self_mem_mutualComponent (assignmentOfRelation R) w

/-- `claim_partial_order_neighborhood_assignment_quotient_singletons`。
    商は成分割り当ての像であり、その値が一元集合に置き換わる。 -/
theorem componentSet_assignmentOfRelation (R : V → V → Prop) [DecidableRel R]
    (hR : IsPartialOrderOnUniv R) :
    componentSet (assignmentOfRelation R)
      = Finset.image (fun v : V => ({v} : Finset V)) Finset.univ := by
  have hFun : mutualComponent (assignmentOfRelation R) = fun v : V => ({v} : Finset V) := by
    funext v
    exact mutualComponent_assignmentOfRelation R hR v
  rw [componentSet, hFun]

/-- `def_partial_order_quotient_realization_map` の実現写像 `η_R(v) = {v}`。
    `V` と商の行き来はこの一本だけを通す。 -/
def realizationMap (v : V) : Finset V := {v}

/-- 実現写像の値が商に入ることは、商の一元集合表示による。 -/
theorem realizationMap_mem_componentSet (R : V → V → Prop) [DecidableRel R]
    (hR : IsPartialOrderOnUniv R) (v : V) :
    realizationMap v ∈ componentSet (assignmentOfRelation R) := by
  rw [componentSet_assignmentOfRelation R hR]
  exact Finset.mem_image_of_mem _ (Finset.mem_univ v)

/-- `claim_partial_order_quotient_realization_map_bijective` の単射性。
    人手証明どおり `v ∈ {v} = {w}` から `v = w` を得る。 -/
theorem realizationMap_injective :
    Function.Injective (realizationMap (V := V)) := by
  intro v w hvw
  have hv : v ∈ realizationMap v := by
    show v ∈ ({v} : Finset V)
    exact Finset.mem_singleton_self v
  rw [hvw] at hv
  have hMem : v ∈ ({w} : Finset V) := hv
  exact Finset.mem_singleton.mp hMem

/-- `claim_partial_order_quotient_realization_map_bijective` の全射性。
    人手証明どおり、商の元を一元集合表示から取り出す。 -/
theorem realizationMap_surjective_onto_componentSet (R : V → V → Prop) [DecidableRel R]
    (hR : IsPartialOrderOnUniv R) {Q : Finset V}
    (hQ : Q ∈ componentSet (assignmentOfRelation R)) :
    ∃ v : V, realizationMap v = Q := by
  rw [componentSet_assignmentOfRelation R hR] at hQ
  obtain ⟨v, _, hv⟩ := Finset.mem_image.mp hQ
  exact ⟨v, hv⟩

/-- `claim_partial_order_quotient_realization_order`。
    実現写像の定義、商の到達関係の定義、一元集合の所属、到達関係と関係の一致を
    人手証明と同じ順で使う。 -/
theorem componentReaches_realizationMap_iff (R : V → V → Prop) [DecidableRel R]
    (hR : IsPartialOrderOnUniv R) (v w : V) :
    ComponentReaches (assignmentOfRelation R) (realizationMap v) (realizationMap w)
      ↔ R v w := by
  constructor
  · rintro ⟨a, ha, b, hb, hab⟩
    have hav : a = v := Finset.mem_singleton.mp ha
    have hbw : b = w := Finset.mem_singleton.mp hb
    subst hav
    subst hbw
    exact (reaches_assignmentOfRelation_iff R hR a b).mp hab
  · intro hvw
    refine ⟨v, Finset.mem_singleton_self v, w, Finset.mem_singleton_self w, ?_⟩
    exact (reaches_assignmentOfRelation_iff R hR v w).mpr hvw

/-- 関係への所属は有限手続きで決まる（近傍割り当ての構成に使う判定）。 -/
instance instDecidableMemAssignmentOfRelation (R : V → V → Prop) [DecidableRel R] (v w : V) :
    Decidable (w ∈ assignmentOfRelation R v) := by
  unfold assignmentOfRelation
  infer_instance

/-- `claim_partial_order_quotient_realization_finite_decidable` の前半で数える組。
    `N_R` を作るために所属を判定する組 `(v,w)` の全体である。 -/
def relationScan : Finset (V × V) := Finset.univ

omit [DecidableEq V] in
/-- 所属判定の組の総数は `|V|²` である。 -/
theorem card_relationScan :
    (relationScan (V := V)).card = Fintype.card V ^ 2 := by
  rw [relationScan]
  simp [Finset.card_univ, pow_two]

/-- `claim_partial_order_quotient_realization_finite_decidable` の後半で数える対象。
    商と実現写像を作るために書き出す一元集合の添字の全体である。 -/
def singletonScan : Finset V := Finset.univ

omit [DecidableEq V] in
/-- 書き出す一元集合の個数は `|V|` である。 -/
theorem card_singletonScan :
    (singletonScan (V := V)).card = Fintype.card V := by
  rw [singletonScan]
  simp [Finset.card_univ]

end CellularAutomata.NeighborhoodAssignmentReachabilityRealizationOfFinitePosets
