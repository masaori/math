/- 整数を成分とする有限添字の正方行列、積、単位行列。 -/
import Mathlib.Data.Matrix.Mul

namespace Ising2DLambda.IntegerMatrix

abbrev Square (α : Type*) := Matrix α α ℤ

def product {α : Type*} [Fintype α] (A B : Square α) : Square α :=
  A * B

def identity (α : Type*) [DecidableEq α] : Square α :=
  1

end Ising2DLambda.IntegerMatrix
