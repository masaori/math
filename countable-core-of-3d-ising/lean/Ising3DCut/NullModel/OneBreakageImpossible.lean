/-
「破れ数がちょうど 1 の配位は存在しない」の Lean 具体版の前半。
各辺に、その両端を結ぶ別の三辺があるなら、一辺だけが破れることはないと示す。
次の段で三次元箱の各辺について同じ正方形の残り三辺を構成する。

人手証明は正方形の四辺を、辺の向き（始点から第二端点へ）とは無関係に
つないで等号の連鎖を作る（`c=a` の場合は三本目を、`c=a-ε_j` の場合は
一本目を、それぞれ第二端点から第一端点へ向かって使う）。
そこで辺が二点を結ぶことを向きによらない述語 `Connects` として書き、
連鎖の仮定をこの述語で述べる。向きを固定した仮定では箱の正方形を渡せない。

住処: 有限集合と等号だけ。ℝ / ℂ は現れない。
-/
import Ising3DCut.NullModel.BrokenComplement

namespace Ising3DCut.NullModel

/-- 辺 `f` が二点 `x`, `y` を結ぶこと。辺の向きは問わない。 -/
def Connects {L : ℕ} (f : Edge L) (x y : Site L) : Prop :=
  (endpoint0 f = x ∧ endpoint1 f = y) ∨ (endpoint0 f = y ∧ endpoint1 f = x)

/-- 破れていない辺が結ぶ二点では、配位の値が一致する。 -/
lemma value_eq_of_connects_of_not_broken {L : ℕ} (σ : Config L) {f : Edge L} {x y : Site L}
    (hconn : Connects f x y) (hnb : σ (endpoint0 f) = σ (endpoint1 f)) :
    σ x = σ y := by
  rcases hconn with ⟨h0, h1⟩ | ⟨h0, h1⟩
  · rw [← h0, ← h1]; exact hnb
  · rw [← h0, ← h1]; exact hnb.symm

/-- 一つの辺の両端を別の三辺で結べるなら、その一辺だけを破れ辺にはできない。 -/
theorem brokenCount_ne_one_of_alternate_three_edges {L : ℕ} (σ : Config L)
    (alternate : ∀ e : Edge L, ∃ (f₁ f₂ f₃ : Edge L) (p q : Site L),
      f₁ ≠ e ∧ f₂ ≠ e ∧ f₃ ≠ e ∧
      Connects f₁ (endpoint0 e) p ∧
      Connects f₂ p q ∧
      Connects f₃ q (endpoint1 e)) :
    brokenCount σ ≠ 1 := by
  intro hone
  have hcard : (brokenSet σ).card = 1 := hone
  obtain ⟨e, hsingleton⟩ := Finset.card_eq_one.mp hcard
  obtain ⟨f₁, f₂, f₃, p, q, hf₁e, hf₂e, hf₃e, hc₁, hc₂, hc₃⟩ := alternate e
  have heBroken : σ (endpoint0 e) ≠ σ (endpoint1 e) := by
    have : e ∈ brokenSet σ := by simp [hsingleton]
    simpa [brokenSet] using this
  have hf₁ : σ (endpoint0 f₁) = σ (endpoint1 f₁) := by
    have : f₁ ∉ brokenSet σ := by simp [hsingleton, hf₁e]
    simpa [brokenSet] using this
  have hf₂ : σ (endpoint0 f₂) = σ (endpoint1 f₂) := by
    have : f₂ ∉ brokenSet σ := by simp [hsingleton, hf₂e]
    simpa [brokenSet] using this
  have hf₃ : σ (endpoint0 f₃) = σ (endpoint1 f₃) := by
    have : f₃ ∉ brokenSet σ := by simp [hsingleton, hf₃e]
    simpa [brokenSet] using this
  apply heBroken
  calc
    σ (endpoint0 e) = σ p := value_eq_of_connects_of_not_broken σ hc₁ hf₁
    _ = σ q := value_eq_of_connects_of_not_broken σ hc₂ hf₂
    _ = σ (endpoint1 e) := value_eq_of_connects_of_not_broken σ hc₃ hf₃

end Ising3DCut.NullModel
