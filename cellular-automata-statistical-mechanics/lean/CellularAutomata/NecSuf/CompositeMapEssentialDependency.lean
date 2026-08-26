/-
章「合成写像の本質的依存台」の必要十分版。

具体版（CellularAutomata.CompositeMapEssentialDependency）と同じ順序で、値写像、
値写像を近傍上で表せること、二つの表現から合成が合成近傍上で表せること、
表現可能性から合成近傍の外に本質的依存元がないこと、そして本質的依存台を有限集合として
集めたときの包含を示す。

必要な構造の検査結果:
  - 値写像 `cellMap` の定義には何も要らない。舞台型・状態型ともに構造を仮定しない。
  - 「各値写像が近傍上で表せる」から「大域写像が局所規則族で書ける」への往復には、
    舞台型の等号判定だけが要る（制限写像 `restrict` を書くため）。状態型には何も要らない。
  - 合成が合成近傍上で表せる段は、前章の必要十分版 `globalMap_composition_eq` をそのまま使う。
    ここでも要るのは舞台型の等号判定（有限部分集合の合併）だけで、有限性は要らない。
  - 合成近傍の外に本質的依存元がないことには、前章の必要十分版
    `representable_implies_not_essentialDep_outside` が要求する状態側の性質、すなわち
    「各元と異なる元が入れ替え写像 ν の値に一意に定まること」だけを追加で使う。
    状態の有限性・等号判定・二元性は使わない。
  - 舞台の有限性が要るのは、値写像をその本質的依存台の上で表す段（基準値延長で表すために
    `Finset.univ \ S` を取る）と、依存台を `Finset` として集める段だけである。
    延長のためには状態型の値が一つ（`base`）要る。
  - 状態型の有限性と等号判定は、依存台の所属が有限検査で決まることにしか要らない。
    ここではその決定手続きを仮定 `decDep` として外へ出し、包含の主張自体からは外した。
  - グラフ、時間、順序、演算、ℝ / ℂ はいずれも使わない。
-/
import CellularAutomata.NecSuf.ComposedNeighborhoodClosure
import CellularAutomata.NecSuf.LocalRuleRepresentation

namespace CellularAutomata.NecSuf.CompositeMapEssentialDependency

open CellularAutomata.NecSuf.EssentialDependency
open CellularAutomata.NecSuf.RedundantNeighbor
open CellularAutomata.NecSuf.TimeExpansionDependency
open CellularAutomata.NecSuf.LocalRuleRepresentation
open CellularAutomata.NecSuf.ComposedNeighborhoodClosure

section General

variable {V A : Type} [DecidableEq V]

/-- `def_finite_configuration_map_cell_map` の必要十分版。構造を一切使わない。 -/
def cellMap (F : (V → A) → (V → A)) (v : V) : (V → A) → A :=
  fun x => F x v

-- 制限写像を書くだけなら舞台型の等号判定は使わないので、この段では仮定から外す。
omit [DecidableEq V] in
/-- 各値写像が N 上で表せるなら、F は N 上の局所規則族の大域写像である。
    舞台型の等号判定だけを使う。 -/
theorem exists_localRuleFamily_of_cellMap_representable
    (N : V → Finset V) (F : (V → A) → (V → A))
    (hF : ∀ v, Representable (N v) (cellMap F v)) :
    ∃ f : (v : V) → (↥(N v) → A) → A, globalMap N f = F := by
  choose f hf using hF
  refine ⟨f, ?_⟩
  funext x v
  exact (hf v x).symm

omit [DecidableEq V] in
/-- 逆向き: 局所規則族の大域写像の値写像は、その近傍上で表せる。 -/
theorem cellMap_representable_of_globalMap
    (N : V → Finset V) (f : (v : V) → (↥(N v) → A) → A) (v : V) :
    Representable (N v) (cellMap (globalMap N f) v) :=
  ⟨f v, fun _ => rfl⟩

/-- 人手証明の第一段と第二段の合成。各値写像が N・M 上で表せるなら、
    合成写像の値写像は合成近傍 (N ⋆ M)(v) 上で表せる。 -/
