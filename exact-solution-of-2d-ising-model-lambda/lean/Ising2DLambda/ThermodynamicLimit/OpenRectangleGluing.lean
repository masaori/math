/-
章「熱力学極限」の「開境界長方形の接合不等式」の証明のうち、
接合の全単射と、破れボンド数の接合面分解の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts` の
`claim_open_rectangle_gluing_inequality` の証明の前半である。

  人手証明の段                              このファイル
  制限 ρ_L(i,j) := ρ(i,j)                   openConfigSplitFirstLeft
  制限 ρ_R(i,j) := ρ(a+i,j)                 openConfigSplitFirstRight
  接合 ρ_{σ,τ}（i<a で σ、a≤i で τ）        openConfigGlueFirst
  「二つの構成を順に行うと各頂点で元の値に戻る」
    （σ,τ から接いで制限すると σ に戻る）   splitFirstLeft_glueFirst
    （σ,τ から接いで制限すると τ に戻る）   splitFirstRight_glueFirst
    （ρ を制限して接ぐと ρ に戻る）         glueFirst_splitFirst
  全単射 Σ^op_{a,b}×Σ^op_{c,b} ↔ Σ^op_{a+c,b}  openConfigGlueEquivFirst
  接合面の破れ辺数 s^↔                 openSeamBrokenCountFirst
  b^op_{a+c,b} = b^op_{a,b}+b^op_{c,b}+s^↔
                                             openBrokenBondCount_glueFirst
  第二の座標の向き（ρ_B, ρ_T と同様の構成）  …SecondBottom / …SecondTop /
                                            openConfigGlueSecond /
                                            splitSecondBottom_glueSecond /
                                            splitSecondTop_glueSecond /
                                            glueSecond_splitSecond /
                                            openConfigGlueEquivSecond
  接合面の破れ辺数 s^↕ と同じ分解       openSeamBrokenCountSecond /
                                             openBrokenBondCount_glueSecond

住処: 配位は有限集合 `Σ^op` の元であり、可算側で閉じる。ℝ / ℂ は現れない。
実数で評価した上下の不等式は後続のセクションで扱う。

人手証明との対応の注意:
- 人手証明の場合分け「0 ≤ i < a では σ(i,j)、a ≤ i < a+c では τ(i-a,j)」は
  `dite (i < a)` で書き、切り捨て減法 `i - a` をそのまま使う（本文どおり）。
- 「各頂点で元の値に戻る」は、頂点の第一座標での場合分け（`dif_pos` / `dif_neg`）と、
  自然数の初等計算（`a + i - a = i`、`a + (i - a) = i`）だけで示す。
  omega は不等式・切り捨て減法のこの初等計算にのみ使う。
-/
import Ising2DLambda.ThermodynamicLimit.OpenRectangle

namespace Ising2DLambda.ThermodynamicLimit

variable (a b c : ℕ)

/-- 第一の座標の向きの接合の左側への制限 `ρ_L(i,j) := ρ(i,j)`（`0 ≤ i < a`）。 -/
def openConfigSplitFirstLeft (ρ : OpenConfig (a + c) b) : OpenConfig a b :=
  fun v => ρ (⟨v.1.val, by have := v.1.isLt; omega⟩, v.2)

/-- 第一の座標の向きの接合の右側への制限 `ρ_R(i,j) := ρ(a+i,j)`（`0 ≤ i < c`）。 -/
def openConfigSplitFirstRight (ρ : OpenConfig (a + c) b) : OpenConfig c b :=
  fun v => ρ (⟨a + v.1.val, by have := v.1.isLt; omega⟩, v.2)

/-- 第一の座標の向きの接合 `ρ_{σ,τ}`: `i < a` なら `σ(i,j)`、`a ≤ i < a+c` なら `τ(i-a,j)`。 -/
def openConfigGlueFirst (σ : OpenConfig a b) (τ : OpenConfig c b) :
    OpenConfig (a + c) b :=
  fun v =>
    if h : v.1.val < a then σ (⟨v.1.val, h⟩, v.2)
    else τ (⟨v.1.val - a, by have := v.1.isLt; omega⟩, v.2)

/-- 接いでから左側へ制限すると `σ` に戻る（各頂点の第一座標は `i < a` なので
`σ` の枝が返り、頂点は元のまま）。 -/
lemma splitFirstLeft_glueFirst (σ : OpenConfig a b) (τ : OpenConfig c b) :
    openConfigSplitFirstLeft a b c (openConfigGlueFirst a b c σ τ) = σ := by
  funext v
  exact dif_pos v.1.isLt

/-- 接いでから右側へ制限すると `τ` に戻る（各頂点の第一座標は `a + i ≥ a` なので
`τ` の枝が返り、`a + i - a = i` で頂点が戻る）。 -/
lemma splitFirstRight_glueFirst (σ : OpenConfig a b) (τ : OpenConfig c b) :
    openConfigSplitFirstRight a b c (openConfigGlueFirst a b c σ τ) = τ := by
  funext v
  refine Eq.trans (dif_neg (show ¬ (a + v.1.val < a) from by omega)) ?_
  show τ (⟨a + v.1.val - a, _⟩, v.2) = τ v
  simp only [show a + v.1.val - a = v.1.val from by omega]
  rfl

/-- 制限してから接ぐと `ρ` に戻る（第一座標が `i < a` か `a ≤ i` かで場合を分け、
後者は `a + (i - a) = i` で頂点が戻る）。 -/
lemma glueFirst_splitFirst (ρ : OpenConfig (a + c) b) :
    openConfigGlueFirst a b c
      (openConfigSplitFirstLeft a b c ρ) (openConfigSplitFirstRight a b c ρ) = ρ := by
  funext v
  by_cases h : v.1.val < a
  · exact dif_pos h
  · refine Eq.trans (dif_neg h) ?_
    show ρ (⟨a + (v.1.val - a), _⟩, v.2) = ρ v
    simp only [show a + (v.1.val - a) = v.1.val from by omega]
    rfl

/-- 全単射 `Σ^op_{a,b} × Σ^op_{c,b} ↔ Σ^op_{a+c,b}`（第一の座標の向きの接合）。
人手証明の「二つの構成を順に行うと各頂点で元の値に戻るので、これは全単射」にあたる。 -/
def openConfigGlueEquivFirst : OpenConfig a b × OpenConfig c b ≃ OpenConfig (a + c) b where
  toFun p := openConfigGlueFirst a b c p.1 p.2
  invFun ρ :=
    (openConfigSplitFirstLeft a b c ρ, openConfigSplitFirstRight a b c ρ)
  left_inv p :=
    Prod.ext (splitFirstLeft_glueFirst a b c p.1 p.2)
      (splitFirstRight_glueFirst a b c p.1 p.2)
  right_inv ρ := glueFirst_splitFirst a b c ρ

/-- 第二の座標の向きの接合の下側への制限 `ρ_B(i,j) := ρ(i,j)`（`0 ≤ j < b`）。 -/
def openConfigSplitSecondBottom (ρ : OpenConfig a (b + c)) : OpenConfig a b :=
  fun v => ρ (v.1, ⟨v.2.val, by have := v.2.isLt; omega⟩)

/-- 第二の座標の向きの接合の上側への制限 `ρ_T(i,j) := ρ(i,b+j)`（`0 ≤ j < c`）。 -/
def openConfigSplitSecondTop (ρ : OpenConfig a (b + c)) : OpenConfig a c :=
  fun v => ρ (v.1, ⟨b + v.2.val, by have := v.2.isLt; omega⟩)

/-- 第二の座標の向きの接合: `j < b` なら `σ(i,j)`、`b ≤ j < b+c` なら `τ(i,j-b)`。 -/
def openConfigGlueSecond (σ : OpenConfig a b) (τ : OpenConfig a c) :
    OpenConfig a (b + c) :=
  fun v =>
    if h : v.2.val < b then σ (v.1, ⟨v.2.val, h⟩)
    else τ (v.1, ⟨v.2.val - b, by have := v.2.isLt; omega⟩)

/-- 接いでから下側へ制限すると `σ` に戻る（第二座標 `j < b` で `σ` の枝が返る）。 -/
lemma splitSecondBottom_glueSecond (σ : OpenConfig a b) (τ : OpenConfig a c) :
    openConfigSplitSecondBottom a b c (openConfigGlueSecond a b c σ τ) = σ := by
  funext v
  exact dif_pos v.2.isLt

/-- 接いでから上側へ制限すると `τ` に戻る（第二座標 `b + j ≥ b` で `τ` の枝が返り、
`b + j - b = j` で頂点が戻る）。 -/
lemma splitSecondTop_glueSecond (σ : OpenConfig a b) (τ : OpenConfig a c) :
    openConfigSplitSecondTop a b c (openConfigGlueSecond a b c σ τ) = τ := by
  funext v
  refine Eq.trans (dif_neg (show ¬ (b + v.2.val < b) from by omega)) ?_
  show τ (v.1, ⟨b + v.2.val - b, _⟩) = τ v
  simp only [show b + v.2.val - b = v.2.val from by omega]
  rfl

/-- 制限してから接ぐと `ρ` に戻る（第二座標が `j < b` か `b ≤ j` かで場合を分け、
後者は `b + (j - b) = j` で頂点が戻る）。 -/
lemma glueSecond_splitSecond (ρ : OpenConfig a (b + c)) :
    openConfigGlueSecond a b c
      (openConfigSplitSecondBottom a b c ρ) (openConfigSplitSecondTop a b c ρ) = ρ := by
  funext v
  by_cases h : v.2.val < b
  · exact dif_pos h
  · refine Eq.trans (dif_neg h) ?_
    show ρ (v.1, ⟨b + (v.2.val - b), _⟩) = ρ v
    simp only [show b + (v.2.val - b) = v.2.val from by omega]
    rfl

/-- 全単射 `Σ^op_{a,b} × Σ^op_{a,c} ↔ Σ^op_{a,b+c}`（第二の座標の向きの接合）。 -/
def openConfigGlueEquivSecond : OpenConfig a b × OpenConfig a c ≃ OpenConfig a (b + c) where
  toFun p := openConfigGlueSecond a b c p.1 p.2
  invFun ρ :=
    (openConfigSplitSecondBottom a b c ρ, openConfigSplitSecondTop a b c ρ)
  left_inv p :=
    Prod.ext (splitSecondBottom_glueSecond a b c p.1 p.2)
      (splitSecondTop_glueSecond a b c p.1 p.2)
  right_inv ρ := glueSecond_splitSecond a b c ρ

/-- 横向きの破れ辺だけを数えた数。辺の向きごとの分解を明示する補助量。 -/
def openHorizontalBrokenCount (σ : OpenConfig a b) : ℕ :=
  (Finset.univ.filter fun e : OpenEdgeH a b =>
    σ e.val ≠ σ (e.val.1, ⟨e.val.2.val + 1, e.property⟩)).card

/-- 縦向きの破れ辺だけを数えた数。辺の向きごとの分解を明示する補助量。 -/
def openVerticalBrokenCount (σ : OpenConfig a b) : ℕ :=
  (Finset.univ.filter fun e : OpenEdgeV a b =>
    σ e.val ≠ σ (⟨e.val.1.val + 1, e.property⟩, e.val.2)).card

private lemma card_filter_univ_eq_sum_indicator {α : Type} [Fintype α] [DecidableEq α]
    (p : α → Prop) [DecidablePred p] :
    (Finset.univ.filter p).card = ∑ x : α, if p x then 1 else 0 := by
  rw [Finset.card_filter]

/-- 第一座標方向の接合面で破れる辺の本数 `s^↔`。 -/
def openSeamBrokenCountFirst (ha : 0 < a) (hc : 0 < c)
    (σ : OpenConfig a b) (τ : OpenConfig c b) : ℕ :=
  (Finset.univ.filter fun j : Fin b =>
    σ (⟨a - 1, by omega⟩, j) ≠ τ (⟨0, hc⟩, j)).card

lemma openSeamBrokenCountFirst_le (ha : 0 < a) (hc : 0 < c)
    (σ : OpenConfig a b) (τ : OpenConfig c b) :
    openSeamBrokenCountFirst a b c ha hc σ τ ≤ b := by
  exact le_trans (Finset.card_filter_le _ _) (by simp)

/-- 第一座標方向に接ぐ前の辺、右側の辺、接合面の辺を、接合後の辺へ埋め込む。 -/
def openEdgeJoinFirst (ha : 0 < a) (hc : 0 < c) :
    OpenEdge a b ⊕ (OpenEdge c b ⊕ Fin b) → OpenEdge (a + c) b
  | Sum.inl (Sum.inl e) => Sum.inl ⟨(⟨e.val.1.val, by omega⟩, e.val.2), e.property⟩
  | Sum.inl (Sum.inr e) => Sum.inr ⟨(⟨e.val.1.val, by
      have hi := e.val.1.isLt
      omega⟩, e.val.2), by
        show e.val.1.val + 1 < a + c
        have he := e.property
        omega⟩
  | Sum.inr (Sum.inl (Sum.inl e)) =>
      Sum.inl ⟨(⟨a + e.val.1.val, by omega⟩, e.val.2), e.property⟩
  | Sum.inr (Sum.inl (Sum.inr e)) =>
      Sum.inr ⟨(⟨a + e.val.1.val, by
        have hi := e.val.1.isLt
        omega⟩, e.val.2), by
          show a + e.val.1.val + 1 < a + c
          have he := e.property
          omega⟩
  | Sum.inr (Sum.inr j) =>
      Sum.inr ⟨(⟨a - 1, by omega⟩, j), by
        show a - 1 + 1 < a + c
        calc
          a - 1 + 1 = a := Nat.sub_add_cancel (Nat.one_le_iff_ne_zero.mpr (Nat.ne_of_gt ha))
          _ < a + c := by omega⟩

/-- 接合後の辺を、左側、右側、接合面のいずれかへ戻す。 -/
def openEdgeSplitFirst (_ha : 0 < a) (hc : 0 < c) :
    OpenEdge (a + c) b → OpenEdge a b ⊕ (OpenEdge c b ⊕ Fin b)
  | Sum.inl e =>
      if h : e.val.1.val < a then
        Sum.inl (Sum.inl ⟨(⟨e.val.1.val, h⟩, e.val.2), e.property⟩)
      else
        Sum.inr (Sum.inl (Sum.inl
          ⟨(⟨e.val.1.val - a, by omega⟩, e.val.2), e.property⟩))
  | Sum.inr e =>
      if hL : e.val.1.val + 1 < a then
        Sum.inl (Sum.inr ⟨(⟨e.val.1.val, by omega⟩, e.val.2), hL⟩)
      else if hS : e.val.1.val + 1 = a then
        Sum.inr (Sum.inr e.val.2)
      else
        Sum.inr (Sum.inl (Sum.inr
          ⟨(⟨e.val.1.val - a, by
            have hi := e.val.1.isLt
            omega⟩, e.val.2), by
              show e.val.1.val - a + 1 < c
              have he := e.property
              omega⟩))

/-- 接合前の三つの互いに交わらない辺集合と、接合後の辺集合との全単射。 -/
def openEdgeJoinEquivFirst (ha : 0 < a) (hc : 0 < c) :
    OpenEdge a b ⊕ (OpenEdge c b ⊕ Fin b) ≃ OpenEdge (a + c) b where
  toFun := openEdgeJoinFirst a b c ha hc
  invFun := openEdgeSplitFirst a b c ha hc
  left_inv := by
    intro e
    rcases e with (e | e)
    · rcases e with (e | e)
      · simp [openEdgeJoinFirst, openEdgeSplitFirst]
      · have he := e.property
        simp [openEdgeJoinFirst, openEdgeSplitFirst, he]
    · rcases e with (e | j)
      · rcases e with (e | e)
        · have hi := e.val.1.isLt
          simp [openEdgeJoinFirst, openEdgeSplitFirst, show ¬a + e.val.1.val < a by omega]
        · have hi := e.val.1.isLt
          have he := e.property
          simp [openEdgeJoinFirst, openEdgeSplitFirst,
            show ¬a + e.val.1.val + 1 < a by omega,
            show ¬a + e.val.1.val + 1 = a by omega]
      · have hEq : a - 1 + 1 = a := by omega
        simp [openEdgeJoinFirst, openEdgeSplitFirst, hEq]
  right_inv := by
    intro e
    rcases e with (e | e)
    · by_cases h : e.val.1.val < a
      · simp [openEdgeSplitFirst, openEdgeJoinFirst, h]
      · simp [openEdgeSplitFirst, openEdgeJoinFirst, h]
        apply congrArg Sum.inl
        apply Subtype.ext
        apply Prod.ext
        · apply Fin.ext
          change a + (e.val.1.val - a) = e.val.1.val
          omega
        · rfl
    · by_cases hL : e.val.1.val + 1 < a
      · simp [openEdgeSplitFirst, openEdgeJoinFirst, hL]
      · by_cases hS : e.val.1.val + 1 = a
        · simp [openEdgeSplitFirst, openEdgeJoinFirst, hS]
          apply congrArg Sum.inr
          apply Subtype.ext
          apply Prod.ext
          · apply Fin.ext
            change a - 1 = e.val.1.val
            omega
          · rfl
        · simp [openEdgeSplitFirst, openEdgeJoinFirst, hL, hS]
          apply congrArg Sum.inr
          apply Subtype.ext
          apply Prod.ext
          · apply Fin.ext
            change a + (e.val.1.val - a) = e.val.1.val
            omega
          · rfl

/-- 破れボンド集合を向きの印 `Sum.inl` / `Sum.inr` で分けると、
破れボンド数は横向きと縦向きの破れ辺数の和になる。 -/
lemma openBrokenBondCount_eq_oriented (σ : OpenConfig a b) :
    openBrokenBondCount a b σ =
      openHorizontalBrokenCount a b σ + openVerticalBrokenCount a b σ := by
  let pH : OpenEdgeH a b → Prop := fun e =>
    σ e.val ≠ σ (e.val.1, ⟨e.val.2.val + 1, e.property⟩)
  let pV : OpenEdgeV a b → Prop := fun e =>
    σ e.val ≠ σ (⟨e.val.1.val + 1, e.property⟩, e.val.2)
  change (Finset.univ.filter fun e : OpenEdgeH a b ⊕ OpenEdgeV a b =>
      σ (openBoundary0 a b e) ≠ σ (openBoundary1 a b e)).card =
    (Finset.univ.filter pH).card + (Finset.univ.filter pV).card
  rw [card_filter_univ_eq_sum_indicator, card_filter_univ_eq_sum_indicator,
    card_filter_univ_eq_sum_indicator, Fintype.sum_sum_type]
  rfl

private lemma openEdgeJoinFirst_broken_left (ha : 0 < a) (hc : 0 < c)
    (σ : OpenConfig a b) (τ : OpenConfig c b) (e : OpenEdge a b) :
    (openConfigGlueFirst a b c σ τ
        (openBoundary0 (a + c) b (openEdgeJoinFirst a b c ha hc (Sum.inl e))) ≠
      openConfigGlueFirst a b c σ τ
        (openBoundary1 (a + c) b (openEdgeJoinFirst a b c ha hc (Sum.inl e)))) ↔
      σ (openBoundary0 a b e) ≠ σ (openBoundary1 a b e) := by
  rcases e with (e | e)
  · simp [openEdgeJoinFirst, openConfigGlueFirst, openBoundary0, openBoundary1]
  · have he := e.property
    simp [openEdgeJoinFirst, openConfigGlueFirst, openBoundary0, openBoundary1, he]

private lemma openEdgeJoinFirst_broken_right (ha : 0 < a) (hc : 0 < c)
    (σ : OpenConfig a b) (τ : OpenConfig c b) (e : OpenEdge c b) :
    (openConfigGlueFirst a b c σ τ
        (openBoundary0 (a + c) b
          (openEdgeJoinFirst a b c ha hc (Sum.inr (Sum.inl e)))) ≠
      openConfigGlueFirst a b c σ τ
        (openBoundary1 (a + c) b
          (openEdgeJoinFirst a b c ha hc (Sum.inr (Sum.inl e))))) ↔
      τ (openBoundary0 c b e) ≠ τ (openBoundary1 c b e) := by
  rcases e with (e | e)
  · have hi := e.val.1.isLt
    simp [openEdgeJoinFirst, openConfigGlueFirst, openBoundary0, openBoundary1,
      show ¬a + e.val.1.val < a by omega]
  · have hi := e.val.1.isLt
    have he := e.property
    simp [openEdgeJoinFirst, openConfigGlueFirst, openBoundary0, openBoundary1,
      show ¬a + e.val.1.val < a by omega,
      show ¬a + e.val.1.val + 1 < a by omega,
      show a + e.val.1.val + 1 - a = e.val.1.val + 1 by omega]

private lemma openEdgeJoinFirst_broken_seam (ha : 0 < a) (hc : 0 < c)
    (σ : OpenConfig a b) (τ : OpenConfig c b) (j : Fin b) :
    (openConfigGlueFirst a b c σ τ
        (openBoundary0 (a + c) b
          (openEdgeJoinFirst a b c ha hc (Sum.inr (Sum.inr j)))) ≠
      openConfigGlueFirst a b c σ τ
        (openBoundary1 (a + c) b
          (openEdgeJoinFirst a b c ha hc (Sum.inr (Sum.inr j))))) ↔
      σ (⟨a - 1, by omega⟩, j) ≠ τ (⟨0, hc⟩, j) := by
  have hEq : a - 1 + 1 = a := Nat.sub_add_cancel
    (Nat.one_le_iff_ne_zero.mpr (Nat.ne_of_gt ha))
  simp [openEdgeJoinFirst, openConfigGlueFirst, openBoundary0, openBoundary1, hEq, ha]

/-- 第一座標方向へ接いだ配位の破れボンド集合は、左側、右側、接合面の
三つの互いに交わらない部分へ分かれる。 -/
theorem openBrokenBondCount_glueFirst (ha : 0 < a) (hc : 0 < c)
    (σ : OpenConfig a b) (τ : OpenConfig c b) :
    openBrokenBondCount (a + c) b (openConfigGlueFirst a b c σ τ) =
      openBrokenBondCount a b σ + openBrokenBondCount c b τ +
        openSeamBrokenCountFirst a b c ha hc σ τ := by
  rw [openBrokenBondCount, openBrokenBondSet, card_filter_univ_eq_sum_indicator]
  rw [← Fintype.sum_equiv (openEdgeJoinEquivFirst a b c ha hc)
    (fun e => if openConfigGlueFirst a b c σ τ
        (openBoundary0 (a + c) b (openEdgeJoinFirst a b c ha hc e)) ≠
      openConfigGlueFirst a b c σ τ
        (openBoundary1 (a + c) b (openEdgeJoinFirst a b c ha hc e)) then 1 else 0)
    (fun e => if openConfigGlueFirst a b c σ τ (openBoundary0 (a + c) b e) ≠
      openConfigGlueFirst a b c σ τ (openBoundary1 (a + c) b e) then 1 else 0)
    (fun _ => rfl)]
  rw [Fintype.sum_sum_type, Fintype.sum_sum_type]
  rw [openBrokenBondCount, openBrokenBondSet, card_filter_univ_eq_sum_indicator,
    openBrokenBondCount, openBrokenBondSet, card_filter_univ_eq_sum_indicator,
    openSeamBrokenCountFirst, card_filter_univ_eq_sum_indicator]
  simp_rw [openEdgeJoinFirst_broken_left, openEdgeJoinFirst_broken_right,
    openEdgeJoinFirst_broken_seam]
  omega

/-- 二つの座標を交換した配位。 -/
def openConfigTranspose (σ : OpenConfig a b) : OpenConfig b a :=
  fun v => σ (v.2, v.1)

/-- 座標交換は横向き辺と縦向き辺を交換する。 -/
def openEdgeTranspose : OpenEdge a b ≃ OpenEdge b a where
  toFun
    | Sum.inl e => Sum.inr ⟨(e.val.2, e.val.1), e.property⟩
    | Sum.inr e => Sum.inl ⟨(e.val.2, e.val.1), e.property⟩
  invFun
    | Sum.inl e => Sum.inr ⟨(e.val.2, e.val.1), e.property⟩
    | Sum.inr e => Sum.inl ⟨(e.val.2, e.val.1), e.property⟩
  left_inv := by rintro (e | e) <;> rfl
  right_inv := by rintro (e | e) <;> rfl

private lemma openEdgeTranspose_broken (σ : OpenConfig a b) (e : OpenEdge a b) :
    (openConfigTranspose a b σ (openBoundary0 b a (openEdgeTranspose a b e)) ≠
      openConfigTranspose a b σ (openBoundary1 b a (openEdgeTranspose a b e))) ↔
      σ (openBoundary0 a b e) ≠ σ (openBoundary1 a b e) := by
  rcases e with (e | e) <;> rfl

/-- 座標を交換しても、各辺とその両端が一対一に対応するので破れボンド数は変わらない。 -/
lemma openBrokenBondCount_transpose (σ : OpenConfig a b) :
    openBrokenBondCount b a (openConfigTranspose a b σ) = openBrokenBondCount a b σ := by
  rw [openBrokenBondCount, openBrokenBondSet, card_filter_univ_eq_sum_indicator,
    openBrokenBondCount, openBrokenBondSet, card_filter_univ_eq_sum_indicator]
  rw [← Fintype.sum_equiv (openEdgeTranspose a b)
    (fun e => if openConfigTranspose a b σ
        (openBoundary0 b a (openEdgeTranspose a b e)) ≠
      openConfigTranspose a b σ
        (openBoundary1 b a (openEdgeTranspose a b e)) then 1 else 0)
    (fun e => if openConfigTranspose a b σ (openBoundary0 b a e) ≠
      openConfigTranspose a b σ (openBoundary1 b a e) then 1 else 0)
    (fun _ => rfl)]
  simp_rw [openEdgeTranspose_broken]

/-- 第二座標方向の接合面で破れる辺の本数 `s^↕`。 -/
def openSeamBrokenCountSecond (hb : 0 < b) (hc : 0 < c)
    (σ : OpenConfig a b) (τ : OpenConfig a c) : ℕ :=
  (Finset.univ.filter fun i : Fin a =>
    σ (i, ⟨b - 1, by omega⟩) ≠ τ (i, ⟨0, hc⟩)).card

lemma openSeamBrokenCountSecond_le (hb : 0 < b) (hc : 0 < c)
    (σ : OpenConfig a b) (τ : OpenConfig a c) :
    openSeamBrokenCountSecond a b c hb hc σ τ ≤ a := by
  exact le_trans (Finset.card_filter_le _ _) (by simp)

private lemma openConfigTranspose_glueSecond (σ : OpenConfig a b) (τ : OpenConfig a c) :
    openConfigTranspose a (b + c) (openConfigGlueSecond a b c σ τ) =
      openConfigGlueFirst b a c (openConfigTranspose a b σ) (openConfigTranspose a c τ) := by
  funext v
  rfl

private lemma openSeamBrokenCountFirst_transpose (hb : 0 < b) (hc : 0 < c)
    (σ : OpenConfig a b) (τ : OpenConfig a c) :
    openSeamBrokenCountFirst b a c hb hc
        (openConfigTranspose a b σ) (openConfigTranspose a c τ) =
      openSeamBrokenCountSecond a b c hb hc σ τ := by
  rfl

/-- 第二座標方向へ接いだ配位についても、座標交換を介して、破れボンド集合は
下側、上側、接合面の三つへ互いに交わらず分かれる。 -/
theorem openBrokenBondCount_glueSecond (hb : 0 < b) (hc : 0 < c)
    (σ : OpenConfig a b) (τ : OpenConfig a c) :
    openBrokenBondCount a (b + c) (openConfigGlueSecond a b c σ τ) =
      openBrokenBondCount a b σ + openBrokenBondCount a c τ +
        openSeamBrokenCountSecond a b c hb hc σ τ := by
  calc
    _ = openBrokenBondCount (b + c) a
        (openConfigTranspose a (b + c) (openConfigGlueSecond a b c σ τ)) :=
      (openBrokenBondCount_transpose a (b + c) _).symm
    _ = openBrokenBondCount (b + c) a
        (openConfigGlueFirst b a c (openConfigTranspose a b σ)
          (openConfigTranspose a c τ)) := by rw [openConfigTranspose_glueSecond]
    _ = openBrokenBondCount b a (openConfigTranspose a b σ) +
          openBrokenBondCount c a (openConfigTranspose a c τ) +
          openSeamBrokenCountFirst b a c hb hc
            (openConfigTranspose a b σ) (openConfigTranspose a c τ) :=
      openBrokenBondCount_glueFirst b a c hb hc _ _
    _ = _ := by
      rw [openBrokenBondCount_transpose, openBrokenBondCount_transpose,
        openSeamBrokenCountFirst_transpose]

end Ising2DLambda.ThermodynamicLimit
