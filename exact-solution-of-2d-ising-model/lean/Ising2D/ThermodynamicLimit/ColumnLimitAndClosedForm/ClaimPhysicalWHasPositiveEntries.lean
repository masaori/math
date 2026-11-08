/-
# 具体的な `W = V_1^{1/2} V_2 V_1^{1/2}` の成分はすべて正

正本: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`
（`maxeig_004_claim_W_has_positive_entries`、ラベル **`W_has_positive_entries`**）

## 人手証明との対応

人手の行・列番号 `ι(μ)`（`def_config_basis_iso`）は Lean の `configBasisIso M μ`、
人手の `μ(m+1)`（周期端で `μ(M_col+1) := μ(1)`）は `μ (nextSite m)` である。

| 人手証明 | 本ファイル |
| --- | --- |
| 準備の `d(μ) := ∑_m μ(m)μ(m+1)` | `adjacentSpinProductSum` |
| 準備の `X := (½K_1)_ℂD`・`b(μ) := exp(½K_1d(μ))`・`b(μ) > 0`（`real_exp_positive`） | `halfK1SmulD`・`squareRootV1DiagonalEntry`・`squareRootV1DiagonalEntry_pos` |
| Step 1 の `D_{pq}` の 4 行（`p ≠ q`） | `sum_sigmaZ_sigmaZ_apply_of_ne`（2 行目の `σ^z_{m+1} = σ^z_{m^+}` は `nextSite` の読み方で段は無い） |
| Step 1 の `D_{kk}` の 7 行 | `sum_sigmaZ_sigmaZ_apply_configBasisIso_self`（2 行目・6 行目は `nextSite` の読み方で段は無い） |
| Step 1 の `X_{pq}` の 3 行（`p ≠ q`）と「`X` は対角行列」 | `halfK1SmulD_apply_of_ne`・`halfK1SmulD_eq_diagonal`（`def_diagonal_matrix` を Lean の `Matrix.diagonal` へ読み替える段） |
| Step 1 の `B_{pq}` の 2 行（`p ≠ q`） | `physicalV1halfC_apply_of_ne`（1 行目の `B = exp(X)` は `physicalV1halfC_eq_matExp_halfK1SmulD`） |
| Step 1 の `B_{kk}` の 7 行 | `physicalV1halfC_apply_configBasisIso_self` |
| 準備の `e(μ,μ') := ∑_m μ(m)μ'(m)`・`v(μ,μ') := exp(K_2e(μ,μ'))`・`v(μ,μ') > 0`（`real_exp_positive`） | `sameSiteSpinProductSum`・`secondTransferEntry`・`secondTransferEntry_pos` |
| Step 2 の `(V_2)_{kl}` の 3 行 | `V2_apply_configBasisIso_eq_secondTransferEntry`（1 行目の `config_numbering_equals_kronecker_numbering` は Lean の `V2` が添字 `ι(μ)` で定義されているので段は無い。2 行目は `V2_apply_configBasisIso`（`PartitionFunction/TransferMatrixRepresentation/DefinitionTransferMatrix.lean`、`def_transfer_matrix` の `V_2` の成分）） |
| Step 3 の補助の鎖 2 本（`t ≠ l` で `(BV_2)_{kt}B_{tl} = 0_ℂ`、`s ≠ k` で `B_{ks}(V_2)_{sl} = 0_ℂ`） | `physicalV1halfC_mul_V2_apply_mul_apply_of_ne`・`physicalV1halfC_apply_mul_V2_apply_of_ne`（主の鎖の 3 行目・5 行目が引く） |
| Step 3 の主の鎖 9 行（`W_{kl} = ((BV_2)B)_{kl} = … = ((b(μ)v(μ,μ'))b(μ'))_ℂ`。外側の和 `t` を先に潰す） | `physicalSymTransferC_apply_configBasisIso` の calc の 9 段 |
| Step 3 の `w := (b(μ)v(μ,μ'))b(μ') = ∏_{j=1}^{3} r_j > 0`（2 行） | `symTransferEntryProduct_pos` の calc の 2 段 |
| 主張「`W_{ι(μ),ι(μ')} > 0`、すなわち `W_{ι(μ),ι(μ')} = w_ℂ` を満たす `w ∈ ℝ_{>0}` が在る」（`W` は複素行列） | `W_has_positive_entries`（上の 2 本で閉じる） |
| 実成分で組んだ `W` の成分が正（人手に無い。人手 `W_real_has_positive_entries` と同じ手順で主張の形から導く） | `physicalSymTransferR_pos`・`W_has_positive_entries_physical` |

人手の `W` は複素行列 `physicalSymTransferC` で、Step 1〜3 は複素行列のまま計算する（Lean も同じ）。
実成分で組んだ `W`（`physicalSymTransferR`）は、`EvenSectorBridge` や Rayleigh 商が受け取る実行列で、
`physicalSymTransferC_eq_map`（`W` は実成分の行列の `ℂ` への埋め込み）でつながる。

人手の主張の形 `W_has_positive_entries` は、人手の Step 3 の結びどおり `w := (b(μ)v(μ,μ'))b(μ')` と取り、
主の鎖 `physicalSymTransferC_apply_configBasisIso` と `w > 0` の鎖 `symTransferEntryProduct_pos` で閉じる。
人手の「言い換えの形」（すべての `k, l` について `W_kl > 0`）は
`ClaimEpsilonRealCommutesWithWRealAndWRealHasPositiveEntries.lean` の `W_has_positive_entries_as_inclusion` で、
人手の最後の段どおり `ι` の全射性で `W_has_positive_entries` から導く。

`EvenSectorBridge` が受け取る形 `∀ k l, 0 < W k l`（実成分で組んだ `W`）は `physicalSymTransferR_pos` で、
人手 `W_real_has_positive_entries` の証明と同じく、`ι` の全射性で `k = ι(μ)`・`l = ι(μ')` と書き、主張の形の `w` について
`((W_ℝ)_{kl})_ℂ = W_{kl} = w_ℂ` から `ℝ → ℂ` の単射性で導く。

人手は結合定数を `K_1, K_2 ∈ ℝ_{>0}` とする。Step 1〜3 はどれも `K_1, K_2` の正値性を使わない（`exp` は実数の指数関数で、
値はどの実数でも正なので）が、主張を人手どおりにするため `W_has_positive_entries`・`W_has_positive_entries_physical`・`physicalSymTransferR_pos` は
`K_1 > 0`・`K_2 > 0` を仮定に取る（`W_has_positive_entries` は仮定を使わず `_hK1`・`_hK2` で受ける。実成分の 2 つは主張の形へ渡すため受ける）。Step 1〜3 のほかの補題は人手の証明の中の段なので仮定を置かない。

必要十分版は `NecSuf/SandwichByDiagonal.lean`（Step 3 の補助の鎖 2 本・主の鎖・`w > 0` の鎖と主張の形を、
同じ並びのまま、有限の添字、加法の可換モノイドと乗法だけの係数 `R`（`x·0 = 0`・`0·x = 0` は明示の仮定）、
積を保つ写像 `φ : S → R` で書いたもの）。
具体版をその特殊化（`R := ℂ`・`S := ℝ`・`φ := ℝ → ℂ の埋め込み`）として導出するのは
`ClaimPhysicalWHasPositiveEntriesFromNecSuf.lean`。
-/
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.PhysicalSymTransferBridge
import Ising2D.MathematicalTools.MatrixExponentialAndCommutators.ClaimExpOfDiagonalMatrix
import Ising2D.MathematicalTools.MatrixExponentialAndCommutators.ClaimRealExpPositive
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimFiniteProductOfPositiveRealsIsPositive

namespace Ising2D

open Matrix

variable {M : ℕ}

/-! ## 準備: `d(μ)`・`X`・`b(μ)` -/

/-- 人手の準備の `d(μ) := ∑_{m=1}^{M_col} μ(m)μ(m+1) ∈ ℝ`（`def_finite_sum_of_real_numbers` の和）。
人手の `μ(m+1)`（周期規約 `μ(M_col+1) := μ(1)`）は Lean の `μ (nextSite m)` である。 -/
noncomputable def adjacentSpinProductSum (μ : SpinConf M) : ℝ :=
  ∑ m : Fin M, (μ m : ℝ) * (μ (nextSite m) : ℝ)

/-- 人手の準備の `X := (½K_1)_ℂ D`（`½K_1 ∈ ℝ` による `def_matrix_scalar_multiple` のスカラー倍、
`D = ∑_m σ^z_mσ^z_{m+1}`）。人手の `½K_1` は、`physicalV1halfC` と同じく Lean の `K1 / 2` である。 -/
noncomputable def halfK1SmulD (M : ℕ) (K1 : ℝ) : TensorPow M :=
  ((K1 / 2 : ℝ) : ℂ) • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m)

