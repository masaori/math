/-
章「相互到達成分の商が定める有限半順序」の Lean 具体版。
人手証明の正本は
structured-latex/content/neighborhood-assignment-reachability-quotient-order.ts。

対応表（人手証明 → この file）
  def_neighborhood_mutual_reachability_component_set
    `componentSet`, `mem_componentSet_iff`
  claim_neighborhood_mutual_reachability_component_nonempty
    `componentSet_nonempty`
  claim_neighborhood_mutual_reachability_component_representative
    `componentSet_eq_mutualComponent_of_mem`
  def_neighborhood_mutual_reachability_component_order
    `ComponentReaches`
  claim_neighborhood_mutual_reachability_component_order_representative_independent
    `componentReaches_iff_forall`
  claim_neighborhood_mutual_reachability_component_order_reflexive
    `componentReaches_refl`
  claim_neighborhood_mutual_reachability_component_order_transitive
    `componentReaches_trans`
  claim_neighborhood_mutual_reachability_component_order_antisymmetric
    `componentReaches_antisymm`
  claim_neighborhood_mutual_reachability_component_order_is_partial_order
    `componentSet_finite`, `componentReaches_isPartialOrder`
  claim_neighborhood_mutual_reachability_component_order_finite_decidable
    `instDecidableComponentReaches`, `card_componentSet_le`,
    `quotientScan`, `card_quotientScan`

人手証明どおり、商は同値類の抽象的な構成ではなく、既に定義済みの成分割り当て
`mutualComponent` の像として有限集合のまま取る。同一視をせず、代表の回復
（`componentSet_eq_mutualComponent_of_mem`）を定理として明示する。

比較回数のコストモデル自体は前章までと同じく形式化していない。形式化しているのは、
商の上の到達関係の成否が決定可能であること（`instDecidableComponentReaches`）、
成分の個数が舞台の元数以下であること（`card_componentSet_le`）、そして人手証明が
数える走査の組の総数が `(|V|²+1)·|V|³ + 4|V|²` であること（`card_quotientScan`）である。

住処: 有限型、有限部分集合、有限写像、自然数だけ。ℝ / ℂ は現れない。
-/
import CellularAutomata.NeighborhoodAssignmentReachabilityPreorder

namespace CellularAutomata.NeighborhoodAssignmentReachabilityQuotientOrder

open CellularAutomata.FiniteNeighborhoodAssignmentMonoid
open CellularAutomata.NeighborhoodAssignmentReachabilityPreorder

variable {V : Type} [Fintype V] [DecidableEq V]

/-- `def_neighborhood_mutual_reachability_component_set` の相互到達成分の全体
    `𝒬(N) = { C_N(v) | v ∈ V }`。写像 `v ↦ C_N(v)` の像として取る。 -/
def componentSet (N : NeighborhoodAssignment V) : Finset (Finset V) :=
  Finset.image (mutualComponent N) Finset.univ

/-- 商の元であることは、ある元の相互到達成分に等しいことである。 -/
theorem mem_componentSet_iff (N : NeighborhoodAssignment V) (Q : Finset V) :
    Q ∈ componentSet N ↔ ∃ u : V, mutualComponent N u = Q := by
  simp [componentSet]

/-- `claim_neighborhood_mutual_reachability_component_nonempty`。
    人手証明どおり、代表 `u` を取り、被覆 `u ∈ C_N(u)` を使う。 -/
theorem componentSet_nonempty (N : NeighborhoodAssignment V) {Q : Finset V}
    (hQ : Q ∈ componentSet N) : Q.Nonempty := by
  obtain ⟨u, hu⟩ := (mem_componentSet_iff N Q).mp hQ
  refine ⟨u, ?_⟩
  rw [← hu]
  exact self_mem_mutualComponent N u

/-- `claim_neighborhood_mutual_reachability_component_representative`。
    人手証明どおり、`v ∈ C_N(u) ∩ C_N(v)` から分割の前半を適用する。 -/
theorem componentSet_eq_mutualComponent_of_mem (N : NeighborhoodAssignment V)
    {Q : Finset V} (hQ : Q ∈ componentSet N) {v : V} (hv : v ∈ Q) :
    Q = mutualComponent N v := by
  obtain ⟨u, hu⟩ := (mem_componentSet_iff N Q).mp hQ
  have hvu : v ∈ mutualComponent N u := by rw [hu]; exact hv
  have hvv : v ∈ mutualComponent N v := self_mem_mutualComponent N v
  have hInter : (mutualComponent N u ∩ mutualComponent N v).Nonempty :=
    ⟨v, Finset.mem_inter.mpr ⟨hvu, hvv⟩⟩
  have hEq : mutualComponent N u = mutualComponent N v :=
    mutualComponent_eq_of_inter_nonempty N hInter
  rw [← hu, hEq]

