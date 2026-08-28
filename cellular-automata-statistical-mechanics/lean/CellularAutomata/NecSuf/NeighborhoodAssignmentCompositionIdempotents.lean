/-
章「合成冪等な近傍割り当ての特徴づけ」の必要十分版。

具体版（CellularAutomata.NeighborhoodAssignmentCompositionIdempotents）と同じ順序で、
合成冪等性と「推移性かつ二段分解可能性」の同値、自己近傍を含む場合、二条件が互いを
含意しないこと、有限決定を示す。

必要な構造の検査結果:
  - **同値そのものに、舞台の有限性も等号判定も要らない。** 近傍の値を `Set` で表せば、
    合成冪等性と二条件の同値は型にインスタンスを一つも要求せずに成り立つ
    （`setCompositionIdempotent_iff_transitive_and_twoStepFactorable`）。使うのは
    合成の所属条件（合成の証人の存在）と写像・部分集合の外延性だけである。
  - **自己近傍を含む場合も同様である。** 二段分解の証人に対象元自身を取る一段だけを使い、
    有限性も等号判定も要らない（`setCompositionIdempotent_iff_transitive_of_self_mem`）。
  - **反例に要るのは相異なる二元だけである。** 具体版は「二段分解可能だが推移的でない」
    反例を三元舞台（`Fin 3`）で挙げているが、必要なのは相異なる二元 `a ≠ b` だけであり、
    `N(a)={a,b}`、`N(b)={a}`、他は空で反例になる（`setFactorableOnlyWitness`）。
    これは SageMath の全数走査が二元舞台に反例を見つけた事実（`overview.md` に記録）と
    一致する。具体版の三元の証人は主張の存在に必要ではない。
  - **二段分解可能性の側は `a ≠ b` すら使わない。**
    `setFactorableOnlyWitness_isTwoStepFactorable` は相異なることを仮定しない。
    `a ≠ b` が要るのは推移性の否定の側だけである。
  - **有限性と等号判定が要るのは二か所だけである。** 近傍の値を `Finset` で表して合成を
    `Finset.biUnion` で書く段（`DecidableEq V`）と、三重・二重の全称量化と存在量化を
    有限走査へ落として決定可能性を出す段（`Fintype V`）である。これは特徴づけの性質では
    なく、表現と決定手続きの要求である。
  - 状態集合、局所規則、時間、ℝ / ℂ はいずれも使わない。
-/
import CellularAutomata.NeighborhoodAssignmentCompositionIdempotents
import CellularAutomata.NecSuf.FiniteNeighborhoodAssignmentMonoid

namespace CellularAutomata.NecSuf.NeighborhoodAssignmentCompositionIdempotents

open CellularAutomata.NecSuf.FiniteNeighborhoodAssignmentMonoid

/-! ### 同値（インスタンスを一つも要らない段） -/

/-- `def_composition_idempotent_neighborhood_assignment` の `Set` 版。 -/
def SetCompositionIdempotent {V : Type} (N : V → Set V) : Prop :=
  setComp N N = N

/-- `def_transitive_neighborhood_assignment` の `Set` 版。 -/
def SetTransitive {V : Type} (N : V → Set V) : Prop :=
  ∀ v u w : V, u ∈ N v → w ∈ N u → w ∈ N v

/-- `def_two_step_factorable_neighborhood_assignment` の `Set` 版。 -/
def SetTwoStepFactorable {V : Type} (N : V → Set V) : Prop :=
  ∀ v w : V, w ∈ N v → ∃ u ∈ N v, w ∈ N u

/-- `claim_composition_idempotent_neighborhood_assignment_characterization` の必要十分版。
    具体版と同じ順序で、順方向は合成の所属条件から二条件を分けて取り出し、
    逆方向は各値の両包含から写像の等号を得る。有限性も等号判定も使わない。 -/
