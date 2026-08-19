/-
章「安定ファイバー根付き木族の数値プロファイルは共役を決定しない」の具体版。
人手証明の正本は
structured-latex/content/iterate-monoid-conjugacy-numerical-profile.ts。

八配位上の二つの有限写像について、反復表、深さ別個数、分岐個数、
根直前の部分木の個数を人手証明と同じ順序で計算し、全単射を有限走査して
非共役性を証明する。有限集合、自然数、写像の等号だけを使い、R / C は使わない。
-/
import CellularAutomata.IterateMonoidConjugacyInvariance
import CellularAutomata.NecSuf.IterateMonoidConjugacyNumericalProfile

namespace CellularAutomata.IterateMonoidConjugacyNumericalProfile

open CellularAutomata.EssentialDependency
open CellularAutomata.TimeExpansionDependency

/-- 反例の八つの配位 `x₀,...,x₇`。 -/
abbrev Configuration := Fin 8

/-- 構造化記述の表で定めた写像 `F`。 -/
def counterexampleF : Configuration → Configuration :=
  ([0, 0, 0, 1, 1, 2, 4, 7] : List Configuration).get

/-- 構造化記述の表で定めた写像 `G`。 -/
def counterexampleG : Configuration → Configuration :=
  ([0, 0, 0, 1, 1, 2, 5, 7] : List Configuration).get

/-- 自己写像の有限反復。 -/
def iterate {X : Type} (H : X → X) : ℕ → X → X
  | 0 => id
  | n + 1 => H ∘ iterate H n

/-- 全近傍を使えば、有限配位上の任意の大域写像は非一様な二値 CA として実現できる。 -/
def fullNeighborhoodRule {V : Type} [Fintype V]
    (H : (V → State) → (V → State))
    (v : V) (x : ↑(Finset.univ : Finset V) → State) : State :=
  H (fun u => x ⟨u, Finset.mem_univ u⟩) v

theorem globalMap_fullNeighborhoodRule {V : Type} [Fintype V] [DecidableEq V]
    (H : (V → State) → (V → State)) :
    globalMap (fun _ : V => Finset.univ) (fullNeighborhoodRule H) = H := by
  funext x v
  rfl

/-- 人手証明が最小衝突開始位置と最小正周期を決めるために使う反復表。 -/
theorem counterexample_iteration_rows :
    iterate counterexampleF 1 6 = 4 ∧
    iterate counterexampleF 2 6 = 1 ∧
    iterate counterexampleF 3 6 = 0 ∧
    iterate counterexampleG 1 6 = 5 ∧
    iterate counterexampleG 2 6 = 2 ∧
    iterate counterexampleG 3 6 = 0 ∧
    (∀ y, iterate counterexampleF 3 y = iterate counterexampleF 4 y) ∧
    (∀ y, iterate counterexampleG 3 y = iterate counterexampleG 4 y) := by
  native_decide

/-- 両写像の安定ファイバーは `{x₀,...,x₆}` と `{x₇}` である。 -/
theorem counterexample_stable_fibers :
    (∀ y, iterate counterexampleF 3 y = 7 ↔ y = 7) ∧
    (∀ y, iterate counterexampleG 3 y = 7 ↔ y = 7) ∧
    (∀ y, y ≠ 7 → iterate counterexampleF 3 y = 0) ∧
    (∀ y, y ≠ 7 → iterate counterexampleG 3 y = 0) := by
  native_decide

/-- 大きい安定ファイバー。 -/
def largeFiber : Finset Configuration := Finset.univ.filter (fun y => y ≠ 7)

/-- 表から直接得る根付き木の深さ。 -/
def treeDepthF : Configuration → ℕ := ([0, 1, 1, 2, 2, 2, 3, 0] : List ℕ).get
def treeDepthG : Configuration → ℕ := ([0, 1, 1, 2, 2, 2, 3, 0] : List ℕ).get

/-- 深さ `k` の元数。 -/
def depthCount (depth : Configuration → ℕ) (fiber : Finset Configuration) (k : ℕ) : ℕ :=
  (fiber.filter (fun y => depth y = k)).card

/-- 根の自己ループを除いた、頂点 `z` へ入る辺の個数。 -/
def branchCount (H : Configuration → Configuration)
    (fiber : Finset Configuration) (root z : Configuration) : ℕ :=
  (fiber.filter (fun y => y ≠ root ∧ H y = z)).card

/-- 両方の大きいファイバーの深さ別個数列は `(1,2,3,1)` である。 -/
theorem counterexample_depth_profiles :
    (List.ofFn (fun k : Fin 4 => depthCount treeDepthF largeFiber k)) = [1, 2, 3, 1] ∧
    (List.ofFn (fun k : Fin 4 => depthCount treeDepthG largeFiber k)) = [1, 2, 3, 1] := by
  native_decide

