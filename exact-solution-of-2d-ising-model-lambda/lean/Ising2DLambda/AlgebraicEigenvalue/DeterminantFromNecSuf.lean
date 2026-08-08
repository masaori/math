/-
具体版が必要十分版の特殊化として得られることの明示（`lean/README.md` の要件 4）。

2 点を動かすこと: 必要十分版 `NecSuf.AlgebraicEigenvalue.two_le_card_moved` に
  ι := RowConfig L
を代入すると、具体版 `AlgebraicEigenvalue.two_le_card_movedBy` がそのまま出る
（`movedBy` の定義が必要十分版の `filter` そのものなので、書き換えは要らない）。

対角行列の行列式: 必要十分版 `NecSuf.AlgebraicEigenvalue.det_diagonal` に
  ι := RowConfig L、R := Polynomial ℤ、w := κ ∘ sgn
を代入すると、具体版 `AlgebraicEigenvalue.determinant_diagonal` が出る。
仮定 `w 1 = 1` にあたるのは `permSign_id`（人手証明の `sgn(id_{R_L}) = 1`）と
`constPoly_one` である。

このことは、具体版の証明が次を使っていないという主張の裏取りになっている。
行配位であること・格子の形・スピンの値が ±1 であること・順序 `≺` の作り方・
値が整係数多項式であること・**符号の乗法性**（`claim_permutation_sign_mul`）。

住処: ℕ / ℤ / ℤ[x] のみ。ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.Determinant
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.Determinant

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 2 点を動かすことの具体版を、必要十分版から導いたもの。 -/
theorem two_le_card_movedBy_from_necSuf {φ : Equiv.Perm (RowConfig L)} (h : φ ≠ 1) :
    2 ≤ (movedBy L φ).card :=
  NecSuf.AlgebraicEigenvalue.two_le_card_moved h

/-- 対角行列の行列式の具体版を、必要十分版から導いたもの。 -/
theorem determinant_diagonal_from_necSuf (A : RowMatrix L)
    (hA : ∀ τ τ' : RowConfig L, τ ≠ τ' → A τ τ' = constPoly 0) :
    determinant L A = ∏ τ : RowConfig L, A τ τ :=
  NecSuf.AlgebraicEigenvalue.det_diagonal
    (fun φ => constPoly (permSign L φ))
    (by rw [permSign_id, constPoly_one])
    A
    (fun τ τ' h => by rw [hA τ τ' h, constPoly_zero])

end Ising2DLambda.AlgebraicEigenvalue
