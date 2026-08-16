/-
人手証明「開境界正方形の密度の列は Cauchy 列である（q は 1 以下）」
（`claim_open_square_density_sequence_cauchy_le_one`）の具体版。

`0 < q ≤ 1` のとき、列 `L ↦ Ψ^op_L(q)` は `def_rational_log_order_group_cauchy_sequence` の Cauchy 列である。
準備の第一: 核 `Γ(q)` は非負（`claim_open_square_density_difference_bound_core_nonneg_le_one`）なので
Archimedes 性（`claim_rational_log_order_group_archimedean`）で `Γ(q) ≤ n·ε` の `n` を取り、
`a := n+2`、`N := a²`。ℕ の事実 `1 ≤ a`、`n ≤ a`、`a < a²`、`1 ≤ N`。
準備の第二: `N ≤ L`、`N ≤ M` から `a < L`、`a < M`、`a² ≤ L`、`a² ≤ M`。
準備の第三: `(1/a)·Γ(q) ≤ ε`（`claim_rational_log_order_group_div_ge_multiplier_le`）。
上端: `Ψ_L + (−Ψ_M) ≤ R_a`（差の上からの評価）`= (1/a)·Γ(q)`（核の等式を右から左）`≤ ε`。
下端: `−ε ≤ −((1/a)·Γ(q))`（逆元の順序反転）`= −R_a`（核の等式）`≤ Ψ_L + (−Ψ_M)`（差の下からの評価）。
推移律は `claim_rational_log_order_group_linear_order`。
住処は ℕ・ℚ・Λ_ℚ のみで、ℝ / ℂ は現れない。

人手証明の列は `L ≥ 1` の上の写像だが、`IsCauchyRationalLogOrder` は `ℕ → Λ_ℚ` を受けるので、
`L = 0` では `0` を置く。Cauchy 性の定義は `N ≥ 1` 以上の添字しか見ないので、この値は使われない。
-/
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupCauchySequence
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupArchimedean
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupDivGeMultiplierLe
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupNegReversesOrder
import Ising2DLambda.ThermodynamicLimit.OpenSquareLargeSidesDensityDifferenceUpper
import Ising2DLambda.ThermodynamicLimit.OpenSquareLargeSidesDensityDifferenceLower
import Ising2DLambda.ThermodynamicLimit.OpenSquareDensityDifferenceBoundCore
import Ising2DLambda.ThermodynamicLimit.OpenSquareDensityDifferenceBoundCoreNonneg

namespace Ising2DLambda.ThermodynamicLimit

/-- 列 `L ↦ Ψ^op_L(q)`（`L = 0` では `0`。Cauchy 性の定義は `L ≥ 1` しか見ない）。 -/
noncomputable def openSquareDensitySequence (q : ℚ) : ℕ → RationalLogOrderGroup :=
  fun L => if h : L = 0 then 0 else
    haveI : NeZero L := ⟨h⟩
    openScaledFreeEntropy L q

/-- `L ≠ 0` では列の値は `Ψ^op_L(q)` そのものである。 -/
theorem openSquareDensitySequence_of_ne_zero (q : ℚ) (L : ℕ) [hL : NeZero L] :
    openSquareDensitySequence q L = openScaledFreeEntropy L q := by
  unfold openSquareDensitySequence
  rw [dif_neg hL.out]

/-- 主張。`0 < q ≤ 1` のとき `L ↦ Ψ^op_L(q)` は Cauchy 列である。 -/
theorem isCauchyRationalLogOrder_openSquareDensitySequence_of_le_one
    {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    IsCauchyRationalLogOrder (openSquareDensitySequence q) := by
  intro ε hε hne
  -- 準備の第一: 核は非負、Archimedes 性の倍率 n、a := n+2、N := a²
  have hcore0 : rationalLogOrderLE 0 (openSquareDensityDifferenceBoundCore q) :=
    rationalLogOrderLE_zero_openSquareDensityDifferenceBoundCore_of_le_one hq0 hq1
  obtain ⟨n, hn⟩ :=
    rationalLogOrderLE_natSmul_of_pos (openSquareDensityDifferenceBoundCore q) ε hcore0 hε hne
  set a : ℕ := n + 2 with ha_def
  have ha1 : 1 ≤ a := by omega
  have hna : n ≤ a := by omega
  have haa : a < a ^ 2 := by nlinarith
  haveI : NeZero a := ⟨by omega⟩
  refine ⟨a ^ 2, ?_, ?_⟩
  · -- N = a² ≥ 1
    exact le_trans ha1 (le_of_lt haa)
  intro L M hL hM
  -- 準備の第二: 辺の条件
  have haL : a < L := lt_of_lt_of_le haa hL
  have haM : a < M := lt_of_lt_of_le haa hM
  haveI : NeZero L := ⟨by omega⟩
  haveI : NeZero M := ⟨by omega⟩
  -- 準備の第三: (1/a)·Γ(q) ≤ ε（claim_rational_log_order_group_div_ge_multiplier_le）
  have hdiv : rationalLogOrderLE (((1 : ℚ) / a) • openSquareDensityDifferenceBoundCore q) ε :=
    rationalLogOrderLE_inv_natSmul_le_of_le_natSmul hε ha1 hna hn
  -- 核の等式 (1/a)·Γ(q) = R_a（claim_open_square_density_difference_bound_is_core_over_base_side）
  have hcore := one_div_smul_openSquareDensityDifferenceBoundCore a q
  -- 差の上下の評価
  have hup := rationalLogOrderLE_openSquareLargeSidesDensityDifference_upper_of_le_one
    a L M haL haM hL hM hq0 hq1
  have hlow := rationalLogOrderLE_openSquareLargeSidesDensityDifference_lower_of_le_one
    a L M haL haM hL hM hq0 hq1
  -- R_a を (1/a)·Γ(q) へ読み替える（核の等式を右から左）
  rw [← hcore] at hup hlow
  -- 列の差は Ψ_L + (−Ψ_M)
  have hseq : openSquareDensitySequence q L - openSquareDensitySequence q M =
      openScaledFreeEntropy L q + -(openScaledFreeEntropy M q) := by
    rw [openSquareDensitySequence_of_ne_zero, openSquareDensitySequence_of_ne_zero, sub_eq_add_neg]
  rw [hseq]
  refine ⟨?_, ?_⟩
  · -- 下端: −ε ≤ −((1/a)·Γ(q)) ≤ Ψ_L + (−Ψ_M)
    exact rationalLogOrderLE_trans (rationalLogOrderLE_neg_le_neg hdiv) hlow
  · -- 上端: Ψ_L + (−Ψ_M) ≤ (1/a)·Γ(q) ≤ ε
    exact rationalLogOrderLE_trans hup hdiv

end Ising2DLambda.ThermodynamicLimit
