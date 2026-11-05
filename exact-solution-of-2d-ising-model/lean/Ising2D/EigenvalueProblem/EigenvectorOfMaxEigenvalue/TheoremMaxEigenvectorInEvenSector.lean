/-
# `ε` の固有値は `+1`（最大固有ベクトルは偶セクター）（具体版）

正本: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`
（`closing_007_theorem_max_eigenvector_in_even_sector`、
ラベル **`max_eigenvector_in_even_sector`**）

必要十分版は置かない。本ファイルの内容は `ClaimEpsilonEigenvalueOnCheckQ.lean`（符号の反転則）、
`ClaimTraceEpsilonVPlusViaCheckEigenvalues.lean`（トレースの符号）、`ClaimTraceEpsilonVPlusClosedForm.lean`
（`trace_of_epsilon_V_plus`）の組み合わせであり、新しい抽象構造は現れない。

## 人手証明との対応

人手の `ε ∈ {0,1}^{𝓜̌}` は Lean では `T : Finset (Fin M)`（`ε_μ = 1` の `μ` の集合）で、`|ε|` は `T.card`、
`(1,…,1)` は `Finset.univ` である。人手の `-1_ℂ := (−1)_ℂ` は Lean の `(-1 : ℂ)` で、
`(-1)^k` は mathlib の `Monoid.npow`（人手 `def_power_of_complex_number` の `z^0 = 1`・`z^{m+1} = z^m z` と同じ再帰）である。

| 人手の行 | Lean |
| --- | --- |
| 準備 (P1) `(-1)^k(-1)^k = 1_ℂ` の 4 行 | `neg_one_pow_mul_neg_one_pow`（Lean で補った段は 2 つ: 人手の 2 行目の前に略記 `-1_ℂ = (−1)_ℂ` を開く段、人手 3 と 4 の間に `(1)_ℂ = 1_ℂ` の段） |
| 準備 (P2) `|ε| ≤ M_col` の 3 行 | `card_le_of_finset`（1 行目の `|ε|` の置き方は `T.card` そのもの） |
| (1) 3 行の含意 | `vPlusDataOf_eta_univ_eq_one`（具体的な `V^{(+)}`） |
| (2) 8 行の鎖 | `CheckFermi.eta_eq_neg_one_pow_sub_card`（1〜3 行）・`CheckFermi.eta_eq_neg_one_pow_add_card`（3〜8 行） |
| (2) 行列の式 2 行 | `CheckFermi.epsilon_mul_Qproj_eq_neg_one_pow_add_card` |
| (3) 3 行 | `CheckFermi.epsilon_eq_neg_one_pow_smul_parityProd` |
| (4) `εQ̌_{(1,…,1)} = Q̌_{(1,…,1)}` の 3 行 | `CheckFermi.epsilon_mul_Qproj_univ_of_eta` |
| (4) `Q̌_{(1,…,1)}y = y` の 4 行 | `CheckFermi.Qproj_univ_mulVec_of_mem_range`（3 行目の冪等性は `checkFermiOf_Qproj_univ_mul_self`） |
| (4) `εy = y` の 4 行 | `CheckFermi.epsilon_mulVec_of_mem_range_univ` |
| (4) 言い換えの 2 行 `{x | V^{(+)}x = Λ̌_max x} = im Q̌_{(1,…,1)} ⊆ 𝓕^{(+)}` | `eigenspace_VPlus_max_subset_evenSector`（1 行目は `eigenspace_VPlus_max_eq_range_Qproj_univ_checkFermiSetupOf`） |
| 主張 (1)〜(4) | `max_eigenvector_in_even_sector` |

(2)〜(4) の鎖は (1) の結論 `η_{(1,…,1)} = +1` だけを使うので、`CheckFermi` について仮定 `heta` で受け取る形で置く。
人手の主張は具体的な `V^{(+)}`（`vPlusDataOf`）について述べるので、主張 `max_eigenvector_in_even_sector` は
`heta` を (1) の `vPlusDataOf_eta_univ_eq_one` で埋めて述べる。
`VPlusData` の名前空間の `htr` 付きの形（`VPlusData.eta_eq_sign` ほか）は、任意の `VPlusData` について述べる下流
（`TheoremCPlusEqualsLambda.lean`）のための形で、`heta` を (1) の最後の行
（`trace_of_epsilon_V_plus_via_check_eigenvalues` (3) の `⟸`、`VPlusData.eta_univ_eq_one_of_trace_pos`）で埋める。

人手の「ℂ の乗法の結合則・単位元」（`complex_numbers_form_a_field`）と「可換な二数の冪の積」「非負の指数の指数法則」
（`def_power_of_complex_number` からの帰納法）には Lean の具体版が無いので、既存の慣行どおり mathlib の
`mul_assoc`・`one_mul`・`mul_one`・`mul_pow`・`pow_add`・`one_pow` を引き、(2) の 7 行目の指数
`(M_col − |ε|) + |ε| = M_col` は (P2) と `Nat.sub_add_cancel` で閉じる。`mat_mult_associative` も具体版が無いので
`Matrix.mulVec_mulVec` を引く。

`max_eigenvalue_of_V_plus_simple`・`check_joint_eigenspace_decomposition` と 1 対 1 の Lean は `CheckFermiSetup`（添字 `CheckIdx M`）の
上にあり、この章の鎖は `CheckFermi`（添字 `Fin M`）の上にある。具体的な `ψ̌` から作った二つの `Q̌_ε` が同じ行列であることを
`checkFermiOf_Qproj_eq`（運ぶ段）で示し、固有空間の言い換えの 1 行目と、(4) の 2 つ目の鎖の 3 行目が引く冪等性を
`CheckFermiSetup` 側の人手と 1 対 1 の Lean から運ぶ。任意の `VPlusData` についての形では、冪等性を `CheckFermi` の上の
必要十分版の特殊化 `CheckFermi.Qproj_mul_self`（`CheckFermiInput.lean`）で埋める。
-/
import Ising2D.EigenvalueProblem.EigenvectorOfMaxEigenvalue.ClaimTraceEpsilonVPlusViaCheckEigenvalues
import Ising2D.EigenvalueProblem.EigenvectorOfMaxEigenvalue.ClaimTraceEpsilonVPlusClosedForm
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.ClaimVPlusDataFromEigenvaluesOfVPlus
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultipleByOneFromNecSuf
import Ising2D.ThermodynamicLimit.ColumnLimitAndClosedForm.ClaimEpsilonIsRealSymmetric

namespace Ising2D

open Matrix

variable {M : ℕ}

/-! ## 準備 -/

/-- **人手 準備 (P1)**: `k ∈ ℤ_{≥0}` について `(-1)^k(-1)^k = 1_ℂ`。 -/
theorem neg_one_pow_mul_neg_one_pow (k : ℕ) : (-1 : ℂ) ^ k * (-1 : ℂ) ^ k = 1 :=
  calc (-1 : ℂ) ^ k * (-1 : ℂ) ^ k
      = ((-1 : ℂ) * (-1 : ℂ)) ^ k := (mul_pow _ _ k).symm   -- 人手 1: 可換な二数の冪の積
    _ = (((-1 : ℝ) : ℂ) * ((-1 : ℝ) : ℂ)) ^ k := by
          rw [Complex.ofReal_neg, Complex.ofReal_one]         -- 準備の略記 `-1_ℂ := (−1)_ℂ` を開く
    _ = (((-1 : ℝ) * (-1 : ℝ) : ℝ) : ℂ) ^ k := by
          rw [real_inclusion_mul]                            -- 人手 2: `real_inclusion_preserves_product`
    _ = ((1 : ℝ) : ℂ) ^ k := by
          rw [show ((-1 : ℝ) * (-1 : ℝ)) = 1 by norm_num]      -- 人手 3: ℝ の四則 `(−1)(−1) = 1`
    _ = (1 : ℂ) ^ k := by rw [Complex.ofReal_one]            -- `(1)_ℂ = 1_ℂ`（`inclusion_rr_to_cc` の像）
    _ = 1 := one_pow k                                       -- 人手 4: `1_ℂ^k = 1_ℂ`（`k` の帰納法）

/-- **人手 準備 (P2)**: `|ε| ≤ M_col`。人手の 1 行目 `|ε| = #{μ ∈ 𝓜̌ | ε_μ = 1}` は、Lean では `ε` を
その集合 `T` で表すので `T.card` そのものである。 -/
theorem card_le_of_finset (T : Finset (Fin M)) : T.card ≤ M :=
  calc T.card
      ≤ (Finset.univ : Finset (Fin M)).card :=
          Finset.card_le_card (Finset.subset_univ T)         -- 人手 2: 有限集合の部分集合の元の個数は全体以下
    _ = M := by rw [Finset.card_univ, Fintype.card_fin]      -- 人手 3: `def_check_index_set` の `𝓜̌ = {1,…,M_col}`

