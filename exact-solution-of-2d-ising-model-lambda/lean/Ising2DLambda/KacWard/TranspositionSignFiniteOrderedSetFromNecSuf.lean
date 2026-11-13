/-
主張「有限線型順序集合の相異なる二点の互換の符号は -1 である」の具体版が、
必要十分版 `NecSuf.KacWard.sign_transposition`（有限台の互換の転倒対の分割を
全体集合へ適用したもの）の特殊化として得られることを示す導出版。
-/
import Ising2DLambda.KacWard.TranspositionSignFiniteOrderedSet
import Ising2DLambda.NecSuf.KacWard.PermutationSignOrbitProduct

namespace Ising2DLambda.KacWard

variable {J : Type*} [Fintype J] [LinearOrder J]

omit [Fintype J] in
/-- 具体版の互換は必要十分版の互換と同じ置換である。 -/
theorem finiteTranspositionPerm_eq_necSuf (a b : J) :
    finiteTranspositionPerm a b = NecSuf.KacWard.transpositionPerm a b := by
  ext u
  rfl

theorem finiteTransposition_sign_from_necSuf {a b : J} (hab : a ≠ b) :
    NecSuf.AlgebraicEigenvalue.sign (fun x y : J => x < y) (finiteTranspositionPerm a b) = -1 := by
  rw [finiteTranspositionPerm_eq_necSuf]
  exact NecSuf.KacWard.sign_transposition a b hab

end Ising2DLambda.KacWard
