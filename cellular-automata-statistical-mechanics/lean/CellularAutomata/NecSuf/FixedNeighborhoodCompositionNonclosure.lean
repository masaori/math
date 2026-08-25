/-
章「固定近傍による可逆大域写像族の合成非閉性」の必要十分版。

具体版（CellularAutomata.FixedNeighborhoodCompositionNonclosure）と同じ順序で、
座標送り写像が固定近傍の局所規則族で表せること、右逆写像からの単射性、両側逆写像、
二回合成のセル値写像が近傍の外の添字に本質的に依存すること、そこからの表現不能、
可逆な大域写像の族が合成で閉じないことを示す。

必要な構造の検査結果:
  - 舞台側に要るのは添字型 V の等号判定だけである（近傍を一元有限集合として書き、
    制限写像と一点反転を書くため）。V の有限性、セル数が 3 であること、
    巡回写像 s が置換であることはいずれも要らない。
  - 単射性に要るのは s の右逆写像 t（∀ v, s (t v) = v）だけであり、
    両側逆であることも s^3 = id も要らない。両側逆写像の主張には
    それぞれの向きの合成条件だけを仮定する（具体版は t := s ∘ s、s^3 = id でこれを満たす）。
  - 状態側に要るのは、写像 ν と「各元と異なる元が ν の値に一意に定まる」ことだけである。
    状態が二元であること、有限であること、等号判定を持つことはいずれも要らない。
    本質的依存の証人を作るために基準値 base : A を一つ要求する（具体版の定値零配位）。
  - 表現不能に要るのは、二回合成が読む添字 s (s v₀) が近傍 N(v₀) = {s v₀} の外にあること、
    すなわち s (s v₀) ≠ s v₀ だけである。
  - 大域写像全体 M(V,N) を有限集合として集める段は具体版にだけ置く。ここでは所属を
    「局所規則族が存在する」という存在文で述べ、V と A の有限性を使わない。
  - グラフ、時間、順序、演算、ℝ / ℂ はいずれも使わない。
-/
import CellularAutomata.NecSuf.LocalRuleRepresentation

namespace CellularAutomata.NecSuf.FixedNeighborhoodCompositionNonclosure

open CellularAutomata.NecSuf.EssentialDependency
open CellularAutomata.NecSuf.RedundantNeighbor
open CellularAutomata.NecSuf.TimeExpansionDependency
open CellularAutomata.NecSuf.LocalRuleRepresentation

variable {V A : Type} [DecidableEq V]

/-- 座標送り写像 F_s(x)(v) = x(s(v))。舞台の有限性も s の全単射性も仮定しない。 -/
def shiftMap (s : V → V) (x : V → A) : V → A := fun v => x (s v)

/-- 固定近傍 N_s(v) = {s(v)}。 -/
def shiftNbhd (s : V → V) (v : V) : Finset V := {s v}

/-- F_s を固定近傍上で表す一元局所規則族。 -/
def shiftRules (s : V → V) : (v : V) → (↥(shiftNbhd s v) → A) → A :=
  fun v z => z ⟨s v, by simp [shiftNbhd]⟩

omit [DecidableEq V] in
/-- 局所規則族が定める大域写像は座標送り写像に一致する。 -/
theorem globalMap_shiftRules (s : V → V) :
    globalMap (shiftNbhd s) (shiftRules s) = (shiftMap s : (V → A) → V → A) := by
  funext x v
  simp [globalMap, shiftRules, restrict, shiftMap]

omit [DecidableEq V] in
/-- 左からの合成が恒等になるのは t ∘ s = id のときである。 -/
theorem shiftMap_comp_left (s t : V → V) (hts : ∀ v, t (s v) = v) :
    (shiftMap s ∘ shiftMap t : (V → A) → V → A) = id := by
  funext x v
  simp [shiftMap, hts]

omit [DecidableEq V] in
/-- 右からの合成が恒等になるのは s ∘ t = id のときである。 -/
theorem shiftMap_comp_right (s t : V → V) (hst : ∀ v, s (t v) = v) :
    (shiftMap t ∘ shiftMap s : (V → A) → V → A) = id := by
  funext x v
  simp [shiftMap, hst]

omit [DecidableEq V] in
/-- 単射性に要るのは s の右逆写像だけである（具体版と同じく t v を代入して比較する）。 -/
theorem shiftMap_injective (s t : V → V) (hst : ∀ v, s (t v) = v) :
    Function.Injective (shiftMap s : (V → A) → V → A) := by
  intro x y hxy
  funext v
  have h := congrFun hxy (t v)
  simpa [shiftMap, hst] using h

