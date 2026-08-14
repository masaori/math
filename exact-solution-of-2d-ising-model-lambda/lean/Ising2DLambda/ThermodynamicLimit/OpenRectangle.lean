/-
章「熱力学極限」の開境界長方形の定義 5 件の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。

  人手証明のラベル                          このファイル
  def_open_rectangle_vertices               OpenVertex
  def_open_rectangle_edges                  OpenEdgeH / OpenEdgeV / OpenEdge /
                                            openBoundary0 / openBoundary1
  def_open_rectangle_configuration          OpenConfig
  def_open_rectangle_broken_bond_count      openBrokenBondSet / openBrokenBondCount
  def_open_rectangle_partition_polynomial   openPartitionPolynomial

住処: 人手証明のこれらのブロックは可算側（ℕ および ℤ[x]）を宣言している。
したがってここに ℝ / ℂ は現れない。数え上げは `ℕ`、分配多項式は `Polynomial ℤ` で書く。

人手証明との対応の注意:
- 人手証明の「`i < a` かつ `j < b` を満たす `(i,j) ∈ ℕ × ℕ`」は、`Fin a × Fin b`
  （上界の証明を持つ自然数の組）としてそのまま写す。剰余類は使わない（本文どおり）。
- 横向き辺の番号の条件は本文どおり `j + 1 < b` で書く。`j < b` はそこから従うので、
  頂点型の部分型として持っても集合としては本文と同じである（縦向きも同様）。
- 向きの印を付けた直和 `({h} × E_h) ∪ ({v} × E_v)` は直和型 `⊕` で写す
  （`Sum.inl` が印 h、`Sum.inr` が印 v にあたる）。
- 本文は `a ≥ 1`、`b ≥ 1` を仮定するが、これらの定義はその仮定なしで意味を持つ
  （`a = 0` や `b = 0` では頂点・辺・配位が空になるだけである）。定義には仮定を課さない。
-/
import Mathlib.Data.Finset.Card
import Mathlib.Data.Fintype.Pi
import Mathlib.Data.Fintype.Sum
import Mathlib.Data.Fintype.Prod
import Mathlib.Algebra.Polynomial.Basic
import Ising2DLambda.PartitionPolynomial.Basic

namespace Ising2DLambda.ThermodynamicLimit

open Finset
open Ising2DLambda.PartitionPolynomial (SpinValue card_spinValue)

variable (a b : ℕ)

/-- 頂点集合 `V^op_{a,b} = {(i,j) ∈ ℕ×ℕ | i<a かつ j<b}`。
`Fin a` は「`i < a` の証明を持つ自然数 `i`」なので、本文の内包的定義とそのまま対応する。 -/
def OpenVertex : Type := Fin a × Fin b

instance : Fintype (OpenVertex a b) := by unfold OpenVertex; infer_instance
instance : DecidableEq (OpenVertex a b) := by unfold OpenVertex; infer_instance

/-- SageMath 検証と同じ数え上げ: 頂点数は `a·b`（直積の数え上げ）。 -/
lemma card_openVertex : Fintype.card (OpenVertex a b) = a * b := by
  show Fintype.card (Fin a × Fin b) = a * b
  rw [Fintype.card_prod, Fintype.card_fin, Fintype.card_fin]