/-- 人手の準備の `b(μ) := exp(½K_1 d(μ)) ∈ ℝ`（`exp` は実数の指数関数）。 -/
noncomputable def squareRootV1DiagonalEntry (K1 : ℝ) (μ : SpinConf M) : ℝ :=
  Real.exp ((K1 / 2) * adjacentSpinProductSum μ)

/-- 人手の準備の `b(μ) > 0`（`real_exp_positive`）。 -/
theorem squareRootV1DiagonalEntry_pos (K1 : ℝ) (μ : SpinConf M) :
    squareRootV1DiagonalEntry K1 μ > 0 :=
  real_exp_positive _                                         -- `real_exp_positive`

/-! ## Step 1: `D` の成分 -/

/-- **人手 Step 1 の `D_{pq}` の鎖**（`p ≠ q`）: `D = ∑_m σ^z_mσ^z_{m+1}` について `D_{pq} = 0_ℂ`。

人手の 4 行のうち 2 行目（`σ^z_{m+1} = σ^z_{m^+}` を各項へ）は、Lean では `σ^z_{m+1}` を最初から
`sigmaZ (nextSite m)`（`= σ^z_{m^+}`、`def_site_pauli_periodic_extension`）と書くので、添字の読み方であって段は無い。
`finite_sum_of_matrices_entrywise` は具体版が無く `Matrix.sum_apply`、`finite_sum_of_complex_zeros` は
`Finset.sum_const_zero`（既存の慣行どおり）。 -/
theorem sum_sigmaZ_sigmaZ_apply_of_ne {p q : Conf M} (hpq : p ≠ q) :
    (∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m)) p q = 0 :=
  calc (∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m)) p q
      = ∑ m : Fin M, (sigmaZ m * sigmaZ (nextSite m)) p q :=
        Matrix.sum_apply _ _ _ _                              -- `finite_sum_of_matrices_entrywise`
    _ = ∑ _m : Fin M, (0 : ℂ) :=
        Finset.sum_congr rfl fun m _ =>
          sigmaZ_mul_sigmaZ_apply_of_ne m (nextSite m) hpq     -- `site_sigma_z_product_is_diagonal` を各 `(m, m^+)` へ
    _ = 0 := Finset.sum_const_zero                            -- `finite_sum_of_complex_zeros`

