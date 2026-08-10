/-
章「固有値の代数性」の「代数的数における値を取る写像は、有限積を有限積へ写す」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_second_evaluation_prod`）に対応する。

  人手証明                                     このファイル
  ev_{ξ,z} : ℤ[x][t] → Qbar                    evalSecond ξ z
  ev(1) = 1（帰納法の出発点）                  evalSecond_one
  ev(f·g) = ev(f)·ev(g)（一歩の第 2 段）       evalSecond_mul
  ev(∏_{i∈s} f_i) = ∏_{i∈s} ev(f_i)            evalSecond_prod

帰納法は人手証明と同じく「元を 1 つ足す」形で回す（`Finset.cons_induction`）。
mathlib の `map_prod`（環準同型は有限積を保つ）へは委ねていない。使ったのは
`Finset.prod_empty` と `Finset.prod_cons`（空の積は単位元／有限積から因子を 1 つ括り出す）
だけである。単位元と積の保存は、人手証明が `def_second_evaluation` の中で
約束として述べているものをそのまま補題にした。

住処: 人手証明のこのブロックは Qbar を宣言している。ここに ℝ / ℂ は現れない
（値は ℚ の代数閉包の元、係数は ℤ[x]）。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitFactorRoot

namespace Ising2DLambda.AlgebraicEigenvalue

open Polynomial

/-- `def_second_evaluation` の約束のうち、単位元を単位元へ送ること。 -/
theorem evalSecond_one (ξ z : Qbar) : evalSecond ξ z (1 : SecondPoly) = 1 := by
  rw [evalSecond, Polynomial.eval₂_one]

/-- `def_second_evaluation` の約束のうち、積を保つこと。 -/
theorem evalSecond_mul (ξ z : Qbar) (f g : SecondPoly) :
    evalSecond ξ z (f * g) = evalSecond ξ z f * evalSecond ξ z g := by
  rw [evalSecond, evalSecond, evalSecond, Polynomial.eval₂_mul]

/-- 人手証明の主張（`claim_second_evaluation_prod`）。`s` の元の個数についての帰納法。 -/
theorem evalSecond_prod {β : Type*} [DecidableEq β] (ξ z : Qbar)
    (s : Finset β) (f : β → SecondPoly) :
    evalSecond ξ z (∏ i ∈ s, f i) = ∏ i ∈ s, evalSecond ξ z (f i) := by
  induction s using Finset.cons_induction with
  | empty =>
      -- 出発点。空の積は単位元であり、その値は Qbar の単位元である。
      rw [Finset.prod_empty, Finset.prod_empty, evalSecond_one]
  | cons a s ha ih =>
      -- 一歩。因子を 1 つ括り出し（第 1 段）、積の保存を当て（第 2 段）、
      -- 帰納法の仮定を当て（第 3 段）、因子を 1 つ戻す（第 4 段）。
      rw [Finset.prod_cons, Finset.prod_cons, evalSecond_mul, ih]

end Ising2DLambda.AlgebraicEigenvalue
