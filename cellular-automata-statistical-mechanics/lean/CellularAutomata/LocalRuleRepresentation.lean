/-
章「依存台による局所規則の表現」の具体版。
人手証明の正本は structured-latex/content/local-rule-representation.ts。

有限集合 V、二元状態 State、有限部分集合 S、制限写像と基準値延長写像を人手証明と同じ対象として使う。
表現可能性、表現可能性と依存台包含の同値、依存台の最小性、単射な大域写像の逆写像を表す局所規則、
その最小近傍と走査組数をこの順で形式化する。有限集合と自然数だけを使い、ℝ / ℂ は現れない。
-/
import CellularAutomata.InverseMapLocality

namespace CellularAutomata.LocalRuleRepresentation

open CellularAutomata.EssentialDependency
open CellularAutomata.RedundantNeighbor
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.InverseMapLocality
open CellularAutomata.ReversibilityFiniteDecidability

variable {V : Type} [Fintype V] [DecidableEq V]

/-- `def_local_rule_representable`: g が S 上の局所規則 h の冗長拡大として書けること。 -/
def Representable (S : Finset V) (g : (V → State) → State) : Prop :=
  ∃ h : (↥S → State) → State, ∀ y, g y = h (restrict S y)

omit [Fintype V] in
/-- 一つの添字 w に本質的に依存しないなら、w の値だけを置換しても出力は変わらない。 -/
lemma eq_update_of_not_essential (g : (V → State) → State) (w : V)
    (hnot : ¬ EssentialDep g w) (y : V → State) (a : State) :
    g y = g (Function.update y w a) := by
  by_contra hne
  apply hnot
  refine ⟨y, Function.update y w a, ?_, hne⟩
  intro u hu
  simp [Function.update, hu]

