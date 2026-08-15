/-
章「熱力学極限」の「周期境界と開境界の境界評価」の証明のうち、
頂点の対応と配位の全単射の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts` の
`claim_periodic_open_boundary_comparison` の証明の前半である。

  人手証明の段                                このファイル
  頂点の対応 v_L(i,j) := (s(i), s(j))          periodicVertexToOpen
  逆写像 (p,q) ↦ (π(p), π(q))                  openVertexToPeriodic
  s(π(p)) = p（除法の原理の一意性）            periodicVertexToOpen_openVertexToPeriodic
  π(s(y)) = y                                  openVertexToPeriodic_periodicVertexToOpen
  v_L は全単射                                 periodicOpenVertexEquiv
  配位の読み替え r_L(τ) := τ ∘ v_L             openConfigToPeriodic
  逆写像 σ ↦ σ ∘ (v_L の逆写像)                periodicConfigToOpen
  往復して戻ること（τ 側）                     periodicConfigToOpen_openConfigToPeriodic
  往復して戻ること（σ 側）                     openConfigToPeriodic_periodicConfigToOpen
  r_L は全単射                                 periodicOpenConfigEquiv

住処: 頂点・配位はいずれも有限集合の元であり、可算側で閉じる。ℝ / ℂ は現れない。
境界横断辺の破れ本数と破れボンド数の分解、実数評価の上下は後続のセクションで扱う。

人手証明との対応の注意:
- 人手証明の代表を取る写像 s は `ZMod.val`、自然な射影 π は `Nat.cast : ℕ → ZMod L` である。
- 「除法の原理の一意性から s(π(p)) = p」は `ZMod.val_cast_of_lt`、
  「π(s(y)) = y」は `ZMod.natCast_rightInverse` で、どちらも代表の一意性そのものであり、
  人手証明が使っていない性質は使わない。
-/
import Ising2DLambda.PartitionPolynomial.Basic
import Ising2DLambda.ThermodynamicLimit.OpenRectangle

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.PartitionPolynomial

variable (L : ℕ) [NeZero L]

/-- 人手証明の頂点の対応 `v_L(i,j) := (s(i), s(j))`。
代表を取る写像 `s` は `ZMod.val` であり、`0 ≤ s(i), s(j) ≤ L-1` が
`ZMod.val_lt`（値が `L` 未満であること）として付いてくる。 -/
def periodicVertexToOpen (u : Vertex L) : OpenVertex L L :=
  (⟨u.1.val, ZMod.val_lt u.1⟩, ⟨u.2.val, ZMod.val_lt u.2⟩)

/-- 人手証明の逆写像 `(p,q) ↦ (π(p), π(q))`。自然な射影 `π` は `Nat.cast` である。 -/
def openVertexToPeriodic (v : OpenVertex L L) : Vertex L :=
  ((v.1.val : ZMod L), (v.2.val : ZMod L))

/-- 人手証明の「`0 ≤ p ≤ L-1` の整数 `p` について `s(π(p)) = p`（除法の原理の一意性）」。
成分ごとに `ZMod.val_cast_of_lt` を適用する。 -/
lemma periodicVertexToOpen_openVertexToPeriodic (v : OpenVertex L L) :
    periodicVertexToOpen L (openVertexToPeriodic L v) = v := by
  refine Prod.ext (Fin.ext ?_) (Fin.ext ?_)
  · exact ZMod.val_cast_of_lt v.1.isLt
  · exact ZMod.val_cast_of_lt v.2.isLt

/-- 人手証明の「任意の `y ∈ ℤ/Lℤ` について `π(s(y)) = y`」。
成分ごとに `ZMod.natCast_rightInverse` を適用する。 -/
lemma openVertexToPeriodic_periodicVertexToOpen (u : Vertex L) :
    openVertexToPeriodic L (periodicVertexToOpen L u) = u :=
  Prod.ext (ZMod.natCast_rightInverse u.1) (ZMod.natCast_rightInverse u.2)

/-- 人手証明の「ゆえに `v_L` は全単射である」。 -/
def periodicOpenVertexEquiv : Vertex L ≃ OpenVertex L L where
  toFun := periodicVertexToOpen L
  invFun := openVertexToPeriodic L
  left_inv := openVertexToPeriodic_periodicVertexToOpen L
  right_inv := periodicVertexToOpen_openVertexToPeriodic L

/-- 人手証明の配位を読み替える写像 `r_L(τ) := τ ∘ v_L`。 -/
def openConfigToPeriodic (τ : OpenConfig L L) : Config L :=
  fun u => τ (periodicVertexToOpen L u)

/-- 人手証明の逆写像 `τ' ↦ τ' ∘ (v_L の逆写像)`。 -/
def periodicConfigToOpen (σ : Config L) : OpenConfig L L :=
  fun v => σ (openVertexToPeriodic L v)

/-- 往復して戻ること（開境界側）。各頂点で
`τ(v_L((v_L の逆写像)(v))) = τ(v)` を頂点の往復の等式から得る。 -/
lemma periodicConfigToOpen_openConfigToPeriodic (τ : OpenConfig L L) :
    periodicConfigToOpen L (openConfigToPeriodic L τ) = τ :=
  funext fun v => congrArg τ (periodicVertexToOpen_openVertexToPeriodic L v)

/-- 往復して戻ること（周期境界側）。各頂点で
`σ((v_L の逆写像)(v_L(u))) = σ(u)` を頂点の往復の等式から得る。 -/
lemma openConfigToPeriodic_periodicConfigToOpen (σ : Config L) :
    openConfigToPeriodic L (periodicConfigToOpen L σ) = σ :=
  funext fun u => congrArg σ (openVertexToPeriodic_periodicVertexToOpen L u)

/-- 人手証明の「`r_L` も全単射である」。 -/
def periodicOpenConfigEquiv : OpenConfig L L ≃ Config L where
  toFun := openConfigToPeriodic L
  invFun := periodicConfigToOpen L
  left_inv := periodicConfigToOpen_openConfigToPeriodic L
  right_inv := openConfigToPeriodic_periodicConfigToOpen L

end Ising2DLambda.ThermodynamicLimit