/-- `def_neighborhood_mutual_reachability_component_order` の商の上の到達関係
    `Q ⊑_N R :⟺ ∃ v ∈ Q, ∃ w ∈ R, v ⪯_N w`。 -/
def ComponentReaches (N : NeighborhoodAssignment V) (Q R : Finset V) : Prop :=
  ∃ v ∈ Q, ∃ w ∈ R, Reaches N v w

/-- `claim_neighborhood_mutual_reachability_component_order_representative_independent`。
    右向きは、任意の代表から存在する代表へ到達関係を二回の推移律で継ぐ。
    左向きは、成分が空でないことから代表を一組取る。 -/
theorem componentReaches_iff_forall (N : NeighborhoodAssignment V) {Q R : Finset V}
    (hQ : Q ∈ componentSet N) (hR : R ∈ componentSet N) :
    ComponentReaches N Q R ↔ ∀ v ∈ Q, ∀ w ∈ R, Reaches N v w := by
  constructor
  · rintro ⟨v₀, hv₀, w₀, hw₀, hv₀w₀⟩ v hv w hw
    have hQv : Q = mutualComponent N v :=
      componentSet_eq_mutualComponent_of_mem N hQ hv
    have hRw : R = mutualComponent N w :=
      componentSet_eq_mutualComponent_of_mem N hR hw
    have hv₀mem : v₀ ∈ mutualComponent N v := by rw [← hQv]; exact hv₀
    have hw₀mem : w₀ ∈ mutualComponent N w := by rw [← hRw]; exact hw₀
    have hvv₀ : Reaches N v v₀ := ((mem_mutualComponent_iff N v v₀).mp hv₀mem).1
    have hw₀w : Reaches N w₀ w := ((mem_mutualComponent_iff N w w₀).mp hw₀mem).2
    exact reaches_trans N (reaches_trans N hvv₀ hv₀w₀) hw₀w
  · intro hAll
    obtain ⟨v, hv⟩ := componentSet_nonempty N hQ
    obtain ⟨w, hw⟩ := componentSet_nonempty N hR
    exact ⟨v, hv, w, hw, hAll v hv w hw⟩

/-- `claim_neighborhood_mutual_reachability_component_order_reflexive`。
    成分が空でないことと到達関係の反射性だけを使う。 -/
theorem componentReaches_refl (N : NeighborhoodAssignment V) {Q : Finset V}
    (hQ : Q ∈ componentSet N) : ComponentReaches N Q Q := by
  obtain ⟨v, hv⟩ := componentSet_nonempty N hQ
  exact ⟨v, hv, v, hv, reaches_refl N v⟩

/-- `claim_neighborhood_mutual_reachability_component_order_transitive`。
    三つの成分から代表を一つずつ取り、代表非依存性で到達を取り出して推移律を使う。 -/
theorem componentReaches_trans (N : NeighborhoodAssignment V) {Q R S : Finset V}
    (hQ : Q ∈ componentSet N) (hR : R ∈ componentSet N) (hS : S ∈ componentSet N)
    (hQR : ComponentReaches N Q R) (hRS : ComponentReaches N R S) :
    ComponentReaches N Q S := by
  obtain ⟨v, hv⟩ := componentSet_nonempty N hQ
  obtain ⟨u, hu⟩ := componentSet_nonempty N hR
  obtain ⟨w, hw⟩ := componentSet_nonempty N hS
  have hvu : Reaches N v u := (componentReaches_iff_forall N hQ hR).mp hQR v hv u hu
  have huw : Reaches N u w := (componentReaches_iff_forall N hR hS).mp hRS u hu w hw
  exact ⟨v, hv, w, hw, reaches_trans N hvu huw⟩

/-- `claim_neighborhood_mutual_reachability_component_order_antisymmetric` の片側包含。
    人手証明の「`v` を固定し任意の `w ∈ R` を取る」段に対応する。 -/