theorem setCompositionIdempotent_iff_transitive_and_twoStepFactorable
    {V : Type} (N : V → Set V) :
    SetCompositionIdempotent N ↔ SetTransitive N ∧ SetTwoStepFactorable N := by
  constructor
  · intro hIdem
    constructor
    · intro v u w huN hwN
      have hwComp : w ∈ setComp N N v := ⟨u, huN, hwN⟩
      rw [hIdem] at hwComp
      exact hwComp
    · intro v w hwN
      have hwComp : w ∈ setComp N N v := by
        rw [hIdem]
        exact hwN
      exact hwComp
  · rintro ⟨hTransitive, hFactorable⟩
    funext v
    ext w
    constructor
    · rintro ⟨u, huN, hwN⟩
      exact hTransitive v u w huN hwN
    · intro hwN
      obtain ⟨u, huN, hwNu⟩ := hFactorable v w hwN
      exact ⟨u, huN, hwNu⟩

/-- `claim_reflexive_neighborhood_assignment_idempotent_iff_transitive` の必要十分版。
    二段分解の証人に対象元自身を取る一段だけを使う。 -/
theorem setCompositionIdempotent_iff_transitive_of_self_mem
    {V : Type} (N : V → Set V) (hSelf : ∀ v : V, v ∈ N v) :
    SetCompositionIdempotent N ↔ SetTransitive N := by
  constructor
  · intro hIdem
    exact (setCompositionIdempotent_iff_transitive_and_twoStepFactorable N).mp hIdem |>.1
  · intro hTransitive
    apply (setCompositionIdempotent_iff_transitive_and_twoStepFactorable N).mpr
    refine ⟨hTransitive, ?_⟩
    intro v w hwN
    exact ⟨w, hwN, hSelf w⟩

/-! ### 反例に要るのは相異なる二元だけ -/

/-- 推移的だが二段分解可能でない証人。`N(a)={b}`、他は空。 -/
def setTransitiveOnlyWitness {V : Type} (a b : V) : V → Set V :=
  fun v => {w | v = a ∧ w = b}

/-- 二段の辺が存在しないので推移性は空虚に成り立つ。相異なることだけを使う。 -/
theorem setTransitiveOnlyWitness_isTransitive {V : Type} {a b : V} (hab : a ≠ b) :
    SetTransitive (setTransitiveOnlyWitness a b) := by
  rintro v u w ⟨-, hub⟩ ⟨hua, -⟩
  exact absurd (hua.symm.trans hub) hab

/-- `b ∈ N(a)` だが `N(a)` の元 `b` からは `b` へ辺が出ないので二段分解できない。 -/
theorem setTransitiveOnlyWitness_not_twoStepFactorable {V : Type} {a b : V} (hab : a ≠ b) :
    ¬ SetTwoStepFactorable (setTransitiveOnlyWitness a b) := by
  intro hFactorable
  obtain ⟨u, ⟨-, hub⟩, ⟨hua, -⟩⟩ := hFactorable a b ⟨rfl, rfl⟩
  exact hab (hua.symm.trans hub)

/-- 二段分解可能だが推移的でない証人。`N(a)={a,b}`、`N(b)={a}`、他は空。
    具体版は同じ役割の証人を三元舞台で置いているが、二元で足りる。 -/
def setFactorableOnlyWitness {V : Type} (a b : V) : V → Set V :=
  fun v => {w | (v = a ∧ (w = a ∨ w = b)) ∨ (v = b ∧ w = a)}

/-- 二段分解可能性。三つの場合それぞれに証人を明示する。`a ≠ b` は使わない。 -/
theorem setFactorableOnlyWitness_isTwoStepFactorable {V : Type} (a b : V) :
    SetTwoStepFactorable (setFactorableOnlyWitness a b) := by
  rintro v w (⟨hv, hwa | hwb⟩ | ⟨hv, hwa⟩)
  · exact ⟨b, Or.inl ⟨hv, Or.inr rfl⟩, Or.inr ⟨rfl, hwa⟩⟩
  · exact ⟨a, Or.inl ⟨hv, Or.inl rfl⟩, Or.inl ⟨rfl, Or.inr hwb⟩⟩
  · exact ⟨a, Or.inr ⟨hv, rfl⟩, Or.inl ⟨rfl, Or.inl hwa⟩⟩

