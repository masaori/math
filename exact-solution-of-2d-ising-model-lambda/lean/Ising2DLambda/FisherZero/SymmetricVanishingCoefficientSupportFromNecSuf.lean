/- 必要十分版を `Qbar` 係数の対称多項式へ特殊化する導出。住処: Qbar。 -/
import Ising2DLambda.FisherZero.SymmetricVanishingCoefficientSupport
import Ising2DLambda.NecSuf.FisherZero.SymmetricVanishingCoefficientSupport

namespace Ising2DLambda.FisherZero

open MvPolynomial

/-- `claim_symmetric_vanishing_last_variable_coefficient_support` を必要十分版から得る。
`K = Qbar`。対称性から互換 `(k n)` についての不変性を取り出して渡す。
変数の置換・末尾の変数への零代入は、どちらも具体版と同じ式で定めてある。 -/
theorem symmetricVanishing_coeff_eq_zero_from_necSuf {n : ℕ} (P : QbarMvPoly (n + 1))
    (hsym : IsQbarSymmetric P) (hlz : lastVariableZero n P = 0)
    (a : Fin (n + 1) →₀ ℕ) (k : Fin (n + 1)) (hk : a k = 0) :
    coeff a P = 0 :=
  Ising2DLambda.NecSuf.FisherZero.swapInvariantVanishing_coeff_eq_zero_necSuf P a k
    (hsym (Equiv.swap k (Fin.last n))) hlz hk

end Ising2DLambda.FisherZero