/-- **人手 Step 1 の `D_{kk}` の鎖**（`k := ν(ι(μ))`）: `D_{kk} = d(μ)_ℂ`。

人手の 7 行のうち 2 行目（`σ^z_{m+1} = σ^z_{m^+}`）と 6 行目（`μ(m+1) = μ(m^+)`）は、Lean では両方を最初から
`nextSite m` で書くので、添字の読み方であって段は無い。`real_inclusion_preserves_product` は `real_inclusion_mul`、
`real_inclusion_preserves_finite_sum` は具体版が無く `Complex.ofReal_sum`（既存の慣行どおり）。 -/
theorem sum_sigmaZ_sigmaZ_apply_configBasisIso_self (μ : SpinConf M) :
    (∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m)) (configBasisIso M μ) (configBasisIso M μ)
      = ((adjacentSpinProductSum μ : ℝ) : ℂ) :=
  calc (∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m)) (configBasisIso M μ) (configBasisIso M μ)
      = ∑ m : Fin M, (sigmaZ m * sigmaZ (nextSite m)) (configBasisIso M μ) (configBasisIso M μ) :=
        Matrix.sum_apply _ _ _ _                              -- `finite_sum_of_matrices_entrywise`
    _ = ∑ m : Fin M, ((μ m : ℝ) : ℂ) * ((μ (nextSite m) : ℝ) : ℂ) :=
        Finset.sum_congr rfl fun m _ =>
          sigmaZ_mul_sigmaZ_apply_configBasisIso_self μ m (nextSite m)
                                                              -- `site_sigma_z_product_diagonal_entry` を各 `(m, m^+)` へ
    _ = ∑ m : Fin M, (((μ m : ℝ) * (μ (nextSite m) : ℝ) : ℝ) : ℂ) :=
        Finset.sum_congr rfl fun _m _ => real_inclusion_mul _ _ -- `real_inclusion_preserves_product` を各項へ
    _ = ((∑ m : Fin M, (μ m : ℝ) * (μ (nextSite m) : ℝ) : ℝ) : ℂ) :=
        (Complex.ofReal_sum _ _).symm                         -- `real_inclusion_preserves_finite_sum`
    _ = ((adjacentSpinProductSum μ : ℝ) : ℂ) := rfl           -- `d(μ)` の定義