/-- `a ∈ N(b)` かつ `b ∈ N(a)` だが `b ∉ N(b)` なので推移的でない。相異なることを使う。 -/
theorem setFactorableOnlyWitness_not_transitive {V : Type} {a b : V} (hab : a ≠ b) :
    ¬ SetTransitive (setFactorableOnlyWitness a b) := by
  intro hTransitive
  have haNb : a ∈ setFactorableOnlyWitness a b b := Or.inr ⟨rfl, rfl⟩
  have hbNa : b ∈ setFactorableOnlyWitness a b a := Or.inl ⟨rfl, Or.inr rfl⟩
  have hbNb : b ∈ setFactorableOnlyWitness a b b := hTransitive b a b haNb hbNa
  rcases hbNb with ⟨hba, -⟩ | ⟨-, hba⟩
  · exact hab hba.symm
  · exact hab hba.symm

/-- `claim_transitive_and_factorable_neighborhood_assignment_independent` の必要十分版。
    舞台に相異なる二元があれば、どちらの向きの反例も作れる。 -/
theorem setTransitive_and_twoStepFactorable_independent
    {V : Type} {a b : V} (hab : a ≠ b) :
    (∃ N : V → Set V, SetTransitive N ∧ ¬ SetTwoStepFactorable N) ∧
      (∃ N : V → Set V, SetTwoStepFactorable N ∧ ¬ SetTransitive N) :=
  ⟨⟨setTransitiveOnlyWitness a b, setTransitiveOnlyWitness_isTransitive hab,
      setTransitiveOnlyWitness_not_twoStepFactorable hab⟩,
    ⟨setFactorableOnlyWitness a b, setFactorableOnlyWitness_isTwoStepFactorable a b,
      setFactorableOnlyWitness_not_transitive hab⟩⟩

/-! ### 有限表現と決定可能性（等号判定と有限性が要る段） -/

section FinsetStage

variable {V : Type} [DecidableEq V]

/-- 有限表現版の合成冪等性。合成を `Finset.biUnion` で書くために等号判定が要る。 -/
def HetCompositionIdempotent (N : V → Finset V) : Prop :=
  hetComp N N = N

/-- 有限表現版の推移性。値の表現以外に何も要求しない。 -/
def HetTransitive (N : V → Finset V) : Prop :=
  ∀ v u w : V, u ∈ N v → w ∈ N u → w ∈ N v

/-- 有限表現版の二段分解可能性。 -/
def HetTwoStepFactorable (N : V → Finset V) : Prop :=
  ∀ v w : V, w ∈ N v → ∃ u ∈ N v, w ∈ N u

theorem hetTransitive_iff_setTransitive (N : V → Finset V) :
    HetTransitive N ↔ SetTransitive (fun v => ((N v : Finset V) : Set V)) := Iff.rfl

theorem hetTwoStepFactorable_iff_setTwoStepFactorable (N : V → Finset V) :
    HetTwoStepFactorable N ↔ SetTwoStepFactorable (fun v => ((N v : Finset V) : Set V)) :=
  Iff.rfl

/-- 有限表現版の同値。証明手順は `Set` 版と同じ二方向である。 -/
theorem hetCompositionIdempotent_iff_transitive_and_twoStepFactorable (N : V → Finset V) :
    HetCompositionIdempotent N ↔ HetTransitive N ∧ HetTwoStepFactorable N := by
  constructor
  · intro hIdem
    constructor
    · intro v u w huN hwN
      have hwComp : w ∈ hetComp N N v := Finset.mem_biUnion.mpr ⟨u, huN, hwN⟩
      rw [hIdem] at hwComp
      exact hwComp
    · intro v w hwN
      have hwComp : w ∈ hetComp N N v := by
        rw [hIdem]
        exact hwN
      exact Finset.mem_biUnion.mp hwComp
  · rintro ⟨hTransitive, hFactorable⟩
    funext v
    ext w
    constructor
    · intro hwComp
      obtain ⟨u, huN, hwN⟩ := Finset.mem_biUnion.mp hwComp
      exact hTransitive v u w huN hwN
    · intro hwN
      obtain ⟨u, huN, hwNu⟩ := hFactorable v w hwN
      exact Finset.mem_biUnion.mpr ⟨u, huN, hwNu⟩

