/-
章「固有値の代数性」の行列式の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは定義 1 件
（ラベル `def_constant_polynomial` / `def_identity_matrix` / `def_determinant`）と主張 2 件
（`claim_permutation_moves_two` / `claim_determinant_diagonal`）に対応する。

  人手証明                                  このファイル
  κ : ℤ → ℤ[x]（定数多項式）                constPoly
  I（単位行列）                             identityRowMatrix
  det A                                     determinant
  M(φ)（φ が動かす行配位の集合）            movedBy
  |M(φ)| ≥ 2                                two_le_card_movedBy
  対角行列の行列式                          determinant_diagonal
  det I = κ(1)                              determinant_identity

`constPoly` は mathlib の `Polynomial.C` そのものである（`x^0` の係数が `n` で他が `0` の
多項式を与える写像）。人手証明が整数と定数多項式を同じ記号で書かないと約束しているので、
ここでも `(n : Polynomial ℤ)` のような自動強制に任せず、この名前を通す。

`determinant` の積 `∏ τ : RowConfig L` に添字の順序は入れていない。人手証明が述べるとおり
`ℤ[x]` の積が可換なので順序によらないためで、順序 `≺` が要るのは `permSign` の中の転倒数だけである。

`permSign` が `noncomputable`（`Nat.find` を使う）なので、`determinant` も `noncomputable` である。
これは数学の内容ではなく Lean の実行可能性の話である。

住処: 人手証明のこれらのブロックは ℤ / ℕ を宣言している。ここに ℝ / ℂ は現れない
（係数は ℤ、値は `Polynomial ℤ`、数え上げは ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.PermutationSign
import Ising2DLambda.TransferMatrix.WeightProduct
import Mathlib.Data.Fintype.Perm

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable (L : ℕ) [NeZero L]

/-- 人手証明の `κ : ℤ → ℤ[x]`。`x^0` の係数が `n` で、他の係数はすべて `0`。 -/
noncomputable def constPoly (n : ℤ) : Polynomial ℤ := Polynomial.C n

@[simp] lemma constPoly_zero : constPoly 0 = 0 := map_zero _

@[simp] lemma constPoly_one : constPoly 1 = 1 := map_one _

/-- 人手証明の単位行列 `I`。 -/
noncomputable def identityRowMatrix : RowMatrix L :=
  fun τ τ' => if τ = τ' then constPoly 1 else constPoly 0

/-- 人手証明の `det A = Σ_φ κ(sgn φ) · Π_τ A_{τ,φ(τ)}`。 -/
noncomputable def determinant (A : RowMatrix L) : Polynomial ℤ :=
  ∑ φ : Equiv.Perm (RowConfig L), constPoly (permSign L φ) * ∏ τ : RowConfig L, A τ (φ τ)


variable {L}


end Ising2DLambda.AlgebraicEigenvalue