theorem composite_cellMap_representable
    (N M : V → Finset V) (F G : (V → A) → (V → A))
    (hF : ∀ v, Representable (N v) (cellMap F v))
    (hG : ∀ v, Representable (M v) (cellMap G v)) (v : V) :
    Representable (composedNeighborhood N M v) (cellMap (F ∘ G) v) := by
  obtain ⟨f, hf⟩ := exists_localRuleFamily_of_cellMap_representable N F hF
  obtain ⟨g, hg⟩ := exists_localRuleFamily_of_cellMap_representable M G hG
  have h := globalMap_composition_eq N M f g
  rw [hf, hg] at h
  exact ⟨composedLocalRuleFamily N M f g v, fun y => congrFun (congrFun h y) v⟩

/-- 人手証明の第三段の点ごとの形。合成近傍の外には本質的依存元がない。
    状態側に要るのは「各元と異なる元が ν の値に一意」だけである。 -/
theorem composite_not_essentialDep_outside
    (nu : A → A) (uniqueAlternative : ∀ a b : A, b ≠ a ↔ b = nu a)
    (N M : V → Finset V) (F G : (V → A) → (V → A))
    (hF : ∀ v, Representable (N v) (cellMap F v))
    (hG : ∀ v, Representable (M v) (cellMap G v)) (v : V) :
    ∀ w, w ∉ composedNeighborhood N M v → ¬ EssentialDep (cellMap (F ∘ G) v) w :=
  representable_implies_not_essentialDep_outside nu uniqueAlternative
    (composedNeighborhood N M v) (cellMap (F ∘ G) v)
    (composite_cellMap_representable N M F G hF hG v)

end General

section Finite

variable {V A : Type} [Fintype V] [DecidableEq V]
variable (decDep : ∀ (g : (V → A) → A) (w : V), Decidable (EssentialDep g w))

/-- `def_global_map_essential_dependency_assignment` の必要十分版。
    有限集合として集めるために舞台の有限性と、所属の決定手続き `decDep` だけを使う。 -/
def supportAssignment (F : (V → A) → (V → A)) (v : V) : Finset V :=
  @Finset.filter V (fun w => EssentialDep (cellMap F v) w)
    (fun w => decDep (cellMap F v) w) Finset.univ

omit [DecidableEq V] in
theorem mem_supportAssignment_iff (F : (V → A) → (V → A)) (v w : V) :
    w ∈ supportAssignment decDep F v ↔ EssentialDep (cellMap F v) w := by
  simp [supportAssignment]

/-- 値写像は自身の本質的依存台の上で表せる。基準値 `base` と舞台の有限性だけを追加で使う。 -/
theorem cellMap_representable_on_supportAssignment (base : A)
    (F : (V → A) → (V → A)) (v : V) :
    Representable (supportAssignment decDep F v) (cellMap F v) :=
  ⟨cellMap F v ∘ baseExtend (supportAssignment decDep F v) base,
    not_essentialDep_outside_implies_representation base
      (supportAssignment decDep F v) (cellMap F v)
      (fun w hw hdep => hw ((mem_supportAssignment_iff decDep F v w).mpr hdep))⟩

/-- `claim_composite_map_support_bounded_by_composed_support` の必要十分版。 -/
theorem supportAssignment_composite_subset (base : A)
    (nu : A → A) (uniqueAlternative : ∀ a b : A, b ≠ a ↔ b = nu a)
    (F G : (V → A) → (V → A)) (v : V) :
    supportAssignment decDep (F ∘ G) v ⊆
      composedNeighborhood (supportAssignment decDep F) (supportAssignment decDep G) v := by
  intro w hw
  by_contra hnot
  exact composite_not_essentialDep_outside nu uniqueAlternative
    (supportAssignment decDep F) (supportAssignment decDep G) F G
    (fun u => cellMap_representable_on_supportAssignment decDep base F u)
    (fun u => cellMap_representable_on_supportAssignment decDep base G u) v w hnot
    ((mem_supportAssignment_iff decDep (F ∘ G) v w).mp hw)

end Finite

section StrictWitness

/-!
反例に必要な構造の検査。具体版は二セルの舞台と二元状態 `State` で書いたが、
証明で実際に使うのは「舞台が相異なる二つのセル ca ≠ cb を持つこと」と
「状態型が相異なる二つの値 a0 ≠ a1 を持つこと」だけである。
舞台がちょうど二セルであることも、状態型が二元であることも使わない。
舞台の有限性は依存台を `Finset` として集める段にだけ要り、
等号判定は舞台側では二セルの識別、状態側では相違の読み取りにだけ要る。
-/

variable {C A : Type} [Fintype C] [DecidableEq C] [DecidableEq A]