/-- 有限表現版の自己近傍の場合。証人は対象元自身。 -/
theorem hetCompositionIdempotent_iff_transitive_of_self_mem (N : V → Finset V)
    (hSelf : ∀ v : V, v ∈ N v) :
    HetCompositionIdempotent N ↔ HetTransitive N := by
  constructor
  · intro hIdem
    exact (hetCompositionIdempotent_iff_transitive_and_twoStepFactorable N).mp hIdem |>.1
  · intro hTransitive
    apply (hetCompositionIdempotent_iff_transitive_and_twoStepFactorable N).mpr
    refine ⟨hTransitive, ?_⟩
    intro v w hwN
    exact ⟨w, hwN, hSelf w⟩

/-- 有限表現版の「二段分解可能だが推移的でない」証人。`Set` 版と同じ二元の構成。 -/
def hetFactorableOnlyWitness (a b : V) : V → Finset V :=
  fun v => if v = a then {a, b} else if v = b then {a} else ∅

theorem coe_hetFactorableOnlyWitness {a b : V} (hab : a ≠ b) (v : V) :
    ((hetFactorableOnlyWitness a b v : Finset V) : Set V) =
      setFactorableOnlyWitness a b v := by
  by_cases hva : v = a
  · subst hva
    ext w
    simp [hetFactorableOnlyWitness, setFactorableOnlyWitness, hab]
  · by_cases hvb : v = b
    · subst hvb
      ext w
      simp [hetFactorableOnlyWitness, setFactorableOnlyWitness, hva]
    · ext w
      simp [hetFactorableOnlyWitness, setFactorableOnlyWitness, hva, hvb]

theorem hetFactorableOnlyWitness_isTwoStepFactorable {a b : V} (hab : a ≠ b) :
    HetTwoStepFactorable (hetFactorableOnlyWitness a b) := by
  rw [hetTwoStepFactorable_iff_setTwoStepFactorable]
  have h : (fun v => ((hetFactorableOnlyWitness a b v : Finset V) : Set V)) =
      setFactorableOnlyWitness a b := funext (coe_hetFactorableOnlyWitness hab)
  rw [h]
  exact setFactorableOnlyWitness_isTwoStepFactorable a b

theorem hetFactorableOnlyWitness_not_transitive {a b : V} (hab : a ≠ b) :
    ¬ HetTransitive (hetFactorableOnlyWitness a b) := by
  rw [hetTransitive_iff_setTransitive]
  have h : (fun v => ((hetFactorableOnlyWitness a b v : Finset V) : Set V)) =
      setFactorableOnlyWitness a b := funext (coe_hetFactorableOnlyWitness hab)
  rw [h]
  exact setFactorableOnlyWitness_not_transitive hab

/-- 有限表現版の「推移的だが二段分解可能でない」証人。 -/
def hetTransitiveOnlyWitness (a b : V) : V → Finset V :=
  fun v => if v = a then {b} else ∅

theorem coe_hetTransitiveOnlyWitness (a b : V) (v : V) :
    ((hetTransitiveOnlyWitness a b v : Finset V) : Set V) =
      setTransitiveOnlyWitness a b v := by
  by_cases hva : v = a
  · subst hva
    ext w
    simp [hetTransitiveOnlyWitness, setTransitiveOnlyWitness]
  · ext w
    simp [hetTransitiveOnlyWitness, setTransitiveOnlyWitness, hva]

theorem hetTransitiveOnlyWitness_isTransitive {a b : V} (hab : a ≠ b) :
    HetTransitive (hetTransitiveOnlyWitness a b) := by
  rw [hetTransitive_iff_setTransitive]
  have h : (fun v => ((hetTransitiveOnlyWitness a b v : Finset V) : Set V)) =
      setTransitiveOnlyWitness a b := funext (coe_hetTransitiveOnlyWitness a b)
  rw [h]
  exact setTransitiveOnlyWitness_isTransitive hab

theorem hetTransitiveOnlyWitness_not_twoStepFactorable {a b : V} (hab : a ≠ b) :
    ¬ HetTwoStepFactorable (hetTransitiveOnlyWitness a b) := by
  rw [hetTwoStepFactorable_iff_setTwoStepFactorable]
  have h : (fun v => ((hetTransitiveOnlyWitness a b v : Finset V) : Set V)) =
      setTransitiveOnlyWitness a b := funext (coe_hetTransitiveOnlyWitness a b)
  rw [h]
  exact setTransitiveOnlyWitness_not_twoStepFactorable hab