/-- 分岐個数多重集合は、個数 `0,1,2` の重複度を順に `3,2,2` として一致する。 -/
theorem counterexample_branch_profiles :
    (largeFiber.filter (fun z => branchCount counterexampleF largeFiber 0 z = 0)).card = 3 ∧
    (largeFiber.filter (fun z => branchCount counterexampleF largeFiber 0 z = 1)).card = 2 ∧
    (largeFiber.filter (fun z => branchCount counterexampleF largeFiber 0 z = 2)).card = 2 ∧
    (largeFiber.filter (fun z => branchCount counterexampleG largeFiber 0 z = 0)).card = 3 ∧
    (largeFiber.filter (fun z => branchCount counterexampleG largeFiber 0 z = 1)).card = 2 ∧
    (largeFiber.filter (fun z => branchCount counterexampleG largeFiber 0 z = 2)).card = 2 := by
  native_decide

/-- `z` へ高々七回で到達する、大きいファイバー内の元の有限表。 -/
def descendantTable (H : Configuration → Configuration) (z : Configuration) :
    Finset Configuration :=
  Finset.univ.filter (fun y => ∃ n ∈ Finset.range 8, iterate H n y = z)

/-- 根直前の二頂点の子孫個数は `F` で `{4,2}`、`G` で `{3,3}` である。 -/
theorem counterexample_descendant_cardinalities :
    (descendantTable counterexampleF 1).card = 4 ∧
    (descendantTable counterexampleF 2).card = 2 ∧
    (descendantTable counterexampleG 1).card = 3 ∧
    (descendantTable counterexampleG 2).card = 3 := by
  native_decide

/-- 共役写像は全反復を移送する。 -/
theorem conjugate_iterate {X Y : Type} (F : X → X) (G : Y → Y) (h : X → Y)
    (hconj : ∀ y, h (F y) = G (h y)) (n : ℕ) (y : X) :
    h (iterate F n y) = iterate G n (h y) := by
  induction n with
  | zero => rfl
  | succ n ih =>
      simp only [iterate, Function.comp_apply]
      rw [hconj, ih]

theorem counterexampleG_fixed_points (z : Configuration)
    (hz : counterexampleG z = z) : z = 0 ∨ z = 7 := by
  native_decide +revert

theorem counterexampleG_preimage_seven (z : Configuration)
    (hz : counterexampleG z = 7) : z = 7 := by
  native_decide +revert

theorem counterexampleG_preimage_zero (z : Configuration)
    (hz : counterexampleG z = 0) : z = 0 ∨ z = 1 ∨ z = 2 := by
  native_decide +revert

/-- 数値プロファイルが一致する反例の二写像は共役でない。 -/
theorem counterexample_not_conjugate :
    ¬ ∃ h : Configuration ≃ Configuration,
      ∀ y, h (counterexampleF y) = counterexampleG (h y) := by
  intro hex
  obtain ⟨h, hconj⟩ := hex
  have h0fixed : counterexampleG (h 0) = h 0 := by
    rw [← hconj]
    congr 1
  have h7fixed : counterexampleG (h 7) = h 7 := by
    rw [← hconj]
    congr 1
  have h0 : h 0 = 0 := by
    rcases counterexampleG_fixed_points (h 0) h0fixed with hzero | hseven
    · exact hzero
    · have h1seven : h 1 = 7 := by
        apply counterexampleG_preimage_seven
        rw [← hconj]
        simpa [hseven] using congrArg h (show counterexampleF 1 = 0 by native_decide)
      exact False.elim ((by decide : (1 : Configuration) ≠ 0)
        (h.injective (h1seven.trans hseven.symm)))
  have h1cases : h 1 = 1 ∨ h 1 = 2 := by
    have hz : counterexampleG (h 1) = 0 := by
      rw [← hconj]
      simpa [h0] using congrArg h (show counterexampleF 1 = 0 by native_decide)
    rcases counterexampleG_preimage_zero (h 1) hz with hz | hcases
    · exact False.elim ((by decide : (1 : Configuration) ≠ 0) (h.injective (hz.trans h0.symm)))
    · exact hcases
  have himage : (descendantTable counterexampleF 1).image h ⊆
      descendantTable counterexampleG (h 1) := by
    intro z hz
    obtain ⟨y, hy, rfl⟩ := Finset.mem_image.mp hz
    simp only [descendantTable, Finset.mem_filter, Finset.mem_univ, true_and] at hy ⊢
    obtain ⟨n, hn, hreach⟩ := hy
    refine ⟨n, hn, ?_⟩
    rw [← conjugate_iterate counterexampleF counterexampleG h hconj]
    exact congrArg h hreach
  have hcardImage : ((descendantTable counterexampleF 1).image h).card = 4 := by
    rw [Finset.card_image_of_injective _ h.injective]
    exact counterexample_descendant_cardinalities.1
  have hle := Finset.card_le_card himage
  rw [hcardImage] at hle
  rcases h1cases with h1 | h1 <;> rw [h1] at hle
  · rw [counterexample_descendant_cardinalities.2.2.1] at hle
    omega
  · rw [counterexample_descendant_cardinalities.2.2.2] at hle
    omega

