/-
人手証明の `claim_arf_fourier_sign_projection` と一対一に対応する具体版。
トーラスの巻き付き二次符号（`def_torus_quadratic_sign`）と、スピン構造の Arf 符号
χ の係数 (−1)^{(1−a)(1−b)} の四場合を、巻き付き偶奇の四場合ごとに確かめる。住処は ℤ である。
-/
import Ising2DLambda.KacWard.TorusQuadraticSign

namespace Ising2DLambda.KacWard

/-- スピン構造 (a, b) の Arf 偶奇 (1 − a)(1 − b) mod 2。 -/
def torusArfParity (a b : Bool) : Bool := (!a) && (!b)

/-- スピン構造 (a, b) の Arf 符号 (−1)^{(1−a)(1−b)}。 -/
def torusArfSign (a b : Bool) : ℤ :=
  if torusArfParity a b then -1 else 1

theorem arfFourierSignProjection (h v : Bool) :
    torusArfSign false false * torusQuadraticSign false false h v +
    torusArfSign false true * torusQuadraticSign false true h v +
    torusArfSign true false * torusQuadraticSign true false h v +
    torusArfSign true true * torusQuadraticSign true true h v = 2 := by
  cases h <;> cases v <;> decide

end Ising2DLambda.KacWard
