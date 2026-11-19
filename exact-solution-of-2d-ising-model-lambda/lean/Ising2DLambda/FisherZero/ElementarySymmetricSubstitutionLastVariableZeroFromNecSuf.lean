/- 必要十分版を `Qbar` 係数の基本対称式への代入と末尾の変数への零代入へ特殊化する導出。住処: Qbar。 -/
import Ising2DLambda.FisherZero.ElementarySymmetricSubstitutionLastVariableZero
import Ising2DLambda.FisherZero.ElementarySymmetricLastVariableZeroFromNecSuf
import Ising2DLambda.NecSuf.FisherZero.ElementarySymmetricSubstitutionLastVariableZero

namespace Ising2DLambda.FisherZero

open MvPolynomial

/-- 準備 `ms_{z_n} ∘ ee_{n+1} = ms_{ee_n} ∘ z_n` の値ごとの形を、
`lz_n(es_{n+1,j}) = es_{n,j}` の必要十分版からの導出で得る。 -/
theorem lastVariableZero_comp_elementarySymmetricValues_from_necSuf (n : ℕ) (j : Fin (n + 1)) :
    qbarMvSubst (lastVariableZeroValues n) (elementarySymmetricValues (n + 1) j) =
      qbarMvSubst (elementarySymmetricValues n) (lastVariableZeroValues n j) := by
  refine Fin.lastCases ?_ (fun k => ?_) j
  · calc qbarMvSubst (lastVariableZeroValues n) (elementarySymmetricValues (n + 1) (Fin.last n))
        = lastVariableZero n (qbarElementarySymmetric (n + 1) (n + 1)) := rfl
      _ = qbarElementarySymmetric n (n + 1) :=
          lastVariableZero_elementarySymmetric_from_necSuf n (n + 1)
      _ = 0 := elementarySymmetric_eq_zero_of_lt (Nat.lt_succ_self n)
      _ = qbarMvSubst (elementarySymmetricValues n) 0 := (map_zero _).symm
      _ = qbarMvSubst (elementarySymmetricValues n) (lastVariableZeroValues n (Fin.last n)) := by
          rw [lastVariableZeroValues, Fin.lastCases_last]
  · calc qbarMvSubst (lastVariableZeroValues n) (elementarySymmetricValues (n + 1) k.castSucc)
        = lastVariableZero n (qbarElementarySymmetric (n + 1) (k.val + 1)) := rfl
      _ = qbarElementarySymmetric n (k.val + 1) :=
          lastVariableZero_elementarySymmetric_from_necSuf n (k.val + 1)
      _ = elementarySymmetricValues n k := rfl
      _ = qbarMvSubst (elementarySymmetricValues n) (X k) := (aeval_X _ k).symm
      _ = qbarMvSubst (elementarySymmetricValues n) (lastVariableZeroValues n k.castSucc) := by
          rw [lastVariableZeroValues, Fin.lastCases_castSucc]

/-- `claim_elementary_symmetric_substitution_last_variable_zero` を必要十分版から得る。
`K = Qbar`、`σ = Fin (n + 1)`、`e = ee_{n+1}`、`y = z_n`、`z = z_n`、`e' = ee_n`。 -/
theorem lastVariableZero_elementarySymmetricSubst_from_necSuf {n : ℕ} (Q : QbarMvPoly (n + 1)) :
    lastVariableZero n (elementarySymmetricSubst (n + 1) Q) =
      elementarySymmetricSubst n (lastVariableZero n Q) :=
  Ising2DLambda.NecSuf.FisherZero.mvSubst_comm_of_values_comm_necSuf
    (elementarySymmetricValues (n + 1)) (lastVariableZeroValues n)
    (lastVariableZeroValues n) (elementarySymmetricValues n)
    (lastVariableZero_comp_elementarySymmetricValues_from_necSuf n) Q

end Ising2DLambda.FisherZero
