/-
# `tr(εV^{(+)}) > 0` から `im Q̌_{(1,…,1)} ⊆ 𝓕^{(+)}`

対応する人手証明（正本は `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`）:

* `eigenvector_of_max_eigenvalue_claim_trace_positive_implies_even_eigenvector`
  （ラベル **`max_eigenvector_in_even_sector_via_trace_of_epsilon_V_plus`**）

主張（`K_1, K_2 > 0` は `IsingParam` が持つ。`M_col ≥ 2`）:

1. `tr(εV^{(+)}) = (2e^{−K_2} cosh K_1)^M + (2e^{K_2} sinh K_1)^M ∈ ℝ_{>0}`
2. `im Q̌_{(1,…,1)} ⊆ 𝓕^{(+)}`

`V^{(+)}` は人手 `def_V_plus` の `(V_1^{(+)})^{1/2}V_2(V_1^{(+)})^{1/2}`、Lean の `VPlusOfTransfer M K_1 K_2` である。
`Q̌_{(1,…,1)}` は `(checkFermiOf P _).Qproj Finset.univ`。`im Q̌_{(1,…,1)}` の元は `Q̌_{(1,…,1)} *ᵥ x` の形のベクトルとして書き、
`𝓕^{(+)}` の元であることは `ε *ᵥ y = y` と書く。
`Q̌_{(1,…,1)}` と `η_{(1,…,1)}` を持つ `vPlusDataOf P _ _` は、`V^{(+)}` を `V_2` の指数表示で書き換えた形
`VPlus M (sinh 2K_2) K_1 K_2^*` で持つので、(2) では `vPlusDataOf_V` と `VPlusOfTransfer_eq_VPlus`
（`K_2^* = Kstar K_2` は `IsingParam.K2star` の定義）で (1) の `V^{(+)}` へつなぐ。

## 人手証明との対応

- (1) 「`trace_of_epsilon_V_plus` そのもの」: `ClaimTraceEpsilonVPlusClosedForm.lean` の `trace_of_epsilon_V_plus`
- (2) の前置き `y ∈ im Q̌_{(1,…,1)}` を取ると冪等性より `y = Q̌_{(1,…,1)}y`:
  `check_joint_eigenspace_decomposition` (1) の冪等性 `CheckFermi.Qproj_mul_self` と `Matrix.mulVec_mulVec`
- (2) 1 行目 `tr(εV^{(+)}) > 0`: (1)
- (2) 2 行目 `η_{(1,…,1)} = +1`: `trace_of_epsilon_V_plus_via_check_eigenvalues` の同値
  （`VPlusData.eta_univ_eq_one_of_trace_pos`）
- (2) 3 行目 `εQ̌_{(1,…,1)} = Q̌_{(1,…,1)}`: `epsilon_eigenvalue_on_check_Q` (1) の
  `εQ̌_{(1,…,1)} = η_{(1,…,1)}Q̌_{(1,…,1)}`（`CheckFermi.epsilon_mul_Qproj`）に 2 行目を代入する
- `εy = εQ̌_{(1,…,1)}y = Q̌_{(1,…,1)}y = y` の式変形 3 行: 証明の最後の `calc`
  （2 段目の積の結合 `ε(Q̌y) = (εQ̌)y`（`Matrix.mulVec_mulVec`）は Lean で補った中間）

人手の主張は既存の主張を並べるだけなので、必要十分版は置かない
（(1) の証明が使う 1 次元開鎖のスピン和と `exp(K_1εG)` の偶奇分解の必要十分版は `NecSuf/OpenChainSpinSum.lean`・
`NecSuf/ExpOfInvolution.lean`、(2) の各行の必要十分版は `Ising2D/NecSuf/ParityFermion.lean` が持つ）。
-/
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.ClaimVPlusDataFromEigenvaluesOfVPlus
import Ising2D.EigenvalueProblem.EigenvectorOfMaxEigenvalue.ClaimTraceEpsilonVPlusClosedForm
import Ising2D.EigenvalueProblem.EigenvectorOfMaxEigenvalue.TheoremMaxEigenvectorInEvenSector

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- **人手 `max_eigenvector_in_even_sector_via_trace_of_epsilon_V_plus`**:
(1) `tr(εV^{(+)}) = (2exp(-K_2)cosh K_1)^{M_col} + (2exp(K_2)sinh K_1)^{M_col} ∈ ℝ_{>0}`、
(2) `im Q̌_{(1,…,1)} ⊆ 𝓕^{(+)}`。 -/
theorem max_eigenvector_in_even_sector_via_trace_of_epsilon_V_plus (P : IsingParam) (hM2 : 2 ≤ M) :
    ((epsilon M * VPlusOfTransfer M (P.K1 : ℂ) P.K2).trace
        = (((2 * Real.exp (-P.K2) * Real.cosh P.K1) ^ M
            + (2 * Real.exp P.K2 * Real.sinh P.K1) ^ M : ℝ) : ℂ)
      ∧ 0 < ((epsilon M * VPlusOfTransfer M (P.K1 : ℂ) P.K2).trace).re)
    ∧ ∀ x : Conf M → ℂ,
        epsilon M *ᵥ ((checkFermiOf P (by omega : M ≠ 0)).Qproj (Finset.univ : Finset (Fin M)) *ᵥ x)
          = (checkFermiOf P (by omega : M ≠ 0)).Qproj Finset.univ *ᵥ x := by
  -- (1): `trace_of_epsilon_V_plus` そのもの
  have h1 := trace_of_epsilon_V_plus hM2 P.K1_pos P.K2
  refine ⟨h1, fun x => ?_⟩
  have hM : M ≠ 0 := by omega
  set F := checkFermiOf P hM with hF
  set D := vPlusDataOf P hM P.c2_mul_s2star_eq_c2star with hD
  set y := F.Qproj Finset.univ *ᵥ x with hyx
  -- (2) の前置き: `y ∈ im Q̌_{(1,…,1)}` なら冪等性より `y = Q̌_{(1,…,1)}y`
  have hy : F.Qproj Finset.univ *ᵥ y = y := by
    rw [hyx, Matrix.mulVec_mulVec, F.Qproj_mul_self]
  -- (2) 1 行目: (1) の `tr(εV^{(+)}) > 0` を `vPlusDataOf` の `V^{(+)}` の形で読む
  have htr : 0 < ((epsilon M * D.V).trace).re := by
    rw [hD, vPlusDataOf_V, IsingParam.K2star, ← VPlusOfTransfer_eq_VPlus P.K2_pos]
    exact h1.2
  -- (2) 2 行目: `η_{(1,…,1)} = +1`
  have heta : F.eta Finset.univ = 1 := D.eta_univ_eq_one_of_trace_pos htr
  -- (2) 3 行目: `εQ̌_{(1,…,1)} = Q̌_{(1,…,1)}`
  have hεQ : epsilon M * F.Qproj Finset.univ = F.Qproj Finset.univ := by
    rw [F.epsilon_mul_Qproj, heta, one_smul]
  -- `εy = εQ̌_{(1,…,1)}y = Q̌_{(1,…,1)}y = y`
  calc epsilon M *ᵥ y = epsilon M *ᵥ (F.Qproj Finset.univ *ᵥ y) := by rw [hy]
    _ = F.Qproj Finset.univ *ᵥ y := by rw [Matrix.mulVec_mulVec, hεQ]
    _ = y := hy

end Ising2D
