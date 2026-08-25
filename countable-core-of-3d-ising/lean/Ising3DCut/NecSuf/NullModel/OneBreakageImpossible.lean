/-
「破れ数がちょうど 1 の配位は存在しない」の Lean 必要十分版。

具体版から三次元箱、座標、正方形、スピン値を落とすと、有限個の辺、二つの端点写像、
頂点上の値、および各辺の両端を別の三辺で結ぶ条件だけが残る。
-/
import Mathlib

namespace Ising3DCut.NecSuf.NullModel

/-- 辺が二頂点を向きによらず結ぶこと。 -/
def Connects {Edge Vertex : Type} (source target : Edge → Vertex)
    (e : Edge) (x y : Vertex) : Prop :=
  (source e = x ∧ target e = y) ∨ (source e = y ∧ target e = x)

/-- 各辺の両端を別の三辺で結べる有限辺系では、異なる値を結ぶ辺は一つだけにはならない。 -/
theorem broken_count_ne_one_of_alternate_chain
    {Edge Vertex Value : Type} [Fintype Edge] [DecidableEq Edge] [DecidableEq Value]
    (source target : Edge → Vertex) (value : Vertex → Value)
    (alternate : ∀ e : Edge, ∃ (f₁ f₂ f₃ : Edge) (p q : Vertex),
      f₁ ≠ e ∧ f₂ ≠ e ∧ f₃ ≠ e ∧
      Connects source target f₁ (source e) p ∧
      Connects source target f₂ p q ∧
      Connects source target f₃ q (target e)) :
    (Finset.univ.filter fun e => value (source e) ≠ value (target e)).card ≠ 1 := by
  intro hone
  obtain ⟨e, hsingleton⟩ := Finset.card_eq_one.mp hone
  obtain ⟨f₁, f₂, f₃, p, q, hf₁e, hf₂e, hf₃e, hc₁, hc₂, hc₃⟩ := alternate e
  have he : value (source e) ≠ value (target e) := by
    have : e ∈ Finset.univ.filter fun g => value (source g) ≠ value (target g) := by
      simp [hsingleton]
    simpa using this
  have value_eq_of_connects {f : Edge} {x y : Vertex}
      (hconn : Connects source target f x y)
      (hnot : value (source f) = value (target f)) : value x = value y := by
    rcases hconn with ⟨h₀, h₁⟩ | ⟨h₀, h₁⟩
    · rw [← h₀, ← h₁]; exact hnot
    · rw [← h₀, ← h₁]; exact hnot.symm
  have hf₁ : value (source f₁) = value (target f₁) := by
    have : f₁ ∉ Finset.univ.filter fun g => value (source g) ≠ value (target g) := by
      simp [hsingleton, hf₁e]
    simpa using this
  have hf₂ : value (source f₂) = value (target f₂) := by
    have : f₂ ∉ Finset.univ.filter fun g => value (source g) ≠ value (target g) := by
      simp [hsingleton, hf₂e]
    simpa using this
  have hf₃ : value (source f₃) = value (target f₃) := by
    have : f₃ ∉ Finset.univ.filter fun g => value (source g) ≠ value (target g) := by
      simp [hsingleton, hf₃e]
    simpa using this
  apply he
  calc
    value (source e) = value p := value_eq_of_connects hc₁ hf₁
    _ = value q := value_eq_of_connects hc₂ hf₂
    _ = value (target e) := value_eq_of_connects hc₃ hf₃

end Ising3DCut.NecSuf.NullModel
