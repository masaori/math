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
| Step 1 の `B` の成分を `μ = μ'` かどうかで一つにまとめた形（人手に無い。いまの Step 3 の証明（実行列で計算する）が使う） | `physicalV1halfC_apply_configBasisIso`（`B_{kk}`・`B_{pq}` の鎖と `ι` の単射性から導く）・`physicalV1halfR_apply_configBasisIso`（その実成分。前者から導く） |
| 実成分の対角成分が正（人手に無い。いまの Step 3 の証明（実行列で計算する）が使う形） | `physicalV1halfR_apply_configBasisIso_self_pos`（`real_exp_positive`） |
| 準備の `e(μ,μ') := ∑_m μ(m)μ'(m)`・`v(μ,μ') := exp(K_2e(μ,μ'))`・`v(μ,μ') > 0`（`real_exp_positive`） | `sameSiteSpinProductSum`・`secondTransferEntry`・`secondTransferEntry_pos` |
| Step 2 の `(V_2)_{kl}` の 3 行 | `V2_apply_configBasisIso_eq_secondTransferEntry`（1 行目の `config_numbering_equals_kronecker_numbering` は Lean の `V2` が添字 `ι(μ)` で定義されているので段は無い。2 行目は `V2_apply_configBasisIso`（`PartitionFunction/TransferMatrixRepresentation/DefinitionTransferMatrix.lean`、`def_transfer_matrix` の `V_2` の成分）） |
| Step 2 の実成分（人手に無い。いまの Step 3 の証明（実行列で計算する）が使う形） | `physicalV2R_apply_configBasisIso`（Step 2 の鎖から導く）・`physicalV2R_apply_configBasisIso_pos`（`secondTransferEntry_pos`） |
| Step 3 の補助の鎖 2 本（`t ≠ l` で `(BV_2)_{kt}B_{tl} = 0_ℂ`、`s ≠ k` で `B_{ks}(V_2)_{sl} = 0_ℂ`） | `physicalV1halfC_mul_V2_apply_mul_apply_of_ne`・`physicalV1halfC_apply_mul_V2_apply_of_ne`（いまの Step 3 の証明はまだ使わない。(cl2e) で主の鎖から引く） |
| Step 3 の 1〜4 行目（`W` の定義、行列の積の定義、`j ≠ ι(μ)` の項が `0`、`k ≠ ι(μ')` の項が `0`） | `physicalSymTransferR_apply_configBasisIso` の式変形の各行。3・4 行目の「Step 1 の対角性」は `physicalV1halfR_offDiag`（Step 1 の補題の `μ ≠ μ'` の場合） |
| Step 3 の「3 つの因子はいずれも正」 | `W_has_positive_entries_physical`（実成分で組んだ `W` の `ι(μ), ι(μ')` 成分が正） |
| 主張「`W_{ι(μ),ι(μ')} > 0`、すなわち `W_{ι(μ),ι(μ')} = w_ℂ` を満たす `w ∈ ℝ_{>0}` が在る」（`W` は複素行列） | `W_has_positive_entries` |

Lean の `W`（`physicalSymTransferR`）は実行列で、その成分を `ℂ` へ埋め込んだものが人手の
`W = V_1^{1/2}V_2V_1^{1/2}`（`physicalSymTransferC`）である（`physicalSymTransferC_eq_map`）。
Step 1・Step 2 の実成分は、人手の `V_1^{1/2} = exp(½K_1D)`・`V_2` の成分（複素数）から
`physicalV1halfC_eq_map`・`physicalV2C_eq_map` と `ℝ → ℂ` の単射性で読み取る。この読み取りの段は人手に無い
（人手は `ℝ ⊂ ℂ` の包含を明示せずに使う）。