/-! ## (2)〜(4) の鎖（(1) の結論 `η_{(1,…,1)} = +1` を仮定 `heta` で受け取る） -/

namespace CheckFermi

variable (F : CheckFermi M)

/-- **人手 (2) の鎖の 1〜3 行**: `η_ε = (-1)^{M_col − |ε|}`。 -/
theorem eta_eq_neg_one_pow_sub_card (heta : F.eta Finset.univ = 1) (T : Finset (Fin M)) :
    F.eta T = (-1 : ℂ) ^ (M - T.card) :=
  calc F.eta T
      = F.eta Finset.univ * (-1 : ℂ) ^ (M - T.card) := F.eta_eq_eta_univ_mul T  -- 人手 1: `epsilon_eigenvalue_on_check_Q` (3)
    _ = 1 * (-1 : ℂ) ^ (M - T.card) := by rw [heta]                            -- 人手 2: (1)
    _ = (-1 : ℂ) ^ (M - T.card) := one_mul _                                   -- 人手 3: `1_ℂ` は乗法の単位元

/-- **人手 (2) の鎖の 3〜8 行**: `η_ε = (-1)^{M_col + |ε|}`。 -/
theorem eta_eq_neg_one_pow_add_card (heta : F.eta Finset.univ = 1) (T : Finset (Fin M)) :
    F.eta T = (-1 : ℂ) ^ (M + T.card) :=
  calc F.eta T
      = (-1 : ℂ) ^ (M - T.card) := F.eta_eq_neg_one_pow_sub_card heta T         -- 人手 1〜3
    _ = (-1 : ℂ) ^ (M - T.card) * 1 := (mul_one _).symm                        -- 人手 4: `1_ℂ` は乗法の単位元
    _ = (-1 : ℂ) ^ (M - T.card) * ((-1 : ℂ) ^ T.card * (-1 : ℂ) ^ T.card) := by
          rw [neg_one_pow_mul_neg_one_pow]                                     -- 人手 5: (P1)（`k → |ε|`）を右辺から左辺へ
    _ = ((-1 : ℂ) ^ (M - T.card) * (-1 : ℂ) ^ T.card) * (-1 : ℂ) ^ T.card :=
          (mul_assoc _ _ _).symm                                               -- 人手 6: 乗法の結合則
    _ = (-1 : ℂ) ^ M * (-1 : ℂ) ^ T.card := by
          rw [← pow_add, Nat.sub_add_cancel (card_le_of_finset T)]             -- 人手 7: 指数法則（`a → M_col − |ε|`、(P2)）
    _ = (-1 : ℂ) ^ (M + T.card) := (pow_add _ _ _).symm                        -- 人手 8: 指数法則（`a → M_col`）