/-! ## Step 1: `X` と `B := V_1^{1/2} = exp(X)` の成分 -/

/-- **人手 Step 1 の `X_{pq}` の鎖**（`p ≠ q`）: `X_{pq} = 0_ℂ`。

`def_matrix_scalar_multiple` は具体版が無く `Matrix.smul_apply`、`complex_times_zero_is_zero` は `mul_zero`（既存の慣行どおり）。 -/
theorem halfK1SmulD_apply_of_ne (K1 : ℝ) {p q : Conf M} (hpq : p ≠ q) :
    halfK1SmulD M K1 p q = 0 :=
  calc halfK1SmulD M K1 p q
      = ((K1 / 2 : ℝ) : ℂ) * (∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m)) p q := by
        rw [halfK1SmulD, Matrix.smul_apply, smul_eq_mul]      -- `def_matrix_scalar_multiple`
    _ = ((K1 / 2 : ℝ) : ℂ) * 0 := by
        rw [sum_sigmaZ_sigmaZ_apply_of_ne hpq]                -- 上の `D_{pq} = 0_ℂ`
    _ = 0 := mul_zero _                                       -- `complex_times_zero_is_zero`

/-- 人手 Step 1 の「`X` は対角行列（`def_diagonal_matrix`）」: 非対角成分が `0_ℂ` なので、`X` は対角成分 `X_{kk}` の
Lean の対角行列 `Matrix.diagonal` に等しい（成分ごとの比較 `Matrix.diagonal_apply` による読み替え。
`exp_of_diagonal_matrix` の具体版 `matExp_diagonal` が `Matrix.diagonal` の形を受け取るため）。 -/
theorem halfK1SmulD_eq_diagonal (K1 : ℝ) :
    halfK1SmulD M K1 = Matrix.diagonal (fun I => halfK1SmulD M K1 I I) := by
  ext p q
  by_cases h : p = q
  · subst h
    rw [Matrix.diagonal_apply_eq]
  · rw [Matrix.diagonal_apply_ne _ h, halfK1SmulD_apply_of_ne K1 h]

/-- 人手 `def_transfer_matrix_square_root` の `B = V_1^{1/2} = exp(X)`（Lean の定義の展開）。 -/
theorem physicalV1halfC_eq_matExp_halfK1SmulD (K1 : ℝ) :
    physicalV1halfC M K1 = matExp (halfK1SmulD M K1) := rfl

/-- **人手 Step 1 の `B_{pq}` の鎖**（`p ≠ q`）: `B_{pq} = (exp(X))_{pq} = 0_ℂ`。 -/
theorem physicalV1halfC_apply_of_ne (K1 : ℝ) {p q : Conf M} (hpq : p ≠ q) :
    physicalV1halfC M K1 p q = 0 :=
  calc physicalV1halfC M K1 p q
      = matExp (halfK1SmulD M K1) p q := by
        rw [physicalV1halfC_eq_matExp_halfK1SmulD]            -- `def_transfer_matrix_square_root`
    _ = 0 := by
        rw [halfK1SmulD_eq_diagonal, matExp_diagonal, Matrix.diagonal_apply_ne _ hpq]
                                                              -- `exp_of_diagonal_matrix` を対角行列 `X` へ

/-- **人手 Step 1 の `B_{kk}` の鎖**（`k := ν(ι(μ))`）: `B_{kk} = b(μ)_ℂ`。

