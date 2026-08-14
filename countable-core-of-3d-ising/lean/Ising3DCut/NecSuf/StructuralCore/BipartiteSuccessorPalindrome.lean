/-
人手証明の主張「回文性に整数の算術は要らない」
（ラベル `claim_structural_palindrome`）の必要十分版。

具体版の証明で使う性質だけを残す。

  使っている性質                                   なぜ削れないか
  `Fintype V` と `Fintype W`（配位の有限性）        水準集合の元の個数を数えるため。
  `Fintype E` と `DecidableEq E`                    破れ辺集合とその補集合の元の個数を取るため。
  端点写像 `endpoint0, endpoint1 : E → V`           破れの定義が両端の値を参照するため。
  `color (endpoint0 e) ≠ color (endpoint1 e)`       各辺でちょうど一方の端点だけを反転させるため。
  `flip (flip x) = x`                               色反転を対合にするため。
  `flip x ≠ y ↔ x = y` と `x ≠ flip y ↔ x = y`      反転した側の端点がどちらでも、
                                                    反転後の不一致を反転前の一致へ戻すため。

具体版が持っていた次の構造は仮定しない: 方向の添字集合 `I`、始点の部分集合 `A_i`、
後続写像 `succ_i` とその単射性、値が整数 ±1 であること。
辺は「二つの端点写像を備えた有限型」だけでよい。

証明手順は具体版と同じ（対合、各辺の破れの反転、破れ辺集合の補集合化、
破れ数の補数、二つの水準集合の全単射、元の個数の等置）。

住処: 有限型、`Finset`、`Nat`、`Bool` のみ。ℝ / ℂ は現れない。
-/
import Mathlib.Data.Fintype.EquivFin
import Mathlib.Data.Fintype.Pi

namespace Ising3DCut.NecSuf.StructuralCore

variable {V E W : Type} [Fintype V] [DecidableEq V] [Fintype W] [DecidableEq W]
variable [Fintype E] [DecidableEq E]
variable (endpoint0 endpoint1 : E → V) (color : V → Bool) (flip : W → W)

/-- 色が `true` の点だけで値を反転する写像。 -/
def colorFlip (σ : V → W) : V → W :=
  fun a => if color a then flip (σ a) else σ a

/-- 具体版の第一段: 値の反転が対合なら、色反転も対合である。 -/
lemma colorFlip_colorFlip (hflip_flip : ∀ x, flip (flip x) = x) (σ : V → W) :
    colorFlip color flip (colorFlip color flip σ) = σ := by
  funext a
  by_cases h : color a
  · simp [colorFlip, h, hflip_flip]
  · simp [colorFlip, h]

