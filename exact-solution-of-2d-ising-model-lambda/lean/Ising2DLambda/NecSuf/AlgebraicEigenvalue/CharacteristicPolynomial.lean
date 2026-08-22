/-
定義「転送行列の型の行列に対する特性行列」の必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.CharacteristicPolynomial`）の `ch(A)` の作り方が
実際に使っているのは次だけである。行配位であること・格子の形・スピンの値が ±1 であること・
係数が整係数多項式であることは、どこにも使っていない。

  使っている性質            なぜ削れないか
  `DecidableEq ι`           対角成分かどうかを `i = j` で分けるのに要る。
  `CommSemiring S`          多項式環 `Polynomial S` が定まること。**引き算を一度も使って
                            いないので、環である必要はない。** 具体版が符号の反転を係数環の
                            側で済ませているため、多項式環の側に引き算が要らない。

住処: ここに ℝ / ℂ は現れない（添字は一般の型、係数は一般の可換半環）。
-/
import Mathlib.Algebra.Polynomial.Basic
import Mathlib.Algebra.Polynomial.Coeff

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {S : Type*} [CommSemiring S]

/-- 具体版の `ch(A)` にあたる行列。符号の反転は係数環 `S` の側で済ませてある前提なので、
ここには引き算が現れない。 -/
noncomputable def charMatrix (B : ι → ι → S) (i j : ι) : Polynomial S :=
  if i = j then Polynomial.X + Polynomial.C (B i i) else Polynomial.C (B i j)


end Ising2DLambda.NecSuf.AlgebraicEigenvalue
