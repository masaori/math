/-
章「依存順序から得る部分構造」の必要十分版。

具体版と同じ定義と証明順序を保ち、実際に使う構造だけを残す。

* 下方集合・上方集合・順序凸性と共通部分には、集合 X と関係 R だけを使う。
* 反鎖の順序凸性には、R の反対称性と推移性だけを使う。反射性と有限性は要らない。
* 時刻切片の反鎖性には、時刻写像、非反射的な時刻関係、および R の相異なる二点間で
  時刻が増えることだけを使う。自然数時刻は要らない。
* 一段境界と下方集合の境界には、一段関係 D が R に含まれることだけを使う。

先頭の順序凸・下方集合・上方集合・非比較・反鎖は、構造化本文と同じく
有限半順序の道具であり、CA のイベント・時刻・局所規則を仮定しない。

舞台、状態、近傍、局所規則、自然数、グラフ、物理的因果、R / C は使わない。
-/
import Mathlib

namespace CellularAutomata.NecSuf.DependencyOrderSubstructures

variable {Event Time : Type}

def IsOrderConvex (X : Set Event) (R : Set (Event × Event)) (K : Set Event) : Prop :=
  ∀ a ∈ K, ∀ c ∈ K, ∀ b ∈ X, (a, b) ∈ R → (b, c) ∈ R → b ∈ K

def IsDownSet (X : Set Event) (R : Set (Event × Event)) (J : Set Event) : Prop :=
  ∀ a ∈ J, ∀ b ∈ X, (b, a) ∈ R → b ∈ J

def IsUpSet (X : Set Event) (R : Set (Event × Event)) (U : Set Event) : Prop :=
  ∀ a ∈ U, ∀ b ∈ X, (a, b) ∈ R → b ∈ U

theorem down_set_order_convex (X : Set Event) (R : Set (Event × Event))
    (J : Set Event) (hJ : IsDownSet X R J) : IsOrderConvex X R J := by
  intro _a _ha c hc b hb _hab hbc
  exact hJ c hc b hb hbc

theorem up_set_order_convex (X : Set Event) (R : Set (Event × Event))
    (U : Set Event) (hU : IsUpSet X R U) : IsOrderConvex X R U := by
  intro a ha _c _hc b hb hab _hbc
  exact hU a ha b hb hab

theorem order_convex_intersection (X : Set Event) (R : Set (Event × Event))
    (K₁ K₂ : Set Event) (h₁ : IsOrderConvex X R K₁) (h₂ : IsOrderConvex X R K₂) :
    IsOrderConvex X R (K₁ ∩ K₂) := by
  rintro a ⟨ha₁, ha₂⟩ c ⟨hc₁, hc₂⟩ b hb hab hbc
  exact ⟨h₁ a ha₁ c hc₁ b hb hab hbc, h₂ a ha₂ c hc₂ b hb hab hbc⟩

def Incomparable (X : Set Event) (R : Set (Event × Event)) : Set (Event × Event) :=
  { ab | ab.1 ∈ X ∧ ab.2 ∈ X ∧ (ab.1, ab.2) ∉ R ∧ (ab.2, ab.1) ∉ R }

theorem incomparable_symm (X : Set Event) (R : Set (Event × Event)) (a b : Event) :
    (a, b) ∈ Incomparable X R ↔ (b, a) ∈ Incomparable X R := by
  constructor <;> rintro ⟨ha, hb, h₁, h₂⟩ <;> exact ⟨hb, ha, h₂, h₁⟩

def IsAntichainOn (X : Set Event) (R : Set (Event × Event)) (K : Set Event) : Prop :=
  ∀ a ∈ K, ∀ b ∈ K, a ≠ b → (a, b) ∈ Incomparable X R

theorem antichain_order_convex (X : Set Event) (R : Set (Event × Event))
    (R_antisymm : ∀ a b, (a, b) ∈ R → (b, a) ∈ R → a = b)
    (R_trans : ∀ a b c, (a, b) ∈ R → (b, c) ∈ R → (a, c) ∈ R)
    (K : Set Event) (hK : IsAntichainOn X R K) : IsOrderConvex X R K := by
  intro a ha c hc b _hb hab hbc
  by_cases hac : a = c
  · subst hac
    exact (R_antisymm a b hab hbc) ▸ ha
  · exact ((hK a ha c hc hac).2.2.1 (R_trans a b c hab hbc)).elim

def timeSlice (X : Set Event) (time : Event → Time) (t : Time) : Set Event :=
  { a | a ∈ X ∧ time a = t }

theorem time_slice_antichain (X : Set Event) (R : Set (Event × Event))
    (time : Event → Time) (lt : Time → Time → Prop)
    (lt_irreflexive : ∀ t, ¬ lt t t)
    (R_eq_or_time_increases : ∀ a b, (a, b) ∈ R → a = b ∨ lt (time a) (time b))
    (t : Time) : IsAntichainOn X R (timeSlice X time t) := by
  rintro a ⟨haX, hat⟩ b ⟨hbX, hbt⟩ hab
  have key : ∀ x y, time x = t → time y = t → x ≠ y → (x, y) ∉ R := by
    intro x y hxt hyt hxy hR
    rcases R_eq_or_time_increases x y hR with hxy' | hlt
    · exact hxy hxy'
    · rw [hxt, hyt] at hlt
      exact lt_irreflexive t hlt
  exact ⟨haX, hbX, key a b hat hbt hab, key b a hbt hat hab.symm⟩

def oneStepBoundary (X : Set Event) (D : Set (Event × Event)) (K : Set Event) : Set Event :=
  { a | a ∈ K ∧ ∃ b, b ∈ X ∧ b ∉ K ∧ ((a, b) ∈ D ∨ (b, a) ∈ D) }

theorem oneStepBoundary_finite (X : Set Event) (D : Set (Event × Event))
    (K : Set Event) (hK : K.Finite) : (oneStepBoundary X D K).Finite :=
  hK.subset (fun _a ha => ha.1)

theorem down_set_no_incoming_edge (X : Set Event) (R D : Set (Event × Event))
    (D_subset_R : D ⊆ R) (J : Set Event) (hJ : IsDownSet X R J)
    (a b : Event) (ha : a ∈ J) (hbX : b ∈ X) (hbJ : b ∉ J)
    (hD : (b, a) ∈ D) : False :=
  hbJ (hJ a ha b hbX (D_subset_R hD))

theorem down_set_boundary_outgoing (X : Set Event) (R D : Set (Event × Event))
    (D_subset_R : D ⊆ R) (J : Set Event) (hJ : IsDownSet X R J) :
    oneStepBoundary X D J = { a | a ∈ J ∧ ∃ b, b ∈ X ∧ b ∉ J ∧ (a, b) ∈ D } := by
  ext a
  constructor
  · rintro ⟨haJ, b, hbX, hbJ, hout | hin⟩
    · exact ⟨haJ, b, hbX, hbJ, hout⟩
    · exact (down_set_no_incoming_edge X R D D_subset_R J hJ a b haJ hbX hbJ hin).elim
  · rintro ⟨haJ, b, hbX, hbJ, hout⟩
    exact ⟨haJ, b, hbX, hbJ, Or.inl hout⟩

end CellularAutomata.NecSuf.DependencyOrderSubstructures