/-- 決定可能性。三重・二重の全称量化と存在量化を有限走査へ落とすために舞台の有限性が要る。 -/
instance instDecidableHetTransitive [Fintype V] (N : V → Finset V) :
    Decidable (HetTransitive N) := by
  unfold HetTransitive
  infer_instance

instance instDecidableHetTwoStepFactorable [Fintype V] (N : V → Finset V) :
    Decidable (HetTwoStepFactorable N) := by
  unfold HetTwoStepFactorable
  infer_instance

instance instDecidableHetCompositionIdempotent [Fintype V] (N : V → Finset V) :
    Decidable (HetCompositionIdempotent N) := by
  unfold HetCompositionIdempotent
  infer_instance

end FinsetStage

/-! ### 具体版の導出 -/

section Derivation

open CellularAutomata.NeighborhoodAssignmentCompositionIdempotents
open CellularAutomata.FiniteNeighborhoodAssignmentMonoid

variable {V : Type} [DecidableEq V]

theorem isCompositionIdempotent_eq_het (N : V → Finset V) :
    IsCompositionIdempotent N = HetCompositionIdempotent N := rfl

theorem isTransitive_eq_het (N : V → Finset V) :
    IsTransitive N = HetTransitive N := rfl

theorem isTwoStepFactorable_eq_het (N : V → Finset V) :
    IsTwoStepFactorable N = HetTwoStepFactorable N := rfl

/-- 具体版の特徴づけは、必要十分版の有限表現版の特殊化である。 -/
theorem compositionIdempotent_iff_transitive_and_twoStepFactorable_of_necSuf
    (N : V → Finset V) :
    IsCompositionIdempotent N ↔ IsTransitive N ∧ IsTwoStepFactorable N :=
  hetCompositionIdempotent_iff_transitive_and_twoStepFactorable N

/-- 具体版の自己近傍の場合も、必要十分版の特殊化である。 -/
theorem compositionIdempotent_iff_transitive_of_self_mem_of_necSuf
    (N : V → Finset V) (hSelf : ∀ v : V, v ∈ N v) :
    IsCompositionIdempotent N ↔ IsTransitive N :=
  hetCompositionIdempotent_iff_transitive_of_self_mem N hSelf

/-- 具体版の独立性は、必要十分版の二元の構成を `Fin 2` と `Fin 3` へ特殊化して得られる。
    二番目の存在主張には具体版の三元の証人は要らず、`0 ≠ 1` だけで足りる。 -/
theorem transitive_and_twoStepFactorable_independent_of_necSuf :
    (∃ N : NeighborhoodAssignment (Fin 2),
      IsTransitive N ∧ ¬ IsTwoStepFactorable N) ∧
    (∃ N : NeighborhoodAssignment (Fin 3),
      IsTwoStepFactorable N ∧ ¬ IsTransitive N) := by
  have h2 : (0 : Fin 2) ≠ 1 := by decide
  have h3 : (0 : Fin 3) ≠ 1 := by decide
  exact ⟨⟨hetTransitiveOnlyWitness (0 : Fin 2) 1,
      hetTransitiveOnlyWitness_isTransitive h2,
      hetTransitiveOnlyWitness_not_twoStepFactorable h2⟩,
    ⟨hetFactorableOnlyWitness (0 : Fin 3) 1,
      hetFactorableOnlyWitness_isTwoStepFactorable h3,
      hetFactorableOnlyWitness_not_transitive h3⟩⟩

/-- 具体版の有限決定は、必要十分版の決定可能性インスタンスの特殊化である。 -/
theorem finite_decidable_of_necSuf [Fintype V] (N : V → Finset V) :
    (IsCompositionIdempotent N ∨ ¬ IsCompositionIdempotent N) ∧
      (IsTransitive N ∨ ¬ IsTransitive N) ∧
      (IsTwoStepFactorable N ∨ ¬ IsTwoStepFactorable N) :=
  ⟨@Decidable.em _ (instDecidableHetCompositionIdempotent N),
    @Decidable.em _ (instDecidableHetTransitive N),
    @Decidable.em _ (instDecidableHetTwoStepFactorable N)⟩

end Derivation

end CellularAutomata.NecSuf.NeighborhoodAssignmentCompositionIdempotents
