/-
章「転送行列」の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは定義 2 件と
主張「辺の集合は行ごとに分割される」（ラベル `claim_edge_row_partition`）に対応する。

  人手証明のラベル                このファイル
  def_row_configuration           RowConfig
  def_row_restriction             rowRestriction
  def_intra_row_broken_count      intraRowBrokenCount
  def_inter_row_broken_count      interRowBrokenCount
  claim_edge_row_partition        edgeOfRow / edgeOfRow_boundary0 / edgeOfRow_boundary1_horizontal
                                  / edgeOfRow_boundary1_vertical / edgeEquiv

人手証明の主張は「行ごとの辺の集合が、本数 L で、互いに素で、合併がもとの集合になり、
端点が番号から直接読める」という 4 つである。Lean では前 3 つをまとめて
「辺の番号の集合が (行番号, 列番号) の 2 つ組の 2 つのコピーと 1 対 1 に対応する」
（`edgeEquiv`）として述べる。合併・互いに素・本数 L はこの 1 対 1 対応と同値であり、
人手証明の Step 2（分解の一意性）がそのまま単射性の証明になる。
4 つめの端点は `edgeOfRow_boundary0` と 2 つの `edgeOfRow_boundary1_*` である。

この主張には必要十分版を別に置いていない。主張の中身がこの格子の番号の付け方そのもの
（どの番号がどの行に属するか）であり、それを抽象化すると同じ言明の言い換えにしかならないためである。
そのかわり、この主張が下流で何に必要かは、主張「破れボンド数は行内の破れと行間の破れに分かれる」の
必要十分版が「(行, 列) の 2 つ組の 2 つのコピーとの 1 対 1 対応」を仮定として持つことで示される。
すなわち、この主張の必要性はそちらの仮定として検査されている。

住処: 人手証明のこれらのブロックは可算側（ℕ）を宣言している。
したがってここに ℝ / ℂ は現れない（添字は `ZMod L`、数え上げは `ℕ`）。
-/
import Ising2DLambda.PartitionPolynomial.Basic

namespace Ising2DLambda.TransferMatrix

open Finset PartitionPolynomial

variable (L : ℕ)

/-- 行配位 `τ : ℤ/Lℤ → {+1,-1}`。 -/
def RowConfig : Type := ZMod L → SpinValue

instance [NeZero L] : Fintype (RowConfig L) := by unfold RowConfig; infer_instance
instance [NeZero L] : DecidableEq (RowConfig L) := by unfold RowConfig; infer_instance

/-- 人手証明の `|R_L| = 2^L`（`ℤ/Lℤ` の各元に独立に 2 通り）。 -/
lemma card_rowConfig [NeZero L] : Fintype.card (RowConfig L) = 2 ^ L := by
  show Fintype.card (ZMod L → SpinValue) = 2 ^ L
  rw [Fintype.card_fun, card_spinValue, ZMod.card]

/-- 配位の第 `i` 行への制限 `ρ_i(σ)`。人手証明と同じく `σ_i` とは書かない。 -/
def rowRestriction (σ : Config L) (i : ZMod L) : RowConfig L := fun j => σ (i, j)

/-- 行内破れ数 `b_h(τ) = |{ j | τ(j) ≠ τ(j+1) }|`。`j+1` は `ℤ/Lℤ` の中の加法。 -/
def intraRowBrokenCount [NeZero L] (τ : RowConfig L) : ℕ :=
  (univ.filter fun j : ZMod L => τ j ≠ τ (j + 1)).card

