/- 必要十分版を末尾を固定する置換の延長と末尾の変数への零代入へ特殊化する導出。住処: Qbar。
`σ = ℕ_{<n}`、`τ = ℕ_{<n+1}`、`c = castSucc`、`t = n`、覆いは `Fin.lastCases`。 -/
import Ising2DLambda.FisherZero.LastVariableZeroPreservesSymmetry
import Ising2DLambda.NecSuf.FisherZero.LastVariableZeroPreservesSymmetry

namespace Ising2DLambda.FisherZero

open MvPolynomial

/-- `ℕ_{<n+1}` は `castSucc` の像と末尾 `n` で覆われる。 -/
theorem fin_succ_cover (n : ℕ) (x : Fin (n + 1)) : x = Fin.last n ∨ ∃ k : Fin n, x = k.castSucc :=
  Fin.lastCases (Or.inl rfl) (fun k => Or.inr ⟨k, rfl⟩) x

/-- `claim_last_fixed_permutation_extension_is_bijection` を必要十分版から得る。 -/
theorem lastFixedExtensionFun_inverse_from_necSuf (n : ℕ) (f g : Fin n → Fin n)
    (hgf : ∀ k, g (f k) = k) (j : Fin (n + 1)) :
    lastFixedExtensionFun n g (lastFixedExtensionFun n f j) = j :=
  Ising2DLambda.NecSuf.FisherZero.fixedPointExtension_inverse_necSuf Fin.castSucc (Fin.last n)
    (fin_succ_cover n) f g (lastFixedExtensionFun n f) (lastFixedExtensionFun n g)
    (lastFixedExtensionFun_last n f) (lastFixedExtensionFun_castSucc n f)
    (lastFixedExtensionFun_last n g) (lastFixedExtensionFun_castSucc n g) hgf j

/-- `claim_last_variable_zero_commutes_with_variable_permutation` を必要十分版から得る。 -/
theorem variablePermutation_lastVariableZero_from_necSuf {n : ℕ} (ϱ : Equiv.Perm (Fin n))
    (P : QbarMvPoly (n + 1)) :
    variablePermutation n ϱ (lastVariableZero n P) =
      lastVariableZero n (variablePermutation (n + 1) (lastFixedExtension n ϱ) P) :=
  Ising2DLambda.NecSuf.FisherZero.lastPointZero_comm_variableMap_necSuf Fin.castSucc (Fin.last n)
    (fin_succ_cover n) (lastVariableZeroValues n)
    (by rw [lastVariableZeroValues, Fin.lastCases_last])
    (fun k => by rw [lastVariableZeroValues, Fin.lastCases_castSucc])
    ϱ (lastFixedExtension n ϱ) (lastFixedExtensionFun_last n ϱ)
    (lastFixedExtensionFun_castSucc n ϱ) P

/-- `claim_last_variable_zero_preserves_symmetry` を必要十分版から得る。 -/
theorem lastVariableZero_isQbarSymmetric_from_necSuf {n : ℕ} (P : QbarMvPoly (n + 1))
    (hP : IsQbarSymmetric P) : IsQbarSymmetric (lastVariableZero n P) :=
  fun ϱ => Ising2DLambda.NecSuf.FisherZero.invariant_map_of_comm_necSuf (lastVariableZero n)
    (fun j => variablePermutation (n + 1) j) (fun i => variablePermutation n i)
    (lastFixedExtension n) (fun i a => variablePermutation_lastVariableZero_from_necSuf i a)
    P hP ϱ

end Ising2DLambda.FisherZero
