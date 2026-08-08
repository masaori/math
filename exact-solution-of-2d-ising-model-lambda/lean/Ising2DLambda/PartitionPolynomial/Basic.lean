/-
章「分配多項式」の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/partition-polynomial.ts`。
このファイルは人手証明の定義 4 件をそのまま Lean の定義へ写したものである。

  人手証明のラベル              このファイル
  def_lattice                   Vertex / EdgeIndex / boundary0 / boundary1
  def_configuration             Config
  def_broken_bond_count         brokenBondCount
  def_multiplicity              multiplicity
  def_partition_polynomial      partitionPolynomial

住処: 人手証明のこれらのブロックは可算側（ℕ および ℤ[x]）を宣言している。
したがってここに ℝ / ℂ は現れない。数え上げは `ℕ`、分配多項式は `Polynomial ℤ` で書く。
-/
import Mathlib.Data.Finset.Card
import Mathlib.Data.ZMod.Basic
import Mathlib.Data.Fintype.Pi
import Mathlib.Algebra.Polynomial.Basic

namespace Ising2DLambda.PartitionPolynomial

open Finset

/-- スピンの値の集合 `{+1,-1}`。人手証明どおり ℤ の元として読む
（`ℝ` を持ち込まないため、Bool ではなく ℤ の部分型で書く）。 -/
def SpinValue : Type := {z : ℤ // z = 1 ∨ z = -1}

instance : DecidableEq SpinValue := fun a b =>
  decidable_of_iff (a.1 = b.1) Subtype.ext_iff.symm

/-- `{+1,-1}` がちょうど 2 元であることを、Bool との 1 対 1 対応で示す。 -/
def spinValueEquivBool : SpinValue ≃ Bool where
  toFun s := decide (s.1 = 1)
  invFun b := if b then ⟨1, Or.inl rfl⟩ else ⟨-1, Or.inr rfl⟩
  left_inv := by
    rintro ⟨z, rfl | rfl⟩ <;> simp
  right_inv := by
    intro b; cases b <;> simp

instance : Fintype SpinValue := Fintype.ofEquiv Bool spinValueEquivBool.symm

lemma card_spinValue : Fintype.card SpinValue = 2 := by
  rw [Fintype.card_congr spinValueEquivBool, Fintype.card_bool]

variable (L : ℕ)

/-- 頂点集合 `V_L = (ℤ/Lℤ) × (ℤ/Lℤ)`。第 1 成分が行番号、第 2 成分が列番号。 -/
def Vertex : Type := ZMod L × ZMod L

instance [NeZero L] : Fintype (Vertex L) := by
  unfold Vertex; infer_instance

instance : DecidableEq (Vertex L) := by
  unfold Vertex; infer_instance

lemma card_vertex [NeZero L] : Fintype.card (Vertex L) = L ^ 2 := by
  show Fintype.card (ZMod L × ZMod L) = L ^ 2
  rw [Fintype.card_prod, ZMod.card, sq]

/-- 辺の番号の集合 `E_L = {1,…,2L²}`。0 始まりの番号で表す
（人手証明の番号 `e` はここでの `e.val + 1` に対応する）。
`e.val < L^2` が横向き（`E_{L,h}`）、そうでないものが縦向き（`E_{L,v}`）である。 -/
def Edge : Type := Fin (2 * L ^ 2)

instance : Fintype (Edge L) := by unfold Edge; infer_instance
instance : DecidableEq (Edge L) := by unfold Edge; infer_instance

lemma card_edge : Fintype.card (Edge L) = 2 * L ^ 2 := by
  show Fintype.card (Fin (2 * L ^ 2)) = 2 * L ^ 2
  exact Fintype.card_fin _

/-- 辺の番号を、横向き・縦向きそれぞれの中での 0 始まりの番号へ直す。
人手証明の `e-1=iL+j`（横向き）と `e-L²-1=iL+j`（縦向き）の左辺にあたる。 -/
def edgeIndex (e : Edge L) : ℕ := if e.val < L ^ 2 then e.val else e.val - L ^ 2

/-- 人手証明の除法の原理による分解 `k = iL + j` の行番号 `i`。 -/
def edgeRow (e : Edge L) : ℕ := edgeIndex L e / L

/-- 同じ分解の列番号 `j`。 -/
def edgeColumn (e : Edge L) : ℕ := edgeIndex L e % L

/-- 端点写像 `∂₀`。どちらの向きでも `(i, j)`。 -/
def boundary0 (e : Edge L) : Vertex L := ((edgeRow L e : ZMod L), (edgeColumn L e : ZMod L))

/-- 端点写像 `∂₁`。横向きは列番号だけを 1 進め、縦向きは行番号だけを 1 進める
（`ℤ/Lℤ` の中で足すので周期境界条件になる）。 -/
def boundary1 (e : Edge L) : Vertex L :=
  if e.val < L ^ 2 then ((edgeRow L e : ZMod L), (edgeColumn L e : ZMod L) + 1)
  else ((edgeRow L e : ZMod L) + 1, (edgeColumn L e : ZMod L))

/-- 配位 `σ : V_L → {+1,-1}`。 -/
def Config : Type := Vertex L → SpinValue

instance [NeZero L] : Fintype (Config L) := by unfold Config; infer_instance
-- 配位の相等の決定可能性には頂点集合が有限であること（したがって `NeZero L`）が要る。
instance [NeZero L] : DecidableEq (Config L) := by unfold Config; infer_instance

/-- 人手証明の `|Σ_L| = 2^{L²}`（各頂点に独立に 2 通り）。 -/
lemma card_config [NeZero L] : Fintype.card (Config L) = 2 ^ L ^ 2 := by
  show Fintype.card (Vertex L → SpinValue) = 2 ^ L ^ 2
  rw [Fintype.card_fun, card_spinValue, card_vertex]

/-- 破れボンド数 `b(σ)`。破れている辺の番号の個数。 -/
def brokenBondCount (σ : Config L) : ℕ :=
  (univ.filter fun e : Edge L => σ (boundary0 L e) ≠ σ (boundary1 L e)).card

/-- 人手証明の `0 ≤ b(σ) ≤ |E_L| = 2L²`（部分集合の個数は全体の個数以下）。 -/
lemma brokenBondCount_le (σ : Config L) : brokenBondCount L σ ≤ 2 * L ^ 2 := by
  refine le_trans (card_filter_le _ _) ?_
  rw [card_univ, card_edge]

/-- 多重度 `Ω_L(m)`。破れボンド数がちょうど `m` の配位の個数。 -/
def multiplicity [NeZero L] (m : ℕ) : ℕ :=
  (univ.filter fun σ : Config L => brokenBondCount L σ = m).card

/-- 分配多項式 `Z_L = Σ_σ x^{b(σ)} ∈ ℤ[x]`。代入は行わない（`x` は不定元）。 -/
noncomputable def partitionPolynomial [NeZero L] : Polynomial ℤ :=
  ∑ σ : Config L, Polynomial.X ^ brokenBondCount L σ

end Ising2DLambda.PartitionPolynomial
