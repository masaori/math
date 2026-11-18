/- 必要十分版を `Qbar` 係数の多変数多項式環と末尾の変数への零代入へ特殊化する導出。住処: Qbar。 -/
import Ising2DLambda.FisherZero.ElementarySymmetricLastVariableZero
import Ising2DLambda.NecSuf.FisherZero.ElementarySymmetricLastVariableZero

namespace Ising2DLambda.FisherZero

open MvPolynomial

/-- `claim_last_variable_zero_elementary_symmetric` を必要十分版から得る。
`A = Qbar[X_{<n+1}]`、`R = Qbar[X_{<n}]`、`φ = lz_n`、`X` は変数、`g = Fin.castSucc`、`t` は `ℕ_{<n}` の全体、
`a` は末尾 `Fin.last n`、`y k = X^{(n)}_k`。`ℕ_{<n+1} = insert (last n) (castSucc の像)` は添字の書き換え。 -/
theorem lastVariableZero_elementarySymmetric_from_necSuf (n j : ℕ) :
    lastVariableZero n (qbarElementarySymmetric (n + 1) j) = qbarElementarySymmetric n j := by
  classical
  have huniv : (Finset.univ : Finset (Fin (n + 1))) =
      insert (Fin.last n) ((Finset.univ : Finset (Fin n)).map Fin.castSuccEmb) := by
    ext x
    induction x using Fin.lastCases with
    | last => simp
    | cast k => simp [Fin.castSucc_ne_last]
  have h := Ising2DLambda.NecSuf.FisherZero.elementarySymmetric_insert_zero_necSuf
    (lastVariableZero n).toRingHom (fun k : Fin (n + 1) => (X k : QbarMvPoly (n + 1)))
    Fin.castSuccEmb Finset.univ (Fin.last n)
    (by simp [Fin.castSucc_ne_last]) (fun k : Fin n => (X k : QbarMvPoly n))
    (fun k => lastVariableZero_X_castSucc n k) (lastVariableZero_X_last n) j
  rw [← huniv] at h
  exact h

end Ising2DLambda.FisherZero
