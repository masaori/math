/-
「因数定理の商の、もとの根における値は零でない」の必要十分版。

必要なのは、始点の値が 2 段の等式で終点へ書き換えられることと、終点が指定した元と
異なることだけ。型に代数構造は一切要らず（加法・積・零元の規則・体・代数閉性は不要）、
「零元」も単に指定された 1 つの元として受け取る。
-/

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

universe u

/-- 2 段の等式の鎖の始点は、終点が指定した元と異なるなら、その元と異なる。 -/
theorem eq_chain_ne_zero_necSuf {α : Sort u} {a b c z : α}
    (h1 : a = b) (h2 : b = c) (h3 : c ≠ z) : a ≠ z := by
  rw [h1, h2]
  exact h3

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