/-- 行間破れ数 `b_v(τ, τ') = |{ j | τ(j) ≠ τ'(j) }|`。 -/
def interRowBrokenCount [NeZero L] (τ τ' : RowConfig L) : ℕ :=
  (univ.filter fun j : ZMod L => τ j ≠ τ' j).card

lemma intraRowBrokenCount_le [NeZero L] (τ : RowConfig L) : intraRowBrokenCount L τ ≤ L := by
  refine le_trans (card_filter_le _ _) ?_
  rw [card_univ, ZMod.card]

lemma interRowBrokenCount_le [NeZero L] (τ τ' : RowConfig L) :
    interRowBrokenCount L τ τ' ≤ L := by
  refine le_trans (card_filter_le _ _) ?_
  rw [card_univ, ZMod.card]

section EdgeRowPartition

variable [NeZero L]

/-- 人手証明の Step 1（番号が正しい範囲に入ること）。
`i, j ∈ {0,…,L-1}` なら `iL + j ≤ L² - 1`。ここでは `j + L*i` の順で書く
（Lean の除法の補題がこの形を使うため。値は同じ）。 -/
lemma rowColumnIndex_lt (i j : ZMod L) : j.val + L * i.val < L ^ 2 := by
  have hj : j.val < L := ZMod.val_lt j
  have hi : i.val + 1 ≤ L := ZMod.val_lt i
  calc j.val + L * i.val < L + L * i.val := by omega
    _ = L * (i.val + 1) := by ring
    _ ≤ L * L := Nat.mul_le_mul_left L hi
    _ = L ^ 2 := (sq L).symm

/-- 辺の番号を (向き, 行番号, 列番号) から作る。人手証明の
`E_{L,h,i} = { iL+j+1 }`・`E_{L,v,i} = { L²+iL+j+1 }` にあたる
（Lean の辺の番号は 0 始まりなので、人手証明の番号から 1 を引いた形になる）。
`side = false` が横向き、`side = true` が縦向きである。 -/
def edgeOfRow (side : Bool) (i j : ZMod L) : Edge L :=
  ⟨(if side then L ^ 2 else 0) + (j.val + L * i.val), by
    have h := rowColumnIndex_lt L i j
    cases side <;> simp <;> omega⟩

/-- 人手証明の Step 2（分解の一意性）の前半。番号を `L` で割った商が行番号である。 -/
lemma edgeIndex_edgeOfRow (side : Bool) (i j : ZMod L) :
    edgeIndex L (edgeOfRow L side i j) = j.val + L * i.val := by
  have h := rowColumnIndex_lt L i j
  cases side with
  | false => simp [edgeIndex, edgeOfRow]; omega
  | true => simp [edgeIndex, edgeOfRow]

lemma edgeRow_edgeOfRow (side : Bool) (i j : ZMod L) :
    edgeRow L (edgeOfRow L side i j) = i.val := by
  have hL : 0 < L := Nat.pos_of_ne_zero (NeZero.ne L)
  rw [edgeRow, edgeIndex_edgeOfRow, Nat.add_mul_div_left _ _ hL,
    Nat.div_eq_of_lt (ZMod.val_lt j), Nat.zero_add]

lemma edgeColumn_edgeOfRow (side : Bool) (i j : ZMod L) :
    edgeColumn L (edgeOfRow L side i j) = j.val := by
  rw [edgeColumn, edgeIndex_edgeOfRow, Nat.add_mul_mod_self_left,
    Nat.mod_eq_of_lt (ZMod.val_lt j)]

/-- 人手証明の 4 つめ（端点）の前半。どちらの向きでも `∂₀ = (i, j)`。 -/
lemma edgeOfRow_boundary0 (side : Bool) (i j : ZMod L) :
    boundary0 L (edgeOfRow L side i j) = (i, j) := by
  rw [boundary0, edgeRow_edgeOfRow, edgeColumn_edgeOfRow]
  exact Prod.ext (ZMod.natCast_rightInverse i) (ZMod.natCast_rightInverse j)

/-- 同じく後半（横向き）。列番号だけを 1 進める。 -/
lemma edgeOfRow_boundary1_horizontal (i j : ZMod L) :
    boundary1 L (edgeOfRow L false i j) = (i, j + 1) := by
  have h := rowColumnIndex_lt L i j
  have hval : (edgeOfRow L false i j).val < L ^ 2 := by simpa [edgeOfRow] using h
  rw [boundary1, if_pos hval, edgeRow_edgeOfRow, edgeColumn_edgeOfRow]
  rw [ZMod.natCast_rightInverse i, ZMod.natCast_rightInverse j]

/-- 同じく後半（縦向き）。行番号だけを 1 進める。 -/
lemma edgeOfRow_boundary1_vertical (i j : ZMod L) :
    boundary1 L (edgeOfRow L true i j) = (i + 1, j) := by
  have hval : ¬ (edgeOfRow L true i j).val < L ^ 2 := by simp [edgeOfRow]
  rw [boundary1, if_neg hval, edgeRow_edgeOfRow, edgeColumn_edgeOfRow]
  rw [ZMod.natCast_rightInverse i, ZMod.natCast_rightInverse j]

/-- 辺の番号の集合を (行番号, 列番号) の 2 つ組の 2 つのコピーへ写す写像。
`inl` が横向き（同じ行の中）、`inr` が縦向き（隣り合う 2 行の間）である。 -/
def edgeOfSum (w : (ZMod L × ZMod L) ⊕ (ZMod L × ZMod L)) : Edge L :=
  match w with
  | Sum.inl (i, j) => edgeOfRow L false i j
  | Sum.inr (i, j) => edgeOfRow L true i j

/-- 人手証明の Step 3・Step 4・Step 5（本数・互いに素・合併）に対応する単射性。
証明は Step 2 の一意性そのもので、番号から向き・行番号・列番号が一意に読めることを使う。 -/
lemma edgeOfSum_injective : Function.Injective (edgeOfSum L) := by
  -- 向きは番号が `L²` 未満かどうかで決まり、行番号と列番号は商と余りで決まる。
  have hlt : ∀ i j : ZMod L, (edgeOfRow L false i j).val < L ^ 2 := by
    intro i j; simpa [edgeOfRow] using rowColumnIndex_lt L i j
  have hnlt : ∀ i j : ZMod L, ¬ (edgeOfRow L true i j).val < L ^ 2 := by
    intro i j; simp [edgeOfRow]
  rintro (⟨i, j⟩ | ⟨i, j⟩) (⟨i', j'⟩ | ⟨i', j'⟩) hEq <;>
    simp only [edgeOfSum] at hEq
  · -- 横向きどうし。番号が等しいので商と余りが等しく、行番号と列番号が等しい。
    have hr : i.val = i'.val := by
      have := congrArg (edgeRow L) hEq
      rwa [edgeRow_edgeOfRow, edgeRow_edgeOfRow] at this
    have hc : j.val = j'.val := by
      have := congrArg (edgeColumn L) hEq
      rwa [edgeColumn_edgeOfRow, edgeColumn_edgeOfRow] at this
    simp [ZMod.val_injective _ hr, ZMod.val_injective _ hc]
  · -- 横向きと縦向き。番号の範囲が重ならないので起こりえない。
    have h1 := hlt i j
    rw [hEq] at h1
    exact absurd h1 (hnlt i' j')
  · have h1 := hlt i' j'
    rw [← hEq] at h1
    exact absurd h1 (hnlt i j)
  · have hr : i.val = i'.val := by
      have := congrArg (edgeRow L) hEq
      rwa [edgeRow_edgeOfRow, edgeRow_edgeOfRow] at this
    have hc : j.val = j'.val := by
      have := congrArg (edgeColumn L) hEq
      rwa [edgeColumn_edgeOfRow, edgeColumn_edgeOfRow] at this
    simp [ZMod.val_injective _ hr, ZMod.val_injective _ hc]

/-- 辺の番号の集合と、(行番号, 列番号) の 2 つ組の 2 つのコピーとの 1 対 1 対応。
人手証明の `claim_edge_row_partition` の 1 つめから 3 つめ（本数 `L`・互いに素・合併）は、
この対応があることと同じことを言っている。単射性から全単射を出すのに個数が等しいこと
`2·L·L = 2L²` を使う。 -/
noncomputable def edgeEquiv : ((ZMod L × ZMod L) ⊕ (ZMod L × ZMod L)) ≃ Edge L :=
  Equiv.ofBijective (edgeOfSum L)
    ((Fintype.bijective_iff_injective_and_card _).mpr
      ⟨edgeOfSum_injective L, by
        simp [Fintype.card_sum, Fintype.card_prod, ZMod.card, card_edge, sq]
        ring⟩)

@[simp] lemma edgeEquiv_inl (i j : ZMod L) :
    edgeEquiv L (Sum.inl (i, j)) = edgeOfRow L false i j := rfl

@[simp] lemma edgeEquiv_inr (i j : ZMod L) :
    edgeEquiv L (Sum.inr (i, j)) = edgeOfRow L true i j := rfl

end EdgeRowPartition

end Ising2DLambda.TransferMatrix