/-- **人手 (2) の行列の式**: `εQ̌_ε = (-1)^{M_col + |ε|}Q̌_ε`。 -/
theorem epsilon_mul_Qproj_eq_neg_one_pow_add_card (heta : F.eta Finset.univ = 1) (T : Finset (Fin M)) :
    epsilon M * F.Qproj T = (-1 : ℂ) ^ (M + T.card) • F.Qproj T :=
  calc epsilon M * F.Qproj T
      = F.eta T • F.Qproj T := F.epsilon_mul_Qproj T                           -- 人手 1: `epsilon_eigenvalue_on_check_Q` (1)
    _ = (-1 : ℂ) ^ (M + T.card) • F.Qproj T := by
          rw [F.eta_eq_neg_one_pow_add_card heta T]                            -- 人手 2: 上の鎖の `η_ε = (-1)^{M_col+|ε|}`

/-- **人手 (3)**: `ε = (-1)^{M_col} ∏_μ (I - 2ň_μ)`。 -/
theorem epsilon_eq_neg_one_pow_smul_parityProd (heta : F.eta Finset.univ = 1) :
    epsilon M = (-1 : ℂ) ^ M • F.parityProd :=
  calc epsilon M
      = (F.eta Finset.univ * (-1 : ℂ) ^ M) • F.parityProd := F.epsilon_eq_parityProd  -- 人手 1: `epsilon_eigenvalue_on_check_Q` (4)
    _ = (1 * (-1 : ℂ) ^ M) • F.parityProd := by rw [heta]                             -- 人手 2: (1)
    _ = (-1 : ℂ) ^ M • F.parityProd := by rw [one_mul]                                -- 人手 3: `1_ℂ` は乗法の単位元

/-- **人手 (4) の 1 つ目の鎖**: `εQ̌_{(1,…,1)} = Q̌_{(1,…,1)}`。 -/
theorem epsilon_mul_Qproj_univ_of_eta (heta : F.eta Finset.univ = 1) :
    epsilon M * F.Qproj (Finset.univ : Finset (Fin M)) = F.Qproj Finset.univ :=
  calc epsilon M * F.Qproj Finset.univ
      = F.eta Finset.univ • F.Qproj Finset.univ := F.epsilon_mul_Qproj Finset.univ  -- 人手 1: `epsilon_eigenvalue_on_check_Q` (1)
    _ = (1 : ℂ) • F.Qproj Finset.univ := by rw [heta]                               -- 人手 2: (1)
    _ = F.Qproj Finset.univ := one_smul_tensorPow _                                  -- 人手 3: `scalar_multiple_by_one`