/-- 横向き辺の番号の集合 `E^op_{a,b,h} = {(i,j) | i<a かつ j+1<b}`。
条件 `j+1<b` を本文どおりに持つ（`j<b` はそこから従う）。 -/
def OpenEdgeH : Type := {v : Fin a × Fin b // v.2.val + 1 < b}

instance : Fintype (OpenEdgeH a b) := by unfold OpenEdgeH; infer_instance
instance : DecidableEq (OpenEdgeH a b) := by unfold OpenEdgeH; infer_instance

/-- 縦向き辺の番号の集合 `E^op_{a,b,v} = {(i,j) | i+1<a かつ j<b}`。 -/
def OpenEdgeV : Type := {v : Fin a × Fin b // v.1.val + 1 < a}

instance : Fintype (OpenEdgeV a b) := by unfold OpenEdgeV; infer_instance
instance : DecidableEq (OpenEdgeV a b) := by unfold OpenEdgeV; infer_instance

/-- 辺の番号の集合。向きの印を付けた直和 `({h}×E_h) ∪ ({v}×E_v)` を直和型で写す
（`Sum.inl` が印 h、`Sum.inr` が印 v）。 -/
def OpenEdge : Type := OpenEdgeH a b ⊕ OpenEdgeV a b

instance : Fintype (OpenEdge a b) := by unfold OpenEdge; infer_instance
instance : DecidableEq (OpenEdge a b) := by unfold OpenEdge; infer_instance

/-- 横向き辺と `Fin a × Fin (b-1)` の 1 対 1 対応（数え上げのため）。
`j + 1 < b` と `j < b - 1` は自然数の切り捨て減法のもとで同値である。 -/
def openEdgeHEquiv : OpenEdgeH a b ≃ Fin a × Fin (b - 1) where
  toFun e := (e.val.1, ⟨e.val.2.val, by have := e.property; omega⟩)
  invFun p :=
    ⟨(p.1, ⟨p.2.val, by have := p.2.isLt; omega⟩),
      show p.2.val + 1 < b by have := p.2.isLt; omega⟩
  left_inv := by rintro ⟨⟨i, j⟩, h⟩; rfl
  right_inv := by rintro ⟨i, j⟩; rfl

/-- 縦向き辺と `Fin (a-1) × Fin b` の 1 対 1 対応（数え上げのため）。 -/
def openEdgeVEquiv : OpenEdgeV a b ≃ Fin (a - 1) × Fin b where
  toFun e := (⟨e.val.1.val, by have := e.property; omega⟩, e.val.2)
  invFun p :=
    ⟨(⟨p.1.val, by have := p.1.isLt; omega⟩, p.2),
      show p.1.val + 1 < a by have := p.1.isLt; omega⟩
  left_inv := by rintro ⟨⟨i, j⟩, h⟩; rfl
  right_inv := by rintro ⟨i, j⟩; rfl

/-- SageMath 検証と同じ数え上げ: 辺数は `a·(b-1) + (a-1)·b`（直和と直積の数え上げ）。 -/
lemma card_openEdge : Fintype.card (OpenEdge a b) = a * (b - 1) + (a - 1) * b := by
  show Fintype.card (OpenEdgeH a b ⊕ OpenEdgeV a b) = a * (b - 1) + (a - 1) * b
  rw [Fintype.card_sum, Fintype.card_congr (openEdgeHEquiv a b),
    Fintype.card_congr (openEdgeVEquiv a b), Fintype.card_prod, Fintype.card_prod,
    Fintype.card_fin, Fintype.card_fin, Fintype.card_fin, Fintype.card_fin]

/-- 端点写像 `∂^op₀`。どちらの向きでも `(i, j)`。 -/
def openBoundary0 : OpenEdge a b → OpenVertex a b
  | Sum.inl e => e.val
  | Sum.inr e => e.val

/-- 端点写像 `∂^op₁`。横向きは `(i, j+1)`、縦向きは `(i+1, j)`。
足し算は ℕ のままで、辺の条件 `j+1<b`（横）・`i+1<a`（縦）が上界の証明を与える
（剰余類を使わないので、反対側の境界へ戻る辺は無い）。 -/
def openBoundary1 : OpenEdge a b → OpenVertex a b
  | Sum.inl e => (e.val.1, ⟨e.val.2.val + 1, e.property⟩)
  | Sum.inr e => (⟨e.val.1.val + 1, e.property⟩, e.val.2)

/-- 配位の集合 `Σ^op_{a,b} = {σ | σ : V^op_{a,b} → {+1,-1}}`。 -/
def OpenConfig : Type := OpenVertex a b → SpinValue

instance : Fintype (OpenConfig a b) := by unfold OpenConfig; infer_instance
instance : DecidableEq (OpenConfig a b) := by unfold OpenConfig; infer_instance

/-- SageMath 検証と同じ数え上げ: 配位数は `2^{a·b}`（各頂点に独立に 2 通り）。 -/
lemma card_openConfig : Fintype.card (OpenConfig a b) = 2 ^ (a * b) := by
  show Fintype.card (OpenVertex a b → SpinValue) = 2 ^ (a * b)
  rw [Fintype.card_fun, card_spinValue, card_openVertex]

/-- 破れた辺の番号の集合 `B^op_{a,b}(σ)`。 -/
def openBrokenBondSet (σ : OpenConfig a b) : Finset (OpenEdge a b) :=
  univ.filter fun e : OpenEdge a b =>
    σ (openBoundary0 a b e) ≠ σ (openBoundary1 a b e)

/-- 破れボンド数 `b^op_{a,b}(σ) = |B^op_{a,b}(σ)| ∈ ℕ`。 -/
def openBrokenBondCount (σ : OpenConfig a b) : ℕ :=
  (openBrokenBondSet a b σ).card

/-- SageMath 検証と同じ評価: 破れボンド数は辺数以下（部分集合の個数は全体の個数以下）。 -/
lemma openBrokenBondCount_le (σ : OpenConfig a b) :
    openBrokenBondCount a b σ ≤ a * (b - 1) + (a - 1) * b := by
  refine le_trans (card_filter_le _ _) ?_
  rw [card_univ, card_openEdge]

/-- 開境界長方形の分配多項式 `Z^op_{a,b} = Σ_σ x^{b^op(σ)} ∈ ℤ[x]`。
有限和なので `ℤ[x]` の元として閉じており、代入は行わない（`x` は不定元）。 -/
noncomputable def openPartitionPolynomial : Polynomial ℤ :=
  ∑ σ : OpenConfig a b, Polynomial.X ^ openBrokenBondCount a b σ

end Ising2DLambda.ThermodynamicLimit
