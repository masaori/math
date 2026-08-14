/-
章「冗長近傍からの独立性」の必要十分版。

具体版と同じ制限写像・基準値延長写像・証明順序を保ち、実際に使う構造だけを残す。

* 制限、冗長拡大、依存の移送には、添字型の等号判定と延長に使う基準値だけが要る。
* 追加元への非依存を具体版と同じ一点反転検査で示すには、状態型上の写像 ν と
  「a と異なる元は ν(a) だけ」という性質が要る。
* 依存台に対応する点ごとの同値にも有限性は要らない。有限性は具体版で点ごとの述語を
  Finset として集める段階にだけ要る。

グラフ、時間、順序、演算、ℝ / ℂ はいずれも使わない。
-/
import CellularAutomata.NecSuf.EssentialDependency

namespace CellularAutomata.NecSuf.RedundantNeighbor

variable {T A : Type} [DecidableEq T] (S : Finset T)

/-- 必要十分版の制限写像。状態型には構造を要求しない。 -/
def restrict (y : T → A) : (↥S → A) :=
  fun u => y u.val

/-- 必要十分版の冗長拡大。 -/
def extendRule (f : (↥S → A) → A) : (T → A) → A :=
  fun y => f (restrict S y)

/-- 必要十分版の基準値延長写像。必要なのは選んだ一つの値だけである。 -/
def baseExtend (base : A) (x : ↥S → A) : T → A :=
  fun u => if h : u ∈ S then x ⟨u, h⟩ else base

/-- 制限と基準値延長の合成は恒等写像である。 -/
theorem restrict_baseExtend (base : A) (x : ↥S → A) :
    restrict S (baseExtend S base x) = x := by
  funext u
  simp [restrict, baseExtend, u.property]

/-- 具体版と同じ一点反転検査により、追加元には本質的に依存しない。 -/
theorem no_essentialDep_on_added_element
    (nu : A → A)
    (uniqueAlternative : ∀ a b : A, b ≠ a ↔ b = nu a)
    (f : (↥S → A) → A) (w : T) (hw : w ∉ S) :
    ¬ CellularAutomata.NecSuf.EssentialDependency.EssentialDep (extendRule S f) w := by
  rw [CellularAutomata.NecSuf.EssentialDependency.essentialDep_iff_flip nu uniqueAlternative]
  rintro ⟨y, hne⟩
  apply hne
  have hrestrict : restrict S
      (CellularAutomata.NecSuf.EssentialDependency.flip nu w y) = restrict S y := by
    funext u
    exact CellularAutomata.NecSuf.EssentialDependency.flip_ne nu w y u.val
      (fun h : u.val = w => hw (h ▸ u.property))
  show extendRule S f y = extendRule S f
    (CellularAutomata.NecSuf.EssentialDependency.flip nu w y)
  unfold extendRule
  rw [hrestrict]

/-- 元の添字への本質的依存は、制限と基準値延長で両方向に移送できる。 -/
theorem essentialDep_transfer (base : A) (f : (↥S → A) → A)
    (w : T) (hw : w ∈ S) :
    CellularAutomata.NecSuf.EssentialDependency.EssentialDep (extendRule S f) w ↔
      CellularAutomata.NecSuf.EssentialDependency.EssentialDep f ⟨w, hw⟩ := by
  constructor
  · rintro ⟨y, y', agree, hne⟩
    refine ⟨restrict S y, restrict S y', ?_, hne⟩
    intro u hu
    have huw : u.val ≠ w := fun h => hu (Subtype.ext h)
    exact agree u.val huw
  · rintro ⟨x, x', agree, hne⟩
    refine ⟨baseExtend S base x, baseExtend S base x', ?_, ?_⟩
    · intro u hu
      by_cases hmem : u ∈ S
      · have : (⟨u, hmem⟩ : ↥S) ≠ ⟨w, hw⟩ :=
          fun h => hu (congrArg Subtype.val h)
        simp [baseExtend, hmem, agree ⟨u, hmem⟩ this]
      · simp [baseExtend, hmem]
    · show extendRule S f (baseExtend S base x) ≠
        extendRule S f (baseExtend S base x')
      unfold extendRule
      rw [restrict_baseExtend, restrict_baseExtend]
      exact hne

/-- 依存台の等号の有限集合化より前にある、各添字についての必要十分条件。
    ここには T や A の有限性は要らない。 -/
theorem essentialDep_extendRule_iff
    (nu : A → A)
    (uniqueAlternative : ∀ a b : A, b ≠ a ↔ b = nu a)
    (base : A) (f : (↥S → A) → A) (w : T) :
    CellularAutomata.NecSuf.EssentialDependency.EssentialDep (extendRule S f) w ↔
      ∃ hw : w ∈ S,
        CellularAutomata.NecSuf.EssentialDependency.EssentialDep f ⟨w, hw⟩ := by
  constructor
  · intro hdep
    by_cases hw : w ∈ S
    · exact ⟨hw, (essentialDep_transfer S base f w hw).mp hdep⟩
    · exact absurd hdep (no_essentialDep_on_added_element S nu uniqueAlternative f w hw)
  · rintro ⟨hw, hdep⟩
    exact (essentialDep_transfer S base f w hw).mpr hdep

end CellularAutomata.NecSuf.RedundantNeighbor