`def_matrix_scalar_multiple` は具体版が無く `Matrix.smul_apply`、`complex_exp_of_real_argument` は具体版が無く
`Complex.ofReal_exp`（既存の慣行どおり）。 -/
theorem physicalV1halfC_apply_configBasisIso_self (K1 : ℝ) (μ : SpinConf M) :
    physicalV1halfC M K1 (configBasisIso M μ) (configBasisIso M μ)
      = ((squareRootV1DiagonalEntry K1 μ : ℝ) : ℂ) :=
  calc physicalV1halfC M K1 (configBasisIso M μ) (configBasisIso M μ)
      = matExp (halfK1SmulD M K1) (configBasisIso M μ) (configBasisIso M μ) := by
        rw [physicalV1halfC_eq_matExp_halfK1SmulD]            -- `def_transfer_matrix_square_root`
    _ = Complex.exp (halfK1SmulD M K1 (configBasisIso M μ) (configBasisIso M μ)) := by
        conv_lhs => rw [halfK1SmulD_eq_diagonal, matExp_diagonal, Matrix.diagonal_apply_eq]
                                                              -- `exp_of_diagonal_matrix` を対角行列 `X` へ
    _ = Complex.exp (((K1 / 2 : ℝ) : ℂ)
          * (∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m)) (configBasisIso M μ) (configBasisIso M μ)) := by
        rw [halfK1SmulD, Matrix.smul_apply, smul_eq_mul]      -- `def_matrix_scalar_multiple`
    _ = Complex.exp (((K1 / 2 : ℝ) : ℂ) * ((adjacentSpinProductSum μ : ℝ) : ℂ)) := by
        rw [sum_sigmaZ_sigmaZ_apply_configBasisIso_self]      -- 上の `D_{kk} = d(μ)_ℂ`
    _ = Complex.exp (((K1 / 2 * adjacentSpinProductSum μ : ℝ) : ℂ)) := by
        rw [real_inclusion_mul]                               -- `real_inclusion_preserves_product`
    _ = ((Real.exp (K1 / 2 * adjacentSpinProductSum μ) : ℝ) : ℂ) :=
        (Complex.ofReal_exp _).symm                           -- `complex_exp_of_real_argument`
    _ = ((squareRootV1DiagonalEntry K1 μ : ℝ) : ℂ) := rfl     -- `b(μ)` の定義

/-! ## 準備: `e(μ,μ')`・`v(μ,μ')` -/

