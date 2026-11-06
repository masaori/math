/-
# `exp(K_1D_0)`・`G`・`ε`・`V_2` の成分を配置の基底で読み取る（具体版）

正本: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`
（`closing_006_theorem_trace_of_epsilon_V_plus`、ラベル **`trace_of_epsilon_V_plus`** の準備 (P5) と Step 3、Step 4 が使う成分の形）

| 人手 | Lean |
| --- | --- |
| 準備 (P5) の 2 行目の根拠 `(f_I)_J = ∏_m (e_{i_m})_{j_m}`（`def_end_iso`・`def_kronecker` (1)。Lean の定義 `Pi.single` を人手の形へ読み替える段） | `basisVec_apply_eq_prod` |
| 準備 (P5) の 3 行 `(f_{ι(s)})_{ord(s')} = δ_{s=s'}` | `basisVec_configBasisIso_apply` |
| 準備 (P5) の列の読み取りの 4 行 `(Xf_{ι(s)})_{ord(s')} = X_{ord(s'),ord(s)}` | `mulVec_basisVec_configBasisIso_apply` |
| Step 3 (b) の `(-s)(m) := -s(m)` | `negSpinConf`（値の側は `negSpinVal`） |
| Step 3 (a) の 4 行 `(D_0)_{ord(s'),ord(s)} = (D_0f_{ι(s)})_{ord(s')} = ⋯ = (E(s))_ℂδ_{s=s'}` | `openChainD0_apply_configBasisIso` の 4 段 |
| 同 「同じ 4 行で `G_{ord(s'),ord(s)} = (s(M_col)s(1))_ℂδ_{s=s'}`」 | `boundaryG_apply_configBasisIso` の 4 段 |
| 同 「全ての番号は `ord(s)` の形なので対角行列」（`row_configuration_numbering_bijective`・`def_diagonal_matrix`） | `eq_diagonal_of_apply_configBasisIso`（`D_0`・`G` は `openChainD0_eq_diagonal`・`boundaryG_eq_diagonal`） |
| 同 `κD_0` は対角行列で `(κD_0)_{ord(s),ord(s)} = κ(E(s))_ℂ = (K_1E(s))_ℂ` | `smul_openChainD0_eq_diagonal`（対角成分は 2 段の calc） |
| 同 `exp(κD_0)` は対角行列で `(exp(κD_0))_{ord(s),ord(s)} = exp((K_1E(s))_ℂ) = (exp(K_1E(s)))_ℂ` | `matExp_smul_openChainD0`（対角成分の 2 行は `matExp_smul_openChainD0_apply`） |
| Step 4 の 1・2 行目の根拠（`mat_mult` の和で `0_ℂ` を掛けた項が消え、`finite_sum_with_single_nonzero_term` で一つの項が残る） | `mul_apply_configBasisIso_of_single_nonzero` |
| Step 4 が「(a) の対角性」として使う非対角成分 `(exp(κD_0))_{ord(s),ord(t)} = 0_ℂ`・`G_{ord(s),ord(t)} = 0_ℂ`（`t ≠ s`）と、`G` の対角成分 `G_{ord(s),ord(s)} = (s(M_col)s(1))_ℂ` | `matExp_smul_openChainD0_apply_of_ne`・`boundaryG_apply_configBasisIso_of_ne`・`boundaryG_apply_configBasisIso_self` |
| Step 3 (b) `εf_{ι(s)} = f_{ι(-s)}` | `epsilon_mulVec_basisVec_configBasisIso` |
| 同 3 行 `ε_{ord(s'),ord(s)} = (εf_{ι(s)})_{ord(s')} = (f_{ι(-s)})_{ord(s')} = δ_{-s=s'}` | `epsilon_apply_configBasisIso_col` の 3 段 |
| Step 4 が (b) として使う `ε_{ord(s),ord(t)} = δ_{-t=s} = 0_ℂ`（`t ≠ -s`）と `δ_{-(-s)=s} = 1_ℂ` | `epsilon_apply_configBasisIso_of_ne`・`epsilon_apply_configBasisIso_neg_self`（`-(-s) = s` は `negSpinConf_negSpinConf`） |
| Step 3 (c) `(V_2)_{ι(s),ι(s')} = exp(K_2∑_m s(m)s'(m))` | `V2_apply_configBasisIso`（`PartitionFunction/TransferMatrixRepresentation/DefinitionTransferMatrix.lean`） |
| 同 `(V_2)_{ord(s),ord(s)} = (exp(K_2M_col))_ℂ` | `V2_apply_configBasisIso_self` |
| 同 `(V_2)_{ord(-s),ord(s)} = (exp(-K_2M_col))_ℂ`（`(-s(m))s(m) = -1` を足す） | `V2_apply_configBasisIso_neg_self`（和は `sum_negSpin_mul_self`） |

人手 (a)(b) の鎖は、(P5) の列の読み取り `mulVec_basisVec_configBasisIso_apply` と (P5) の
`basisVec_configBasisIso_apply` を両端に置く。`D_0f_{ι(s)} = (E(s))_ℂf_{ι(s)}` は `openChainD0_mulVec_basisVec_eq_energy`、
`Gf_{ι(s)} = (s(M_col)s(1))_ℂf_{ι(s)}` は `boundaryG_mulVec_basisVec`（`D0_G_diagonal_action`）、`exp_of_diagonal_matrix` は
`matExp_diagonal`、`real_inclusion_preserves_product` は `real_inclusion_mul` である。`complex_exp_of_real_argument` には
Lean の具体版が無く、mathlib の `Complex.ofReal_exp` を引く。
人手 (b) の理由のうち「`ε` はすべての成分を入れ替える」は `epsilon_mulVec_basisVec`（`ε f_I = f_{π(I)}`、
`π` は `flipConf`）であり、`ι` のもとで `π(ι(s)) = ι(-s)` となること（人手の `+1 ↦ 1`, `-1 ↦ 2` の入れ替え）を
`configBasisIso_negSpinConf` で示す。
人手 Step 4 は (b) の 3 行（列 `ord(s)` の成分 `ε_{ord(s'),ord(s)} = δ_{-s=s'}`）を、`s → t`、`s' → s` と置いて行 `ord(s)` の成分に使う。
`ε_{ord(s),ord(t)} = δ_{-t=s}` が `1_ℂ` になるのは `t = -s` のときだけで、それには `-(-s) = s`（`negSpinConf_negSpinConf`）を使う。
人手 (c) の二つの特別な場合は `∑_m s(m)s(m) = M_col`
（`sum_spin_mul_self`）と `∑_m (-s(m))s(m) = -M_col` による。

一般化できるのは、行列の列の読み取りと「行の成分が 1 つを除いて `0` なら積の成分は 1 項になる」（どちらも任意の半環・任意の有限添字の行列で成り立つ自明な事実）と、
`{±1}` の符号反転の組合せだけである。必要十分版にしても何が本質的かについて情報を与えないので、置かない。
-/
import Ising2D.EigenvalueProblem.EigenvectorOfMaxEigenvalue.ClaimOpenChainSpinSums
import Ising2D.EigenvalueProblem.EigenvectorOfMaxEigenvalue.ClaimEpsilonD0GCommuteAndDiagonalAction
import Ising2D.MathematicalTools.MatrixExponentialAndCommutators.ClaimExpOfDiagonalMatrix
import Ising2D.ThermodynamicLimit.ColumnLimitAndClosedForm.ClaimEpsilonIsRealSymmetric
import Ising2D.PartitionFunction.TransferMatrixRepresentation.DefinitionTransferMatrix

namespace Ising2D

open Matrix

variable {M : ℕ}

/-! ## スピン配置の符号反転 `-s` -/

/-- 人手の `-s(m)`（`{-1,1}` は符号反転で閉じている）。 -/
def negSpinVal (a : SpinVal) : SpinVal :=
  ⟨-(a : ℝ), by
    rcases a.2 with h | h
    · right; rw [h]
    · left; rw [h, neg_neg]⟩

@[simp] theorem coe_negSpinVal (a : SpinVal) : ((negSpinVal a : SpinVal) : ℝ) = -(a : ℝ) := rfl

/-- **人手 Step 3 (b) の `(-s)(m) := -s(m)`。** -/
def negSpinConf (s : SpinConf M) : SpinConf M := fun m => negSpinVal (s m)

@[simp] theorem coe_negSpinConf_apply (s : SpinConf M) (m : Fin M) :
    ((negSpinConf s m : SpinVal) : ℝ) = -(s m : ℝ) := rfl

/-! ## 準備 (P5): 基底ベクトルの成分と列の読み取り -/

/-- 人手 (P5) の 2 行目の根拠 `def_end_iso` の `f_I = e_{i_1} ⊠ ⋯ ⊠ e_{i_M}` と `def_kronecker` (1) の成分の式:
`(f_I)_J = ∏_m (e_{i_m})_{j_m}`。

Lean の `basisVec I` は `Pi.single I 1` で定義してあり（`DefinitionConfigBasisIso.lean`）、人手の `e_i ∈ ℂ^2` は
`Pi.single i 1 : Fin 2 → ℂ` である。この補題は Lean の定義を人手の定義の形へ読み替える段で、人手には対応する行が無い
（人手では定義そのもの）。
証明に使う `Finset.prod_boole` は読み替えのためだけのもので、人手の 3 行目の場合分けは
`basisVec_configBasisIso_apply` が人手どおりに行う。 -/
theorem basisVec_apply_eq_prod (I J : Conf M) :
    basisVec I J = ∏ m : Fin M, (Pi.single (I m) (1 : ℂ) : Fin 2 → ℂ) (J m) := by
  simp only [basisVec, Pi.single_apply]
  rw [Finset.prod_boole]
  simp only [Finset.mem_univ, true_implies, funext_iff]

open Classical in
/-- **人手 準備 (P5) の 3 行**: `(f_{ι(s)})_{ord(s')} = δ_{s=s'}`。

1 行目 `(f_{ι(s)})_{ord(s')} = (f_{ι(s)})_{ν(ι(s'))}`（`config_numbering_equals_kronecker_numbering`）は、Lean では
ベクトルの添字が `ι(s')` そのものなので（`PartitionFunction/TransferMatrixRepresentation/DefinitionTransferMatrix.lean` 冒頭の「行列の添字」）、
添字の読み方であって段は無い。2 行目は `basisVec_apply_eq_prod`、3 行目は人手の場合分けである:
`s = s'` なら全ての因子が `(e_i)_i = 1_ℂ` で、積は `finite_product_of_complex_ones`（Lean は `Finset.prod_const_one`）。
`s ≠ s'` なら `ι` の単射性（`configBasisIso_eq_iff`）より、ある `m` で `ι(s)_m ≠ ι(s')_m` となってその因子は `0_ℂ`、
積は `finite_product_with_zero_factor_is_zero`（Lean は `Finset.prod_eq_zero`）。 -/
theorem basisVec_configBasisIso_apply (s s' : SpinConf M) :
    basisVec (configBasisIso M s) (configBasisIso M s') = if s = s' then 1 else 0 :=
  calc basisVec (configBasisIso M s) (configBasisIso M s')
      = ∏ m : Fin M,
          (Pi.single (configBasisIso M s m) (1 : ℂ) : Fin 2 → ℂ) (configBasisIso M s' m) :=
        basisVec_apply_eq_prod _ _
    _ = if s = s' then 1 else 0 := by
        by_cases h : s = s'
        · -- `s = s'`: 全ての因子が `(e_i)_i = 1_ℂ`
          subst h
          rw [if_pos rfl]
          calc ∏ m : Fin M,
                (Pi.single (configBasisIso M s m) (1 : ℂ) : Fin 2 → ℂ) (configBasisIso M s m)
              = ∏ _m : Fin M, (1 : ℂ) :=
                Finset.prod_congr rfl fun m _ => Pi.single_eq_same _ _
            _ = 1 := Finset.prod_const_one  -- `finite_product_of_complex_ones`
        · -- `s ≠ s'`: `ι` の単射性より `ι(s)_m ≠ ι(s')_m` なる `m` があり、その因子は `0_ℂ`
          rw [if_neg h]
          have hne : configBasisIso M s ≠ configBasisIso M s' :=
            fun hc => h ((configBasisIso_eq_iff s s').mp hc)
          obtain ⟨m, hm⟩ := Function.ne_iff.mp hne
          -- `finite_product_with_zero_factor_is_zero`
          exact Finset.prod_eq_zero (Finset.mem_univ m) (Pi.single_eq_of_ne (Ne.symm hm) _)

/-- **人手 準備 (P5) の列の読み取りの 4 行**: `X ∈ Mat(2^{M_col},ℂ)` について
`(Xf_{ι(s)})_{ord(s')} = X_{ord(s'),ord(s)}`。

2 行目の `finite_sum_with_single_nonzero_term`（Lean は `Finset.sum_eq_single`）の仮定は人手どおりに示す:
`row_configuration_numbering_bijective` より `l ≠ ord(s)` の番号は `t ≠ s` なる `l = ord(t)` と書け
（Lean では `ι` の全射性 `(configBasisIso M).surjective`）、(P5) より `(f_{ι(s)})_l = 0_ℂ`、
`complex_times_zero_is_zero` より `X_{ord(s'),l}(f_{ι(s)})_l = 0_ℂ` である。 -/
theorem mulVec_basisVec_configBasisIso_apply (X : TensorPow M) (s s' : SpinConf M) :
    (X *ᵥ basisVec (configBasisIso M s)) (configBasisIso M s')
      = X (configBasisIso M s') (configBasisIso M s) :=
  calc (X *ᵥ basisVec (configBasisIso M s)) (configBasisIso M s')
      = ∑ l : Conf M, X (configBasisIso M s') l * basisVec (configBasisIso M s) l := by
        rw [Matrix.mulVec, dotProduct]  -- `mat_mult`
    _ = X (configBasisIso M s') (configBasisIso M s)
          * basisVec (configBasisIso M s) (configBasisIso M s) := by
        -- `finite_sum_with_single_nonzero_term`
        refine Finset.sum_eq_single (configBasisIso M s) (fun l _ hl => ?_)
          (fun hs => absurd (Finset.mem_univ _) hs)
        obtain ⟨t, rfl⟩ := (configBasisIso M).surjective l
        have hst : s ≠ t := fun hc => hl (by rw [hc])
        rw [basisVec_configBasisIso_apply, if_neg hst, mul_zero]  -- (P5)・`complex_times_zero_is_zero`
    _ = X (configBasisIso M s') (configBasisIso M s) * 1 := by
        rw [basisVec_configBasisIso_apply, if_pos rfl]  -- (P5) の `s' = s`
    _ = X (configBasisIso M s') (configBasisIso M s) := mul_one _  -- `complex_numbers_form_a_field` の積の単位元

/-- 人手 Step 4 の二つの鎖の 1・2 行目の根拠「`mat_mult` の和 `∑_{k=1}^{2^{M_col}}` で、`k ≠ ord(u)` の成分 `0_ℂ` を
掛けた項は `complex_zero_times_is_zero` で `0_ℂ` になり、`finite_sum_with_single_nonzero_term` により一つの項だけが残る」:
行 `ord(s)` の成分が `ord(u)` 以外で `0_ℂ` なら `(AX)_{ord(s),J} = A_{ord(s),ord(u)}X_{ord(u),J}`。

`k ≠ ord(u)` の番号を `t ≠ u` なる `k = ord(t)` と書くのは `row_configuration_numbering_bijective`
（Lean では `ι` の全射性 `(configBasisIso M).surjective`）である。 -/
theorem mul_apply_configBasisIso_of_single_nonzero {A : TensorPow M} (X : TensorPow M) {s u : SpinConf M}
    (hA : ∀ t : SpinConf M, t ≠ u → A (configBasisIso M s) (configBasisIso M t) = 0) (J : Conf M) :
    (A * X) (configBasisIso M s) J
      = A (configBasisIso M s) (configBasisIso M u) * X (configBasisIso M u) J :=
  calc (A * X) (configBasisIso M s) J
      = ∑ k : Conf M, A (configBasisIso M s) k * X k J := by
        rw [Matrix.mul_apply]                                      -- `mat_mult`
    _ = A (configBasisIso M s) (configBasisIso M u) * X (configBasisIso M u) J := by
        -- `finite_sum_with_single_nonzero_term`
        refine Finset.sum_eq_single (configBasisIso M u) (fun k _ hk => ?_)
          (fun h => absurd (Finset.mem_univ _) h)
        obtain ⟨t, rfl⟩ := (configBasisIso M).surjective k
        have htu : t ≠ u := fun hc => hk (by rw [hc])
        rw [hA t htu, zero_mul]                                    -- `complex_zero_times_is_zero`

/-! ## Step 3 (a) -/

open Classical in
/-- **人手 Step 3 (a) の 4 行**: `(D_0)_{ord(s'),ord(s)} = (D_0f_{ι(s)})_{ord(s')} = ((E(s))_ℂf_{ι(s)})_{ord(s')}
= (E(s))_ℂ(f_{ι(s)})_{ord(s')} = (E(s))_ℂδ_{s=s'}`。

1 行目は (P5) の列の読み取り、2 行目は `D0_G_diagonal_action` と `def_open_chain_spin_energy`
（`openChainD0_mulVec_basisVec_eq_energy`）、3 行目は `def_matrix_scalar_multiple`（数ベクトルのスカラー倍は成分ごと）、
4 行目は (P5)。`δ_{s=s'}` は Lean では `if s = s' then 1 else 0` である。 -/
theorem openChainD0_apply_configBasisIso (s s' : SpinConf M) :
    openChainD0 M (configBasisIso M s') (configBasisIso M s)
      = ((openChainEnergy s : ℝ) : ℂ) * (if s = s' then 1 else 0) :=
  calc openChainD0 M (configBasisIso M s') (configBasisIso M s)
      = (openChainD0 M *ᵥ basisVec (configBasisIso M s)) (configBasisIso M s') :=
        (mulVec_basisVec_configBasisIso_apply _ s s').symm         -- 人手 1: (P5) の列の読み取り
    _ = (((openChainEnergy s : ℝ) : ℂ) • basisVec (configBasisIso M s)) (configBasisIso M s') := by
        rw [openChainD0_mulVec_basisVec_eq_energy]  -- 人手 2: `D0_G_diagonal_action`・`def_open_chain_spin_energy`
    _ = ((openChainEnergy s : ℝ) : ℂ) * basisVec (configBasisIso M s) (configBasisIso M s') := by
        rw [Pi.smul_apply, smul_eq_mul]                            -- 人手 3: `def_matrix_scalar_multiple`
    _ = ((openChainEnergy s : ℝ) : ℂ) * (if s = s' then 1 else 0) := by
        rw [basisVec_configBasisIso_apply]                         -- 人手 4: (P5)

open Classical in
/-- **人手 Step 3 (a) の「同じ 4 行で `G_{ord(s'),ord(s)} = (s(M_col)s(1))_ℂδ_{s=s'}`」**。

段は `openChainD0_apply_configBasisIso` と同じで、2 行目が `D0_G_diagonal_action` の `G` の式
（`boundaryG_mulVec_basisVec`）になる。 -/
theorem boundaryG_apply_configBasisIso (hM : M ≠ 0) (s s' : SpinConf M) :
    boundaryG M hM (configBasisIso M s') (configBasisIso M s)
      = (((s (lastSite M hM) : ℝ) * (s (firstSite M hM) : ℝ) : ℝ) : ℂ) * (if s = s' then 1 else 0) :=
  calc boundaryG M hM (configBasisIso M s') (configBasisIso M s)
      = (boundaryG M hM *ᵥ basisVec (configBasisIso M s)) (configBasisIso M s') :=
        (mulVec_basisVec_configBasisIso_apply _ s s').symm         -- 人手 1: (P5) の列の読み取り
    _ = ((((s (lastSite M hM) : ℝ) * (s (firstSite M hM) : ℝ) : ℝ) : ℂ)
          • basisVec (configBasisIso M s)) (configBasisIso M s') := by
        rw [boundaryG_mulVec_basisVec]                             -- 人手 2: `D0_G_diagonal_action` の `G` の式
    _ = (((s (lastSite M hM) : ℝ) * (s (firstSite M hM) : ℝ) : ℝ) : ℂ)
          * basisVec (configBasisIso M s) (configBasisIso M s') := by
        rw [Pi.smul_apply, smul_eq_mul]                            -- 人手 3: `def_matrix_scalar_multiple`
    _ = (((s (lastSite M hM) : ℝ) * (s (firstSite M hM) : ℝ) : ℝ) : ℂ) * (if s = s' then 1 else 0) := by
        rw [basisVec_configBasisIso_apply]                         -- 人手 4: (P5)

/-- 人手 (a) の「`row_configuration_numbering_bijective` より全ての番号は `ord(s)` の形なので、対角行列（`def_diagonal_matrix`）」:
`s ≠ s'` で `A_{ord(s'),ord(s)} = 0_ℂ`、対角成分が `A_{ord(s),ord(s)} = d(s)` なら、`A` は対角成分 `d` の対角行列である。

行と列の番号を `ι(s')`・`ι(s)` と書くのが `ι` の全射性（`(configBasisIso M).surjective`）で、
Lean の対角行列 `Matrix.diagonal` への読み替えは成分ごとの比較（`Matrix.diagonal_apply`）である。 -/
theorem eq_diagonal_of_apply_configBasisIso {A : TensorPow M} {d : SpinConf M → ℂ}
    (hoff : ∀ s s' : SpinConf M, s ≠ s' → A (configBasisIso M s') (configBasisIso M s) = 0)
    (hdiag : ∀ s : SpinConf M, A (configBasisIso M s) (configBasisIso M s) = d s) :
    A = Matrix.diagonal (fun I => d ((configBasisIso M).symm I)) := by
  ext J I
  obtain ⟨s', rfl⟩ := (configBasisIso M).surjective J
  obtain ⟨s, rfl⟩ := (configBasisIso M).surjective I
  rw [Matrix.diagonal_apply]
  by_cases hs : s = s'
  · subst hs
    rw [if_pos rfl, Equiv.symm_apply_apply, hdiag]
  · rw [if_neg (fun hc => hs ((configBasisIso_eq_iff s' s).mp hc).symm), hoff s s' hs]

/-- **人手 Step 3 (a)**: `D_0` は対角行列で `(D_0)_{ord(s),ord(s)} = (E(s))_ℂ`。

非対角成分は (a) の 4 行の `s ≠ s'` で `(E(s))_ℂ0_ℂ = 0_ℂ`（`complex_times_zero_is_zero`）、
対角成分は `s' = s` で `(E(s))_ℂ1_ℂ = (E(s))_ℂ`（`complex_numbers_form_a_field` の積の単位元）である。 -/
theorem openChainD0_eq_diagonal :
    openChainD0 M
      = Matrix.diagonal (fun I => ((openChainEnergy ((configBasisIso M).symm I) : ℝ) : ℂ)) :=
  eq_diagonal_of_apply_configBasisIso (A := openChainD0 M) (d := fun s => ((openChainEnergy s : ℝ) : ℂ))
    (fun s s' hs => by rw [openChainD0_apply_configBasisIso, if_neg hs, mul_zero])
    (fun s => by rw [openChainD0_apply_configBasisIso, if_pos rfl, mul_one])

/-- **人手 Step 3 (a)**: `G` は対角行列で `G_{ord(s),ord(s)} = (s(M_col)s(1))_ℂ`（`openChainD0_eq_diagonal` と同じ読み方）。 -/
theorem boundaryG_eq_diagonal (hM : M ≠ 0) :
    boundaryG M hM
      = Matrix.diagonal (fun I =>
          (((((configBasisIso M).symm I (lastSite M hM) : SpinVal) : ℝ)
            * (((configBasisIso M).symm I (firstSite M hM) : SpinVal) : ℝ) : ℝ) : ℂ)) :=
  eq_diagonal_of_apply_configBasisIso (A := boundaryG M hM)
    (d := fun s => (((s (lastSite M hM) : ℝ) * (s (firstSite M hM) : ℝ) : ℝ) : ℂ))
    (fun s s' hs => by rw [boundaryG_apply_configBasisIso, if_neg hs, mul_zero])
    (fun s => by rw [boundaryG_apply_configBasisIso, if_pos rfl, mul_one])

/-- **人手 Step 3 (a) の `κD_0`**（`κ := (K_1)_ℂ`）: `κD_0` は対角行列で、対角成分は
`(κD_0)_{ord(s),ord(s)} = κ(E(s))_ℂ = (K_1E(s))_ℂ`。

非対角成分は `def_matrix_scalar_multiple` と (a) の `D_0` の非対角成分と `complex_times_zero_is_zero`、
対角成分の 2 行は `def_matrix_scalar_multiple` と (a)、`real_inclusion_preserves_product`（`real_inclusion_mul`）である。 -/
theorem smul_openChainD0_eq_diagonal (K1 : ℝ) :
    (K1 : ℂ) • openChainD0 M
      = Matrix.diagonal (fun I => ((K1 * openChainEnergy ((configBasisIso M).symm I) : ℝ) : ℂ)) :=
  eq_diagonal_of_apply_configBasisIso (A := (K1 : ℂ) • openChainD0 M)
    (d := fun s => ((K1 * openChainEnergy s : ℝ) : ℂ))
    (fun s s' hs => by
      calc ((K1 : ℂ) • openChainD0 M) (configBasisIso M s') (configBasisIso M s)
          = (K1 : ℂ) * openChainD0 M (configBasisIso M s') (configBasisIso M s) := by
            rw [Matrix.smul_apply, smul_eq_mul]                    -- `def_matrix_scalar_multiple`
        _ = (K1 : ℂ) * 0 := by
            rw [openChainD0_eq_diagonal, Matrix.diagonal_apply,
              if_neg (fun hc => hs ((configBasisIso M).injective hc).symm)]  -- (a) の非対角成分
        _ = 0 := mul_zero _)                                       -- `complex_times_zero_is_zero`
    (fun s => by
      calc ((K1 : ℂ) • openChainD0 M) (configBasisIso M s) (configBasisIso M s)
          = (K1 : ℂ) * ((openChainEnergy s : ℝ) : ℂ) := by
            rw [Matrix.smul_apply, smul_eq_mul, openChainD0_eq_diagonal, Matrix.diagonal_apply_eq,
              Equiv.symm_apply_apply]                              -- 人手 1: `def_matrix_scalar_multiple` と (a)
        _ = ((K1 * openChainEnergy s : ℝ) : ℂ) :=
            real_inclusion_mul _ _                                 -- 人手 2: `real_inclusion_preserves_product`
      )

/-- **人手 Step 3 (a)**: `exp(κD_0)` は対角行列で `(exp(κD_0))_{ord(s),ord(s)} = (exp(K_1E(s)))_ℂ`。

1 段目は `smul_openChainD0_eq_diagonal`、2 段目は `exp_of_diagonal_matrix`（`matExp_diagonal`）、
3 段目は対角成分ごとに `complex_exp_of_real_argument`（Lean の具体版は無く、mathlib の `Complex.ofReal_exp`）。
対角成分だけを取り出した 2 行は `matExp_smul_openChainD0_apply`。 -/
theorem matExp_smul_openChainD0 (K1 : ℝ) :
    matExp ((K1 : ℂ) • openChainD0 M)
      = Matrix.diagonal (fun I =>
          ((Real.exp (K1 * openChainEnergy ((configBasisIso M).symm I)) : ℝ) : ℂ)) :=
  calc matExp ((K1 : ℂ) • openChainD0 M)
      = matExp (Matrix.diagonal (fun I =>
          ((K1 * openChainEnergy ((configBasisIso M).symm I) : ℝ) : ℂ))) := by
        rw [smul_openChainD0_eq_diagonal]                          -- (a) の `κD_0` の対角性
    _ = Matrix.diagonal (fun I =>
          Complex.exp ((K1 * openChainEnergy ((configBasisIso M).symm I) : ℝ) : ℂ)) :=
        matExp_diagonal _                                          -- `exp_of_diagonal_matrix`
    _ = Matrix.diagonal (fun I =>
          ((Real.exp (K1 * openChainEnergy ((configBasisIso M).symm I)) : ℝ) : ℂ)) :=
        congrArg Matrix.diagonal (funext fun _ => (Complex.ofReal_exp _).symm)  -- `complex_exp_of_real_argument`

/-- **人手 Step 3 (a) の最後の 2 行**: `(exp(κD_0))_{ord(s),ord(s)} = exp((K_1E(s))_ℂ) = (exp(K_1E(s)))_ℂ`。 -/
theorem matExp_smul_openChainD0_apply (K1 : ℝ) (s : SpinConf M) :
    matExp ((K1 : ℂ) • openChainD0 M) (configBasisIso M s) (configBasisIso M s)
      = ((Real.exp (K1 * openChainEnergy s) : ℝ) : ℂ) :=
  calc matExp ((K1 : ℂ) • openChainD0 M) (configBasisIso M s) (configBasisIso M s)
      = Complex.exp ((K1 * openChainEnergy s : ℝ) : ℂ) := by
        rw [smul_openChainD0_eq_diagonal, matExp_diagonal, Matrix.diagonal_apply_eq,
          Equiv.symm_apply_apply]                                  -- 人手 1: `exp_of_diagonal_matrix`
    _ = ((Real.exp (K1 * openChainEnergy s) : ℝ) : ℂ) :=
        (Complex.ofReal_exp _).symm                                -- 人手 2: `complex_exp_of_real_argument`

/-- 人手 Step 4 が「(a) の `exp(κD_0)` の対角性」として使う非対角成分: `t ≠ s` なら
`(exp(κD_0))_{ord(s),ord(t)} = 0_ℂ`（`matExp_smul_openChainD0` の対角行列の非対角成分）。 -/
theorem matExp_smul_openChainD0_apply_of_ne (K1 : ℝ) (s : SpinConf M) :
    ∀ t : SpinConf M, t ≠ s →
      matExp ((K1 : ℂ) • openChainD0 M) (configBasisIso M s) (configBasisIso M t) = 0 := by
  intro t hts
  rw [matExp_smul_openChainD0, Matrix.diagonal_apply_ne _
    (fun hc => hts ((configBasisIso M).injective hc).symm)]

open Classical in
/-- 人手 Step 4 が「(a) の `G` の対角性」として使う非対角成分: `t ≠ s` なら `G_{ord(s),ord(t)} = 0_ℂ`
（(a) の 4 行 `boundaryG_apply_configBasisIso` の `δ_{t=s} = 0_ℂ` と `complex_times_zero_is_zero`）。 -/
theorem boundaryG_apply_configBasisIso_of_ne (hM : M ≠ 0) (s : SpinConf M) :
    ∀ t : SpinConf M, t ≠ s → boundaryG M hM (configBasisIso M s) (configBasisIso M t) = 0 := by
  intro t hts
  rw [boundaryG_apply_configBasisIso, if_neg hts, mul_zero]

open Classical in
/-- 人手 Step 4 が (a) として使う `G` の対角成分: `G_{ord(s),ord(s)} = (s(M_col)s(1))_ℂ`
（(a) の 4 行 `boundaryG_apply_configBasisIso` の `δ_{s=s} = 1_ℂ` と積の単位元）。 -/
theorem boundaryG_apply_configBasisIso_self (hM : M ≠ 0) (s : SpinConf M) :
    boundaryG M hM (configBasisIso M s) (configBasisIso M s)
      = (((s (lastSite M hM) : ℝ) * (s (firstSite M hM) : ℝ) : ℝ) : ℂ) := by
  rw [boundaryG_apply_configBasisIso, if_pos rfl, mul_one]

/-! ## Step 3 (b) -/

/-- 人手 (b) の理由の、`ι`（`+1 ↦ 1`, `-1 ↦ 2`）のもとで全成分の入れ替えが `s ↦ -s` になる段:
`π(ι(s)) = ι(-s)`。 -/
theorem configBasisIso_negSpinConf (s : SpinConf M) :
    configBasisIso M (negSpinConf s) = flipConf (configBasisIso M s) := by
  funext m
  rw [configBasisIso_apply, flipConf_apply, configBasisIso_apply]
  rcases (s m).2 with h | h
  · rw [idxOfSpin, idxOfSpin, if_neg (by rw [coe_negSpinConf_apply, h]; norm_num), if_pos h,
      flipIdx_zero]
  · rw [idxOfSpin, idxOfSpin, if_pos (by rw [coe_negSpinConf_apply, h, neg_neg]),
      if_neg (by rw [h]; norm_num), flipIdx_one]

/-- **人手 Step 3 (b)**: `εf_{ι(s)} = f_{ι(-s)}`。 -/
theorem epsilon_mulVec_basisVec_configBasisIso (s : SpinConf M) :
    epsilon M *ᵥ basisVec (configBasisIso M s) = basisVec (configBasisIso M (negSpinConf s)) :=
  calc epsilon M *ᵥ basisVec (configBasisIso M s)
      = basisVec (flipConf (configBasisIso M s)) := epsilon_mulVec_basisVec _
    _ = basisVec (configBasisIso M (negSpinConf s)) := by rw [configBasisIso_negSpinConf]

open Classical in
/-- **人手 Step 3 (b) の 3 行**: `ε_{ord(s'),ord(s)} = (εf_{ι(s)})_{ord(s')} = (f_{ι(-s)})_{ord(s')} = δ_{-s=s'}`。

1 行目は (P5) の列の読み取り、2 行目は (b)（`epsilon_mulVec_basisVec_configBasisIso`）、3 行目は (P5)。 -/
theorem epsilon_apply_configBasisIso_col (s s' : SpinConf M) :
    epsilon M (configBasisIso M s') (configBasisIso M s) = if negSpinConf s = s' then 1 else 0 :=
  calc epsilon M (configBasisIso M s') (configBasisIso M s)
      = (epsilon M *ᵥ basisVec (configBasisIso M s)) (configBasisIso M s') :=
        (mulVec_basisVec_configBasisIso_apply _ s s').symm         -- 人手 1: (P5) の列の読み取り
    _ = basisVec (configBasisIso M (negSpinConf s)) (configBasisIso M s') := by
        rw [epsilon_mulVec_basisVec_configBasisIso]                -- 人手 2: (b)
    _ = if negSpinConf s = s' then 1 else 0 :=
        basisVec_configBasisIso_apply _ _                          -- 人手 3: (P5)

/-- 人手 `negated_row_configuration_is_involutive`（`trace_of_epsilon_V_plus` の (b) が使う `-(-s) = s`）。
人手の 3 行の鎖を `calc` の 3 段にした（`def_negated_row_configuration` を `s → -s`・`s → s` で 2 回、符号反転を 2 回）。
住処の違い: 人手は `s(m) ∈ {-1,1} ⊂ ℤ` で計算するが、Lean の `SpinVal` は `{-1,1} ⊂ ℝ` の部分型なので、鎖は値を ℝ へ埋め込んで書き、
最後の段の `neg_neg` は ℝ で効く。写像の等号（すべての `m` で値が等しい）は `funext`・`Subtype.ext` である。 -/
theorem negSpinConf_negSpinConf (s : SpinConf M) : negSpinConf (negSpinConf s) = s := by
  funext m
  apply Subtype.ext
  calc ((negSpinConf (negSpinConf s) m : SpinVal) : ℝ)
      = -((negSpinConf s m : SpinVal) : ℝ) := coe_negSpinConf_apply _ m   -- `def_negated_row_configuration`（`s → -s`）
    _ = -(-((s m : SpinVal) : ℝ)) := by rw [coe_negSpinConf_apply]       -- `def_negated_row_configuration`（`s → s`）
    _ = ((s m : SpinVal) : ℝ) := neg_neg _                               -- 符号反転を 2 回行うと元に戻る

/-- 人手 Step 4 が (b) として使う非対角成分: `t ≠ -s` なら `ε_{ord(s),ord(t)} = δ_{-t=s} = 0_ℂ`
（(b) の 3 行 `epsilon_apply_configBasisIso_col` を `s → t`、`s' → s` で。`-t = s` なら `t = -(-t) = -s`）。 -/
theorem epsilon_apply_configBasisIso_of_ne (s : SpinConf M) :
    ∀ t : SpinConf M, t ≠ negSpinConf s → epsilon M (configBasisIso M s) (configBasisIso M t) = 0 := by
  intro t ht
  rw [epsilon_apply_configBasisIso_col, if_neg (fun hc => ht (by rw [← hc, negSpinConf_negSpinConf]))]

/-- 人手 Step 4 の 3 行目「(b) の `δ_{-(-s)=s} = 1_ℂ`」: `ε_{ord(s),ord(-s)} = 1_ℂ`
（(b) の 3 行 `epsilon_apply_configBasisIso_col` を `s → -s`、`s' → s` で）。 -/
theorem epsilon_apply_configBasisIso_neg_self (s : SpinConf M) :
    epsilon M (configBasisIso M s) (configBasisIso M (negSpinConf s)) = 1 := by
  rw [epsilon_apply_configBasisIso_col, if_pos (negSpinConf_negSpinConf s)]

/-! ## Step 3 (c) -/

/-- 人手 (c) の `∑_{m=1}^{M_col} s(m)s(m) = M_col`。 -/
theorem sum_spin_mul_self (s : SpinConf M) : ∑ m : Fin M, (s m : ℝ) * (s m : ℝ) = M := by
  have h : ∀ m : Fin M, (s m : ℝ) * (s m : ℝ) = 1 := fun m => by
    rcases (s m).2 with h | h <;> rw [h] <;> norm_num
  rw [Finset.sum_congr rfl fun m _ => h m, Finset.sum_const, Finset.card_univ, Fintype.card_fin,
    nsmul_eq_mul, mul_one]

/-- **人手 Step 3 (c) の一つ目の特別な場合**: `(V_2)_{ord(s),ord(s)} = (exp(K_2M_col))_ℂ`。 -/
theorem V2_apply_configBasisIso_self (K2 : ℝ) (s : SpinConf M) :
    V2 M K2 (configBasisIso M s) (configBasisIso M s) = ((Real.exp (K2 * M) : ℝ) : ℂ) :=
  calc V2 M K2 (configBasisIso M s) (configBasisIso M s)
      = ((Real.exp (K2 * ∑ m : Fin M, (s m : ℝ) * (s m : ℝ)) : ℝ) : ℂ) :=
        V2_apply_configBasisIso K2 s s                             -- `def_transfer_matrix`
    _ = ((Real.exp (K2 * M) : ℝ) : ℂ) := by rw [sum_spin_mul_self]  -- `s(m)s(m) = 1` を足す

/-- 人手 (c) の `(-s(m))s(m) = -1` を `m = 1, …, M_col` について足した `∑_{m=1}^{M_col}(-s(m))s(m) = -M_col`。 -/
theorem sum_negSpin_mul_self (s : SpinConf M) :
    ∑ m : Fin M, (negSpinConf s m : ℝ) * (s m : ℝ) = -(M : ℝ) := by
  have h : ∀ m : Fin M, (negSpinConf s m : ℝ) * (s m : ℝ) = -1 := fun m => by
    rw [coe_negSpinConf_apply]
    rcases (s m).2 with h | h <;> rw [h] <;> norm_num
  rw [Finset.sum_congr rfl fun m _ => h m, Finset.sum_const, Finset.card_univ, Fintype.card_fin,
    nsmul_eq_mul, mul_neg_one]

/-- **人手 Step 3 (c) の二つ目の特別な場合**: `(V_2)_{ord(-s),ord(s)} = (exp(-K_2M_col))_ℂ`。

人手の `-K_2M_col` は `-(K_2M_col)` と読む（`K_2(-M_col) = -(K_2M_col)` の段を 3 段目に置く）。 -/
theorem V2_apply_configBasisIso_neg_self (K2 : ℝ) (s : SpinConf M) :
    V2 M K2 (configBasisIso M (negSpinConf s)) (configBasisIso M s)
      = ((Real.exp (-(K2 * M)) : ℝ) : ℂ) :=
  calc V2 M K2 (configBasisIso M (negSpinConf s)) (configBasisIso M s)
      = ((Real.exp (K2 * ∑ m : Fin M, (negSpinConf s m : ℝ) * (s m : ℝ)) : ℝ) : ℂ) :=
        V2_apply_configBasisIso K2 (negSpinConf s) s               -- `def_transfer_matrix`
    _ = ((Real.exp (K2 * -(M : ℝ)) : ℝ) : ℂ) := by rw [sum_negSpin_mul_self]  -- `(-s(m))s(m) = -1` を足す
    _ = ((Real.exp (-(K2 * M)) : ℝ) : ℂ) := by rw [mul_neg]       -- `K_2(-M_col) = -(K_2M_col)`

end Ising2D