/-- 具体版の第二段: 各辺で破れが一致へ、したがって一致が破れへ移る。 -/
lemma colorFlip_reverses_edge
    (hcolor : ∀ e, color (endpoint0 e) ≠ color (endpoint1 e))
    (hflip_ne : ∀ x y : W, flip x ≠ y ↔ x = y)
    (hne_flip : ∀ x y : W, x ≠ flip y ↔ x = y)
    (σ : V → W) (e : E) :
    colorFlip color flip σ (endpoint0 e) ≠ colorFlip color flip σ (endpoint1 e) ↔
      σ (endpoint0 e) = σ (endpoint1 e) := by
  by_cases h₀ : color (endpoint0 e)
  · have h₁ : color (endpoint1 e) = false := by
      cases h : color (endpoint1 e)
      · exact rfl
      · exact False.elim (hcolor e (h₀.trans h.symm))
    simp [colorFlip, h₀, h₁, hflip_ne]
  · have h₀' : color (endpoint0 e) = false := Bool.eq_false_of_not_eq_true h₀
    have h₁ : color (endpoint1 e) = true := by
      cases h : color (endpoint1 e)
      · exact False.elim (hcolor e (h₀'.trans h.symm))
      · exact rfl
    simp [colorFlip, h₀', h₁, hne_flip]

/-- 破れている辺の有限集合。 -/
def brokenSet (σ : V → W) : Finset E :=
  Finset.univ.filter fun e => σ (endpoint0 e) ≠ σ (endpoint1 e)

/-- 破れ数。 -/
def brokenCount (σ : V → W) : ℕ := (brokenSet endpoint0 endpoint1 σ).card

/-- 具体版の第三段: 色反転で破れ辺集合は補集合になる。 -/
lemma brokenSet_colorFlip
    (hcolor : ∀ e, color (endpoint0 e) ≠ color (endpoint1 e))
    (hflip_ne : ∀ x y : W, flip x ≠ y ↔ x = y)
    (hne_flip : ∀ x y : W, x ≠ flip y ↔ x = y)
    (σ : V → W) :
    brokenSet endpoint0 endpoint1 (colorFlip color flip σ) =
      Finset.univ \ brokenSet endpoint0 endpoint1 σ := by
  ext e
  simp [brokenSet,
    colorFlip_reverses_edge endpoint0 endpoint1 color flip hcolor hflip_ne hne_flip]

/-- 具体版の第四段: 色反転で破れ数は補数になる。 -/
lemma brokenCount_colorFlip
    (hcolor : ∀ e, color (endpoint0 e) ≠ color (endpoint1 e))
    (hflip_ne : ∀ x y : W, flip x ≠ y ↔ x = y)
    (hne_flip : ∀ x y : W, x ≠ flip y ↔ x = y)
    (σ : V → W) :
    brokenCount endpoint0 endpoint1 (colorFlip color flip σ) =
      Fintype.card E - brokenCount endpoint0 endpoint1 σ := by
  rw [brokenCount,
    brokenSet_colorFlip endpoint0 endpoint1 color flip hcolor hflip_ne hne_flip,
    Finset.card_sdiff, Finset.inter_univ, Finset.card_univ, brokenCount]

/-- 破れ数が `m` の配位の有限集合。 -/
def levelSetFinset (m : ℕ) : Finset (V → W) :=
  Finset.univ.filter fun (σ : V → W) => brokenCount endpoint0 endpoint1 σ = m

/-- 破れ数が `m` の配位の有限型。 -/
def LevelSet (m : ℕ) := ↥(levelSetFinset (W := W) endpoint0 endpoint1 m)

instance (m : ℕ) : Fintype (LevelSet (W := W) endpoint0 endpoint1 m) :=
  inferInstanceAs (Fintype ↥(levelSetFinset (W := W) endpoint0 endpoint1 m))

/-- 破れ数が `m` の配位の個数。 -/
def multiplicity (m : ℕ) : ℕ := Fintype.card (LevelSet (W := W) endpoint0 endpoint1 m)

/-- 具体版と同じ、色反転による二つの水準集合の全単射。 -/
def levelSetEquiv
    (hcolor : ∀ e, color (endpoint0 e) ≠ color (endpoint1 e))
    (hflip_flip : ∀ x, flip (flip x) = x)
    (hflip_ne : ∀ x y : W, flip x ≠ y ↔ x = y)
    (hne_flip : ∀ x y : W, x ≠ flip y ↔ x = y)
    {m : ℕ} (h : m ≤ Fintype.card E) :
    LevelSet (W := W) endpoint0 endpoint1 m ≃
      LevelSet (W := W) endpoint0 endpoint1 (Fintype.card E - m) where
  toFun σ := ⟨colorFlip color flip σ.1, by
    apply Finset.mem_filter.mpr
    exact ⟨Finset.mem_univ _, by
      rw [brokenCount_colorFlip endpoint0 endpoint1 color flip hcolor hflip_ne hne_flip,
        (Finset.mem_filter.mp σ.2).2]⟩⟩
  invFun τ := ⟨colorFlip color flip τ.1, by
    apply Finset.mem_filter.mpr
    exact ⟨Finset.mem_univ _, by
      rw [brokenCount_colorFlip endpoint0 endpoint1 color flip hcolor hflip_ne hne_flip,
        (Finset.mem_filter.mp τ.2).2, Nat.sub_sub_self h]⟩⟩
  left_inv σ := Subtype.ext (colorFlip_colorFlip color flip hflip_flip σ.1)
  right_inv τ := Subtype.ext (colorFlip_colorFlip color flip hflip_flip τ.1)

/-- `claim_structural_palindrome` の必要十分版: 多重度の回文性。 -/
theorem multiplicity_palindrome
    (hcolor : ∀ e, color (endpoint0 e) ≠ color (endpoint1 e))
    (hflip_flip : ∀ x, flip (flip x) = x)
    (hflip_ne : ∀ x y : W, flip x ≠ y ↔ x = y)
    (hne_flip : ∀ x y : W, x ≠ flip y ↔ x = y)
    {m : ℕ} (h : m ≤ Fintype.card E) :
    multiplicity (W := W) endpoint0 endpoint1 m =
      multiplicity (W := W) endpoint0 endpoint1 (Fintype.card E - m) := by
  exact Fintype.card_congr
    (levelSetEquiv endpoint0 endpoint1 color flip hcolor hflip_flip hflip_ne hne_flip h)

end Ising3DCut.NecSuf.StructuralCore