/-- 有限型上の二写像の共役全単射の存在は有限決定できる。 -/
def conjugacyDecidable {X Y : Type} [Fintype X] [DecidableEq X]
    [Fintype Y] [DecidableEq Y] (F : X → X) (G : Y → Y) :
    Decidable (∃ h : X → Y, Function.Bijective h ∧ ∀ y, h (F y) = G (h y)) := by
  infer_instance

/-! ### 必要十分版からの導出 -/

/-- この章の反復は必要十分版の反復写像に一致する。 -/
theorem iterate_eq_iterateMap {X : Type} (H : X → X) (n : ℕ) (x : X) :
    iterate H n x = NecSuf.IterateMonoid.iterateMap H n x := by
  induction n with
  | zero => rfl
  | succ n ih =>
      show H (iterate H n x) = H (NecSuf.GlobalMapIteration.iterate H n x)
      exact congrArg H ih

/-- 反復の移送（`conjugate_iterate`）は必要十分版の特殊化として得られる。 -/
theorem conjugate_iterate_from_necessary_sufficient {X Y : Type}
    (F : X → X) (G : Y → Y) (h : X → Y)
    (hconj : ∀ y, h (F y) = G (h y)) (n : ℕ) (y : X) :
    h (iterate F n y) = iterate G n (h y) := by
  rw [iterate_eq_iterateMap, iterate_eq_iterateMap]
  exact NecSuf.IterateMonoidConjugacyInvariance.conjugate_iterateMap F G h hconj n y

/-- 非共役性の証明が使う根の不動性の移送は、必要十分版の不動点移送の特殊化である。 -/
theorem counterexample_root_fixed_from_necessary_sufficient
    (h : Configuration → Configuration)
    (hconj : ∀ y, h (counterexampleF y) = counterexampleG (h y)) :
    counterexampleG (h 0) = h 0 ∧ counterexampleG (h 7) = h 7 :=
  ⟨NecSuf.IterateMonoidConjugacyNumericalProfile.conjugate_fixedPoint
      counterexampleF counterexampleG h hconj (by decide),
   NecSuf.IterateMonoidConjugacyNumericalProfile.conjugate_fixedPoint
      counterexampleF counterexampleG h hconj (by decide)⟩

/-- この章の子孫有限表は、必要十分版の有限表の反復上限 8 での特殊化に一致する。 -/
theorem descendantTable_eq_necessary_sufficient
    (H : Configuration → Configuration) (z : Configuration) :
    descendantTable H z =
      NecSuf.IterateMonoidConjugacyNumericalProfile.descendantTable H 8 z := by
  ext y
  simp [descendantTable, NecSuf.IterateMonoidConjugacyNumericalProfile.descendantTable,
    iterate_eq_iterateMap]

/-- 非共役性の証明が使う子孫個数の不等式は、必要十分版の特殊化として得られる。 -/
theorem counterexample_descendant_card_le_from_necessary_sufficient
    (h : Configuration ≃ Configuration)
    (hconj : ∀ y, h (counterexampleF y) = counterexampleG (h y)) (z : Configuration) :
    (descendantTable counterexampleF z).card ≤
      (descendantTable counterexampleG (h z)).card := by
  rw [descendantTable_eq_necessary_sufficient, descendantTable_eq_necessary_sufficient]
  exact NecSuf.IterateMonoidConjugacyNumericalProfile.descendantTable_card_le
    counterexampleF counterexampleG h hconj h.injective 8 z

/-- この章の共役の有限決定は必要十分版の特殊化である。 -/
def conjugacyDecidable_from_necessary_sufficient :
    Decidable (∃ h : Configuration → Configuration,
      Function.Bijective h ∧ ∀ y, h (counterexampleF y) = counterexampleG (h y)) :=
  NecSuf.IterateMonoidConjugacyNumericalProfile.conjugacyDecidable
    counterexampleF counterexampleG

end CellularAutomata.IterateMonoidConjugacyNumericalProfile
