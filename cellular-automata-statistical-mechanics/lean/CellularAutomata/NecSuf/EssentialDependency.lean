/-
章「本質的依存台」の必要十分版。

具体版と同じ証明順序を保ち、実際に使う構造だけを残す。

* 一点反転との同値に必要なのは、添字型 S の等号判定と、状態型 A 上の写像 ν が
  「a と異なる元は ν(a) だけ」を満たすことだけである。S と A の有限性は使わない。
* 有限決定可能性には、S と A の有限性および A の等号判定が追加で必要である。
* 走査組数の式には、S と A の有限性だけが必要である。

グラフ、時間、順序、演算、ℝ / ℂ はいずれも使わない。
-/
import Mathlib.Data.Fintype.Card
import Mathlib.Data.Fintype.Pi
import Mathlib.Data.Fintype.Prod
import Mathlib.Data.Fintype.BigOperators

namespace CellularAutomata.NecSuf.EssentialDependency

variable {S A : Type} [DecidableEq S]

/-- 必要十分版の一点反転。状態型には ν 以外の構造を要求しない。 -/
def flip (nu : A → A) (w : S) (x : S → A) : S → A :=
  fun u => if u = w then nu (x w) else x u

/-- 必要十分版の本質的依存。有限性を仮定しない。 -/
def EssentialDep (f : (S → A) → A) (w : S) : Prop :=
  ∃ x x' : S → A, (∀ u : S, u ≠ w → x u = x' u) ∧ f x ≠ f x'

/-- 一点反転の上段。 -/
theorem flip_at (nu : A → A) (w : S) (x : S → A) :
    flip nu w x w = nu (x w) := by
  simp [flip]

/-- 一点反転の下段。 -/
theorem flip_ne (nu : A → A) (w : S) (x : S → A) (u : S) (h : u ≠ w) :
    flip nu w x u = x u := by
  simp [flip, h]

/--
本質的依存と一点反転検査の同値に必要な状態側の性質は、各 a について
「a と異なる元が ν(a) に一意に定まる」ことだけである。
証明は具体版と同じく、外延性で x(w) ≠ x'(w) を示し、一意な別値から x' = flip ν w x を得る。
-/
theorem essentialDep_iff_flip
    (nu : A → A)
    (uniqueAlternative : ∀ a b : A, b ≠ a ↔ b = nu a)
    (f : (S → A) → A) (w : S) :
    EssentialDep f w ↔ ∃ x : S → A, f x ≠ f (flip nu w x) := by
  constructor
  · rintro ⟨x, x', agree, hne⟩
    have hw : x w ≠ x' w := by
      intro hEq
      apply hne
      have : x = x' := funext fun u => by
        by_cases hu : u = w
        · rw [hu]; exact hEq
        · exact agree u hu
      rw [this]
    have hw' : x' w = nu (x w) :=
      (uniqueAlternative (x w) (x' w)).mp (Ne.symm hw)
    have : x' = flip nu w x := funext fun u => by
      by_cases hu : u = w
      · rw [hu, flip_at, hw']
      · rw [flip_ne nu w x u hu]; exact (agree u hu).symm
    exact ⟨x, by rw [← this]; exact hne⟩
  · rintro ⟨x, hne⟩
    refine ⟨x, flip nu w x, ?_, hne⟩
    exact fun u hu => (flip_ne nu w x u hu).symm

/--
有限決定可能性に追加で必要なのは、入力の添字型と状態型の有限性、および状態の等号判定である。
存在文を有限個の条件の論理和として判定する。
-/
def essentialDepDecidable
    [Fintype S] [Fintype A] [DecidableEq A]
    (nu : A → A)
    (uniqueAlternative : ∀ a b : A, b ≠ a ↔ b = nu a)
    (f : (S → A) → A) (w : S) : Decidable (EssentialDep f w) :=
  decidable_of_iff (∃ x : S → A, f x ≠ f (flip nu w x))
    (essentialDep_iff_flip nu uniqueAlternative f w).symm

/-- 走査する組 (w,x) の個数。2 値性を使う前の一般形。 -/
theorem card_scan_pairs [Fintype S] [Fintype A] :
    Fintype.card (S × (S → A)) =
      Fintype.card S * Fintype.card A ^ Fintype.card S := by
  rw [Fintype.card_prod, Fintype.card_fun]

end CellularAutomata.NecSuf.EssentialDependency