/-- **人手 (4) の 2 つ目の鎖**: `y = Q̌_{(1,…,1)}x` なら `Q̌_{(1,…,1)}y = y`。
3 行目が引く `check_joint_eigenspace_decomposition` (1) の冪等性 `Q̌_{(1,…,1)}Q̌_{(1,…,1)} = Q̌_{(1,…,1)}` は仮定 `hidem` で受け取る
（具体的な `V^{(+)}` の主張では、人手と 1 対 1 の `CheckFermiSetup.Qproj_mul_self` から運んだ `checkFermiOf_Qproj_univ_mul_self` で埋める）。 -/
theorem Qproj_univ_mulVec_of_mem_range
    (hidem : F.Qproj (Finset.univ : Finset (Fin M)) * F.Qproj Finset.univ = F.Qproj Finset.univ)
    {x y : Conf M → ℂ} (hy : y = F.Qproj (Finset.univ : Finset (Fin M)) *ᵥ x) :
    F.Qproj (Finset.univ : Finset (Fin M)) *ᵥ y = y :=
  calc F.Qproj Finset.univ *ᵥ y
      = F.Qproj Finset.univ *ᵥ (F.Qproj Finset.univ *ᵥ x) := by rw [← hy]   -- 人手 1: `y` の取り方
    _ = (F.Qproj Finset.univ * F.Qproj Finset.univ) *ᵥ x :=
          Matrix.mulVec_mulVec _ _ _                                       -- 人手 2: `mat_mult_associative`
    _ = F.Qproj Finset.univ *ᵥ x := by rw [hidem]                          -- 人手 3: `check_joint_eigenspace_decomposition` (1)
    _ = y := hy.symm                                                       -- 人手 4: `y` の取り方

/-- **人手 (4) の 3 つ目の鎖**: `y = Q̌_{(1,…,1)}x` なら `εy = y`（`y ∈ 𝓕^{(+)}`、`def_even_eigenvectors_of_epsilon`）。 -/
theorem epsilon_mulVec_of_mem_range_univ (heta : F.eta Finset.univ = 1)
    (hidem : F.Qproj (Finset.univ : Finset (Fin M)) * F.Qproj Finset.univ = F.Qproj Finset.univ)
    {x y : Conf M → ℂ} (hy : y = F.Qproj (Finset.univ : Finset (Fin M)) *ᵥ x) :
    epsilon M *ᵥ y = y :=
  calc epsilon M *ᵥ y
      = epsilon M *ᵥ (F.Qproj Finset.univ *ᵥ y) := by
          rw [F.Qproj_univ_mulVec_of_mem_range hidem hy]                   -- 人手 1: 直前の鎖の `Q̌y = y`
    _ = (epsilon M * F.Qproj Finset.univ) *ᵥ y :=
          Matrix.mulVec_mulVec _ _ _                                       -- 人手 2: `mat_mult_associative`
    _ = F.Qproj Finset.univ *ᵥ y := by
          rw [F.epsilon_mul_Qproj_univ_of_eta heta]                        -- 人手 3: 1 つ目の鎖
    _ = y := F.Qproj_univ_mulVec_of_mem_range hidem hy                     -- 人手 4: 直前の鎖の `Q̌y = y`

end CheckFermi

/-! ## (1)（具体的な `V^{(+)}`）と主張 -/

/-- **人手 (1)**: 具体的な `V^{(+)}`（`vPlusDataOf`）について `η_{(1,…,1)} = +1`。
`r := (2exp(-K_2)cosh K_1)^{M_col} + (2exp(K_2)sinh K_1)^{M_col}`。
1 行目の `tr(εV^{(+)}) = r_ℂ` かつ `r ∈ ℝ_{>0}` は `trace_of_epsilon_V_plus` の等号と `∈ ℝ_{>0}` の読み方
（`vPlusDataOf` の `V^{(+)}` は `VPlus` の形で持つので、`VPlusOfTransfer_eq_VPlus` で人手 `def_V_plus` の形へ戻す。
Lean の `trace_of_epsilon_V_plus` は `∈ ℝ_{>0}` を `0 < Re tr(εV^{(+)})` で持つので、等号で書き換えて `0 < r` を読む）。 -/
theorem vPlusDataOf_eta_univ_eq_one (P : IsingParam) (hM2 : 2 ≤ M) :
    (checkFermiOf P (by omega : M ≠ 0)).eta (Finset.univ : Finset (Fin M)) = 1 := by
  have hM : M ≠ 0 := by omega
  set D := vPlusDataOf P hM P.c2_mul_s2star_eq_c2star with hD
  set r : ℝ := (2 * Real.exp (-P.K2) * Real.cosh P.K1) ^ M + (2 * Real.exp P.K2 * Real.sinh P.K1) ^ M with hr
  -- 人手 1 行目: `tr(εV^{(+)}) = r_ℂ` かつ `r ∈ ℝ_{>0}`（`trace_of_epsilon_V_plus`）
  have h1 : (epsilon M * D.V).trace = (r : ℂ) ∧ 0 < r := by
    have hV : D.V = VPlusOfTransfer M (P.K1 : ℂ) P.K2 := by
      rw [hD, vPlusDataOf_V, IsingParam.K2star, ← VPlusOfTransfer_eq_VPlus P.K2_pos]
    obtain ⟨heq, hpos⟩ := trace_of_epsilon_V_plus hM2 P.K1_pos P.K2
    rw [hV]
    refine ⟨heq, ?_⟩
    rw [heq, Complex.ofReal_re] at hpos
    exact hpos
  -- 人手 2 行目: `tr(εV^{(+)}) > 0`（ℂ の元の `z > 0` の定め方。存在する実数として `r` を取る）
  have h2 : ∃ s : ℝ, 0 < s ∧ (epsilon M * D.V).trace = (s : ℂ) := ⟨r, h1.2, h1.1⟩
  -- 人手 3 行目: `trace_of_epsilon_V_plus_via_check_eigenvalues` (3) の `⟸`
  exact D.eta_univ_eq_one_iff_trace_pos.mpr h2

