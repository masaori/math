/-
# 固有値候補 — 具体版を必要十分版の特殊化として導出する

対応する人手証明のラベル: `<epsilon_action_eigenvalues_are_signs>`。

具体版 `Ising2D.epsilon_action_eigenvalues_are_signs` は
`Ising2D/Part004/ClaimEpsilonActionEigenvalues.lean` にあり、必要十分版
`Ising2D.NecSuf.eigenvalue_eq_one_or_neg_one_of_involution` は
`Ising2D/NecSuf/InvolutionEigenvalue.lean` にある。

## 本文・具体版・必要十分版の段対応

* 単位行列と `epsilon M * epsilon M = 1` から二回作用が元へ戻る段:
  具体版の `honeMulVec`, `hmulVec_assoc`, `epsilon_mul_self` / 必要十分版の `hinvolution`。
* 固有値方程式を内側と外側へ代入し、スカラーを括り出す段:
  具体版の `heigen`, `hmulVec_smul` / 必要十分版の `heigen`, `map_smul`。
* 二次式を零にして平方差を因数分解し、二場合を解く段:
  具体版の `hdifference` 以後 / 必要十分版の `hdifference` 以後。
-/
import Ising2D.NecSuf.InvolutionEigenvalue
import Ising2D.Part004.ClaimEpsilonActionEigenvalues

namespace Ising2D

open Matrix

/-- **具体版 `epsilon_action_eigenvalues_are_signs` を必要十分版の特殊化として導出した形**。 -/
theorem epsilon_action_eigenvalues_are_signs_of_necSuf
    (M : ℕ) (_hM : 1 ≤ M) (f : Conf M → ℂ) (lambda : ℂ)
    (hf : f ≠ 0) (heigen : epsilon M *ᵥ f = lambda • f) :
    lambda = 1 ∨ lambda = -1 := by
  apply NecSuf.eigenvalue_eq_one_or_neg_one_of_involution
    (T := Matrix.toLin' (epsilon M)) (f := f) (lambda := lambda) hf
  · intro x
    simp only [Matrix.toLin'_apply]
    rw [Matrix.mulVec_mulVec, epsilon_mul_self, Matrix.one_mulVec]
  · simpa only [Matrix.toLin'_apply] using heigen

end Ising2D