theorem componentReaches_subset (N : NeighborhoodAssignment V) {Q R : Finset V}
    (hQ : Q ∈ componentSet N) (hR : R ∈ componentSet N)
    (hQR : ComponentReaches N Q R) (hRQ : ComponentReaches N R Q) : R ⊆ Q := by
  obtain ⟨v, hv⟩ := componentSet_nonempty N hQ
  intro w hw
  have hvw : Reaches N v w := (componentReaches_iff_forall N hQ hR).mp hQR v hv w hw
  have hwv : Reaches N w v := (componentReaches_iff_forall N hR hQ).mp hRQ w hw v hv
  have hMem : w ∈ mutualComponent N v := (mem_mutualComponent_iff N v w).mpr ⟨hvw, hwv⟩
  have hQv : Q = mutualComponent N v :=
    componentSet_eq_mutualComponent_of_mem N hQ hv
  rw [hQv]
  exact hMem

/-- `claim_neighborhood_mutual_reachability_component_order_antisymmetric`。
    人手証明どおり、`Q` と `R` を入れ替えて同じ論証を繰り返す。 -/
theorem componentReaches_antisymm (N : NeighborhoodAssignment V) {Q R : Finset V}
    (hQ : Q ∈ componentSet N) (hR : R ∈ componentSet N)
    (hQR : ComponentReaches N Q R) (hRQ : ComponentReaches N R Q) : Q = R :=
  Finset.Subset.antisymm
    (componentReaches_subset N hR hQ hRQ hQR)
    (componentReaches_subset N hQ hR hQR hRQ)

/-- `claim_neighborhood_mutual_reachability_component_order_is_partial_order` の
    「`𝒬(N)` が有限集合である」の部分。像は `Finset` として取っている。 -/
theorem componentSet_finite (N : NeighborhoodAssignment V) :
    (componentSet N : Set (Finset V)).Finite := (componentSet N).finite_toSet

/-- `claim_neighborhood_mutual_reachability_component_order_is_partial_order`。
    反射性・推移性・反対称性を人手証明と同じ順に並べる。 -/
theorem componentReaches_isPartialOrder (N : NeighborhoodAssignment V) :
    (∀ Q ∈ componentSet N, ComponentReaches N Q Q) ∧
    (∀ Q ∈ componentSet N, ∀ R ∈ componentSet N, ∀ S ∈ componentSet N,
      ComponentReaches N Q R → ComponentReaches N R S → ComponentReaches N Q S) ∧
    (∀ Q ∈ componentSet N, ∀ R ∈ componentSet N,
      ComponentReaches N Q R → ComponentReaches N R Q → Q = R) :=
  ⟨fun _ hQ => componentReaches_refl N hQ,
   fun _ hQ _ hR _ hS hQR hRS => componentReaches_trans N hQ hR hS hQR hRS,
   fun _ hQ _ hR hQR hRQ => componentReaches_antisymm N hQ hR hQR hRQ⟩

/-- 商の上の到達関係の成否は有限手続きで決まる。 -/
instance instDecidableComponentReaches (N : NeighborhoodAssignment V) (Q R : Finset V) :
    Decidable (ComponentReaches N Q R) := by
  unfold ComponentReaches
  infer_instance

/-- `claim_neighborhood_mutual_reachability_component_order_finite_decidable` の
    `|𝒬(N)| ≤ |V|`。像は `|V|` 個の値からなる。 -/
theorem card_componentSet_le (N : NeighborhoodAssignment V) :
    (componentSet N).card ≤ Fintype.card V := by
  calc (componentSet N).card
      ≤ (Finset.univ : Finset V).card := Finset.card_image_le
    _ = Fintype.card V := Finset.card_univ

/-- 人手証明が数える走査の組。前章の走査に、商の関係表を代表一組で書き下すための
    `|V|²` 回以下の所属判定を継ぎ足す（成分の組は `|𝒬(N)|² ≤ |V|²` 個である）。 -/
def quotientScan :
    Finset (((ℕ × V × V × V) ⊕ ((V × V) ⊕ (Bool × V × V))) ⊕ (V × V)) :=
  (preorderScan (V := V)).disjSum Finset.univ

omit [DecidableEq V] in
/-- 走査する組の総数は `(|V|²+1)·|V|³ + 4|V|²` である。 -/
theorem card_quotientScan :
    (quotientScan (V := V)).card
      = (Fintype.card V ^ 2 + 1) * Fintype.card V ^ 3 + 4 * Fintype.card V ^ 2 := by
  rw [quotientScan, Finset.card_disjSum, card_preorderScan]
  simp [Finset.card_univ, pow_two]
  ring

end CellularAutomata.NeighborhoodAssignmentReachabilityQuotientOrder