/-! ## 二つの `Q̌_ε` をつなぐ（運ぶ段）と、固有空間の言い換え

人手の `Q̌_ε` の Lean は二つある。`max_eigenvalue_of_V_plus_simple`・`check_joint_eigenspace_decomposition` と 1 対 1 の鎖は
`CheckFermiSetup`（添字 `𝓜̌ = CheckIdx M`）の上の `CheckFermiSetup.Qproj`、この章の鎖は `CheckFermi`（添字 `Fin M`）の上の
`CheckFermi.Qproj` である。具体的な `ψ̌` から作った二つ（`checkFermiSetupOf`・`checkFermiOf`）では、
どちらも人手の定義 `Q̌_ε = ∏_{ν=1}^{M_col} A_ν` の同じ行列であることを `checkFermiOf_Qproj_eq` で示す
（添字 `j : Fin M` を `finCheckIdxEquiv M j = j + 1 ∈ 𝓜̌` へ送る付け替えで、人手の証明の行ではない）。 -/

/-- 運ぶ段: 具体的な `ψ̌` について、`CheckFermi` の `Q̌_T` と `CheckFermiSetup` の `Q̌_{e(T)}`（`e = finCheckIdxEquiv`）は
同じ行列。どちらも人手の左から掛ける積 `∏_{ν=1}^{M_col}`（`NecSuf.finProdLeft`、人手の `M_col` が Lean の `r + 1`）に等しく、
因子の `ň_ν` は両側で `ψ̌_ν^†ψ̌_{M_col+1−ν}` の同じ行列、`ν ∈ T ⟺ e(ν) ∈ e(T)` である。 -/
theorem checkFermiOf_Qproj_eq (P : IsingParam) {r : ℕ} (T : Finset (Fin (r + 1))) :
    (checkFermiOf P (Nat.succ_ne_zero r)).Qproj T
      = (checkFermiSetupOf P (Nat.succ_ne_zero r)).Qproj (T.map (finCheckIdxEquiv (r + 1)).toEmbedding) := by
  set F := checkFermiOf P (Nat.succ_ne_zero r)
  set Fs := checkFermiSetupOf P (Nat.succ_ne_zero r)
  set e := finCheckIdxEquiv (r + 1)
  have h := NecSuf.finProdLeft_eq_noncommProd_image (NecSuf.projFactor F.nOp T)
    (fun i j => NecSuf.commute_projFactor F.commute_nOp_nOp T T i j) r id Function.injective_id
  rw [Finset.image_id] at h
  have hfac : ∀ j : Fin (r + 1),
      NecSuf.projFactor F.nOp T j
        = NecSuf.projFactor Fs.nOp (T.map e.toEmbedding) (CheckFermiSetup.checkIdxOfFin j) := by
    intro j
    have hj : CheckFermiSetup.checkIdxOfFin j = e j := Subtype.ext (by simp [CheckFermiSetup.checkIdxOfFin, e, checkIdx])
    have hn : Fs.nOp (e j) = F.nOp j := rfl
    rw [hj]
    by_cases hT : j ∈ T
    · rw [NecSuf.projFactor_of_mem hT, NecSuf.projFactor_of_mem (Finset.mem_map_equiv.2 (by simpa using hT)), hn]
    · rw [NecSuf.projFactor_of_notMem hT,
        NecSuf.projFactor_of_notMem (fun h' => hT (by simpa using Finset.mem_map_equiv.1 h')), hn]
  calc F.Qproj T
      = (Finset.univ : Finset (Fin (r + 1))).noncommProd (NecSuf.projFactor F.nOp T)
          (fun i _ j _ _ => NecSuf.commute_projFactor F.commute_nOp_nOp T T i j) := rfl
    _ = NecSuf.finProdLeft r (fun j => NecSuf.projFactor F.nOp T j) := h.symm
    _ = NecSuf.finProdLeft r
          (fun j => NecSuf.projFactor Fs.nOp (T.map e.toEmbedding) (CheckFermiSetup.checkIdxOfFin j)) :=
        congrArg (NecSuf.finProdLeft r) (funext hfac)
    _ = Fs.Qproj (T.map e.toEmbedding) := (CheckFermiSetup.Qproj_eq_finProdLeft Fs _).symm

