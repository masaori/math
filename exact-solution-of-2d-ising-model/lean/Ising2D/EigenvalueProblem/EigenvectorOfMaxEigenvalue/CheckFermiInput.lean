/-
# 章 018 の設定（章 014–017 からの入力を「仮定」として明示する）

正本: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`（`epsilon_anticommutes_with_check_Z_Y` から `max_eigenvector_in_even_sector` まで）と `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`（`check_number_operator_is_hermitian` 以降）。

## なぜ仮定を置くのか（一次情報）

章 018 は半整数運動量のフェルミオン `ψ̌_μ^†, ψ̌_μ`（原文 `def_check_fermi`）、
個数演算子 `ň_μ`（`def_check_number_operator`）、同時固有射影 `Q̌_ε`
（`check_joint_eigenspace_decomposition`）、`V^{(+)}` の固有値
（`eigenvalues_of_V_plus`）の上に立つ。これらは**章 014–017 の内容**である。
本ファイルが章 017 の具体版 `EigenvalueProblem/EigenvaluesOfVPlus/DefinitionCheckNumberOperator.lean` から
使うのは、`Mat(2^M, ℂ)` に 2-捩れが無いこと `tensorPow_two_torsion_free` だけである。

本ファイルは**章 014–017 から受け取る入力だけを束ねた構造 `Ising2D.CheckFermi`** を置き、
章 018 の主張はすべてそこからの帰結として証明する。仮定の内訳は次のとおりで、
**いずれも章 014–017 の主張そのままである**。

| `CheckFermi` の場 | 原文の主張 | 章 |
| --- | --- | --- |
| `hcre` / `hann` | `ψ̌_μ^†, ψ̌_μ` は `Ž_μ, Y̌_μ` の ℂ 係数 1 次結合（`def_check_fermi`） | 016 |
| `acomm_cre_cre` ほか 3 本 | `ψ̌` の正準反交換関係（`anticommutator_of_check_psi`） | 016 |
| `hstar` | `(ψ̌_μ^†)^* = ψ̌_{M+1-μ}`（`check_number_operator_is_hermitian` (3)） | 016 |

**`ε` が `Ž, Y̌` と反可換であること（原文 (1)(2)）は仮定していない。**
それは章 004・010・013 の形式化済みの定理から**無条件に**従う
（`Ising2D/EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimEpsilonAnticommutesWithCheckZY.lean`）。

`V^{(+)}` の固有値は別途 `Ising2D.VPlusData`（`ClaimTraceEpsilonVPlusViaCheckEigenvalues.lean` 冒頭）で受け取る。
-/
import Ising2D.EigenvalueProblem.EigenvectorOfMaxEigenvalue.ClaimEpsilonAnticommutesWithCheckZY
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.DefinitionCheckNumberOperator
import Ising2D.NecSuf.JointEigenspace
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.DefinitionTrace
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimPositiveDefinite
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimProductOfAnticommutingMatricesCommutesFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimCommutingWithScalarMultipleFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimCommutingWithDifferenceFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimFiniteProductsOfCommutingMatricesFromNecSuf
import Ising2D.NecSuf.FiniteProductLeftAsNoncommProd

namespace Ising2D

open Matrix

variable {M : ℕ}

/-! ## 章 014–017 からの入力 -/

/-- **章 014–017 から受け取る入力**（上表を参照）。

添字型は `Fin M`（原文の `𝓜̌ = {1,…,M}` に 1 対 1 で対応する）。
`ann i` は原文の `ψ̌_{M+1-μ_i}` にあたる（したがって `n_μ = ψ̌_μ^† ψ̌_{M+1-μ}`）。 -/
structure CheckFermi (M : ℕ) where
  /-- `ψ̌_μ^†` -/
  cre : Fin M → TensorPow M
  /-- `ψ̌_{M+1-μ}` -/
  ann : Fin M → TensorPow M
  hcre : ∀ i, IsCheckMode (cre i)
  hann : ∀ i, IsCheckMode (ann i)
  acomm_cre_cre : ∀ i j, cre i * cre j + cre j * cre i = 0
  acomm_ann_ann : ∀ i j, ann i * ann j + ann j * ann i = 0
  acomm_cre_ann : ∀ i j, cre i * ann j + ann j * cre i = if i = j then 1 else 0
  hstar : ∀ i, (cre i)ᴴ = ann i

namespace CheckFermi

variable (F : CheckFermi M)

/-- **原文 `def_check_number_operator`**: `ň_μ := ψ̌_μ^† ψ̌_{M+1-μ}`。 -/
noncomputable def nOp (i : Fin M) : TensorPow M := NecSuf.num F.cre F.ann i

theorem nOp_def (i : Fin M) : F.nOp i = F.cre i * F.ann i := rfl

theorem acomm_cre_ann_self (i : Fin M) : F.cre i * F.ann i + F.ann i * F.cre i = 1 := by
  have := F.acomm_cre_ann i i
  simpa using this

theorem cre_sq (i : Fin M) : F.cre i * F.cre i = 0 :=
  NecSuf.sq_eq_zero_of_acomm_self tensorPow_two_torsion_free (F.acomm_cre_cre i i)

theorem ann_sq (i : Fin M) : F.ann i * F.ann i = 0 :=
  NecSuf.sq_eq_zero_of_acomm_self tensorPow_two_torsion_free (F.acomm_ann_ann i i)

theorem ann_mul_cre (i : Fin M) : F.ann i * F.cre i = 1 - F.nOp i :=
  NecSuf.ann_mul_cre F.cre F.ann i (F.acomm_cre_ann_self i)

theorem nOp_mul_self (i : Fin M) : F.nOp i * F.nOp i = F.nOp i :=
  NecSuf.num_mul_num F.cre F.ann i tensorPow_two_torsion_free
    (F.acomm_cre_cre i i) (F.acomm_ann_ann i i) (F.acomm_cre_ann_self i)

theorem commute_cre_nOp {i j : Fin M} (hij : i ≠ j) :
    Commute (F.cre i) (F.nOp j) :=
  NecSuf.commute_cre_num F.cre F.ann (F.acomm_cre_cre i j)
    (by have := F.acomm_cre_ann i j; rwa [if_neg hij] at this)

theorem commute_ann_nOp {i j : Fin M} (hij : i ≠ j) :
    Commute (F.ann i) (F.nOp j) :=
  NecSuf.commute_ann_num F.cre F.ann
    (by
      have := F.acomm_cre_ann j i
      rw [if_neg (Ne.symm hij)] at this
      linear_combination (norm := noncomm_ring) this)
    (F.acomm_ann_ann i j)

theorem commute_nOp_nOp (i j : Fin M) : Commute (F.nOp i) (F.nOp j) := by
  by_cases hij : i = j
  · subst hij; exact Commute.refl _
  · refine NecSuf.commute_num_num F.cre F.ann (F.acomm_cre_cre i j) ?_ ?_ (F.acomm_ann_ann i j)
    · have := F.acomm_cre_ann i j; rwa [if_neg hij] at this
    · have := F.acomm_cre_ann j i
      rw [if_neg (Ne.symm hij)] at this
      linear_combination (norm := noncomm_ring) this

/-! ## 同時固有射影 `Q̌_ε`（原文 `check_joint_eigenspace_decomposition`） -/

/-- **原文の `Q̌_ε`**（`ε_μ = 1 ⟺ μ ∈ T` で添字づける）。 -/
noncomputable def Qproj (T : Finset (Fin M)) : TensorPow M :=
  NecSuf.projOn F.nOp F.commute_nOp_nOp Finset.univ T

theorem Qproj_mul_self (T : Finset (Fin M)) : F.Qproj T * F.Qproj T = F.Qproj T :=
  NecSuf.projOn_mul_self F.nOp_mul_self _ _

theorem Qproj_mul_Qproj_of_ne {T T' : Finset (Fin M)} (h : T ≠ T') :
    F.Qproj T * F.Qproj T' = 0 := by
  obtain ⟨ν, hν⟩ : ∃ ν : Fin M, ¬(ν ∈ T ↔ ν ∈ T') := by
    by_contra hc
    push_neg at hc
    exact h (Finset.ext fun ν => hc ν)
  exact NecSuf.projOn_mul_projOn_of_ne F.nOp_mul_self (Finset.mem_univ ν) hν

theorem sum_Qproj : ∑ T : Finset (Fin M), F.Qproj T = 1 := by
  have := NecSuf.sum_projOn (n := F.nOp) (hn := F.commute_nOp_nOp) Finset.univ
  rwa [Finset.powerset_univ] at this

theorem nOp_mul_Qproj (ν : Fin M) (T : Finset (Fin M)) :
    F.nOp ν * F.Qproj T = (if ν ∈ T then (1 : ℂ) else 0) • F.Qproj T := by
  have h := NecSuf.num_mul_projOn (n := F.nOp) (hn := F.commute_nOp_nOp)
    F.nOp_mul_self (T := T) (Finset.mem_univ ν)
  rw [Qproj, h]
  by_cases hT : ν ∈ T <;> simp [hT]

/-- **原文 `check_joint_eigenspace_decomposition` (4)**: `tr(Q̌_ε) = 1`。

半整数運動量では `𝓘 = 𝓜̌` が `M` 個すべてなので、章 009 の `2^{M-m}` が `2^0 = 1` になる。 -/
theorem trace_Qproj (T : Finset (Fin M)) : (F.Qproj T).trace = 1 := by
  have h := NecSuf.two_pow_smul_tau_projOn F.cre F.ann F.commute_nOp_nOp
    (Matrix.trace : TensorPow M → ℂ) (fun x y => Matrix.trace_add x y)
    (fun x y => Matrix.trace_mul_comm x y) F.acomm_cre_ann_self
    (fun i j hij => F.commute_cre_nOp hij) (fun i j hij => F.commute_ann_nOp hij)
    Finset.univ T
  rw [trace_one_tensorPow] at h
  have hcard : (Finset.univ : Finset (Fin M)).card = M := by simp
  rw [hcard, nsmul_eq_mul] at h
  have hne : ((2 ^ M : ℕ) : ℂ) ≠ 0 := by
    simp
  have h' : ((2 ^ M : ℕ) : ℂ) * (F.Qproj T).trace = ((2 ^ M : ℕ) : ℂ) * 1 := by
    rw [mul_one]
    exact h
  exact mul_left_cancel₀ hne h'

theorem Qproj_ne_zero (T : Finset (Fin M)) : F.Qproj T ≠ 0 := by
  intro h
  have := F.trace_Qproj T
  rw [h, Matrix.trace_zero] at this
  exact one_ne_zero this.symm

/-! ## `ε` との交換（原文 `epsilon_anticommutes_with_check_Z_Y` (3)(4)） -/

theorem epsilon_anticomm_cre (i : Fin M) :
    epsilon M * F.cre i = -(F.cre i * epsilon M) :=
  epsilon_anticomm_of_isCheckMode (F.hcre i)

theorem epsilon_anticomm_ann (i : Fin M) :
    epsilon M * F.ann i = -(F.ann i * epsilon M) :=
  epsilon_anticomm_of_isCheckMode (F.hann i)

/-- **原文 (4) 前半**: `ε ň_μ = ň_μ ε`。人手の 3 行の鎖と同じ calc である。
人手の前置き「`def_check_index_set` (2) より `M_col+1−μ ∈ 𝓜̌` なので、(3) は `εψ̌_μ^† = −(ψ̌_μ^†ε)` と
`εψ̌_{M_col+1−μ} = −(ψ̌_{M_col+1−μ}ε)` を与える」は、Lean では `ann i`（人手の `ψ̌_{M_col+1−μ}`）が `Ž, Y̌` の 1 次結合
（場 `hann`）であることから (3) を使う `epsilon_anticomm_cre`・`epsilon_anticomm_ann` である。 -/
theorem commute_epsilon_nOp (i : Fin M) : Commute (epsilon M) (F.nOp i) := by
  show epsilon M * F.nOp i = F.nOp i * epsilon M
  calc epsilon M * F.nOp i
      = epsilon M * (F.cre i * F.ann i) := rfl          -- `def_check_number_operator`
    _ = (F.cre i * F.ann i) * epsilon M :=
        mul_comm_of_anticomm_pair_tensorPow _ _ _ (F.epsilon_anticomm_cre i) (F.epsilon_anticomm_ann i)
                                                        -- `product_of_anticommuting_matrices_commutes`
                                                        -- （`G → ε`、`X → ψ̌_μ^†`、`Y → ψ̌_{M_col+1−μ}`。仮定は上の (3) の 2 式）
    _ = F.nOp i * epsilon M := rfl                      -- `def_check_number_operator`

/-- 原文 (4) 前半が必要十分版 `NecSuf.commute_parity_num` の特殊化として得られること。 -/
theorem commute_epsilon_nOp_of_necSuf (i : Fin M) : Commute (epsilon M) (F.nOp i) :=
  NecSuf.commute_parity_num F.cre F.ann (F.epsilon_anticomm_cre i) (F.epsilon_anticomm_ann i)

/-- 人手の `Q̌_ε` の定義の因子 `A_ν := ε_ν ň_ν + (1 − ε_ν)(I − ň_ν)`（`check_joint_eigenspace_decomposition`）。
Lean の `Qproj` は `ε ∈ {0,1}^𝓜̌` を `ε_ν = 1 ⟺ ν ∈ T` の部分集合 `T` で添字づけるので、人手のスカラー `ε_ν` は
`if ν ∈ T then (1 : ℂ) else 0` である。 -/
noncomputable def defFactor (T : Finset (Fin M)) (ν : Fin M) : TensorPow M :=
  (if ν ∈ T then (1 : ℂ) else 0) • F.nOp ν + (1 - (if ν ∈ T then (1 : ℂ) else 0)) • (1 - F.nOp ν)

/-- **原文 (4)** の `εI = Iε` の 2 行。 -/
theorem epsilon_mul_identity_eq_identity_mul_epsilon (M : ℕ) : epsilon M * 1 = 1 * epsilon M :=
  calc epsilon M * 1
      = epsilon M := mul_identity_matrix_tensorPow _    -- `identity_matrix_is_right_unit_of_mat_mult`
    _ = 1 * epsilon M := (identity_matrix_mul_tensorPow _).symm
                                                        -- `identity_matrix_is_left_unit_of_mat_mult`

/-- **原文 (4)** の `εA_ν = A_νε`。前半の 3 式（`have` の `h1`・`h2`・`h3`）と、`A_ν` の 5 行の鎖である。 -/
theorem commute_epsilon_defFactor (T : Finset (Fin M)) (ν : Fin M) :
    epsilon M * F.defFactor T ν = F.defFactor T ν * epsilon M := by
  have hn : epsilon M * F.nOp ν = F.nOp ν * epsilon M := F.commute_epsilon_nOp ν
                                                        -- 上の `εň_ν = ň_νε`（`μ → ν`）
  have h1 : epsilon M * (1 - F.nOp ν) = (1 - F.nOp ν) * epsilon M :=
    mul_sub_eq_sub_mul_of_commute_tensorPow _ _ _ (epsilon_mul_identity_eq_identity_mul_epsilon M) hn
                                                        -- 3 式の 1 行目: `commuting_with_difference`
                                                        -- （`G → ε`、`X → I`、`W → ň_ν`。仮定は `εI = Iε` と `εň_ν = ň_νε`）
  have h2 : epsilon M * ((if ν ∈ T then (1 : ℂ) else 0) • F.nOp ν)
      = ((if ν ∈ T then (1 : ℂ) else 0) • F.nOp ν) * epsilon M :=
    mul_smul_comm_of_commute_tensorPow _ _ _ hn
                                                        -- 3 式の 2 行目: `commuting_with_scalar_multiple`
                                                        -- （`G → ε`、`c → ε_ν`、`X → ň_ν`。仮定は `εň_ν = ň_νε`）
  have h3 : epsilon M * ((1 - (if ν ∈ T then (1 : ℂ) else 0)) • (1 - F.nOp ν))
      = ((1 - (if ν ∈ T then (1 : ℂ) else 0)) • (1 - F.nOp ν)) * epsilon M :=
    mul_smul_comm_of_commute_tensorPow _ _ _ h1
                                                        -- 3 式の 3 行目: `commuting_with_scalar_multiple`
                                                        -- （`G → ε`、`c → 1 − ε_ν`、`X → I − ň_ν`。仮定は 1 行目）
  calc epsilon M * F.defFactor T ν
      = epsilon M * ((if ν ∈ T then (1 : ℂ) else 0) • F.nOp ν
          + (1 - (if ν ∈ T then (1 : ℂ) else 0)) • (1 - F.nOp ν)) := rfl
                                                        -- `A_ν` の置き方
    _ = epsilon M * ((if ν ∈ T then (1 : ℂ) else 0) • F.nOp ν)
          + epsilon M * ((1 - (if ν ∈ T then (1 : ℂ) else 0)) • (1 - F.nOp ν)) :=
        mul_add_matrix_tensorPow _ _ _                  -- `mat_mult_distributes_over_sum_in_right_factor`
    _ = ((if ν ∈ T then (1 : ℂ) else 0) • F.nOp ν) * epsilon M
          + ((1 - (if ν ∈ T then (1 : ℂ) else 0)) • (1 - F.nOp ν)) * epsilon M := by
        rw [h2, h3]                                     -- 上の 3 式の 2 行目と 3 行目を 2 項へ同時適用
    _ = ((if ν ∈ T then (1 : ℂ) else 0) • F.nOp ν
          + (1 - (if ν ∈ T then (1 : ℂ) else 0)) • (1 - F.nOp ν)) * epsilon M :=
        (add_mul_matrix_tensorPow _ _ _).symm           -- `mat_mult_distributes_over_sum_in_left_factor`
    _ = F.defFactor T ν * epsilon M := rfl              -- `A_ν` の置き方

/-- Lean の `Qproj` の因子 `NecSuf.projFactor`（`ν ∈ T` なら `ň_ν`、そうでなければ `I − ň_ν`）は、人手の定義の因子 `A_ν` に等しい。
人手の証明の行ではなく、Lean の `Qproj` の定義と人手の `Q̌_ε` の定義をつなぐ等式である。 -/
theorem projFactor_eq_defFactor (T : Finset (Fin M)) (ν : Fin M) :
    NecSuf.projFactor F.nOp T ν = F.defFactor T ν := by
  by_cases h : ν ∈ T <;> simp [NecSuf.projFactor, defFactor, h]

/-- Lean の `Qproj`（`Finset.noncommProd`）は、人手の定義 `Q̌_ε = ∏_{ν=1}^{M_col} A_ν`（`def_finite_product_of_matrices` の
左から掛ける積。人手の `M_col` が Lean の `r + 1`、人手の `ν` が Lean の `ν : Fin (r + 1)` の `ν + 1`）に等しい。
人手の証明の行ではなく、Lean の定義と人手の定義をつなぐ等式である
（必要十分版 `NecSuf.finProdLeft_eq_noncommProd_image` を恒等写像で使い、因子を `projFactor_eq_defFactor` で付け替える）。 -/
theorem Qproj_eq_finProdLeft_defFactor {r : ℕ} (F : CheckFermi (r + 1)) (T : Finset (Fin (r + 1))) :
    F.Qproj T = NecSuf.finProdLeft r (fun ν => F.defFactor T ν) := by
  have h := NecSuf.finProdLeft_eq_noncommProd_image (NecSuf.projFactor F.nOp T)
    (fun i j => NecSuf.commute_projFactor F.commute_nOp_nOp T T i j) r id Function.injective_id
  rw [Finset.image_id] at h
  calc F.Qproj T
      = (Finset.univ : Finset (Fin (r + 1))).noncommProd (NecSuf.projFactor F.nOp T)
          (fun i _ j _ _ => NecSuf.commute_projFactor F.commute_nOp_nOp T T i j) := rfl
    _ = NecSuf.finProdLeft r (fun ν => NecSuf.projFactor F.nOp T ν) := h.symm
    _ = NecSuf.finProdLeft r (fun ν => F.defFactor T ν) :=
        congrArg (NecSuf.finProdLeft r) (funext fun ν => F.projFactor_eq_defFactor T ν)

/-- **原文 (4) 後半**の `Q̌_ε` の 3 行の鎖（人手の `M_col` が Lean の `r + 1`）。 -/
theorem commute_epsilon_Qproj_succ {r : ℕ} (F : CheckFermi (r + 1)) (T : Finset (Fin (r + 1))) :
    epsilon (r + 1) * F.Qproj T = F.Qproj T * epsilon (r + 1) :=
  calc epsilon (r + 1) * F.Qproj T
      = epsilon (r + 1) * NecSuf.finProdLeft r (fun ν => F.defFactor T ν) := by
        rw [Qproj_eq_finProdLeft_defFactor F T]         -- `check_joint_eigenspace_decomposition` の `Q̌_ε` の定義と `A_ν` の置き方
    _ = NecSuf.finProdLeft r (fun ν => F.defFactor T ν) * epsilon (r + 1) :=
        commute_finProdLeft_tensorPow r _ _ fun ν => F.commute_epsilon_defFactor T ν
                                                        -- `matrix_commuting_with_each_factor_commutes_with_finite_product`
                                                        -- （`n → 2^{M_col}`、`r → M_col`、`X → ε`、`A_j → A_ν`。
                                                        -- Lean の `r` は人手の `M_col − 1`）
    _ = F.Qproj T * epsilon (r + 1) := by
        rw [Qproj_eq_finProdLeft_defFactor F T]         -- `check_joint_eigenspace_decomposition` の `Q̌_ε` の定義と `A_ν` の置き方

/-- 原文 (4) 後半が必要十分版 `NecSuf.commute_parity_projOn` の特殊化として得られること（`M` を限らない）。 -/
theorem commute_epsilon_Qproj_of_necSuf (T : Finset (Fin M)) : Commute (epsilon M) (F.Qproj T) :=
  NecSuf.commute_parity_projOn F.cre F.ann F.commute_nOp_nOp
    F.epsilon_anticomm_cre F.epsilon_anticomm_ann _ T

/-- 原文 (4) 後半の鎖が、同じ並びの必要十分版 `NecSuf.commute_parity_finProdLeft_defFactor` の特殊化として得られること
（`M_col = r + 1`。`Qproj` を人手の定義へ移すのは `Qproj_eq_finProdLeft_defFactor`）。 -/
theorem commute_epsilon_Qproj_succ_of_necSuf {r : ℕ} (F : CheckFermi (r + 1)) (T : Finset (Fin (r + 1))) :
    epsilon (r + 1) * F.Qproj T = F.Qproj T * epsilon (r + 1) := by
  rw [Qproj_eq_finProdLeft_defFactor F T]
  exact NecSuf.commute_parity_finProdLeft_defFactor (𝕜 := ℂ) (fun x y => sub_eq_add_neg x y) r F.cre F.ann
    F.epsilon_anticomm_cre F.epsilon_anticomm_ann _ _

/-- **原文 (4) 後半**: `ε Q̌_ε = Q̌_ε ε`。人手の主張は `M_col ≥ 2` で、それは `M = r + 1` の場合
`commute_epsilon_Qproj_succ`（人手の鎖）である。`M = 0` は人手の主張の外で、必要十分版の特殊化
`commute_epsilon_Qproj_of_necSuf` で埋める（下流が `M` を限らないため）。 -/
theorem commute_epsilon_Qproj : ∀ {M : ℕ} (F : CheckFermi M) (T : Finset (Fin M)),
    Commute (epsilon M) (F.Qproj T)
  | 0, F, T => F.commute_epsilon_Qproj_of_necSuf T
  | _ + 1, F, T => commute_epsilon_Qproj_succ F T

/-! ## エルミート性（原文 `check_number_operator_is_hermitian` (4)） -/

/-- `(ψ̌_{M+1-μ})^* = ψ̌_μ^†`（`hstar` の帰結）。 -/
theorem ann_conjTranspose (i : Fin M) : (F.ann i)ᴴ = F.cre i := by
  rw [← F.hstar i, Matrix.conjTranspose_conjTranspose]

/-- **原文 (4) 前半**: `ň_μ^* = ň_μ`。 -/
theorem nOp_conjTranspose (i : Fin M) : (F.nOp i)ᴴ = F.nOp i := by
  rw [nOp_def, Matrix.conjTranspose_mul, F.ann_conjTranspose, F.hstar, ← nOp_def]

/-- **原文 (4) 後半**: `Q̌_ε^* = Q̌_ε`（必要十分版 `NecSuf.star_projOn` の特殊化）。 -/
theorem Qproj_conjTranspose (T : Finset (Fin M)) : (F.Qproj T)ᴴ = F.Qproj T := by
  have h := NecSuf.star_projOn (A := TensorPow M) F.nOp F.commute_nOp_nOp
    (fun i => (Matrix.star_eq_conjTranspose (F.nOp i)).trans (F.nOp_conjTranspose i))
    Finset.univ T
  rw [Matrix.star_eq_conjTranspose] at h
  exact h

end CheckFermi

end Ising2D
