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
- (2) の準備: `r := (2e^{−K_2} cosh K_1)^M + (2e^{K_2} sinh K_1)^M ∈ ℝ`（証明では `htr` の `exact ⟨_, …⟩` の `_`。
  証明の中の名前 `m` は `M = m + 1` の自然数で、人手の `r` とは別）
- 運ぶ段 `hV`: `vPlusDataOf` の `V^{(+)}` は `VPlus` の形で持つので、
  `vPlusDataOf_V` と `VPlusOfTransfer_eq_VPlus`（`K_2^* = Kstar K_2` は `IsingParam.K2star` の定義）で (1) の `V^{(+)}` へ戻す（運ぶ段 `hV`）
- (2) の含意の鎖 3 行（証明の `h1`・`htr`・`heta`）:
  - 1 行目 `tr(εV^{(+)}) = r_ℂ` かつ `r ∈ ℝ_{>0}`（`∵` (1) とその等号と `∈ ℝ_{>0}` の読み方）: (1) の `h1`。
    Lean の (1) は `∈ ℝ_{>0}` を `0 < Re tr(εV^{(+)})` で持つので、等号で書き換えて `0 < r` を読む（運ぶ段）
  - 2 行目 `tr(εV^{(+)}) > 0`（ℂ の元の `z > 0` の定め方。存在する実数として `r` を取る）: `htr : ∃ s ∈ ℝ_{>0}, tr(εV^{(+)}) = s_ℂ`
  - 3 行目 `η_{(1,…,1)} = +1`: `trace_of_epsilon_V_plus_via_check_eigenvalues` (3) の `⟸`（`VPlusData.eta_univ_eq_one_iff_trace_pos`）
- `εQ̌_{(1,…,1)} = η_{(1,…,1)}Q̌_{(1,…,1)} = 1_ℂQ̌_{(1,…,1)} = Q̌_{(1,…,1)}` の 3 行（証明の `hεQ`）:
  `CheckFermi.epsilon_mul_Qproj_univ_of_eta`（`TheoremMaxEigenvectorInEvenSector.lean`。`max_eigenvector_in_even_sector` (4) の 1 つ目の鎖と同じ 3 行）
- `y = Q̌_{(1,…,1)}x` からの `Q̌_{(1,…,1)}y = y` の 4 行（証明の `hy`）: `CheckFermi.Qproj_univ_mulVec_of_mem_range`
  （(4) の 2 つ目の鎖と同じ 4 行。3 行目の冪等性は人手 `check_joint_eigenspace_decomposition` (1) と 1 対 1 の
  `CheckFermiSetup.Qproj_mul_self` から運んだ `checkFermiOf_Qproj_univ_mul_self`）
- `εy = ε(Q̌_{(1,…,1)}y) = (εQ̌_{(1,…,1)})y = Q̌_{(1,…,1)}y = y` の 4 行: 証明の最後の `calc`
  （2 行目の `mat_mult_associative` は具体版が無いので `Matrix.mulVec_mulVec`。(4) の 3 つ目の鎖 `epsilon_mulVec_of_mem_range_univ` と同じ 4 行）

人手の主張は既存の主張を並べるだけなので、必要十分版は置かない
（(1) の証明が使う 1 次元開鎖のスピン和と、`exp(K_1εG)` の鎖が引く `exponential_series_of_even_odd_power_terms` のノルムの評価の
必要十分版は `NecSuf/OpenChainSpinSum.lean`・`NecSuf/EvenOddSeriesNormEstimate.lean` にある。(2) の各行が引く
`max_eigenvector_in_even_sector` の鎖は必要十分版を置かない（`TheoremMaxEigenvectorInEvenSector.lean` の冒頭）が、
3 行目が引く `epsilon_eigenvalue_on_check_Q` の必要十分版は `ClaimEpsilonEigenvalueOnCheckQ.lean` の冒頭が指す `NecSuf/ParityFermion.lean` ほかにある）。
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
  obtain ⟨m, rfl⟩ : ∃ m, M = m + 1 := ⟨M - 1, by omega⟩
  set F := checkFermiOf P (Nat.succ_ne_zero m) with hF
  set D := vPlusDataOf P (Nat.succ_ne_zero m) P.c2_mul_s2star_eq_c2star with hD
  -- (2) 含意の鎖の 1 行目 `tr(εV^{(+)}) = r_ℂ` かつ `r ∈ ℝ_{>0}` は (1) の `h1`。
  -- 2 行目: `tr(εV^{(+)}) > 0`（ℂ の元の `z > 0` の定め方で、存在する実数として人手の `r`（下の `_`）を取る）
  have htr : ∃ s : ℝ, 0 < s ∧ (epsilon (m + 1) * D.V).trace = (s : ℂ) := by
    have hV : D.V = VPlusOfTransfer (m + 1) (P.K1 : ℂ) P.K2 := by
      rw [hD, vPlusDataOf_V, IsingParam.K2star, ← VPlusOfTransfer_eq_VPlus P.K2_pos]
    obtain ⟨heq, hpos⟩ := h1
    rw [heq, Complex.ofReal_re] at hpos
    exact ⟨_, hpos, hV ▸ heq⟩
  -- (2) 含意の鎖の 3 行目: `η_{(1,…,1)} = +1`（∵ `trace_of_epsilon_V_plus_via_check_eigenvalues` (3) の同値）
  have heta : F.eta Finset.univ = 1 := D.eta_univ_eq_one_iff_trace_pos.mpr htr
  -- `εQ̌_{(1,…,1)} = η_{(1,…,1)}Q̌_{(1,…,1)} = 1_ℂQ̌_{(1,…,1)} = Q̌_{(1,…,1)}` の 3 行
  have hεQ : epsilon (m + 1) * F.Qproj Finset.univ = F.Qproj Finset.univ :=
    F.epsilon_mul_Qproj_univ_of_eta heta
  -- `y ∈ im Q̌_{(1,…,1)}` を `y = Q̌_{(1,…,1)}x` と取り、`Q̌_{(1,…,1)}y = Q̌(Q̌x) = (Q̌Q̌)x = Q̌x = y` の 4 行
  set y := F.Qproj Finset.univ *ᵥ x with hyx
  have hy : F.Qproj Finset.univ *ᵥ y = y :=
    F.Qproj_univ_mulVec_of_mem_range (checkFermiOf_Qproj_univ_mul_self P) hyx
  -- `εy = ε(Q̌_{(1,…,1)}y) = (εQ̌_{(1,…,1)})y = Q̌_{(1,…,1)}y = y`
  calc epsilon (m + 1) *ᵥ y
      = epsilon (m + 1) *ᵥ (F.Qproj Finset.univ *ᵥ y) := by rw [hy]   -- 人手 1: 直前の鎖の `Q̌_{(1,…,1)}y = y`
    _ = (epsilon (m + 1) * F.Qproj Finset.univ) *ᵥ y :=
          Matrix.mulVec_mulVec _ _ _                                -- 人手 2: `mat_mult_associative`
    _ = F.Qproj Finset.univ *ᵥ y := by rw [hεQ]                     -- 人手 3: 上の鎖の `εQ̌_{(1,…,1)} = Q̌_{(1,…,1)}`
    _ = y := hy                                                     -- 人手 4: 直前の鎖の `Q̌_{(1,…,1)}y = y`

end Ising2D