/-- 人手証明の有限帰納法: R の外で一致し、R の各添字に依存しなければ出力は等しい。 -/
lemma eq_of_changes_on (g : (V → State) → State) (S R : Finset V)
    (hsub : supp g ⊆ S) (hR : ∀ w ∈ R, w ∉ S)
    (y y' : V → State) (hagrees : ∀ u, u ∉ R → y u = y' u) : g y = g y' := by
  induction R using Finset.induction_on generalizing y with
  | empty =>
      apply congrArg g
      funext u
      exact hagrees u (by simp)
  | @insert w R hw ih =>
      have hwS : w ∉ S := hR w (by simp)
      have hwNot : ¬ EssentialDep g w := by
        intro hdep
        exact hwS (hsub ((mem_supp_iff g w).mpr hdep))
      let z : V → State := Function.update y w (y' w)
      calc
        g y = g z := eq_update_of_not_essential g w hwNot y (y' w)
        _ = g y' := by
          apply ih
          · intro u huR
            exact hR u (by simp [huR])
          · intro u huR
            by_cases huw : u = w
            · subst u
              simp [z]
            · simpa [z, Function.update, huw] using hagrees u (by simp [huR, huw])

/-- `claim_representable_implies_support_subset`. -/
theorem representable_implies_supp_subset (S : Finset V) (g : (V → State) → State)
    (hrep : Representable S g) : supp g ⊆ S := by
  obtain ⟨h, hg⟩ := hrep
  have hfun : g = extendRule S h := by
    funext y
    exact hg y
  rw [hfun, supp_extendRule]
  intro w hw
  obtain ⟨u, -, rfl⟩ := Finset.mem_map.mp hw
  exact u.property

/-- `claim_support_subset_implies_representable`: 基準値延長で表す。 -/
theorem supp_subset_implies_representable (S : Finset V) (g : (V → State) → State)
    (hsub : supp g ⊆ S) :
    ∀ y, g y = (g ∘ baseExtend S) (restrict S y) := by
  intro y
  apply eq_of_changes_on g S (Finset.univ \ S) hsub
  · intro w hw
    exact (Finset.mem_sdiff.mp hw).2
  · intro u hu
    have huS : u ∈ S := by
      by_contra hnot
      exact hu (Finset.mem_sdiff.mpr ⟨Finset.mem_univ u, hnot⟩)
    change y u = (if h : u ∈ S then restrict S y ⟨u, h⟩ else State.zero)
    simp [huS, restrict]

/-- 表現可能性と依存台包含の同値、および依存台自身による表現。 -/
theorem representable_iff_supp_subset (S : Finset V) (g : (V → State) → State) :
    Representable S g ↔ supp g ⊆ S := by
  constructor
  · exact representable_implies_supp_subset S g
  · intro hsub
    exact ⟨g ∘ baseExtend S, supp_subset_implies_representable S g hsub⟩

theorem representable_on_supp (g : (V → State) → State) : Representable (supp g) g :=
  (representable_iff_supp_subset (supp g) g).mpr (Finset.Subset.rfl)

/-- `claim_support_is_minimum_representing_set`: 依存台は全ての表現添字集合に含まれる。 -/
theorem supp_is_minimum (g : (V → State) → State) (S : Finset V)
    (hrep : Representable S g) : supp g ⊆ S :=
  (representable_iff_supp_subset S g).mp hrep

variable (N : V → Finset V)
variable (f : (v : V) → (↥(N v) → State) → State)

/-- 近傍 N' 上で逆写像を表す局所規則の族。 -/
def inverseLocalRule (hinj : Injective N f) (N' : V → Finset V)
    (v : V) : (↥(N' v) → State) → State :=
  inverseCellMap N f hinj v ∘ baseExtend (N' v)

/-- `claim_inverse_map_is_ca_iff_support_subset` の具体版。 -/
theorem exists_inverse_ca_iff_support_subset (hinj : Injective N f)
    (N' : V → Finset V) :
    (∃ f' : (v : V) → (↥(N' v) → State) → State,
      globalMap N' f' = inverseMap N f hinj) ↔
      ∀ v, inverseSupp N f hinj v ⊆ N' v := by
  constructor
  · rintro ⟨f', hmap⟩ v
    apply representable_implies_supp_subset (N' v) (inverseCellMap N f hinj v)
    refine ⟨f' v, ?_⟩
    intro z
    change inverseMap N f hinj z v = f' v (restrict (N' v) z)
    exact congrFun (congrFun hmap z) v |>.symm
  · intro hsub
    refine ⟨inverseLocalRule N f hinj N', ?_⟩
    funext z v
    change (inverseCellMap N f hinj v ∘ baseExtend (N' v)) (restrict (N' v) z) =
      inverseMap N f hinj z v
    exact (supp_subset_implies_representable (N' v) (inverseCellMap N f hinj v) (hsub v) z).symm

/-- 最小近傍 N*(v) = supp((F⁻¹)_v) 上で逆写像が局所規則として表される。 -/
theorem inverse_ca_on_minimal_neighborhood (hinj : Injective N f) :
    ∃ f' : (v : V) → (↥(inverseSupp N f hinj v) → State) → State,
      globalMap (inverseSupp N f hinj) f' = inverseMap N f hinj :=
  (exists_inverse_ca_iff_support_subset N f hinj (inverseSupp N f hinj)).mpr
    (fun _ => Finset.Subset.rfl)

/-- 逆写像を表す任意の近傍は最小近傍 N* を含む。 -/
theorem inverseSupp_minimal (hinj : Injective N f) (N' : V → Finset V)
    (hrep : ∃ f' : (v : V) → (↥(N' v) → State) → State,
      globalMap N' f' = inverseMap N f hinj) :
    ∀ v, inverseSupp N f hinj v ⊆ N' v :=
  (exists_inverse_ca_iff_support_subset N f hinj N').mp hrep

/-- 最小近傍の各値を決める走査組数は |V|·2^{|V|}。比較コスト自体は形式化しない。 -/
theorem card_minimal_neighborhood_scan_pairs :
    Fintype.card (V × (V → State)) = Fintype.card V * 2 ^ Fintype.card V :=
  card_inverse_scan_pairs

end CellularAutomata.LocalRuleRepresentation