/-- 運ぶ段の `ε = (1,…,1)` の場合: `e((1,…,1)) = (1,…,1)`。 -/
theorem checkFermiOf_Qproj_univ_eq (P : IsingParam) {r : ℕ} :
    (checkFermiOf P (Nat.succ_ne_zero r)).Qproj (Finset.univ : Finset (Fin (r + 1)))
      = (checkFermiSetupOf P (Nat.succ_ne_zero r)).Qproj (Finset.univ : Finset (CheckIdx (r + 1))) := by
  rw [checkFermiOf_Qproj_eq, Finset.map_univ_equiv]

/-- 人手 `check_joint_eigenspace_decomposition` (1) の `Q̌_{(1,…,1)}Q̌_{(1,…,1)} = Q̌_{(1,…,1)}` を、具体的な `ψ̌` の `CheckFermi` の
`Q̌_{(1,…,1)}` について、人手と 1 対 1 の `CheckFermiSetup.Qproj_mul_self` から運んだもの。 -/
theorem checkFermiOf_Qproj_univ_mul_self (P : IsingParam) {r : ℕ} :
    (checkFermiOf P (Nat.succ_ne_zero r)).Qproj (Finset.univ : Finset (Fin (r + 1)))
        * (checkFermiOf P (Nat.succ_ne_zero r)).Qproj Finset.univ
      = (checkFermiOf P (Nat.succ_ne_zero r)).Qproj Finset.univ := by
  rw [checkFermiOf_Qproj_univ_eq]
  exact CheckFermiSetup.Qproj_mul_self _ _

