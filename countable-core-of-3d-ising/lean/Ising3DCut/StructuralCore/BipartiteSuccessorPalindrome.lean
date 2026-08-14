/-
人手証明の主張「回文性に整数の算術は要らない」
（ラベル `claim_structural_palindrome`）の具体版。

人手証明とこのファイルの対応:

  有限集合 V、方向 I、部分後続写像、二色塗り分け   `BipartiteSuccessorSystem`
  辺 E と二つの端点写像                             `StructuralEdge`, `endpoint0`, `endpoint1`
  色 1 の点だけを反転する T                          `colorFlip`
  T(Tσ) = σ                                           `colorFlip_colorFlip`
  各辺で破れが反転                                   `colorFlip_reverses_edge`
  D(Tσ) = E \ D(σ)                                   `brokenSet_colorFlip`
  b(Tσ) = #E - b(σ)                                  `brokenCount_colorFlip`
  T による二つの水準集合の全単射                    `levelSetEquiv`
  Ω_E(m) = Ω_E(#E-m)                                 `multiplicity_palindrome`

人手証明と同じく、後続写像の単射性は系の定義には含めるが、回文性の証明では使わない。
住処: 有限型、`Finset`、`Nat`、`Bool`、整数 ±1 のみ。ℝ / ℂ は現れない。
-/
import Ising3DCut.NullModel.MultiplicityPalindrome

namespace Ising3DCut.StructuralCore

open Ising3DCut.NullModel

noncomputable section

/-- 人手証明の「有限二部後続系」。 -/
structure BipartiteSuccessorSystem (V I : Type) [Fintype V] [Fintype I]
    [DecidableEq V] where
  domain : I → Finset V
  succ : I → V → V
  succ_injective : ∀ i, Set.InjOn (succ i) ↑(domain i)
  color : V → Bool
  color_diff : ∀ i a, a ∈ domain i → color a ≠ color (succ i a)

variable {V I : Type} [Fintype V] [Fintype I] [DecidableEq V] [DecidableEq I]
variable (S : BipartiteSuccessorSystem V I)

/-- 辺 `(a,i)` は `a ∈ A_i` を満たす始点と方向の組。 -/
def StructuralEdge := {p : V × I // p.1 ∈ S.domain p.2}

instance : Fintype (StructuralEdge S) :=
  inferInstanceAs (Fintype {p : V × I // p.1 ∈ S.domain p.2})
instance : DecidableEq (StructuralEdge S) :=
  inferInstanceAs (DecidableEq {p : V × I // p.1 ∈ S.domain p.2})

/-- 辺の第一端点。 -/
def endpoint0 (e : StructuralEdge S) : V := e.1.1

/-- 辺の第二端点。 -/
def endpoint1 (e : StructuralEdge S) : V := S.succ e.1.2 e.1.1

/-- 有限二部後続系の配位。 -/
def Config := V → Spin

instance : Fintype (Config (V := V)) := inferInstanceAs (Fintype (V → Spin))

/-- 色 1 の点だけで値を反転する写像 `T`。 -/
def colorFlip (σ : Config (V := V)) : Config (V := V) :=
  fun a => if S.color a then negSpin (σ a) else σ a

/-- 人手証明の第一段: `T` は対合である。 -/
lemma colorFlip_colorFlip (σ : Config (V := V)) :
    colorFlip S (colorFlip S σ) = σ := by
  funext a
  by_cases h : S.color a
  · simp [colorFlip, h, negSpin_negSpin]
  · simp [colorFlip, h]

/-- 人手証明の第二段: 各辺で破れが一致へ、したがって一致が破れへ移る。 -/
lemma colorFlip_reverses_edge (σ : Config (V := V)) (e : StructuralEdge S) :
    colorFlip S σ (endpoint0 S e) ≠ colorFlip S σ (endpoint1 S e) ↔
      σ (endpoint0 S e) = σ (endpoint1 S e) := by
  have hdiff : S.color (endpoint0 S e) ≠ S.color (endpoint1 S e) :=
    S.color_diff e.1.2 e.1.1 e.2
  by_cases h₀ : S.color (endpoint0 S e)
  · have h₁ : S.color (endpoint1 S e) = false := by
      cases h : S.color (endpoint1 S e)
      · exact rfl
      · exact False.elim (hdiff (h₀.trans h.symm))
    simp [colorFlip, h₀, h₁, negSpin_ne_iff_eq]
  · have h₀' : S.color (endpoint0 S e) = false := Bool.eq_false_of_not_eq_true h₀
    have h₁ : S.color (endpoint1 S e) = true := by
      cases h : S.color (endpoint1 S e)
      · exact False.elim (hdiff (h₀'.trans h.symm))
      · exact rfl
    simp [colorFlip, h₀', h₁, ne_negSpin_iff_eq]

/-- 破れている辺の有限集合 `D(σ)`。 -/
def brokenSet (σ : Config (V := V)) : Finset (StructuralEdge S) :=
  Finset.univ.filter fun e => σ (endpoint0 S e) ≠ σ (endpoint1 S e)

/-- 破れ数 `b(σ)=#D(σ)`。 -/
def brokenCount (σ : Config (V := V)) : ℕ := (brokenSet S σ).card

/-- 人手証明の第三段: `D(Tσ)=E\D(σ)`。 -/
lemma brokenSet_colorFlip (σ : Config (V := V)) :
    brokenSet S (colorFlip S σ) = Finset.univ \ brokenSet S σ := by
  ext e
  simp [brokenSet, colorFlip_reverses_edge]

/-- 人手証明の第四段: `b(Tσ)=#E-b(σ)`。 -/
lemma brokenCount_colorFlip (σ : Config (V := V)) :
    brokenCount S (colorFlip S σ) = Fintype.card (StructuralEdge S) - brokenCount S σ := by
  rw [brokenCount, brokenSet_colorFlip, Finset.card_sdiff, Finset.inter_univ,
    Finset.card_univ, brokenCount]

/-- 破れ数が `m` の配位の有限集合。 -/
def levelSetFinset (m : ℕ) : Finset (Config (V := V)) :=
  Finset.univ.filter fun σ => brokenCount S σ = m

/-- 人手証明の `S_m`。 -/
def LevelSet (m : ℕ) := ↥(levelSetFinset S m)

instance (m : ℕ) : Fintype (LevelSet S m) :=
  inferInstanceAs (Fintype ↥(levelSetFinset S m))

/-- 有限二部後続系の多重度 `Ω_E(m)=#S_m`。 -/
def multiplicity (m : ℕ) : ℕ := Fintype.card (LevelSet S m)

/-- 人手証明の、色反転による二つの水準集合の全単射。 -/
def levelSetEquiv {m : ℕ} (h : m ≤ Fintype.card (StructuralEdge S)) :
    LevelSet S m ≃ LevelSet S (Fintype.card (StructuralEdge S) - m) where
  toFun σ := ⟨colorFlip S σ.1, by
    apply Finset.mem_filter.mpr
    exact ⟨Finset.mem_univ _, by
      rw [brokenCount_colorFlip, (Finset.mem_filter.mp σ.2).2]⟩⟩
  invFun τ := ⟨colorFlip S τ.1, by
    apply Finset.mem_filter.mpr
    exact ⟨Finset.mem_univ _, by
      rw [brokenCount_colorFlip, (Finset.mem_filter.mp τ.2).2, Nat.sub_sub_self h]⟩⟩
  left_inv σ := Subtype.ext (colorFlip_colorFlip S σ.1)
  right_inv τ := Subtype.ext (colorFlip_colorFlip S τ.1)

/-- `claim_structural_palindrome` の具体版。 -/
theorem multiplicity_palindrome {m : ℕ} (h : m ≤ Fintype.card (StructuralEdge S)) :
    multiplicity S m = multiplicity S (Fintype.card (StructuralEdge S) - m) := by
  exact Fintype.card_congr (levelSetEquiv S h)

end

end Ising3DCut.StructuralCore