/-- 人手の準備の `e(μ,μ') := ∑_{m=1}^{M_col} μ(m)μ'(m) ∈ ℝ`（`def_finite_sum_of_real_numbers` の和）。 -/
noncomputable def sameSiteSpinProductSum (μ μ' : SpinConf M) : ℝ :=
  ∑ m : Fin M, (μ m : ℝ) * (μ' m : ℝ)

/-- 人手の準備の `v(μ,μ') := exp(K_2 e(μ,μ')) ∈ ℝ`（`exp` は実数の指数関数）。 -/
noncomputable def secondTransferEntry (K2 : ℝ) (μ μ' : SpinConf M) : ℝ :=
  Real.exp (K2 * sameSiteSpinProductSum μ μ')

/-- 人手の準備の `v(μ,μ') > 0`（`real_exp_positive`）。 -/
theorem secondTransferEntry_pos (K2 : ℝ) (μ μ' : SpinConf M) :
    secondTransferEntry K2 μ μ' > 0 :=
  real_exp_positive _                                         -- `real_exp_positive`

/-! ## Step 2: `(V_2)_{kl} = v(μ,μ')_ℂ` -/

/-- **人手 Step 2 の鎖**（`k := ν(ι(μ))`、`l := ν(ι(μ'))`）: `(V_2)_{kl} = v(μ,μ')_ℂ`。

人手の 3 行のうち 1 行目（`config_numbering_equals_kronecker_numbering` で `(V_2)_{kl}` を `(V_2)_{ord(μ),ord(μ')}` と読む）は、
Lean の `V2` が添字 `ι(μ)` で定義されている（`DefinitionTransferMatrix.lean` の冒頭。人手の成分 `A_{ord(μ),ord(μ')}` は
`config_numbering_equals_kronecker_numbering`（`ord = ν ∘ ι`）により Lean の `A (ι μ) (ι μ')` である）ので、
添字の読み方であって段は無い。 -/
theorem V2_apply_configBasisIso_eq_secondTransferEntry (K2 : ℝ) (μ μ' : SpinConf M) :
    V2 M K2 (configBasisIso M μ) (configBasisIso M μ')
      = ((secondTransferEntry K2 μ μ' : ℝ) : ℂ) :=
  calc V2 M K2 (configBasisIso M μ) (configBasisIso M μ')
      = ((Real.exp (K2 * ∑ m : Fin M, (μ m : ℝ) * (μ' m : ℝ)) : ℝ) : ℂ) :=
        V2_apply_configBasisIso K2 μ μ'                       -- `def_transfer_matrix`
    _ = ((secondTransferEntry K2 μ μ' : ℝ) : ℂ) := rfl       -- `e(μ,μ')` と `v(μ,μ')` の定義

/-! ## Step 3 の補助の鎖: 和の一つを除く項は `0_ℂ` -/

/-- **人手 Step 3 の補助の鎖の 1 本目**（`t ≠ l`、`k := ν(ι(μ))`、`l := ν(ι(μ'))`）:
`(BV_2)_{kt}B_{tl} = 0_ℂ`（`B := V_1^{1/2}`）。

`complex_times_zero_is_zero` は具体版が無く `mul_zero`（既存の慣行どおり）。 -/
theorem physicalV1halfC_mul_V2_apply_mul_apply_of_ne (K1 K2 : ℝ) (μ μ' : SpinConf M)
    {t : Conf M} (htl : t ≠ configBasisIso M μ') :
    (physicalV1halfC M K1 * V2 M K2) (configBasisIso M μ) t * physicalV1halfC M K1 t (configBasisIso M μ')
      = 0 :=
  calc (physicalV1halfC M K1 * V2 M K2) (configBasisIso M μ) t * physicalV1halfC M K1 t (configBasisIso M μ')
      = (physicalV1halfC M K1 * V2 M K2) (configBasisIso M μ) t * 0 := by
        rw [physicalV1halfC_apply_of_ne K1 htl]               -- Step 1 の `B_{tl} = 0_ℂ`
    _ = 0 := mul_zero _                                       -- `complex_times_zero_is_zero`

/-- **人手 Step 3 の補助の鎖の 2 本目**（`s ≠ k`、`k := ν(ι(μ))`、`l := ν(ι(μ'))`）:
`B_{ks}(V_2)_{sl} = 0_ℂ`（`B := V_1^{1/2}`）。

`complex_zero_times_is_zero` は具体版が無く `zero_mul`（既存の慣行どおり）。 -/
theorem physicalV1halfC_apply_mul_V2_apply_of_ne (K1 K2 : ℝ) (μ μ' : SpinConf M)
    {s : Conf M} (hsk : s ≠ configBasisIso M μ) :
    physicalV1halfC M K1 (configBasisIso M μ) s * V2 M K2 s (configBasisIso M μ') = 0 :=
  calc physicalV1halfC M K1 (configBasisIso M μ) s * V2 M K2 s (configBasisIso M μ')
      = 0 * V2 M K2 s (configBasisIso M μ') := by
        rw [physicalV1halfC_apply_of_ne K1 (Ne.symm hsk)]     -- Step 1 の `B_{ks} = 0_ℂ`
    _ = 0 := zero_mul _                                       -- `complex_zero_times_is_zero`

/-! ## Step 3: `W` の成分の主の鎖と `w > 0` -/

/-- **人手 Step 3 の主の鎖**（`k := ν(ι(μ))`、`l := ν(ι(μ'))`、`B := V_1^{1/2}`）:
`W_{kl} = (((b(μ)v(μ,μ'))b(μ'))_ℂ`。人手の 9 行と同じ順に、外側の和（`t`）を先に、内側の和（`s`）を後に潰す。

`mat_mult` は Lean の `Matrix.mul_apply`、`finite_sum_with_single_nonzero_term` は具体版が無く `Finset.sum_eq_single`
（既存の慣行どおり）。和から除く項の値は Step 3 の補助の鎖 2 本である。 -/
theorem physicalSymTransferC_apply_configBasisIso (K1 K2 : ℝ) (μ μ' : SpinConf M) :
    physicalSymTransferC M K1 K2 (configBasisIso M μ) (configBasisIso M μ')
      = (((squareRootV1DiagonalEntry K1 μ * secondTransferEntry K2 μ μ')
            * squareRootV1DiagonalEntry K1 μ' : ℝ) : ℂ) :=
  calc physicalSymTransferC M K1 K2 (configBasisIso M μ) (configBasisIso M μ')
      = ((physicalV1halfC M K1 * V2 M K2) * physicalV1halfC M K1)
          (configBasisIso M μ) (configBasisIso M μ') := rfl  -- `def_symmetrized_transfer_matrix`
    _ = ∑ t : Conf M, (physicalV1halfC M K1 * V2 M K2) (configBasisIso M μ) t
          * physicalV1halfC M K1 t (configBasisIso M μ') :=
        Matrix.mul_apply                                      -- `mat_mult`
    _ = (physicalV1halfC M K1 * V2 M K2) (configBasisIso M μ) (configBasisIso M μ')
          * physicalV1halfC M K1 (configBasisIso M μ') (configBasisIso M μ') :=
        Finset.sum_eq_single (configBasisIso M μ')
          (fun _t _ htl => physicalV1halfC_mul_V2_apply_mul_apply_of_ne K1 K2 μ μ' htl)
          (fun h => absurd (Finset.mem_univ _) h)             -- `finite_sum_with_single_nonzero_term`（上の `t ≠ l` の項の値）
    _ = (∑ s : Conf M, physicalV1halfC M K1 (configBasisIso M μ) s * V2 M K2 s (configBasisIso M μ'))
          * physicalV1halfC M K1 (configBasisIso M μ') (configBasisIso M μ') := by
        rw [Matrix.mul_apply]                                 -- `mat_mult`
    _ = (physicalV1halfC M K1 (configBasisIso M μ) (configBasisIso M μ)
            * V2 M K2 (configBasisIso M μ) (configBasisIso M μ'))
          * physicalV1halfC M K1 (configBasisIso M μ') (configBasisIso M μ') := by
        rw [Finset.sum_eq_single (configBasisIso M μ)
          (fun _s _ hsk => physicalV1halfC_apply_mul_V2_apply_of_ne K1 K2 μ μ' hsk)
          (fun h => absurd (Finset.mem_univ _) h)]            -- `finite_sum_with_single_nonzero_term`（上の `s ≠ k` の項の値）
    _ = (((squareRootV1DiagonalEntry K1 μ : ℝ) : ℂ) * V2 M K2 (configBasisIso M μ) (configBasisIso M μ'))
          * ((squareRootV1DiagonalEntry K1 μ' : ℝ) : ℂ) := by
        rw [physicalV1halfC_apply_configBasisIso_self K1 μ,
          physicalV1halfC_apply_configBasisIso_self K1 μ']    -- Step 1 の `B_{kk}` と `B_{ll}`
    _ = (((squareRootV1DiagonalEntry K1 μ : ℝ) : ℂ) * ((secondTransferEntry K2 μ μ' : ℝ) : ℂ))
          * ((squareRootV1DiagonalEntry K1 μ' : ℝ) : ℂ) := by
        rw [V2_apply_configBasisIso_eq_secondTransferEntry]   -- Step 2
    _ = ((squareRootV1DiagonalEntry K1 μ * secondTransferEntry K2 μ μ' : ℝ) : ℂ)
          * ((squareRootV1DiagonalEntry K1 μ' : ℝ) : ℂ) :=
        congrArg (· * ((squareRootV1DiagonalEntry K1 μ' : ℝ) : ℂ))
          (real_inclusion_mul _ _)                            -- `real_inclusion_preserves_product`
    _ = (((squareRootV1DiagonalEntry K1 μ * secondTransferEntry K2 μ μ')
            * squareRootV1DiagonalEntry K1 μ' : ℝ) : ℂ) :=
        real_inclusion_mul _ _                                -- `real_inclusion_preserves_product`

/-- **人手 Step 3 の `w > 0` の鎖**: `w := (b(μ)v(μ,μ'))b(μ')`、`r_1 := b(μ)`・`r_2 := v(μ,μ')`・`r_3 := b(μ')` について
`w = ∏_{j=1}^{3} r_j > 0`。

人手の添字 `j ∈ {1,2,3}` は Lean の `Fin 3`（`j - 1`）で、`r` は `![b(μ), v(μ,μ'), b(μ')]` である。
`def_finite_product_of_real_numbers`（左から掛ける）の `∏_{j=1}^{3} r_j = (r_1r_2)r_3` は `Fin.prod_univ_three`。
人手の `m := 3` は、Lean の `finite_product_of_positive_reals_is_positive` が因子の数を `m + 1` で受けるので `m := 2` である。 -/
theorem symTransferEntryProduct_pos (K1 K2 : ℝ) (μ μ' : SpinConf M) :
    (squareRootV1DiagonalEntry K1 μ * secondTransferEntry K2 μ μ') * squareRootV1DiagonalEntry K1 μ' > 0 :=
  calc (squareRootV1DiagonalEntry K1 μ * secondTransferEntry K2 μ μ') * squareRootV1DiagonalEntry K1 μ'
      = ∏ j : Fin 3,
          ![squareRootV1DiagonalEntry K1 μ, secondTransferEntry K2 μ μ', squareRootV1DiagonalEntry K1 μ'] j :=
        (Fin.prod_univ_three
          ![squareRootV1DiagonalEntry K1 μ, secondTransferEntry K2 μ μ', squareRootV1DiagonalEntry K1 μ']).symm
                                                              -- `def_finite_product_of_real_numbers`
    _ > 0 :=
        finite_product_of_positive_reals_is_positive 2 _ (fun j => by
          fin_cases j
          · exact squareRootV1DiagonalEntry_pos K1 μ          -- 準備の `b(μ) > 0`
          · exact secondTransferEntry_pos K2 μ μ'             -- 準備の `v(μ,μ') > 0`
          · exact squareRootV1DiagonalEntry_pos K1 μ')        -- 準備の `b(μ') > 0`
                                                              -- `finite_product_of_positive_reals_is_positive`（`m := 3`）

/-- **人手 `W_has_positive_entries` の主張の形**: 複素行列 `W = V_1^{1/2}V_2V_1^{1/2}`（`physicalSymTransferC`、
結合定数 `K_1, K_2 ∈ ℝ_{>0}`）について、`μ, μ' ∈ 𝔐` ごとに `W_{ι(μ),ι(μ')} = w_ℂ` を満たす `w ∈ ℝ_{>0}` が在る
（人手の「`z > 0`」の読み方。`w` は `ℝ` の元として取る）。
人手の Step 3 の結びどおり、`w := (b(μ)v(μ,μ'))b(μ')` と取り、`w > 0` は `symTransferEntryProduct_pos`、
`W_{kl} = w_ℂ` は主の鎖 `physicalSymTransferC_apply_configBasisIso`。 -/
theorem W_has_positive_entries {K1 K2 : ℝ} (_hK1 : 0 < K1) (_hK2 : 0 < K2) (μ μ' : SpinConf M) :
    ∃ w : ℝ, 0 < w ∧
      physicalSymTransferC M K1 K2 (configBasisIso M μ) (configBasisIso M μ') = (w : ℂ) :=
  ⟨(squareRootV1DiagonalEntry K1 μ * secondTransferEntry K2 μ μ') * squareRootV1DiagonalEntry K1 μ',
    symTransferEntryProduct_pos K1 K2 μ μ', physicalSymTransferC_apply_configBasisIso K1 K2 μ μ'⟩

/-- 実成分で組んだ `W`（`physicalSymTransferR`）のすべての成分が正（人手に無い、実行列の側の言い換えの形）。
人手 `W_real_has_positive_entries` の証明と同じ手順で、`ι` の全射性で `k = ι(μ)`・`l = ι(μ')` と書き、
主張の形 `W_has_positive_entries` の `w` を取り、`((W_ℝ)_{kl})_ℂ = W_{kl} = w_ℂ`（`physicalSymTransferC_eq_map`）から
`ℝ → ℂ` の単射性で `(W_ℝ)_{kl} = w > 0` とする。 -/
theorem physicalSymTransferR_pos {K1 K2 : ℝ} (hK1 : 0 < K1) (hK2 : 0 < K2) (k l : Conf M) :
    0 < physicalSymTransferR M K1 K2 k l := by
  obtain ⟨μ, rfl⟩ := (configBasisIso M).surjective k
  obtain ⟨μ', rfl⟩ := (configBasisIso M).surjective l
  obtain ⟨w, hw, hW⟩ := W_has_positive_entries (M := M) hK1 hK2 μ μ'
  have hR : physicalSymTransferR M K1 K2 (configBasisIso M μ) (configBasisIso M μ') = w := by
    apply Complex.ofReal_injective
    rw [← hW, physicalSymTransferC_eq_map, Matrix.map_apply, Complex.ofRealHom_eq_coe]
  rw [hR]
  exact hw

/-- 実成分で組んだ `W` の `ι(μ), ι(μ')` 成分が正（`physicalSymTransferR_pos` を `ι(μ), ι(μ')` で引いたもの）。 -/
theorem W_has_positive_entries_physical {K1 K2 : ℝ} (hK1 : 0 < K1) (hK2 : 0 < K2) (μ μ' : SpinConf M) :
    0 < physicalSymTransferR M K1 K2 (configBasisIso M μ) (configBasisIso M μ') :=
  physicalSymTransferR_pos hK1 hK2 _ _

end Ising2D
