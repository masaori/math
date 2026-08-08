/-
具体版が必要十分版の特殊化として得られることの明示（`lean/README.md` の要件 4）。

列番号の平行移動: 必要十分版 `NecSuf.AlgebraicEigenvalue.translationEquiv` に
  G := ZMod L、a := 1
を代入すると、具体版 `AlgebraicEigenvalue.columnTranslationEquiv` と同じ写像が出る
（`ZMod L` が加法群であることだけを使っており、有限であることも可換であることも使っていない）。

行配位の巡回シフト: 必要十分版 `NecSuf.AlgebraicEigenvalue.precompEquiv` に
  ι := ZMod L、κ := SpinValue、e := columnTranslationEquiv L
を代入すると、具体版 `AlgebraicEigenvalue.rowShiftEquiv` が出る
（値の型 `SpinValue` に何も要求していない。2 元であることも使っていない）。

破れ数が変わらないこと: 必要十分版 `NecSuf.AlgebraicEigenvalue.card_filter_comp_equiv` に
  ι := ZMod L、e := columnTranslationEquiv L
を代入し、述語 `p` を
  行内: p z = (τ z ≠ τ (γ z))、行間: p z = (τ z ≠ τ' z)
と取ると、具体版の 2 つの主張がいずれも出る。すなわち人手証明の 2 つの主張は、
**同じ 1 つの数え上げの補題の、述語の取り方が違うだけの特殊化**である。

このことは、具体版の証明が次を使っていないという主張の裏取りになっている。
行配位であること・格子の形・スピンの値が ±1 であること・添字が `ℤ/Lℤ` であること・
`ℤ/Lℤ` の加法が可換であること・破れ数が「値の相違を数えたもの」であること。

転送行列の主張（`transferMatrix_rowShift`）には必要十分版を置いていない。
その証明は上の 2 つの主張を指数へ代入するだけで新しい論法を持たず、
つないでいる各主張には必要十分版があるためである。

住処: ℕ / ℤ / ℤ[x] のみ。ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.RowConfigShift
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.RowConfigShift

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 具体版の `γ` が、必要十分版の平行移動の特殊化であること。 -/
theorem columnTranslation_eq_necSuf (y : ZMod L) :
    columnTranslation L y = NecSuf.AlgebraicEigenvalue.translationEquiv (1 : ZMod L) y := rfl

/-- 具体版の `S` が、必要十分版の引き戻しの特殊化であること。

`RowConfig L` は `ZMod L → SpinValue` の別名なので、両辺を各点での値として突き合わせる
（型としては同じものだが、`def` で付けた名前は宣言の型の位置では展開されない）。 -/
theorem rowShift_eq_necSuf (τ : RowConfig L) (y : ZMod L) :
    rowShift L τ y
      = NecSuf.AlgebraicEigenvalue.precompEquiv (κ := PartitionPolynomial.SpinValue)
          (columnTranslationEquiv L) (fun z => τ z) y := rfl

/-- 行内破れ数の不変性を、必要十分版から導いたもの。 -/
theorem intraRowBrokenCount_rowShift_from_necSuf (τ : RowConfig L) :
    intraRowBrokenCount L (rowShift L τ) = intraRowBrokenCount L τ := by
  classical
  show (univ.filter fun y : ZMod L => rowShift L τ y ≠ rowShift L τ (y + 1)).card
    = (univ.filter fun z : ZMod L => τ z ≠ τ (z + 1)).card
  have hset : (univ.filter fun y : ZMod L => rowShift L τ y ≠ rowShift L τ (y + 1))
      = univ.filter fun y : ZMod L =>
          (fun z : ZMod L => τ z ≠ τ (columnTranslation L z)) (columnTranslationEquiv L y) := by
    refine filter_congr fun y _ => ?_
    simp [rowShift, columnTranslation, columnTranslationEquiv]
  rw [hset]
  exact NecSuf.AlgebraicEigenvalue.card_filter_comp_equiv (columnTranslationEquiv L)
    (fun z => τ z ≠ τ (columnTranslation L z))

/-- 行間破れ数の不変性を、必要十分版から導いたもの。 -/
theorem interRowBrokenCount_rowShift_from_necSuf (τ τ' : RowConfig L) :
    interRowBrokenCount L (rowShift L τ) (rowShift L τ') = interRowBrokenCount L τ τ' := by
  classical
  show (univ.filter fun y : ZMod L => rowShift L τ y ≠ rowShift L τ' y).card
    = (univ.filter fun z : ZMod L => τ z ≠ τ' z).card
  exact NecSuf.AlgebraicEigenvalue.card_filter_comp_equiv (columnTranslationEquiv L)
    (fun z => τ z ≠ τ' z)

end Ising2DLambda.AlgebraicEigenvalue
