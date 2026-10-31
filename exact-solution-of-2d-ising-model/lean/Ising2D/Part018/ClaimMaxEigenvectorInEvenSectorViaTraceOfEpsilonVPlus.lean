/-
# `tr(εV^{(+)}) > 0` から `im Q̌_{(1,…,1)} ⊆ 𝓕^{(+)}`

対応する人手証明（正本は `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`）:

* `eigenvector_of_max_eigenvalue_claim_trace_positive_implies_even_eigenvector`
  （ラベル **`max_eigenvector_in_even_sector_via_trace_of_epsilon_V_plus`**）

主張（`K_1, K_2 > 0`）:

1. `tr(εV^{(+)}) = (2e^{−K_2} cosh K_1)^M + (2e^{K_2} sinh K_1)^M ∈ ℝ_{>0}`
2. `im Q̌_{(1,…,1)} ⊆ 𝓕^{(+)}`

`V^{(+)}` は `vPlusDataOf P hM _` の `V`（`VPlus M …` そのもの）、`Q̌_{(1,…,1)}` は
`(checkFermiOf P hM).Qproj Finset.univ`、`𝓕^{(+)}` の元であることは `ε *ᵥ y = y`。

## 人手証明との対応

- (2) 1 行目 `tr(εV^{(+)}) > 0`: 仮定 `htr`（下記）
- (2) 2 行目 `η_{(1,…,1)} = +1`: `trace_of_epsilon_V_plus_via_check_eigenvalues` の同値
  （`VPlusData.eta_univ_eq_one_of_trace_pos`）
- (2) 3 行目 `εQ̌_{(1,…,1)} = Q̌_{(1,…,1)}` と、`y = Q̌_{(1,…,1)}y` からの `εy = y` の式変形 3 行:
  `max_eigenvector_in_even_sector` (4) の証明と同じ計算（`VPlusData.mem_evenSector_of_mem_range_univ`。
  中で `VPlusData.epsilon_mul_Qproj_univ` と `Matrix.mulVec_mulVec` を使う）

## 仮定として残っているもの

(1) の等式 `tr(εV^{(+)}) = (2e^{−K_2} cosh K_1)^M + (2e^{K_2} sinh K_1)^M`（人手 `trace_of_epsilon_V_plus`）は、
Lean の通しの証明の項目 4 の残り（`tr(εV^{(+)}) > 0` の本体）で形式化中であり、まだ Lean の定理が無い。
したがって本ファイルは (1) の正値性を仮定 `htr` として受け取り、(2) の含意だけを証明する
（`Theorem007_MaxEigenvectorEvenSector.lean` と同じ扱い）。

人手の主張は既存の主張を並べるだけなので、必要十分版は置かない
（各行の必要十分版は `Ising2D/NecSuf/ParityFermion.lean` が持つ）。
-/
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.ClaimVPlusDataFromEigenvaluesOfVPlus
import Ising2D.Part018.Theorem007_MaxEigenvectorEvenSector

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- **人手 `max_eigenvector_in_even_sector_via_trace_of_epsilon_V_plus` の (2)**:
`tr(εV^{(+)}) > 0` ならば `η_{(1,…,1)} = +1` であり、`im Q̌_{(1,…,1)} ⊆ 𝓕^{(+)}`。 -/
theorem max_eigenvector_in_even_sector_via_trace_of_epsilon_V_plus (P : IsingParam) (hM : M ≠ 0)
    (htr : 0 < ((epsilon M * VPlus M (Real.sinh (2 * P.K2)) (P.K1 : ℂ) (P.K2star : ℂ)).trace).re) :
    (checkFermiOf P hM).eta (Finset.univ : Finset (Fin M)) = 1
      ∧ ∀ y : Conf M → ℂ,
          (checkFermiOf P hM).Qproj (Finset.univ : Finset (Fin M)) *ᵥ y = y →
            epsilon M *ᵥ y = y := by
  set D := vPlusDataOf P hM P.c2_mul_s2star_eq_c2star with hD
  have htr' : 0 < ((epsilon M * D.V).trace).re := by
    rw [hD, vPlusDataOf_V]; exact htr
  exact ⟨D.eta_univ_eq_one_of_trace_pos htr',  -- 人手 (2) の 2 行目
    fun y hy => D.mem_evenSector_of_mem_range_univ htr' hy⟩  -- 人手 (2) の 3 行目と y の式変形

end Ising2D
