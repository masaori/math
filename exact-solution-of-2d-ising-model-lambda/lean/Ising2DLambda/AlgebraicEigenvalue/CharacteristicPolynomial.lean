/-
章「固有値の代数性」の「特性多項式」の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは定義 5 件
（`def_second_matrix` / `def_second_determinant` / `def_indeterminate_element` /
`def_characteristic_matrix` / `def_characteristic_polynomial`）と主張 3 件
（`claim_second_const_degree_zero` / `claim_second_linear_monic` /
`claim_characteristic_polynomial_monic`）に対応する。

  人手証明                          このファイル
  Mat_{R_L}(ℤ[x][t])                SecondRowMatrix L
  det_t B                           secondDeterminant L B
  t（不定元自身が定める元）          Polynomial.X
  ch(A)                             charMatrix L A
  χ_A                               charPoly L A
  ι(a) ∈ D_0                        degLe_constSecond
  t + ι(a) ∈ M_1                    monicDeg_indeterminate_add_constSecond
  χ_A ∈ M_{2^L}                     monicDeg_charPoly
  準備の第一（恒等置換の項）         monicDeg_identity_term
  準備の第二（恒等でない置換の項）   degLe_term_of_ne_one
  準備の第三（その総和）             degLe_rest

人手証明が符号の反転を ℤ[x] の中で済ませていること（`ch(A)_{τ,τ'} = t + ι(-A_{τ,τ'})`）は
ここでも同じで、`ℤ[x][t]` の引き算はどこにも現れない。整数である符号を `ℤ[x][t]` へ入れる
経路も人手証明と同じく `constSecond ∘ constPoly`（= ι ∘ κ）だけである。

mathlib の `Matrix.det` / `Matrix.charpoly` は引いていない（引くと「置換にわたる和として
定める」「係数の条件として次数を定める」という人手証明の定義そのものが消える）。

住処: 人手証明のこれらのブロックは ℤ を宣言している。ここに ℝ / ℂ は現れない
（係数は `Polynomial ℤ`、次数と添字は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.SecondPolynomial

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable (L : ℕ) [NeZero L]

/-- 人手証明の `Mat_{R_L}(ℤ[x][t])`。成分が `ℤ[x][t]` である、行配位を添字とする行列。 -/
def SecondRowMatrix : Type := RowConfig L → RowConfig L → SecondPoly

/-- 人手証明の `det_t B = Σ_φ ι(κ(sgn φ)) · Π_τ B_{τ,φ(τ)}`。 -/
noncomputable def secondDeterminant (B : SecondRowMatrix L) : SecondPoly :=
  ∑ φ : Equiv.Perm (RowConfig L),
    constSecond (constPoly (permSign L φ)) * ∏ τ : RowConfig L, B τ (φ τ)

/-- 人手証明の特性行列 `ch(A)`。符号の反転は `ℤ[x]` の中で済ませてある。 -/
noncomputable def charMatrix (A : RowMatrix L) : SecondRowMatrix L :=
  fun τ τ' =>
    if τ = τ' then Polynomial.X + constSecond (-A τ τ) else constSecond (-A τ τ')

/-- 人手証明の特性多項式 `χ_A = det_t(ch(A))`。 -/
noncomputable def charPoly (A : RowMatrix L) : SecondPoly :=
  secondDeterminant L (charMatrix L A)

variable {L}


end Ising2DLambda.AlgebraicEigenvalue