/-- **人手 `max_eigenvalue_of_V_plus_simple` (3)** を具体的な `V^{(+)}` について集合の等号で述べたもの:
`{x | V^{(+)}x = Λ̌_max x} = im Q̌_{(1,…,1)}`（`CheckFermiSetup` の `Q̌`。`Λ̌_max` は `checkBigLambda … univ`）。
一般の `CheckFermiSetup` についての `eigenspace_VPlus_max_eq_range_Qproj_univ` を具体的な `ψ̌` へ特殊化する。
`V^{(+)} = c V̌'` は `VPlus_eq_smul_checkVprime_const` と `checkFermiSetupOf_Vprime`、`γ(θ~_μ) > 0` は `gammaFn_thetaTilde_pos`。 -/
theorem eigenspace_VPlus_max_eq_range_Qproj_univ_checkFermiSetupOf (P : IsingParam) {r : ℕ} :
    {x : Conf (r + 1) → ℂ |
        (VPlus (r + 1) (Real.sinh (2 * P.K2)) (P.K1 : ℂ) (P.K2star : ℂ)) *ᵥ x
          = ((checkBigLambda (checkFermiSetupOf P (Nat.succ_ne_zero r)) (fun i => gammaTilde P (r + 1) i.1)
                (Real.sinh (2 * P.K2)) Finset.univ : ℝ) : ℂ) • x}
      = (LinearMap.range (Matrix.toLin'
          ((checkFermiSetupOf P (Nat.succ_ne_zero r)).Qproj (Finset.univ : Finset (CheckIdx (r + 1)))))
          : Set (Conf (r + 1) → ℂ)) := by
  set Fs := checkFermiSetupOf P (Nat.succ_ne_zero r)
  have hVeq : VPlus (r + 1) (Real.sinh (2 * P.K2)) (P.K1 : ℂ) (P.K2star : ℂ)
      = ((((2 * Real.sinh (2 * P.K2)) ^ (((r + 1 : ℕ) : ℝ) / 2) : ℝ) : ℂ))
          • Fs.Vprime (fun i => gammaTilde P (r + 1) i.1) := by
    rw [VPlus_eq_smul_checkVprime_const P (Nat.succ_ne_zero r) P.c2_mul_s2star_eq_c2star,
      checkFermiSetupOf_Vprime]
  have hgpos : ∀ i : CheckIdx (r + 1), 0 < gammaTilde P (r + 1) i.1 :=
    fun i => gammaFn_thetaTilde_pos P (Nat.succ_ne_zero r) (CheckIdx.prop' i)
  exact eigenspace_VPlus_max_eq_range_Qproj_univ Fs _ hgpos (star_ofReal_self P.K1)
    (star_ofReal_self P.K2star) (sinh_two_K2_pos P) hVeq

/-- **人手 (4) の言い換えの 2 行**（`M_col ≥ 2`）:
`{x | V^{(+)}x = Λ̌_max x} = im Q̌_{(1,…,1)} ⊆ 𝓕^{(+)}`。
1 行目は `max_eigenvalue_of_V_plus_simple` (3)（`eigenspace_VPlus_max_eq_range_Qproj_univ_checkFermiSetupOf`）で、`CheckFermiSetup` の
`Q̌_{(1,…,1)}` をこの章の `CheckFermi` の `Q̌_{(1,…,1)}` へ `checkFermiOf_Qproj_univ_eq` で運ぶ（運ぶ段）。
2 行目は上で示した包含 `epsilon_mulVec_of_mem_range_univ`（`𝓕^{(+)}` の元であることは `ε *ᵥ y = y`、`def_even_eigenvectors_of_epsilon`）。 -/
theorem eigenspace_VPlus_max_subset_evenSector (P : IsingParam) (hM2 : 2 ≤ M) :
    {x : Conf M → ℂ |
        (VPlus M (Real.sinh (2 * P.K2)) (P.K1 : ℂ) (P.K2star : ℂ)) *ᵥ x
          = ((checkBigLambda (checkFermiSetupOf P (by omega : M ≠ 0)) (fun i => gammaTilde P M i.1)
                (Real.sinh (2 * P.K2)) Finset.univ : ℝ) : ℂ) • x}
      = (LinearMap.range (Matrix.toLin'
          ((checkFermiOf P (by omega : M ≠ 0)).Qproj (Finset.univ : Finset (Fin M))))
          : Set (Conf M → ℂ))
    ∧ (LinearMap.range (Matrix.toLin'
          ((checkFermiOf P (by omega : M ≠ 0)).Qproj (Finset.univ : Finset (Fin M))))
          : Set (Conf M → ℂ))
        ⊆ {y : Conf M → ℂ | epsilon M *ᵥ y = y} := by
  obtain ⟨r, rfl⟩ : ∃ r, M = r + 1 := ⟨M - 1, by omega⟩
  refine ⟨?_, ?_⟩
  · rw [eigenspace_VPlus_max_eq_range_Qproj_univ_checkFermiSetupOf P, checkFermiOf_Qproj_univ_eq P]
                                                        -- 人手 1: `max_eigenvalue_of_V_plus_simple` (3)（`Q̌` を運ぶ段を含む）
  · rintro y ⟨x, rfl⟩                                   -- 人手 2: 上で示した包含（`y = Q̌_{(1,…,1)}x`）
    have heta := vPlusDataOf_eta_univ_eq_one P hM2
    rw [Matrix.toLin'_apply]
    exact (checkFermiOf P (Nat.succ_ne_zero r)).epsilon_mulVec_of_mem_range_univ heta
      (checkFermiOf_Qproj_univ_mul_self P) rfl

/-- **人手 `max_eigenvector_in_even_sector`**（`K_1, K_2 > 0` は `IsingParam` が持つ。`M_col ≥ 2`）:
(1) `η_{(1,…,1)} = +1`、
(2) `η_ε = (-1)^{M_col−|ε|} = (-1)^{M_col+|ε|}`、`εQ̌_ε = (-1)^{M_col+|ε|}Q̌_ε`、
(3) `ε = (-1)^{M_col}∏_μ(I − 2ň_μ)`、
(4) `im Q̌_{(1,…,1)} ⊆ 𝓕^{(+)}`（`im Q̌_{(1,…,1)}` の元は `Q̌_{(1,…,1)} *ᵥ x`、`𝓕^{(+)}` の元であることは `ε *ᵥ y = y`）、
すなわち `{x | V^{(+)}x = Λ̌_max x} = im Q̌_{(1,…,1)} ⊆ 𝓕^{(+)}`（`eigenspace_VPlus_max_subset_evenSector`）。
(4) の第 1 の形 `∀ x, ε(Q̌_{(1,…,1)}x) = Q̌_{(1,…,1)}x` は、最後の包含を像の元ごとに書いたもので、内容は同じである。 -/
theorem max_eigenvector_in_even_sector (P : IsingParam) (hM2 : 2 ≤ M) :
    (checkFermiOf P (by omega : M ≠ 0)).eta (Finset.univ : Finset (Fin M)) = 1
    ∧ (∀ T : Finset (Fin M),
        (checkFermiOf P (by omega : M ≠ 0)).eta T = (-1 : ℂ) ^ (M - T.card)
        ∧ (checkFermiOf P (by omega : M ≠ 0)).eta T = (-1 : ℂ) ^ (M + T.card)
        ∧ epsilon M * (checkFermiOf P (by omega : M ≠ 0)).Qproj T
            = (-1 : ℂ) ^ (M + T.card) • (checkFermiOf P (by omega : M ≠ 0)).Qproj T)
    ∧ epsilon M = (-1 : ℂ) ^ M • (checkFermiOf P (by omega : M ≠ 0)).parityProd
    ∧ (∀ x : Conf M → ℂ,
        epsilon M *ᵥ ((checkFermiOf P (by omega : M ≠ 0)).Qproj (Finset.univ : Finset (Fin M)) *ᵥ x)
          = (checkFermiOf P (by omega : M ≠ 0)).Qproj Finset.univ *ᵥ x)
    ∧ {x : Conf M → ℂ |
        (VPlus M (Real.sinh (2 * P.K2)) (P.K1 : ℂ) (P.K2star : ℂ)) *ᵥ x
          = ((checkBigLambda (checkFermiSetupOf P (by omega : M ≠ 0)) (fun i => gammaTilde P M i.1)
                (Real.sinh (2 * P.K2)) Finset.univ : ℝ) : ℂ) • x}
      = (LinearMap.range (Matrix.toLin'
          ((checkFermiOf P (by omega : M ≠ 0)).Qproj (Finset.univ : Finset (Fin M))))
          : Set (Conf M → ℂ))
    ∧ (LinearMap.range (Matrix.toLin'
          ((checkFermiOf P (by omega : M ≠ 0)).Qproj (Finset.univ : Finset (Fin M))))
          : Set (Conf M → ℂ))
        ⊆ {y : Conf M → ℂ | epsilon M *ᵥ y = y} := by
  have hsub := eigenspace_VPlus_max_subset_evenSector P hM2
  obtain ⟨r, rfl⟩ : ∃ r, M = r + 1 := ⟨M - 1, by omega⟩
  have heta := vPlusDataOf_eta_univ_eq_one P hM2
  have hidem := checkFermiOf_Qproj_univ_mul_self P (r := r)
  set F := checkFermiOf P (Nat.succ_ne_zero r)
  exact ⟨heta,
    fun T => ⟨F.eta_eq_neg_one_pow_sub_card heta T, F.eta_eq_neg_one_pow_add_card heta T,
      F.epsilon_mul_Qproj_eq_neg_one_pow_add_card heta T⟩,
    F.epsilon_eq_neg_one_pow_smul_parityProd heta,
    fun x => F.epsilon_mulVec_of_mem_range_univ heta hidem rfl, hsub.1, hsub.2⟩

/-! ## 任意の `VPlusData` についての形（下流のため） -/

namespace VPlusData

variable {F : CheckFermi M} (D : VPlusData M F)

/-- 人手 (1) の最後の行だけ（`trace_of_epsilon_V_plus_via_check_eigenvalues` (3) の `⟸`）を、任意の `VPlusData` について
`0 < Re tr(εV^{(+)})` の形の仮定で読んだもの。 -/
theorem eta_univ_eq_one (htr : 0 < ((epsilon M * D.V).trace).re) :
    F.eta (Finset.univ : Finset (Fin M)) = 1 :=
  D.eta_univ_eq_one_of_trace_pos htr

/-- 人手 (2) の `η_ε = (-1)^{M−|ε|}`（`CheckFermi.eta_eq_neg_one_pow_sub_card` の `heta` を `eta_univ_eq_one` で埋める）。 -/
theorem eta_eq_sign (htr : 0 < ((epsilon M * D.V).trace).re) (T : Finset (Fin M)) :
    F.eta T = (-1 : ℂ) ^ (M - T.card) :=
  F.eta_eq_neg_one_pow_sub_card (D.eta_univ_eq_one htr) T

/-- 人手 (3)（`CheckFermi.epsilon_eq_neg_one_pow_smul_parityProd` の `heta` を `eta_univ_eq_one` で埋める）。 -/
theorem epsilon_eq_parityProd_of_trace_pos (htr : 0 < ((epsilon M * D.V).trace).re) :
    epsilon M = ((-1 : ℂ) ^ M) • F.parityProd :=
  F.epsilon_eq_neg_one_pow_smul_parityProd (D.eta_univ_eq_one htr)

/-- 人手 (4) の 1 つ目の鎖（`CheckFermi.epsilon_mul_Qproj_univ_of_eta` の `heta` を `eta_univ_eq_one` で埋める）。 -/
theorem epsilon_mul_Qproj_univ (htr : 0 < ((epsilon M * D.V).trace).re) :
    epsilon M * F.Qproj (Finset.univ : Finset (Fin M)) = F.Qproj Finset.univ :=
  F.epsilon_mul_Qproj_univ_of_eta (D.eta_univ_eq_one htr)

/-- 人手 (4) の `im Q̌_{(1,…,1)} ⊆ 𝓕^{(+)}`（`CheckFermi.epsilon_mulVec_of_mem_range_univ` の `heta` を
`eta_univ_eq_one` で、`hidem` を必要十分版の特殊化 `CheckFermi.Qproj_mul_self` で埋める）。 -/
theorem mem_evenSector_of_mem_range_univ (htr : 0 < ((epsilon M * D.V).trace).re)
    {x y : Conf M → ℂ} (hy : y = F.Qproj (Finset.univ : Finset (Fin M)) *ᵥ x) :
    epsilon M *ᵥ y = y :=
  F.epsilon_mulVec_of_mem_range_univ (D.eta_univ_eq_one htr) (F.Qproj_mul_self Finset.univ) hy

end VPlusData

end Ising2D
