/-
章「合成近傍による大域写像の合成表現」の必要十分版。

具体版（CellularAutomata.ComposedNeighborhoodClosure）と同じ順序で、合成近傍、
部分近傍の包含、二段制限、合成局所規則族、大域写像の合成の一致、および
合成近傍上で表せることを示す。

必要な構造の検査結果:
  - 舞台側に要るのは添字型 V の等号判定だけである。これは有限部分集合の族
    (M u)_{u ∈ N v} を一つの `Finset V` として合併するために `Finset.biUnion` が
    要求するものであり、それ以外の用途はない。V の有限性は要らない。
  - 状態側には何も要らない。状態型 A は任意の型でよく、二元であること、
    有限であること、等号判定を持つこと、演算を持つことはいずれも使わない。
  - 二段制限は制限写像の定義から座標ごとに従うだけであり、
    どの段でも基準値延長も一点反転も本質的依存も使わない。
  - 有限性が要るのは、具体版で大域写像全体 M(V,N⋆M) を `Finset` として集める段だけである。
    ここでは所属を「合成近傍上の局所規則族が存在する」という存在文で述べ、
    V と A の有限性を使わない。
  - グラフ、時間、順序、演算、ℝ / ℂ はいずれも使わない。
-/
import CellularAutomata.NecSuf.TimeExpansionDependency

namespace CellularAutomata.NecSuf.ComposedNeighborhoodClosure

open CellularAutomata.NecSuf.RedundantNeighbor
open CellularAutomata.NecSuf.TimeExpansionDependency

variable {V A : Type} [DecidableEq V]

/-- `def_composed_neighborhood` の (N ⋆ M)(v) = ⋃_{u ∈ N(v)} M(u)。
    V の等号判定だけを使い、有限性は使わない。 -/
def composedNeighborhood (N M : V → Finset V) (v : V) : Finset V :=
  (N v).biUnion M

/-- u ∈ N(v) なら M(u) ⊆ (N ⋆ M)(v)。合併の定義だけから従う。 -/
theorem inner_mem_composedNeighborhood (N M : V → Finset V) (v u w : V)
    (hu : u ∈ N v) (hw : w ∈ M u) : w ∈ composedNeighborhood N M v :=
  Finset.mem_biUnion.mpr ⟨u, hu, hw⟩

/-- `def_composed_local_rule_family` の h_v。状態型 A には何の構造も要らない。 -/
def composedLocalRuleFamily (N M : V → Finset V)
    (f : (v : V) → (↥(N v) → A) → A) (g : (v : V) → (↥(M v) → A) → A) :
    (v : V) → (↥(composedNeighborhood N M v) → A) → A :=
  fun v z => f v (fun u => g u.val (fun w =>
    z ⟨w.val, inner_mem_composedNeighborhood N M v u.val w.val u.property w.property⟩))

/-- 人手証明の二段制限:
    ρ^{(N⋆M)(v)}_{M(u)}(ρ^V_{(N⋆M)(v)}x) = ρ^V_{M(u)}x。
    制限写像の定義を座標ごとに展開するだけで、状態側の構造は使わない。 -/
theorem twoStageRestriction (N M : V → Finset V) (x : V → A)
    (v : V) (u : ↥(N v)) :
    (fun w : ↥(M u.val) =>
      (restrict (composedNeighborhood N M v) x)
        ⟨w.val, inner_mem_composedNeighborhood N M v u.val w.val u.property w.property⟩) =
      restrict (M u.val) x := by
  funext w
  rfl

/-- `claim_global_map_composition_representable_on_composed_neighborhood` の等号部分。
    人手証明どおり二段制限を各 u ∈ N(v) で書き換えてから写像の外延性で結ぶ。 -/
theorem globalMap_composition_eq (N M : V → Finset V)
    (f : (v : V) → (↥(N v) → A) → A) (g : (v : V) → (↥(M v) → A) → A) :
    globalMap N f ∘ globalMap M g =
      globalMap (composedNeighborhood N M) (composedLocalRuleFamily N M f g) := by
  funext x v
  show f v (restrict (N v) (globalMap M g x)) =
    f v (fun u => g u.val (fun w =>
      (restrict (composedNeighborhood N M v) x)
        ⟨w.val, inner_mem_composedNeighborhood N M v u.val w.val u.property w.property⟩))
  refine congrArg (f v) ?_
  funext u
  show g u.val (restrict (M u.val) x) = _
  rw [twoStageRestriction N M x v u]

/-- `claim_global_map_composition_representable_on_composed_neighborhood` の所属部分。
    有限性を使わず、所属を合成近傍上の局所規則族の存在として述べる。 -/
theorem globalMap_composition_representable (N M : V → Finset V)
    (f : (v : V) → (↥(N v) → A) → A) (g : (v : V) → (↥(M v) → A) → A) :
    ∃ h : (v : V) → (↥(composedNeighborhood N M v) → A) → A,
      globalMap N f ∘ globalMap M g = globalMap (composedNeighborhood N M) h :=
  ⟨composedLocalRuleFamily N M f g, globalMap_composition_eq N M f g⟩

/-- 表現の言葉だけで述べた合成の閉性。
    N 上で表せる F と M 上で表せる G の合成は N ⋆ M 上で表せる。 -/
theorem composition_representable_of_representable (N M : V → Finset V)
    (F G : (V → A) → (V → A))
    (hF : ∃ f : (v : V) → (↥(N v) → A) → A, globalMap N f = F)
    (hG : ∃ g : (v : V) → (↥(M v) → A) → A, globalMap M g = G) :
    ∃ h : (v : V) → (↥(composedNeighborhood N M v) → A) → A,
      globalMap (composedNeighborhood N M) h = F ∘ G := by
  obtain ⟨f, hf⟩ := hF
  obtain ⟨g, hg⟩ := hG
  subst hf
  subst hg
  exact ⟨composedLocalRuleFamily N M f g, (globalMap_composition_eq N M f g).symm⟩

end CellularAutomata.NecSuf.ComposedNeighborhoodClosure