人手の主張の形 `W_has_positive_entries` は、複素行列 `W`（`physicalSymTransferC`）の成分について
「`w_ℂ` に等しい `w ∈ ℝ_{>0}` が在る」を述べる。いまの証明は `w := (physicalSymTransferR)_{ι(μ),ι(μ')}` と取り、
`W_has_positive_entries_physical` と `physicalSymTransferC_eq_map` で閉じる。人手の Step 1〜3 は複素行列のまま
`B_{kk} = b(μ)_ℂ`・`(V_2)_{kl} = v(μ,μ')_ℂ`・`W_{kl} = ((b(μ)v(μ,μ'))b(μ'))_ℂ` と計算し、`w > 0` を
`finite_product_of_positive_reals_is_positive`（`m := 3`）で示すので、この証明はまだ人手と 1 対 1 ではない
（状態台帳の (cl2e) で人手の鎖に組み直す。Step 1 の `D`・`X`・`B` の成分の鎖と Step 2 の鎖は置いてあり、
`physicalV1halfC_apply_configBasisIso`・`physicalV2R_apply_configBasisIso` を通していまの Step 3 の証明から使われているが、
Step 3 はまだ実行列で計算している。Step 3 の補助の鎖 2 本も置いてあるが、まだ使われていない）。
人手の「言い換えの形」（すべての `k, l` について `W_kl > 0`）は
`ClaimEpsilonRealCommutesWithWRealAndWRealHasPositiveEntries.lean` の `W_has_positive_entries_as_inclusion` で、
人手の最後の段どおり `ι` の全射性で `W_has_positive_entries` から導く。

`EvenSectorBridge` が受け取る形 `∀ k l, 0 < W k l`（実成分で組んだ `W`）は、`ι` が全単射であること
（`def_config_basis_iso`）から `physicalSymTransferR_pos` で得る。これは人手の最後の段の「言い換えの形」を
実行列の側で述べたもので、(cl2e) で人手の主張の形から導き直す。

人手は結合定数を `K_1, K_2 ∈ ℝ_{>0}` とする。Step 1〜3 はどれも `K_1, K_2` の正値性を使わない（`exp` は実数の指数関数で、
値はどの実数でも正なので）が、主張を人手どおりにするため `W_has_positive_entries`・`W_has_positive_entries_physical`・`physicalSymTransferR_pos` は
`K_1 > 0`・`K_2 > 0` を仮定に取る（`W_has_positive_entries_physical` は Step 3 の段だが、主張の形 `W_has_positive_entries` へ渡すため受ける）。Step 1〜3 のほかの補題は人手の証明の中の段なので仮定を置かない。

必要十分版は `NecSuf/SandwichByDiagonal.lean`（Step 3 と同じ式変形を、有限の添字と
結合律・可換律を仮定しない半環の係数で書いたもの）。具体版をその特殊化として導出するのは
`ClaimPhysicalWHasPositiveEntriesFromNecSuf.lean`。
-/
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.PhysicalSymTransferBridge
import Ising2D.MathematicalTools.MatrixExponentialAndCommutators.ClaimExpOfDiagonalMatrix
import Ising2D.MathematicalTools.MatrixExponentialAndCommutators.ClaimRealExpPositive

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

/-- 人手 Step 1 の `B` の成分（`ι` による番号付け）を一つにまとめた形: `μ = μ'` で `b(μ)`、それ以外で `0`。

