/-
# 2 次元 Ising 模型の厳密解（Onsager の自由エネルギー）（具体版）

正本: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`
（`closing_010_theorem_onsager_exact_solution`、ラベル **`onsager_exact_solution`**。その証明の Step 2 が引く
`column_limit_claim_c_between_Lambda_half_and_twice_Lambda_half`、ラベル **`c_between_Lambda_half_and_twice_Lambda_half`** も同じファイルにある）

**本プロジェクトの結論である。**

## 人手証明との対応

| 人手証明 | 本ファイル |
| --- | --- |
| Step 1（`N_row → ∞`） | `onsager_limit_in_N_row`（章 012 の `Ising2D.limit_of_log_Z_in_N_row`） |
| Step 2（`c_between_Lambda_half_and_twice_Lambda_half` を引く `Λ^{(1/2)}_M ≤ c(M) ≤ 2Λ^{(1/2)}_M`） | 通しの定理では `rayleighSup_sandwich_LambdaM_physical`（`TheoremOnsagerUnconditional.lean`。下の 2 行の組で、Step 2 は `c_le_twice_c_plus_physical`）。本ファイルの条件つきの `onsager_exact_solution` は仮定 `hc` で受け取る |
| `c_between_Lambda_half_and_twice_Lambda_half` Step 1（`c(M) ≥ c_+(M) = Λ^{(1/2)}_M`） | `EvenSectorBridge.LambdaM_le_rayleighSup`（`c_plus_le_c` と `c_plus_equals_Lambda_half_integer`（`EvenSectorBridge.c_plus_equals_lamMax`）） |
| `c_between_Lambda_half_and_twice_Lambda_half` Step 2（`c(M) ≤ 2c_+(M) = 2Λ^{(1/2)}_M`） | `c_le_twice_c_plus_physical`（準備の各行と 3 つの鎖と 1 対 1。通しの定理はこれを `rayleighSup_sandwich_LambdaM_physical` から引く） |
| Step 3（挟み撃ち、`M → ∞`） | `onsager_limit_in_M`（`log` の単調性、`(log 2)/M → 0`、章 012 の `Ising2D.onsager_free_energy_expression` を `δ = 1/2` で適用） |
| 主張 | `onsager_exact_solution` |

人手 `c_between_Lambda_half_and_twice_Lambda_half` の Step 2 は、`W_ℝ`・`ε_ℝ` について、`u_k := |x_k|`・
`v_k := u_k + (ε_ℝu)_k`・`v̂_k := v_k/‖v‖` の性質を本文の主張（`real_bilinear_value_at_most_value_at_absolute_vector`・
`epsilon_real_fixes_sum_of_vector_and_its_image`・`norm_squared_of_sum_of_unit_vector_and_its_epsilon_real_image_is_at_most_four`・
`W_real_bilinear_value_at_sum_of_nonnegative_vector_and_its_epsilon_real_image_is_at_least_twice`・
`real_matrix_fixed_vector_stays_fixed_after_normalization`・`real_bilinear_value_of_normalized_vector` ほか）で 1 つずつ引く。
具体版 `c_le_twice_c_plus_physical` は、具体的な `W_ℝ = ϱ(W)`（`M_col = n + 1`）と `ε_ℝ = epsilonReal n` について、
その準備の各行と鎖の各行を同じ順に引く。

`onsager_step3_c_le_two_c_plus` と `EvenSectorBridge.rayleighSup_le_two_mul_LambdaM`・`rayleighSup_sandwich_LambdaM` は、
任意の橋渡し `EvenSectorBridge` の `W` について、記録 `NecSuf.rayleighSup_le_two_mul_evenSectorRayleighSup`
（`NecSuf/EvenSectorUpperBound.lean`。人手の Step 2 が `W_ℝ`・`ε_ℝ` で書き直される前の形の形式化で、今の Step 2 の必要十分版ではない）を
`ε = epsilonR M` で特殊化したもので、人手の鎖と 1 対 1 ではない。形式化の記録として残し、通しの定理はこれらを使わない。

以前の形式化は、本文から参照用ノート `structured-latex/notes/minus_sector_not_adopted.ts` へ退避した
章 019 の `c_equals_c_plus`（`c(M) = max(c_+, c_-) = c_+(M)`）を使って挟み撃ちなしに
`c(M) = Λ^{(1/2)}_M` を出していた。いまは人手の本文と同じく、`c_-(M)` に触れない
`Λ ≤ c(M) ≤ 2Λ` の挟み撃ちで述べる。章 019 の Lean（`RoutesNotAdopted/MinusSector/`）は形式化の記録として残してあり、
本ファイルはそれに依存しない。

本ファイルには必要十分版を置かない。`c_between_Lambda_half_and_twice_Lambda_half` の Step 2 の具体版 `c_le_twice_c_plus_physical` は、
準備で本文の主張を 1 つずつ引き、それらの結論を上限の性質と ℝ の四則演算・大小でつなぐだけで、引いた主張の外に
取り払える構造を持たない（`ε_ℝ`・`W_ℝ` のどの性質が効くかは、引いた各主張のファイルが書いている）。Step 1・Step 3 は
既存の必要十分版（`NecSuf/LogSqueeze.lean` の `abs_log_div_sub_log_le_of_sandwich`、
`NecSuf/RiemannSum.lean` の `tendsto_riemann_sum`）を章 012 が既に系として使っており、本ファイルは
それらの具体版を接続するだけだからである。
-/
import Ising2D.ThermodynamicLimit.ColumnLimitAndClosedForm.TheoremCPlusEqualsLambda
import Ising2D.ThermodynamicLimit.ColumnLimitAndClosedForm.ClaimCPlusLeC
import Ising2D.NecSuf.EvenSectorUpperBound
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.ClaimLimitInNRow
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.TheoremOnsagerFreeEnergy
import Ising2D.ThermodynamicLimit.ColumnLimitAndClosedForm.ClaimEpsilonRealCommutesWithWRealAndWRealHasPositiveEntries
import Ising2D.ThermodynamicLimit.ColumnLimitAndClosedForm.ClaimSumOfNonnegativeVectorAndItsEpsilonRealImageIsNonzero
import Ising2D.ThermodynamicLimit.ColumnLimitAndClosedForm.ClaimEpsilonRealFixesSumOfVectorAndItsImage
import Ising2D.ThermodynamicLimit.ColumnLimitAndClosedForm.ClaimNormSquaredOfSumOfUnitVectorAndItsEpsilonRealImageIsAtMostFour
import Ising2D.ThermodynamicLimit.ColumnLimitAndClosedForm.ClaimWRealBilinearValueAtSumOfNonnegativeVectorAndItsEpsilonRealImageIsAtLeastTwice
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.ClaimRealBilinearValueAtMostValueAtAbsoluteVector
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.ClaimNormOfVectorOfAbsoluteValuesEqualsNorm
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.ClaimNormOfNormalizedRealVectorIsOne
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.ClaimRealMatrixFixedVectorStaysFixedAfterNormalization
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.ClaimRealBilinearValueOfNormalizedVector
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimRealBilinearValueWithNonnegativeEntriesAndScalarMultiple

namespace Ising2D

open Matrix Filter
open scoped Topology

variable {M : ℕ}

/-! ## `c_between_Lambda_half_and_twice_Lambda_half` の Step 2 の不等式 `c(M) ≤ 2c_+(M)` -/

/-- 人手 `c_between_Lambda_half_and_twice_Lambda_half` Step 2 の主張を、成分が正で `ε` と可換な実対称行列 `W` 一般について
記録 `NecSuf.rayleighSup_le_two_mul_evenSectorRayleighSup`（Step 2 の前の形の形式化。今の Step 2 の必要十分版ではない）から
`ε = epsilonR M = permMat flipConf` で特殊化したもの（形式化の記録）。
人手の鎖と 1 対 1 の具体版は `c_le_twice_c_plus_physical`（下）で、通しの定理はそちらを引く。 -/
theorem onsager_step3_c_le_two_c_plus {W : Matrix (Conf M) (Conf M) ℝ} (hW : W.IsSymm)
    (hpos : ∀ k l, 0 < W k l)
    (hcomm : epsilonR M * W = W * epsilonR M) :
    rayleighSup W ≤ 2 * evenSectorRayleighSup W (epsilonR M) :=
  NecSuf.rayleighSup_le_two_mul_evenSectorRayleighSup hW (fun k l => (hpos k l).le)
    flipConf_involutive hcomm

/-- **人手証明 `c_between_Lambda_half_and_twice_Lambda_half` Step 2 の具体版**（人手の準備と 3 つの鎖と 1 対 1）:
`d = 2^{M_col}`、`M_col = n + 1`、`W_ℝ = ϱ(W)`（`def_W_real`）、`ε_ℝ`（`def_epsilon_real`）について、
`Λ = c_+(M_col)`（人手は `c_plus_equals_Lambda_half_integer` で与える。ここでは仮定 `hΛ`）なら `c(M_col) ≤ 2Λ`。

- 人手の `x ∈ ℝ^d`、`‖x‖ = 1` は、Lean の `𝓡`（`rayleighSet`）の条件 `vecNormSq x = 1`（`‖x‖^2 = 1`）で受け取り、
  `‖x‖ = √1 = 1` に読み直してから準備に入る（`DefinitionRayleighSup.lean` の `abs_component_le_one_of_unit` と同じ）。
- 人手の `u, v, v̂` は成分の等式で置く。Lean も `u k := |x k|`・`v k := u k + (ε_ℝu) k`・`v̂ k := v k / ‖v‖` の関数として置き、
  引く主張の成分の仮定は `fun k => rfl` で渡す。
- 人手の `v̂^⊤W_ℝv̂ ∈ 𝓡_+`（`def_sector_rayleigh_sup`、`x → v̂`）は `evenSectorSet` の元であることで、条件 `‖v̂‖ = 1` は
  Lean の `vecNormSq v̂ = 1` に `vecNorm_sq`（`‖v̂‖^2 = vecNormSq v̂`）で読み替える。
- 人手の `‖v‖^2 := ‖v‖‖v‖` は Lean の `vecNorm v ^ 2` である。 -/
theorem c_le_twice_c_plus_physical (n : ℕ) (K1 : ℝ) {K2 : ℝ} (hK2 : 0 < K2) (Λ : ℝ)
    (hΛ : Λ = evenSectorRayleighSup
      (realMatrixOfRealEntries (physicalSymTransferC (n + 1) K1 K2)
        (physicalSymTransferC_hasRealEntries K1 hK2)) (epsilonReal n)) :
    rayleighSup (realMatrixOfRealEntries (physicalSymTransferC (n + 1) K1 K2)
        (physicalSymTransferC_hasRealEntries K1 hK2)) ≤ 2 * Λ := by
  set W := realMatrixOfRealEntries (physicalSymTransferC (n + 1) K1 K2)
    (physicalSymTransferC_hasRealEntries K1 hK2) with hWdef
  -- 準備: `W_real_has_positive_entries` より `(W_ℝ)_kl > 0`、とくに `(W_ℝ)_kl ≥ 0`
  have hWnn : ∀ k l, 0 ≤ W k l := fun k l => (W_real_has_positive_entries K1 hK2 k l).le
  -- 各 `x`（`‖x‖ = 1`）で `x^⊤W_ℝx ≤ 2Λ`
  have hbound : ∀ x : Conf (n + 1) → ℝ, vecNormSq x = 1 → x ⬝ᵥ W *ᵥ x ≤ 2 * Λ := by
    intro x hx1
    have hxnorm : vecNorm x = 1 := by rw [vecNorm, hx1, Real.sqrt_one]       -- Lean の `𝓡` の条件を `‖x‖ = 1` に読む
    set u : Conf (n + 1) → ℝ := fun k => |x k| with hu
    set v : Conf (n + 1) → ℝ := fun k => u k + (epsilonReal n *ᵥ u) k with hv
    set vhat : Conf (n + 1) → ℝ := fun k => v k / vecNorm v with hvhat
    -- 準備: `def_real_absolute_value`（`q → x_k`）の `|q| ≥ 0` より `u_k ≥ 0`
    have hunn : ∀ k, 0 ≤ u k := fun k => abs_nonneg (x k)
    -- 準備: `real_bilinear_value_at_most_value_at_absolute_vector`（`P → W_ℝ`）より `x^⊤W_ℝx ≤ u^⊤W_ℝu`
    have hxu : x ⬝ᵥ W *ᵥ x ≤ u ⬝ᵥ W *ᵥ u :=
      real_bilinear_value_at_most_value_at_absolute_vector W hWnn x
    -- 準備: `‖u‖ = ‖x‖ = 1` の 2 行
    have hunorm : vecNorm u = 1 :=
      calc vecNorm u
          = vecNorm x := norm_of_vector_of_absolute_values_equals_norm x   -- `norm_of_vector_of_absolute_values_equals_norm`（`n → d`）
        _ = 1 := hxnorm                                                    -- `x` の取り方
    -- 準備: `matrix_norm_triangle_inequality` (1) の `‖u‖ = 0 ⟺ u = 0` と `‖u‖ = 1 ≠ 0` より `u ≠ 0`
    --（`K^n` の具体版は Lean に無いので、`vecNorm_pos_of_ne_zero` と同じく `vecNormSq_eq_zero_iff` と `Real.sqrt` の零で示す）
    have hu0 : u ≠ 0 := by
      intro h
      have h0 : vecNorm u = 0 := by
        rw [vecNorm, Real.sqrt_eq_zero (vecNormSq_nonneg u)]
        exact vecNormSq_eq_zero_iff.mpr h
      rw [hunorm] at h0
      exact one_ne_zero h0
    -- 準備: `sum_of_nonnegative_vector_and_its_epsilon_real_image_is_nonzero`（`u → u`）より `v ≠ 0`
    have hv0 : v ≠ 0 :=
      sum_of_nonnegative_vector_and_its_epsilon_real_image_is_nonzero n u v hunn hu0 (fun _ => rfl)
    -- 準備: `norm_of_normalized_real_vector_is_one`（`v → v`）より `‖v‖ > 0` かつ `‖v̂‖ = 1`、よって `‖v‖^2 > 0`
    have hvpos : 0 < vecNorm v := vecNorm_pos_of_ne_zero hv0
    have hvhatnorm : vecNorm vhat = 1 := norm_of_normalized_real_vector_is_one v vhat hv0 (fun _ => rfl)
    have hv2pos : 0 < vecNorm v ^ 2 := pow_pos hvpos 2                       -- 正の実数どうしの積
    -- 準備: `epsilon_real_fixes_sum_of_vector_and_its_image`（`u → u`）より `ε_ℝv = v`
    have hεv : epsilonReal n *ᵥ v = v := epsilon_real_fixes_sum_of_vector_and_its_image n u v (fun _ => rfl)
    -- 準備: `real_matrix_fixed_vector_stays_fixed_after_normalization`（`P → ε_ℝ`、`v → v`）より `ε_ℝv̂ = v̂`
    have hεvhat : ∀ i, (epsilonReal n *ᵥ vhat) i = vhat i :=
      real_matrix_fixed_vector_stays_fixed_after_normalization (epsilonReal n) v vhat hv0 (fun _ => rfl)
        (fun i => congrFun hεv i)
    -- 準備: `def_sector_rayleigh_sup`（`x → v̂`）より `v̂^⊤W_ℝv̂ ∈ 𝓡_+`
    have hvhat_mem : vhat ⬝ᵥ W *ᵥ vhat ∈ evenSectorSet W (epsilonReal n) :=
      ⟨vhat, funext hεvhat, by rw [← vecNorm_sq, hvhatnorm, one_pow], rfl⟩
    -- 準備: `norm_squared_of_sum_of_unit_vector_and_its_epsilon_real_image_is_at_most_four`（`u → u`）より `‖v‖^2 ≤ 4`、
    -- 正の数の逆数を取ると大小が逆になることから `1/‖v‖^2 ≥ 1/4`
    have hv4 : vecNorm v ^ 2 ≤ 4 :=
      norm_squared_of_sum_of_unit_vector_and_its_epsilon_real_image_is_at_most_four n u v hunorm (fun _ => rfl)
    have hinv : 1 / vecNorm v ^ 2 ≥ 1 / 4 := one_div_le_one_div_of_le hv2pos hv4
    -- 準備: `W_real_bilinear_value_at_sum_of_nonnegative_vector_and_its_epsilon_real_image_is_at_least_twice`（`u → u`）
    have hvW : v ⬝ᵥ W *ᵥ v ≥ 2 * (u ⬝ᵥ W *ᵥ u) :=
      W_real_bilinear_value_at_sum_of_nonnegative_vector_and_its_epsilon_real_image_is_at_least_twice
        n K1 hK2 u v hunn (fun _ => rfl)
    -- 準備: `real_bilinear_value_with_nonnegative_entries_is_nonnegative`（`P → W_ℝ`、`x → u`、`y → u`）、`2 > 0` を掛ける
    have huW : u ⬝ᵥ W *ᵥ u ≥ 0 :=
      real_bilinear_value_with_nonnegative_entries_is_nonnegative W hWnn u u hunn hunn
    have h2uW : 2 * (u ⬝ᵥ W *ᵥ u) ≥ 0 := mul_nonneg zero_le_two huW
    -- 主の 7 行の鎖
    have hchain : Λ ≥ x ⬝ᵥ W *ᵥ x / 2 :=
      calc Λ
          = evenSectorRayleighSup W (epsilonReal n) := hΛ                    -- `c_plus_equals_Lambda_half_integer`
        _ ≥ vhat ⬝ᵥ W *ᵥ vhat :=
            le_csSup (evenSectorSet_bddAbove W (epsilonReal n)) hvhat_mem   -- `def_sector_rayleigh_sup` の `sup 𝓡_+` は `𝓡_+` の上界
                                                                            --（`𝓡_+` が上に有界であることは `def_sector_rayleigh_sup` の `𝓡_+ ⊆ 𝓡` から）
        _ = (v ⬝ᵥ W *ᵥ v) / vecNorm v ^ 2 :=
            real_bilinear_value_of_normalized_vector W v vhat hv0 (fun _ => rfl) -- `real_bilinear_value_of_normalized_vector`（`P → W_ℝ`、`v → v`）
        _ ≥ 2 * (u ⬝ᵥ W *ᵥ u) / vecNorm v ^ 2 :=
            div_le_div_of_nonneg_right hvW hv2pos.le                        -- 準備の `v^⊤W_ℝv ≥ 2(u^⊤W_ℝu)` の両辺を正の数 `‖v‖^2` で割る
        _ ≥ 2 * (u ⬝ᵥ W *ᵥ u) / 4 := by
            rw [div_eq_mul_one_div _ (vecNorm v ^ 2), div_eq_mul_one_div _ (4 : ℝ)]
            exact mul_le_mul_of_nonneg_left hinv h2uW                       -- 準備の `1/‖v‖^2 ≥ 1/4` の両辺に非負の数 `2(u^⊤W_ℝu)` を掛ける
        _ = (u ⬝ᵥ W *ᵥ u) / 2 := by ring                                    -- `ℝ` の約分
        _ ≥ x ⬝ᵥ W *ᵥ x / 2 :=
            div_le_div_of_nonneg_right hxu zero_le_two                      -- 準備の `x^⊤W_ℝx ≤ u^⊤W_ℝu` の両辺を正の数 `2` で割る
    -- 続く 2 行
    calc x ⬝ᵥ W *ᵥ x
        = 2 * (x ⬝ᵥ W *ᵥ x / 2) := by ring                                  -- `ℝ` の四則演算
      _ ≤ 2 * Λ := mul_le_mul_of_nonneg_left hchain zero_le_two             -- 上の鎖の `x^⊤W_ℝx/2 ≤ Λ` の両辺に正の数 `2` を掛ける
  -- 最後の 2 行: `c(M) = sup 𝓡 ≤ 2Λ`
  calc rayleighSup W
      = sSup (rayleighSet W) := rfl                                         -- `def_rayleigh_sup`
    _ ≤ 2 * Λ := csSup_le (rayleighSet_nonempty W) (by
        rintro r ⟨x, hx1, rfl⟩
        exact hbound x hx1)                                                 -- 上限は上界のうち最小で、`2Λ` は `𝓡` の上界
                                                                            --（`𝓡` が空でないことは `def_rayleigh_sup` の `rayleighSet_nonempty`）

namespace EvenSectorBridge

variable {F : CheckFermi M} {D : VPlusData M F} (B : EvenSectorBridge M F D)

/-- `Λ̌_max = Λ^{(1/2)}_M`（章 012 の記法との突き合わせ）。 -/
theorem lamMax_eq_LambdaM (P : IsingParam)
    (hC : D.C = (2 * Real.sinh (2 * P.K2)) ^ ((M : ℝ) / 2))
    (hgam : ∑ μ : Fin M, D.gam μ
      = ∑ μ ∈ Finset.Icc 1 M, gammaFn P (tagPoint (1 / 2) M μ)) :
    D.lamMax = LambdaM P (1 / 2) M := by
  unfold VPlusData.lamMax checkLambda LambdaM
  rw [hC]
  congr 1
  congr 1
  rw [← hgam, Finset.mul_sum]
  exact Finset.sum_congr rfl fun μ _ => by
    rw [if_pos (Finset.mem_univ μ)]; ring

/-- **人手証明 `c_between_Lambda_half_and_twice_Lambda_half` Step 1**: `c(M) ≥ c_+(M) = Λ^{(1/2)}_M`
（`c_plus_le_c` と `c_plus_equals_Lambda_half_integer`）。 -/
theorem LambdaM_le_rayleighSup (P : IsingParam)
    (htr : 0 < ((epsilon M * D.V).trace).re)
    (hC : D.C = (2 * Real.sinh (2 * P.K2)) ^ ((M : ℝ) / 2))
    (hgam : ∑ μ : Fin M, D.gam μ
      = ∑ μ ∈ Finset.Icc 1 M, gammaFn P (tagPoint (1 / 2) M μ)) :
    LambdaM P (1 / 2) M ≤ rayleighSup B.W :=
  calc LambdaM P (1 / 2) M
      = evenSectorRayleighSup B.W (epsilonR M) := by
        rw [B.c_plus_equals_lamMax htr, lamMax_eq_LambdaM P hC hgam]
    _ ≤ rayleighSup B.W := c_plus_le_c B.W

/-- 人手 `c_between_Lambda_half_and_twice_Lambda_half` Step 2 の `c(M) ≤ 2c_+(M) = 2Λ^{(1/2)}_M` を、任意の橋渡しの `W` について
記録の特殊化 `onsager_step3_c_le_two_c_plus` から出したもの（形式化の記録。人手の鎖と 1 対 1 ではない。具体的な `W` では
`rayleighSup_sandwich_LambdaM_physical` が `c_le_twice_c_plus_physical` を引く）。 -/
theorem rayleighSup_le_two_mul_LambdaM (P : IsingParam)
    (htr : 0 < ((epsilon M * D.V).trace).re)
    (hpos : ∀ k l, 0 < B.W k l)
    (hcomm : epsilonR M * B.W = B.W * epsilonR M)
    (hC : D.C = (2 * Real.sinh (2 * P.K2)) ^ ((M : ℝ) / 2))
    (hgam : ∑ μ : Fin M, D.gam μ
      = ∑ μ ∈ Finset.Icc 1 M, gammaFn P (tagPoint (1 / 2) M μ)) :
    rayleighSup B.W ≤ 2 * LambdaM P (1 / 2) M :=
  calc rayleighSup B.W
      ≤ 2 * evenSectorRayleighSup B.W (epsilonR M) :=
        onsager_step3_c_le_two_c_plus B.hWsymm hpos hcomm
    _ = 2 * LambdaM P (1 / 2) M := by
        rw [B.c_plus_equals_lamMax htr, lamMax_eq_LambdaM P hC hgam]

/-- 人手 `c_between_Lambda_half_and_twice_Lambda_half`（Step 1・Step 2 を合わせた挟み撃ち）を任意の橋渡しの `W` について述べたもの:
`Λ^{(1/2)}_M ≤ c(M) ≤ 2Λ^{(1/2)}_M`。Step 2 は記録の特殊化 `onsager_step3_c_le_two_c_plus` を通す（形式化の記録）。
通しの定理は具体的な `W` の `rayleighSup_sandwich_LambdaM_physical` を引き、これを使わない。 -/
theorem rayleighSup_sandwich_LambdaM (P : IsingParam)
    (htr : 0 < ((epsilon M * D.V).trace).re)
    (hpos : ∀ k l, 0 < B.W k l)
    (hcomm : epsilonR M * B.W = B.W * epsilonR M)
    (hC : D.C = (2 * Real.sinh (2 * P.K2)) ^ ((M : ℝ) / 2))
    (hgam : ∑ μ : Fin M, D.gam μ
      = ∑ μ ∈ Finset.Icc 1 M, gammaFn P (tagPoint (1 / 2) M μ)) :
    LambdaM P (1 / 2) M ≤ rayleighSup B.W ∧ rayleighSup B.W ≤ 2 * LambdaM P (1 / 2) M :=
  ⟨B.LambdaM_le_rayleighSup P htr hC hgam, B.rayleighSup_le_two_mul_LambdaM P htr hpos hcomm hC hgam⟩

end EvenSectorBridge

/-! ## 2 重極限（人手証明 `onsager_exact_solution`） -/

/-- **人手証明 `onsager_exact_solution` Step 1**（章 012 の再掲）:
`M` を固定したときの `N_row → ∞` の極限は `(1/M) log c(M)`。 -/
theorem onsager_limit_in_N_row (P : IsingParam) {Z : ℕ → ℕ → ℝ} {cM : ℕ → ℝ}
    (hc : ∀ m : ℕ, 2 ≤ m → LambdaM P (1 / 2) m ≤ cM m ∧ cM m ≤ 2 * LambdaM P (1 / 2) m)
    (hZ1 : ∀ m : ℕ, 2 ≤ m → ∀ N, 1 ≤ N → cM m ^ N ≤ Z m N)
    (hZ2 : ∀ m : ℕ, 2 ≤ m → ∀ N, 1 ≤ N → Z m N ≤ 2 ^ m * cM m ^ N)
    {m : ℕ} (hm : 2 ≤ m) :
    Tendsto (fun N : ℕ => 1 / ((m : ℝ) * N) * Real.log (Z m N)) atTop
      (𝓝 (1 / (m : ℝ) * Real.log (cM m))) := by
  have hpos : 0 < cM m := lt_of_lt_of_le (LambdaM_pos P (1 / 2) m) (hc m hm).1
  exact limit_of_log_Z_in_N_row hm hpos (hZ1 m hm) (hZ2 m hm)

/-- **人手証明 `onsager_exact_solution` Step 3**: `Λ ≤ c(M) ≤ 2Λ` と `log` の単調性から
`(1/M)log Λ ≤ (1/M)log c(M) ≤ (1/M)log Λ + (log 2)/M`。`(log 2)/M → 0` と
`onsager_free_energy_expression`（`δ = 1/2`）で挟み撃ちにして、`M → ∞` の極限が Onsager の表式になる。 -/
theorem onsager_limit_in_M (P : IsingParam) {cM : ℕ → ℝ}
    (hc : ∀ m : ℕ, 2 ≤ m → LambdaM P (1 / 2) m ≤ cM m ∧ cM m ≤ 2 * LambdaM P (1 / 2) m) :
    Tendsto (fun m : ℕ => 1 / (m : ℝ) * Real.log (cM m)) atTop
      (𝓝 (1 / 2 * Real.log (2 * Real.sinh (2 * P.K2))
        + 1 / (4 * Real.pi) * ∫ θ in (0 : ℝ)..(2 * Real.pi), gammaFn P θ)) := by
  have hbase := onsager_free_energy_expression P (δ := 1 / 2) (by norm_num) (by norm_num)
  have hupper := hbase.add (tendsto_const_div_atTop_nhds_zero_nat (Real.log 2))
  rw [add_zero] at hupper
  refine tendsto_of_tendsto_of_tendsto_of_le_of_le' hbase hupper ?_ ?_
  · filter_upwards [Filter.eventually_ge_atTop 2] with m hm
    have hΛ : 0 < LambdaM P (1 / 2) m := LambdaM_pos P (1 / 2) m
    have hm0 : (0 : ℝ) ≤ 1 / (m : ℝ) := by positivity
    exact mul_le_mul_of_nonneg_left (Real.log_le_log hΛ (hc m hm).1) hm0
  · filter_upwards [Filter.eventually_ge_atTop 2] with m hm
    have hΛ : 0 < LambdaM P (1 / 2) m := LambdaM_pos P (1 / 2) m
    have hcpos : 0 < cM m := lt_of_lt_of_le hΛ (hc m hm).1
    have hm0 : (0 : ℝ) ≤ 1 / (m : ℝ) := by positivity
    have hlog : Real.log (cM m) ≤ Real.log 2 + Real.log (LambdaM P (1 / 2) m) := by
      rw [← Real.log_mul two_ne_zero hΛ.ne']
      exact Real.log_le_log hcpos (hc m hm).2
    calc 1 / (m : ℝ) * Real.log (cM m)
        ≤ 1 / (m : ℝ) * (Real.log 2 + Real.log (LambdaM P (1 / 2) m)) :=
          mul_le_mul_of_nonneg_left hlog hm0
      _ = 1 / (m : ℝ) * Real.log (LambdaM P (1 / 2) m) + Real.log 2 / (m : ℝ) := by ring

/-- **人手証明 `onsager_exact_solution` そのもの**:

  `lim_{M→∞} lim_{N_row→∞} (1/(M N_row)) log Z = (1/2)log(2 sinh 2K_2) + (1/4π)∫₀^{2π} γ(θ)dθ`

**仮定は次の 3 つだけである。**

* `hZ1`, `hZ2`: 章 011 の `partition_function_sandwich`
  （`N_row ≥ 1` について `c(M)^{N_row} ≤ Z ≤ 2^M c(M)^{N_row}`）
* `hc`: Step 2 の挟み撃ち（人手 `c_between_Lambda_half_and_twice_Lambda_half`） `Λ^{(1/2)}_M ≤ c(M) ≤ 2Λ^{(1/2)}_M`
  （通しの定理では `Ising2D.rayleighSup_sandwich_LambdaM_physical` で与えられる）

**実数解析（Riemann 積分）を使うのは `Ising2D.riemann_sum_to_integral` を経由する
最後の等号だけである**（人手証明の最終段落と同じ）。 -/
theorem onsager_exact_solution (P : IsingParam) {Z : ℕ → ℕ → ℝ} {cM : ℕ → ℝ}
    (hc : ∀ m : ℕ, 2 ≤ m → LambdaM P (1 / 2) m ≤ cM m ∧ cM m ≤ 2 * LambdaM P (1 / 2) m)
    (hZ1 : ∀ m : ℕ, 2 ≤ m → ∀ N, 1 ≤ N → cM m ^ N ≤ Z m N)
    (hZ2 : ∀ m : ℕ, 2 ≤ m → ∀ N, 1 ≤ N → Z m N ≤ 2 ^ m * cM m ^ N) :
    (∀ m : ℕ, 2 ≤ m →
        Tendsto (fun N : ℕ => 1 / ((m : ℝ) * N) * Real.log (Z m N)) atTop
          (𝓝 (1 / (m : ℝ) * Real.log (cM m))))
      ∧ Tendsto (fun m : ℕ => 1 / (m : ℝ) * Real.log (cM m)) atTop
          (𝓝 (1 / 2 * Real.log (2 * Real.sinh (2 * P.K2))
            + 1 / (4 * Real.pi) * ∫ θ in (0 : ℝ)..(2 * Real.pi), gammaFn P θ)) :=
  ⟨fun m hm => onsager_limit_in_N_row P hc hZ1 hZ2 hm, onsager_limit_in_M P hc⟩

end Ising2D