/-- 二回合成の v₀ 座標写像。 -/
def twiceCellMap (s : V → V) (v₀ : V) (x : V → A) : A :=
  shiftMap s (shiftMap s x) v₀

omit [DecidableEq V] in
/-- 二回合成の v₀ 座標写像は s (s v₀) の値をそのまま返す。 -/
theorem twiceCellMap_eq (s : V → V) (v₀ : V) (x : V → A) :
    twiceCellMap s v₀ x = x (s (s v₀)) := rfl

/-- 二回合成の v₀ 座標写像は s (s v₀) に本質的に依存する。
    状態側に要るのは ν と別値の一意性、および証人を作るための基準値だけである。 -/
theorem twiceCellMap_essentialDep (nu : A → A)
    (uniqueAlternative : ∀ a b : A, b ≠ a ↔ b = nu a) (base : A)
    (s : V → V) (v₀ : V) :
    EssentialDep (twiceCellMap s v₀ : (V → A) → A) (s (s v₀)) := by
  refine (essentialDep_iff_flip nu uniqueAlternative (twiceCellMap s v₀) (s (s v₀))).mpr ?_
  refine ⟨fun _ => base, ?_⟩
  have h1 : twiceCellMap s v₀ (fun _ => base) = base := rfl
  have h2 : twiceCellMap s v₀ (flip nu (s (s v₀)) (fun _ => base)) = nu base := by
    show flip nu (s (s v₀)) (fun _ => base) (s (s v₀)) = nu base
    rw [flip_at]
  rw [h1, h2]
  have hne : nu base ≠ base := (uniqueAlternative base (nu base)).mpr rfl
  exact fun h => hne h.symm

/-- 読む添字が近傍の外にあれば、二回合成の v₀ 座標写像は N(v₀) 上では表せない。 -/
theorem twiceCellMap_not_representable (nu : A → A)
    (uniqueAlternative : ∀ a b : A, b ≠ a ↔ b = nu a) (base : A)
    (s : V → V) (v₀ : V) (hout : s (s v₀) ≠ s v₀) :
    ¬ Representable (shiftNbhd s v₀) (twiceCellMap s v₀ : (V → A) → A) := by
  intro hrep
  have hnotDep :=
    representable_implies_not_essentialDep_outside nu uniqueAlternative
      (shiftNbhd s v₀) (twiceCellMap s v₀) hrep (s (s v₀)) (by simp [shiftNbhd, hout])
  exact hnotDep (twiceCellMap_essentialDep nu uniqueAlternative base s v₀)

/-- したがって F_s ∘ F_s は同じ固定近傍の局所規則族では表せない。 -/
theorem shiftMap_comp_not_globalMap (nu : A → A)
    (uniqueAlternative : ∀ a b : A, b ≠ a ↔ b = nu a) (base : A)
    (s : V → V) (v₀ : V) (hout : s (s v₀) ≠ s v₀) :
    ¬ ∃ f : (v : V) → (↥(shiftNbhd s v) → A) → A,
        globalMap (shiftNbhd s) f = (shiftMap s ∘ shiftMap s : (V → A) → V → A) := by
  rintro ⟨f, hf⟩
  apply twiceCellMap_not_representable nu uniqueAlternative base s v₀ hout
  refine ⟨f v₀, ?_⟩
  intro x
  have h := congrFun (congrFun hf x) v₀
  exact h.symm

/-- 固定近傍で表せる可逆な大域写像の族は合成で閉じない。
    有限性を一切使わず、所属は局所規則族の存在として述べる。 -/
theorem reversible_fixed_neighborhood_not_composition_closed (nu : A → A)
    (uniqueAlternative : ∀ a b : A, b ≠ a ↔ b = nu a) (base : A)
    (s t : V → V) (hst : ∀ v, s (t v) = v) (v₀ : V) (hout : s (s v₀) ≠ s v₀) :
    ∃ F : (V → A) → (V → A),
      (∃ f : (v : V) → (↥(shiftNbhd s v) → A) → A, globalMap (shiftNbhd s) f = F) ∧
        Function.Injective F ∧
        ¬ ∃ f : (v : V) → (↥(shiftNbhd s v) → A) → A,
            globalMap (shiftNbhd s) f = F ∘ F :=
  ⟨shiftMap s, ⟨shiftRules s, globalMap_shiftRules s⟩,
    shiftMap_injective s t hst,
    shiftMap_comp_not_globalMap nu uniqueAlternative base s v₀ hout⟩

end CellularAutomata.NecSuf.FixedNeighborhoodCompositionNonclosure