`μ = μ'` は `B_{kk}` の鎖 `physicalV1halfC_apply_configBasisIso_self`、`μ ≠ μ'` は `ι` の単射性
（`configBasisIso_eq_iff`）で `ι(μ) ≠ ι(μ')` とし、`B_{pq}` の鎖 `physicalV1halfC_apply_of_ne` を当てる。 -/
theorem physicalV1halfC_apply_configBasisIso (K1 : ℝ) (μ μ' : SpinConf M) :
    physicalV1halfC M K1 (configBasisIso M μ) (configBasisIso M μ')
      = ((if μ = μ' then
            Real.exp ((K1 / 2) * ∑ m : Fin M, (μ m : ℝ) * (μ (nextSite m) : ℝ))
          else 0 : ℝ) : ℂ) := by
  by_cases h : μ = μ'
  · subst h
    rw [if_pos rfl, physicalV1halfC_apply_configBasisIso_self]
    rfl
  · rw [if_neg h, Complex.ofReal_zero,
      physicalV1halfC_apply_of_ne K1 (fun hc => h ((configBasisIso_eq_iff μ μ').mp hc))]

/-- 人手 Step 1 の `V_1^{1/2}` の実成分（`ι` による番号付け）。
`physicalV1halfC_apply_configBasisIso` の両辺を `physicalV1halfC_eq_map` で実成分の埋め込みと読み、
`ℝ → ℂ` の単射性で実数の等式に移す。 -/
theorem physicalV1halfR_apply_configBasisIso (K1 : ℝ) (μ μ' : SpinConf M) :
    physicalV1halfR M K1 (configBasisIso M μ) (configBasisIso M μ')
      = if μ = μ' then
          Real.exp ((K1 / 2) * ∑ m : Fin M, (μ m : ℝ) * (μ (nextSite m) : ℝ))
        else 0 := by
  apply Complex.ofReal_injective
  rw [← physicalV1halfC_apply_configBasisIso, physicalV1halfC_eq_map K1, Matrix.map_apply,
    Complex.ofRealHom_eq_coe]

/-- 人手 Step 1 の対角性: `V_1^{1/2}` の非対角成分は `0`（行・列番号を `ι(μ), ι(μ')` と書き、
`physicalV1halfR_apply_configBasisIso` の `μ ≠ μ'` の場合を使う）。 -/
theorem physicalV1halfR_offDiag (K1 : ℝ) (i j : Conf M) (hij : i ≠ j) :
    physicalV1halfR M K1 i j = 0 := by
  obtain ⟨μ, rfl⟩ := (configBasisIso M).surjective i
  obtain ⟨μ', rfl⟩ := (configBasisIso M).surjective j
  rw [physicalV1halfR_apply_configBasisIso, if_neg (fun h => hij (by rw [h]))]

/-- 人手 Step 1 の `exp(½K_1∑_m μ(m)μ(m+1)) > 0`（実指数関数の正値性）。 -/
theorem physicalV1halfR_apply_configBasisIso_self_pos (K1 : ℝ) (μ : SpinConf M) :
    0 < physicalV1halfR M K1 (configBasisIso M μ) (configBasisIso M μ) := by
  rw [physicalV1halfR_apply_configBasisIso, if_pos rfl]
  exact real_exp_positive _                                   -- `real_exp_positive`

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

/-! ## Step 2 の実成分（いまの Step 3 の証明（実行列で計算する）が使う形） -/

/-- 人手 Step 2 の `V_2` の実成分（`ι` による番号付け）。
Step 2 の鎖 `V2_apply_configBasisIso_eq_secondTransferEntry` の左辺を `physicalV2C_eq_map` で実成分の埋め込みと読み、
`ℝ → ℂ` の単射性で実数の等式に移す（右辺は `v(μ,μ')` の定義の展開）。 -/
theorem physicalV2R_apply_configBasisIso (K2 : ℝ) (μ μ' : SpinConf M) :
    physicalV2R M K2 (configBasisIso M μ) (configBasisIso M μ')
      = Real.exp (K2 * ∑ m : Fin M, (μ m : ℝ) * (μ' m : ℝ)) := by
  apply Complex.ofReal_injective
  change _ = ((secondTransferEntry K2 μ μ' : ℝ) : ℂ)
  rw [← V2_apply_configBasisIso_eq_secondTransferEntry, physicalV2C_eq_map K2, Matrix.map_apply,
    Complex.ofRealHom_eq_coe]

/-- 人手の準備の `v(μ,μ') > 0` を `V_2` の実成分で述べた形（`secondTransferEntry_pos`）。 -/
theorem physicalV2R_apply_configBasisIso_pos (K2 : ℝ) (μ μ' : SpinConf M) :
    0 < physicalV2R M K2 (configBasisIso M μ) (configBasisIso M μ') := by
  rw [physicalV2R_apply_configBasisIso]
  exact secondTransferEntry_pos K2 μ μ'

/-! ## Step 3: `W` の成分は三つの正の数の積 -/

/-- **人手 Step 3 の式変形**:
`W_{ι(μ),ι(μ')} = (V_1^{1/2})_{ι(μ),ι(μ)} (V_2)_{ι(μ),ι(μ')} (V_1^{1/2})_{ι(μ'),ι(μ')}`。 -/
theorem physicalSymTransferR_apply_configBasisIso (K1 K2 : ℝ) (μ μ' : SpinConf M) :
    physicalSymTransferR M K1 K2 (configBasisIso M μ) (configBasisIso M μ')
      = physicalV1halfR M K1 (configBasisIso M μ) (configBasisIso M μ)
          * physicalV2R M K2 (configBasisIso M μ) (configBasisIso M μ')
          * physicalV1halfR M K1 (configBasisIso M μ') (configBasisIso M μ') := by
  set B := physicalV1halfR M K1
  set V := physicalV2R M K2
  set I := configBasisIso M μ
  set I' := configBasisIso M μ'
  -- `B` の非対角成分は `0`（Step 1 の対角性）
  have hBoff : ∀ i j : Conf M, i ≠ j → B i j = 0 := physicalV1halfR_offDiag K1
  calc physicalSymTransferR M K1 K2 I I'
      = (B * V * B) I I' := rfl  -- (∵ W = V_1^{1/2} V_2 V_1^{1/2})
    _ = ∑ k : Conf M, (∑ j : Conf M, B I j * V j k) * B k I' := by
        -- (∵ 行列の積の定義)
        rw [Matrix.mul_apply]
        simp only [Matrix.mul_apply]
    _ = ∑ k : Conf M, (B I I * V I k) * B k I' := by
        -- (∵ Step 1 の対角性で j ≠ ι(μ) の項は 0)
        refine Finset.sum_congr rfl fun k _ => ?_
        rw [Finset.sum_eq_single I (fun j _ hj => by rw [hBoff I j (Ne.symm hj), zero_mul])
          (fun h => absurd (Finset.mem_univ I) h)]
    _ = B I I * V I I' * B I' I' := by
        -- (∵ Step 1 の対角性で k ≠ ι(μ') の項は 0)
        rw [Finset.sum_eq_single I' (fun k _ hk => by rw [hBoff k I' hk, mul_zero])
          (fun h => absurd (Finset.mem_univ I') h)]

/-- **人手 Step 3 の「3 つの因子はいずれも正」**（実成分で組んだ `W`）: 具体的な `W = V_1^{1/2}V_2V_1^{1/2}` について
`W_{ι(μ),ι(μ')} > 0`（`μ, μ' ∈ 𝔐`）。 -/
theorem W_has_positive_entries_physical {K1 K2 : ℝ} (_hK1 : 0 < K1) (_hK2 : 0 < K2) (μ μ' : SpinConf M) :
    0 < physicalSymTransferR M K1 K2 (configBasisIso M μ) (configBasisIso M μ') := by
  rw [physicalSymTransferR_apply_configBasisIso]
  -- (∵ 3 つの因子はいずれも正の実数なので、積も正)
  exact mul_pos (mul_pos (physicalV1halfR_apply_configBasisIso_self_pos K1 μ)
    (physicalV2R_apply_configBasisIso_pos K2 μ μ'))
    (physicalV1halfR_apply_configBasisIso_self_pos K1 μ')

/-- **人手 `W_has_positive_entries` の主張の形**: 複素行列 `W = V_1^{1/2}V_2V_1^{1/2}`（`physicalSymTransferC`、
結合定数 `K_1, K_2 ∈ ℝ_{>0}`）について、`μ, μ' ∈ 𝔐` ごとに `W_{ι(μ),ι(μ')} = w_ℂ` を満たす `w ∈ ℝ_{>0}` が在る
（人手の「`z > 0`」の読み方。`w` は `ℝ` の元として取る）。
`w := (physicalSymTransferR)_{ι(μ),ι(μ')}` と取り、`w > 0` は `W_has_positive_entries_physical`、
`W_{ι(μ),ι(μ')} = w_ℂ` は `physicalSymTransferC_eq_map`（`W` は実成分の行列の `ℂ` への埋め込み）。 -/
theorem W_has_positive_entries {K1 K2 : ℝ} (hK1 : 0 < K1) (hK2 : 0 < K2) (μ μ' : SpinConf M) :
    ∃ w : ℝ, 0 < w ∧
      physicalSymTransferC M K1 K2 (configBasisIso M μ) (configBasisIso M μ') = (w : ℂ) :=
  ⟨physicalSymTransferR M K1 K2 (configBasisIso M μ) (configBasisIso M μ'),
    W_has_positive_entries_physical hK1 hK2 μ μ', by
    rw [physicalSymTransferC_eq_map, Matrix.map_apply, Complex.ofRealHom_eq_coe]⟩

/-- `W` のすべての成分が正（`ι` が全単射なので、任意の行・列番号は `ι(μ)` の形）。
`EvenSectorBridge.rayleighSup_sandwich_LambdaM` の入力の形。 -/
theorem physicalSymTransferR_pos {K1 K2 : ℝ} (hK1 : 0 < K1) (hK2 : 0 < K2) (k l : Conf M) :
    0 < physicalSymTransferR M K1 K2 k l := by
  obtain ⟨μ, rfl⟩ := (configBasisIso M).surjective k
  obtain ⟨μ', rfl⟩ := (configBasisIso M).surjective l
  exact W_has_positive_entries_physical hK1 hK2 μ μ'

end Ising2D
