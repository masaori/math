/-
章「固有値の代数性」の「行配位の巡回シフト」の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは定義 2 件
（`def_column_translation` / `def_row_config_shift`）と主張 5 件
（`claim_column_translation_bijective` / `claim_row_config_shift_bijective` /
`claim_intra_row_shift_invariant` / `claim_inter_row_shift_invariant` /
`claim_transfer_matrix_shift_invariant`）に対応する。

  人手証明                          このファイル
  γ（列番号の平行移動）              columnTranslation L
  γ'（証明の中で置く逆向きの平行移動） columnTranslationEquiv の invFun
  γ が全単射                         columnTranslationEquiv
  S（行配位の巡回シフト）             rowShift L
  S'（証明の中で置く逆向きのシフト）   rowShiftEquiv の invFun
  S が全単射                         rowShiftEquiv
  b_h(S(τ)) = b_h(τ)                 intraRowBrokenCount_rowShift
  b_v(S(τ),S(τ')) = b_v(τ,τ')        interRowBrokenCount_rowShift
  T_{S(τ),S(τ')} = T_{τ,τ'}          transferMatrix_rowShift
  |γ⁻¹(X)| = |X| の段                card_filter_columnTranslation

人手証明が数え上げを「集合 X を γ で引き戻す」形で書いていることは、ここでも同じである。
`card_filter_columnTranslation` は 1 対 1 対応（`Finset.card_bij'`）で移すだけで、
数え上げの一般論（`Finset.card_image_of_injective` 等で個数の等式を一足飛びに出すこと）へ
丸投げしていない。mathlib の `Equiv.addRight` も引いていない（引くと「γ' を置いて
往復を見る」という人手証明の作り方が消える）。

住処: 人手証明のこれらのブロックは ℕ（転送行列の主張だけ ℤ）を宣言している。
ここに ℝ / ℂ は現れない（添字は `ZMod L`、数え上げは `ℕ`、成分は `Polynomial ℤ`）。
-/
import Ising2DLambda.TransferMatrix.WeightProduct

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable (L : ℕ) [NeZero L]

/-- 人手証明の `γ(y) = y +_{ℤ/Lℤ} 1̄`。 -/
def columnTranslation (y : ZMod L) : ZMod L := y + 1

/-- 人手証明の主張「列番号の平行移動は全単射である」。

証明は人手証明どおり。逆向きの平行移動 `γ'(y) = y + (-1̄)` を置き、
結合則・逆元・単位元で往復が恒等写像であることを見る。 -/
def columnTranslationEquiv : ZMod L ≃ ZMod L where
  toFun := columnTranslation L
  invFun y := y + (-1)
  left_inv y := by
    -- (y + 1̄) + (-1̄) = y + (1̄ + (-1̄)) = y + 0 = y
    show (y + 1) + (-1) = y
    rw [add_assoc, add_neg_cancel, add_zero]
  right_inv y := by
    -- (y + (-1̄)) + 1̄ = y + ((-1̄) + 1̄) = y + 0 = y
    show columnTranslation L (y + (-1)) = y
    rw [columnTranslation, add_assoc, neg_add_cancel, add_zero]

/-- 人手証明の `(S(τ))(y) = τ(γ(y))`。 -/
def rowShift (τ : RowConfig L) : RowConfig L := fun y => τ (columnTranslation L y)

/-- 人手証明の主張「行配位の巡回シフトは全単射である」。

証明は人手証明どおり。`γ` の逆写像で引き戻す `S'` を置き、
2 つの写像が等しいとは各点での値が等しいことである、という形で往復を見る。 -/
def rowShiftEquiv : RowConfig L ≃ RowConfig L where
  toFun := rowShift L
  invFun τ := fun y => τ ((columnTranslationEquiv L).symm y)
  left_inv τ := by
    funext y
    show τ (columnTranslation L ((columnTranslationEquiv L).symm y)) = τ y
    rw [show columnTranslation L ((columnTranslationEquiv L).symm y)
      = columnTranslationEquiv L ((columnTranslationEquiv L).symm y) from rfl,
      Equiv.apply_symm_apply]
  right_inv τ := by
    funext y
    show τ ((columnTranslationEquiv L).symm (columnTranslation L y)) = τ y
    rw [show columnTranslation L y = columnTranslationEquiv L y from rfl,
      Equiv.symm_apply_apply]

variable {L}

/-- 人手証明の数え上げの一歩 `|γ⁻¹(X)| = |X|`。

`γ` が `γ⁻¹(X)` から `X` への全単射であることを、順写像と逆写像を明示して使う。 -/
theorem card_filter_columnTranslation (p : ZMod L → Prop) [DecidablePred p] :
    (univ.filter fun y => p (columnTranslation L y)).card = (univ.filter p).card := by
  refine Finset.card_bij' (fun y _ => columnTranslation L y)
    (fun z _ => (columnTranslationEquiv L).symm z) ?_ ?_ ?_ ?_
  · intro y hy
    simpa using (mem_filter.mp hy).2
  · intro z hz
    refine mem_filter.mpr ⟨mem_univ _, ?_⟩
    have : columnTranslation L ((columnTranslationEquiv L).symm z) = z :=
      (columnTranslationEquiv L).apply_symm_apply z
    simpa [this] using (mem_filter.mp hz).2
  · intro y _
    exact (columnTranslationEquiv L).symm_apply_apply y
  · intro z _
    exact (columnTranslationEquiv L).apply_symm_apply z

/-- 人手証明の主張「行内破れ数は巡回シフトで変わらない」。

`b_h(S(τ))` を定める集合が `X = { z | τ z ≠ τ (γ z) }` の `γ` による逆像であることを
`rowShift` の定義から出し、`card_filter_columnTranslation` で個数を移す。 -/
theorem intraRowBrokenCount_rowShift (τ : RowConfig L) :
    intraRowBrokenCount L (rowShift L τ) = intraRowBrokenCount L τ := by
  classical
  show (univ.filter fun y : ZMod L =>
      rowShift L τ y ≠ rowShift L τ (y + 1)).card
    = (univ.filter fun z : ZMod L => τ z ≠ τ (z + 1)).card
  have hset : (univ.filter fun y : ZMod L => rowShift L τ y ≠ rowShift L τ (y + 1))
      = univ.filter fun y : ZMod L =>
          τ (columnTranslation L y) ≠ τ (columnTranslation L (columnTranslation L y)) := by
    refine filter_congr fun y _ => ?_
    -- `def_row_config_shift` を 2 箇所へ適用する段。
    simp [rowShift, columnTranslation]
  rw [hset]
  exact card_filter_columnTranslation (fun z => τ z ≠ τ (columnTranslation L z))

/-- 人手証明の主張「行間破れ数は 2 つの行配位を同時に巡回シフトしても変わらない」。 -/
theorem interRowBrokenCount_rowShift (τ τ' : RowConfig L) :
    interRowBrokenCount L (rowShift L τ) (rowShift L τ') = interRowBrokenCount L τ τ' := by
  classical
  show (univ.filter fun y : ZMod L => rowShift L τ y ≠ rowShift L τ' y).card
    = (univ.filter fun z : ZMod L => τ z ≠ τ' z).card
  exact card_filter_columnTranslation (fun z => τ z ≠ τ' z)

/-- 人手証明の主張「転送行列の成分は行と列を同時に巡回シフトしても変わらない」。

証明は人手証明どおり 4 つの等号（転送行列の定義・行内破れ数の不変性・
行間破れ数の不変性・転送行列の定義）である。 -/
theorem transferMatrix_rowShift (τ τ' : RowConfig L) :
    transferMatrix L (rowShift L τ) (rowShift L τ') = transferMatrix L τ τ' := by
  rw [transferMatrix, transferMatrix, intraRowBrokenCount_rowShift,
    interRowBrokenCount_rowShift]

end Ising2DLambda.AlgebraicEigenvalue
