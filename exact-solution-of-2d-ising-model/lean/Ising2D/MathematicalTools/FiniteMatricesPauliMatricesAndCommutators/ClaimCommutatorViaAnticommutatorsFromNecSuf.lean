/-
# 反交換子（必要十分版からの導出）

具体版 `ClaimCommutatorViaAnticommutators.lean` の `acomm` と、必要十分版 `Ising2D/NecSuf/CommutatorViaAnticommutators.lean` の
`NecSuf.acomm'` は同じ式 `a b + b a` で定義した同じ演算である。人手のラベルは `commutator_via_anticommutators`。
反交換子を使う必要十分版（`NecSuf.acomm_lincomb_clifford`・`NecSuf.acomm_of_single_site` など）から具体版を導く
導出のファイルは、この一致で具体版の `acomm` へ読み替える。
本文の具体版 `matComm_mul_eq_matAcomm_sub_matAcomm` が必要十分版 `NecSuf.commutator_via_anticommutators'` の
特殊化であることは `matComm_mul_eq_matAcomm_sub_matAcomm_of_necSuf` が述べる。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimCommutatorViaAnticommutators
import Ising2D.NecSuf.CommutatorViaAnticommutators

namespace Ising2D

/-- 具体版の `[a, b]₊` は、必要十分版の `[a, b]₊` と一致する（同じ式の定義）。 -/
theorem acomm_eq_acomm_necSuf {R : Type*} [Ring R] (a b : R) : acomm a b = NecSuf.acomm' a b :=
  rfl

/-- `matComm_mul_eq_matAcomm_sub_matAcomm` を `NecSuf.commutator_via_anticommutators'` の
`R := Mat(n, ℂ)` への特殊化として得る。 -/
theorem matComm_mul_eq_matAcomm_sub_matAcomm_of_necSuf {n : ℕ} (a b c : Matrix (Fin n) (Fin n) ℂ) :
    matComm (a * b) c = a * matAcomm b c - matAcomm a c * b := by
  rw [matComm_def, matAcomm_eq_acomm, matAcomm_eq_acomm, acomm_eq_acomm_necSuf, acomm_eq_acomm_necSuf]
  exact NecSuf.commutator_via_anticommutators' a b c

end Ising2D
