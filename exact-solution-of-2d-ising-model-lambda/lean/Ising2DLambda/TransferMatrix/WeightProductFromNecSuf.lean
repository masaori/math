/-
具体版が必要十分版の特殊化として得られることの明示（`lean/README.md` の要件 4）。

1. 必要十分版 `NecSuf.TransferMatrix.prod_pow_add_eq_pow` に
     M := ℤ[x]、a := 不定元 X、ι := ZMod L、
     f := i ↦ b_h(ρ_i(σ))、g := i ↦ b_v(ρ_i(σ), ρ_{i+1}(σ))、n := b(σ)
   を代入し、仮定 `hn`（指数の和が `b(σ)` に等しいこと）へ
   `claim_broken_bond_row_decomposition` を与えると、具体版
   `TransferMatrix.transfer_weight_product` がそのまま出る。
   このことは、重みの積の証明が「値の側が可換モノイドであること」と
   「添字の側が有限型であること」しか使っておらず、多項式であること・不定元の冪であること・
   スピンの値が `{+1,-1}` であること・格子の形を使っていないという主張の裏取りになっている。

2. 必要十分版 `NecSuf.TransferMatrix.uncurryEquiv` に
     α := ZMod L（行番号）、β := ZMod L（列番号）、γ := SpinValue
   を代入すると、具体版 `TransferMatrix.rowsEquiv` がそのまま出る（両者は定義が一致する）。
   このことは、1 対 1 対応の証明が有限性も値が 2 元であることも使っていないという裏取りになっている。

住処: ℕ および ℤ[x] のみ。ℝ / ℂ は現れない。
-/
import Ising2DLambda.TransferMatrix.WeightProduct
import Ising2DLambda.NecSuf.TransferMatrix.WeightProduct

namespace Ising2DLambda.TransferMatrix

open Finset PartitionPolynomial

variable (L : ℕ) [NeZero L]

omit [NeZero L] in
/-- 具体版の 1 対 1 対応は、必要十分版の特殊化そのものである（定義が一致する）。
`L` が正であることを使わない点も、必要十分版が有限性を仮定していないことと合っている。 -/
lemma rowsEquiv_eq_necSuf :
    (rowsEquiv L : Config L ≃ RowFamily L)
      = NecSuf.TransferMatrix.uncurryEquiv (ZMod L) (ZMod L) SpinValue := rfl

/-- 具体版の定理を、必要十分版から導いたもの。 -/
theorem transfer_weight_product_from_necSuf (σ : Config L) :
    ∏ i : ZMod L, transferMatrix L (rowsOf L σ i) (rowsOf L σ (i + 1))
      = Polynomial.X ^ brokenBondCount L σ :=
  NecSuf.TransferMatrix.prod_pow_add_eq_pow
    (M := Polynomial ℤ) (ι := ZMod L)
    Polynomial.X
    (fun i => intraRowBrokenCount L (rowRestriction L σ i))
    (fun i => interRowBrokenCount L (rowRestriction L σ i) (rowRestriction L σ (i + 1)))
    (fun i => transferMatrix L (rowsOf L σ i) (rowsOf L σ (i + 1)))
    (brokenBondCount L σ)
    (fun _ => rfl)
    (brokenBondCount_eq_row_decomposition L σ).symm

end Ising2DLambda.TransferMatrix