/-- 指定したセル ca の値を全セルへ複製する写像。 -/
def dupMap (ca : C) (x : C → A) : C → A :=
  fun _ => x ca

/-- 二つの中間セルの値の相違を ca で読み、他のセルでは a0 を返す写像。 -/
def diffMap (ca cb : C) (a0 a1 : A) (y : C → A) : C → A :=
  fun c => if c = ca then (if y ca = y cb then a0 else a1) else a0

/-- 合成写像はセル ca で定値である。複製により二つの中間値が常に一致するため。 -/
theorem diffMap_dupMap_const (ca cb : C) (a0 a1 : A) (x : C → A) :
    cellMap (diffMap ca cb a0 a1 ∘ dupMap ca) ca x = a0 := by
  show (if ca = ca then (if dupMap ca x ca = dupMap ca x cb then a0 else a1) else a0) = a0
  simp [dupMap]

/-- 合成写像のセル ca の依存台は空である。 -/
theorem supportAssignment_composite_empty
    (decDep : ∀ (g : (C → A) → A) (w : C), Decidable (EssentialDep g w))
    (ca cb : C) (a0 a1 : A) :
    supportAssignment decDep (diffMap ca cb a0 a1 ∘ dupMap ca) ca = ∅ := by
  refine Finset.eq_empty_iff_forall_notMem.mpr ?_
  intro w hw
  obtain ⟨x, x', -, hne⟩ := (mem_supportAssignment_iff decDep _ ca w).mp hw
  exact hne ((diffMap_dupMap_const ca cb a0 a1 x).trans
    (diffMap_dupMap_const ca cb a0 a1 x').symm)

/-- 相違を読む写像のセル ca は、中間セル cb に本質的に依存する。 -/
theorem diffMap_essentialDep_cb (ca cb : C) (hc : ca ≠ cb) (a0 a1 : A) (hne : a0 ≠ a1) :
    EssentialDep (cellMap (diffMap ca cb a0 a1) ca) cb := by
  refine ⟨fun _ => a0, fun u => if u = cb then a1 else a0, ?_, ?_⟩
  · intro u hu
    simp [hu]
  · show (if ca = ca then (if (a0 : A) = a0 then a0 else a1) else a0) ≠
      (if ca = ca then
        (if (if ca = cb then a1 else a0) = (if (cb : C) = cb then a1 else a0) then a0 else a1)
        else a0)
    simp [hc, hne]

/-- 複製写像のセル cb は、複製元のセル ca に本質的に依存する。 -/
theorem dupMap_essentialDep_ca (ca cb : C) (a0 a1 : A) (hne : a0 ≠ a1) :
    EssentialDep (cellMap (dupMap (A := A) ca) cb) ca := by
  refine ⟨fun _ => a0, fun u => if u = ca then a1 else a0, ?_, ?_⟩
  · intro u hu
    simp [hu]
  · show (a0 : A) ≠ (if ca = ca then a1 else a0)
    simpa using hne

/-- `claim_composite_map_support_bound_can_be_strict` の必要十分版。
    相異なる二セルと相異なる二値さえあれば、包含は真の包含になりうる。 -/
theorem supportAssignment_composite_subset_can_be_strict
    (decDep : ∀ (g : (C → A) → A) (w : C), Decidable (EssentialDep g w))
    (ca cb : C) (hc : ca ≠ cb) (a0 a1 : A) (hne : a0 ≠ a1) :
    supportAssignment decDep (diffMap ca cb a0 a1 ∘ dupMap ca) ca ⊂
      composedNeighborhood (supportAssignment decDep (diffMap ca cb a0 a1))
        (supportAssignment decDep (dupMap (A := A) ca)) ca := by
  have hmem : ca ∈ composedNeighborhood
      (supportAssignment decDep (diffMap ca cb a0 a1))
      (supportAssignment decDep (dupMap (A := A) ca)) ca :=
    Finset.mem_biUnion.mpr ⟨cb,
      (mem_supportAssignment_iff decDep _ ca cb).mpr
        (diffMap_essentialDep_cb ca cb hc a0 a1 hne),
      (mem_supportAssignment_iff decDep _ cb ca).mpr
        (dupMap_essentialDep_ca ca cb a0 a1 hne)⟩
  rw [supportAssignment_composite_empty decDep ca cb a0 a1]
  exact Finset.empty_ssubset.mpr ⟨ca, hmem⟩

end StrictWitness

end CellularAutomata.NecSuf.CompositeMapEssentialDependency
