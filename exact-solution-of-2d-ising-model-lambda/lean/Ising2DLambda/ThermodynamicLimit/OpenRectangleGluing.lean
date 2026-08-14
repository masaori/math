/-
章「熱力学極限」の「開境界長方形の接合不等式」の証明のうち、
接合の全単射の段の具体版（人手証明と 1 対 1 に対応させる）。

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
  第二の座標の向き（ρ_B, ρ_T と同様の構成）  …SecondBottom / …SecondTop /
                                            openConfigGlueSecond /
                                            splitSecondBottom_glueSecond /
                                            splitSecondTop_glueSecond /
                                            glueSecond_splitSecond /
                                            openConfigGlueEquivSecond

住処: 配位は有限集合 `Σ^op` の元であり、可算側で閉じる。ℝ / ℂ は現れない。
破れボンド数の接合面分解と、実数で評価した上下の不等式は後続のセクションで扱う。

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

end Ising2DLambda.ThermodynamicLimit
