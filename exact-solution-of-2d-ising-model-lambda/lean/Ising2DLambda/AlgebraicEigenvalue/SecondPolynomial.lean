/-
章「固有値の代数性」の「もう 1 つの不定元の多項式」の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは定義 4 件
（`def_second_polynomial_ring` / `def_second_constant_embedding` / `def_second_degree_bound` /
`def_second_monic`）と主張 4 件（`claim_second_degree_sum` / `claim_second_degree_prod` /
`claim_second_monic_prod` / `claim_second_monic_add_lower`）に対応する。

  人手証明                          このファイル
  ℤ[x][t]                           SecondPoly
  cf_k(f)                           f.coeff k
  κ(0) / κ(1)（ℤ[x] の零元・単位元） constPoly 0 / constPoly 1
  ι : ℤ[x] → ℤ[x][t]                constSecond
  D_n                               DegLe f n
  M_n                               MonicDeg f n
  次数 n 以下の元の有限和            degLe_sum
  次数の上界は有限積で足し合わさる  degLe_mul（準備）/ degLe_prod（本体）
  モニックな元の有限積              monicDeg_mul（準備）/ monicDeg_prod（本体）
  モニック + 低次                    monicDeg_add_of_degLe

不定元を `λ` と呼ばないのは人手証明と同じ理由である（`λ` は対数順序群 `Λ` の元を表す記号として
固定してある。Lean では加えて `λ` が関数記法の予約語でもある）。

`SecondPoly` は `Polynomial (Polynomial ℤ)` そのものである。人手証明が `ℤ[x]` を係数環とする
`t` の多項式環として導入しているので、ここでも係数環を `Polynomial ℤ` に固定する。
`Polynomial.coeff_add` / `Polynomial.coeff_mul` は多項式環の演算の定義（和の係数は係数の和、
積の係数は畳み込み）であり、人手証明がこの 2 つの等式だけを使うと述べていることに対応する。

`constSecond` は mathlib の `Polynomial.C` そのものである。人手証明が ℤ[x] の元と ℤ[x][t] の元を
同じ記号で書かないと約束しているので、ここでも自動強制に任せずこの名前を通す。

住処: 人手証明のこれらのブロックは ℤ を宣言している。ここに ℝ / ℂ は現れない
（係数は `Polynomial ℤ`、次数と添字は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.Determinant
import Mathlib.Algebra.Polynomial.Coeff

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset

/-- 人手証明の `ℤ[x][t]`。`ℤ[x]` を係数環とする、もう 1 つの不定元の多項式環。 -/
abbrev SecondPoly := Polynomial (Polynomial ℤ)

/-- 人手証明の `ι : ℤ[x] → ℤ[x][t]`（`t` について定数である元を与える写像）。 -/
noncomputable def constSecond (a : Polynomial ℤ) : SecondPoly := Polynomial.C a

@[simp] lemma coeff_constSecond_zero (a : Polynomial ℤ) :
    (constSecond a).coeff 0 = a := by
  simp [constSecond]

@[simp] lemma coeff_constSecond_succ (a : Polynomial ℤ) (k : ℕ) :
    (constSecond a).coeff (k + 1) = 0 := by
  simp [constSecond]

lemma constSecond_constPoly_zero : constSecond (constPoly 0) = 0 := by
  simp [constSecond, constPoly_zero]

lemma constSecond_constPoly_one : constSecond (constPoly 1) = 1 := by
  simp [constSecond, constPoly_one]


end Ising2DLambda.AlgebraicEigenvalue
