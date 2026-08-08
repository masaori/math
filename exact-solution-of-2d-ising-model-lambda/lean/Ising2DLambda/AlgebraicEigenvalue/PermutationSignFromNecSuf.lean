/-
具体版が必要十分版の特殊化として得られることの明示（`lean/README.md` の要件 4）。

必要十分版 `NecSuf.AlgebraicEigenvalue.sign_comp` に
  α  := 行配位の集合 RowConfig L
  lt := 辞書式順序 rowConfigLess L
  三分律 := rowConfigLess_trichotomy（主張「行配位の辞書式順序は線形順序である」の前半）
を代入すると、具体版 `AlgebraicEigenvalue.permSign_comp` が出る。
転倒数・符号の定義はどちらも同じ形なので、代入したあとに残るのは記法の一致だけである。

このことは、具体版の証明が次を使っていないという主張の裏取りになっている。
行配位であること・格子の形・スピンの値が `{+1,-1}` であること・順序が辞書式であること。
**とくに、必要十分版は三分律しか仮定していない。** 具体版が引く
`claim_row_config_order_linear` は三分律と推移律の両方を述べているが、
符号の乗法性が使っているのは三分律だけである（推移律を仮定に足さずに通ることが、
使っていないことの検査になっている）。

住処: ℤ のみ。ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.PermutationSign
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PermutationSign

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable (L : ℕ) [NeZero L]

/-- 具体版の三分律を、必要十分版が要求する形（`NecSuf.Trichotomous`）で述べたもの。 -/
theorem rowConfigLess_trichotomous :
    NecSuf.AlgebraicEigenvalue.Trichotomous (rowConfigLess L) :=
  fun τ τ' => rowConfigLess_trichotomy τ τ'

/-- 転倒数の定義が両側で同じであること（定義を展開するだけ）。 -/
theorem inversionCount_eq_necSuf (φ : Equiv.Perm (RowConfig L)) :
    inversionCount L φ = NecSuf.AlgebraicEigenvalue.inversionCount (rowConfigLess L) φ := rfl

/-- 符号の定義が両側で同じであること（定義を展開するだけ）。 -/
theorem permSign_eq_necSuf (φ : Equiv.Perm (RowConfig L)) :
    permSign L φ = NecSuf.AlgebraicEigenvalue.sign (rowConfigLess L) φ := rfl

variable {L}

/-- 具体版の乗法性を、必要十分版から導いたもの。 -/
theorem permSign_comp_from_necSuf (φ ψ : Equiv.Perm (RowConfig L)) :
    permSign L (φ * ψ) = permSign L φ * permSign L ψ := by
  rw [permSign_eq_necSuf, permSign_eq_necSuf, permSign_eq_necSuf]
  exact NecSuf.AlgebraicEigenvalue.sign_comp (rowConfigLess L) (rowConfigLess_trichotomous L) φ ψ

/-- 恒等置換の符号も同じく必要十分版から出る。 -/
theorem permSign_id_from_necSuf :
    permSign L (1 : Equiv.Perm (RowConfig L)) = 1 := by
  rw [permSign_eq_necSuf]
  exact NecSuf.AlgebraicEigenvalue.sign_one (rowConfigLess L) (rowConfigLess_trichotomous L)

end Ising2DLambda.AlgebraicEigenvalue
