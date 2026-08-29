/-
章「トーラス上の Kac--Ward 行列式」の「定数項一の形式的平方根は存在する」
（`claim_formal_square_root_exists`）の具体版。

人手証明と同じ係数再帰と Cauchy 積の係数比較を使う。住処は Qbar[[X]] であり、
ℝ / ℂ は現れない。2 の可逆性は Qbar が標数零の体であることから来る。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnity
import Ising2DLambda.NecSuf.KacWard.FormalSquareRootExistence

namespace Ising2DLambda.KacWard

open PowerSeries Ising2DLambda.AlgebraicEigenvalue

noncomputable instance invertibleTwoQbar : Invertible (2 : Qbar) :=
  invertibleOfNonzero (by norm_num)

/-- Qbar 上の平方根係数列（本文 `def_sqrt_coefficient_recursion` の具体化）。 -/
noncomputable def sqrtCoeff (d : ℕ → Qbar) : ℕ → Qbar :=
  Ising2DLambda.NecSuf.KacWard.sqrtCoeff d

/-- Qbar[[X]] で、定数項 1 の係数列の平方根係数列は定数項 1 の形式的平方根を与える。 -/
theorem formalSquareRoot_exists (d : ℕ → Qbar) (hd0 : d 0 = 1) :
    constantCoeff (mk (sqrtCoeff d)) = 1 ∧ mk (sqrtCoeff d) * mk (sqrtCoeff d) = mk d :=
  ⟨Ising2DLambda.NecSuf.KacWard.constantCoeff_mk_sqrtCoeff d,
    Ising2DLambda.NecSuf.KacWard.mk_sqrtCoeff_mul_self d hd0⟩

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem formalSquareRoot_exists_from_necSuf (d : ℕ → Qbar) (hd0 : d 0 = 1) :
    constantCoeff (mk (sqrtCoeff d)) = 1 ∧ mk (sqrtCoeff d) * mk (sqrtCoeff d) = mk d :=
  formalSquareRoot_exists d hd0

end Ising2DLambda.KacWard
