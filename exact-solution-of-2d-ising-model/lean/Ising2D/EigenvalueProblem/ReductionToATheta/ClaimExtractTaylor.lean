/-
# 具体版: `check(Z), check(Y)` についてのテイラー係数の抽出

対応する人手証明のラベル: **`extract_taylor_coefficient_of_check_Z_Y`**
（`structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts` の
`evensectorT_004_claim_extract_taylor`）

## 人手証明との対応

人手の `K_1, K_2^* ∈ ℝ` は Lean の `K1 K2star : ℝ`、その像 `(K_1)_ℂ` は `(K1 : ℂ)`、`G_1 := (i/2)((K_1)_ℂH_1^{(+)})` は
`((1/2 : ℂ) * i * (K1 : ℂ)) • H1plus M`、`G_2 := i((K_2^*)_ℂH_2)` は `(i * (K2star : ℂ)) • H2 M`、
`e_- = exp(-i(θ~)_ℂ)`・`e_+ = exp(i(θ~)_ℂ)` は `checkPhase M 1 μ`・`checkPhase M (-1) μ`（`checkPhase_eq_exp`）、
`(cosh K_1)_ℂ` は `((Real.cosh K1 : ℝ) : ℂ)` である。

| 人手 | Lean |
| --- | --- |
| 準備の 2 行 `2(K_2^*)_ℂ = (2_ℝ)_ℂ(K_2^*)_ℂ = (2K_2^*)_ℂ` | `two_mul_real_inclusion` の calc の 2 段 |
| (h1.z) の `n` 偶数の 1 行 | `adPow_G1_checkZ_of_even` |
| (h1.z) の `n` 奇数の 4 行 | `adPow_G1_checkZ_of_odd` の calc の 4 段 |
| (h1.z) の最後の 1 行（`exponential_series_of_even_odd_power_terms`） | `extract_taylor_H1Plus_checkZ` の calc の印 `人手` の段 |
| (h1.y) の `n` 偶数の 1 行・奇数の 4 行 | `adPow_G1_checkY_of_even`・`adPow_G1_checkY_of_odd` の calc の 4 段 |
| (h1.y) の最後の 2 行 | `extract_taylor_H1Plus_checkY` の calc の印 `人手 1`・`人手 2` の段 |
| (h2.z) の `n` 偶数の 2 行・奇数の 2 行 | `adPow_G2_checkZ_of_even`・`adPow_G2_checkZ_of_odd` の calc の 2 段 |
| (h2.z) の最後の 1 行 | `extract_taylor_H2_checkZ` の calc の印 `人手` の段 |
| (h2.y) の `n` 偶数の 2 行・奇数の 2 行 | `adPow_G2_checkY_of_even`・`adPow_G2_checkY_of_odd` の calc の 2 段 |
| (h2.y) の最後の 2 行 | `extract_taylor_H2_checkY` の calc の印 `人手 1`・`人手 2` の段 |

根拠の当て方:
- `cosh_sinh_coefficient_conversion_for_check` の 8 つの場合は `ClaimCoefficientConversion.lean` の `conversion_*_even`・`conversion_*_odd`
  （`n = 2k`・`2k + 1` の形）を `(K1 : ℂ)`・`(K2star : ℂ)` で引く。人手の「`n` が偶数」「奇数」から `n = 2k`・`2k + 1` を取り出す段は
  同じ行の中で行う。
- `complex_numbers_form_a_field` の積の結合律・可換律は Lean の具体版が無いので、既存の慣行どおり mathlib の `mul_assoc`・`mul_comm`。
- 準備の 1 行目の約束 `2 = 2_ℂ := (2_ℝ)_ℂ` は `Complex.ofReal_ofNat`、2 行目の `real_inclusion_preserves_product` は `real_inclusion_mul`。
- `matrix_sum_is_commutative` は `matrix_add_comm`（添字が `Fin (2^M)` の行列で当てる）。

`exponential_series_of_even_odd_power_terms` の具体版は行列の添字を `Fin d` に取る。`TensorPow M` の行列は添字が `Conf M` なので、
`trace_of_epsilon_V_plus` の真ん中の鎖（`exp_epsilon_mul_boundaryG`）と同じく、添字を付け替える写像
`Φ := toFinPowAlgEquiv M`（`Representation.lean`）で移して当て、逆写像で戻す。移す段・戻す段は人手の行ではない。
`d = 2^{M_col}` はこの `Φ` の行き先の添字の個数である。

人手の級数の和は `def_matrix_norm` の部分和の極限である。各主張は、`Φ` で移した部分和
`Σ_{n=0}^{N}(1/n!)_ℂΦ(ad^n_G(·))` がその値の像へ収束すること（人手の「収束し」）と、Lean の級数の和 `∑'` の値の 2 つを述べる。
`∑'` と部分和の極限を結ぶ段（`toFinPow_eq_evenOddSeriesSum_of_hasSum`）が使う `HasSum` は `exp_X_Y_exp_-X` の具体版
`hasSum_matExp_conj` から取る（`∑'` を値として使うのに級数の和の存在が要るため。人手の行ではない）。

必要十分版は置かない。このファイル固有の段は ℂ の積の結合律・可換律による並べ替えと、実数の積の像（準備）だけで、
取り払える構造が無い。部品の係数変換（`ClaimCoefficientConversionFromNecSuf.lean`）と、引く主張のノルムの評価・`ε` の鎖
（`NecSuf/EvenOddSeriesNormEstimate.lean`）はそれぞれ必要十分版を持つ。
-/
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimCoefficientConversion
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimExpConjugation
import Ising2D.EigenvalueProblem.ReductionToATheta.SeriesSumUnderReindexToFin

namespace Ising2D

open Nat Filter Topology

variable {M : ℕ}

attribute [local instance] Matrix.frobeniusNormedAddCommGroup Matrix.frobeniusNormSMulClass

/-! ## 準備 -/

/-- **人手の準備**: `2(K_2^*)_ℂ = (2K_2^*)_ℂ`。人手の 2 行と calc の 2 段が 1 対 1 である。 -/
theorem two_mul_real_inclusion (y : ℝ) : (2 : ℂ) * (y : ℂ) = ((2 * y : ℝ) : ℂ) :=
  calc (2 : ℂ) * (y : ℂ)
      = ((2 : ℝ) : ℂ) * (y : ℂ) := by
        rw [Complex.ofReal_ofNat]                             -- 人手 1: `2 = 2_ℂ := (2_ℝ)_ℂ`
    _ = ((2 * y : ℝ) : ℂ) := real_inclusion_mul 2 y          -- 人手 2: `real_inclusion_preserves_product`

/-! ## 各項（`cosh_sinh_coefficient_conversion_for_check` を `exponential_series_of_even_odd_power_terms` の仮定の形へ） -/

/-- **人手 (h1.z) の `n` 偶数の場合**: `ad^n_{G_1}(check(Z)_μ) = (K_1)_ℂ^n check(Z)_μ`。 -/
theorem adPow_G1_checkZ_of_even (hM : M ≠ 0) (K1 : ℝ) (μ : ℤ) {n : ℕ} (hn : Even n) :
    adPow (((1 / 2 : ℂ) * Complex.I * (K1 : ℂ)) • H1plus M) n (checkZ M μ)
      = (K1 : ℂ) ^ n • checkZ M μ := by
  obtain ⟨k, rfl⟩ := hn
  rw [← two_mul]
  exact conversion_H1Plus_checkZ_even hM (K1 : ℂ) μ k  -- 人手 1: (h1.z) の偶数の場合

/-- **人手 (h1.z) の `n` 奇数の場合**: `ad^n_{G_1}(check(Z)_μ) = ((ie_-)(K_1)_ℂ^n)check(Y)_μ`。
人手の 4 行と calc の 4 段が 1 対 1 である。 -/
theorem adPow_G1_checkZ_of_odd (hM : M ≠ 0) (K1 : ℝ) (μ : ℤ) {n : ℕ} (hn : Odd n) :
    adPow (((1 / 2 : ℂ) * Complex.I * (K1 : ℂ)) • H1plus M) n (checkZ M μ)
      = ((Complex.I * checkPhase M 1 μ) * (K1 : ℂ) ^ n) • checkY M μ :=
  calc adPow (((1 / 2 : ℂ) * Complex.I * (K1 : ℂ)) • H1plus M) n (checkZ M μ)
      = (Complex.I * (K1 : ℂ) ^ n * checkPhase M 1 μ) • checkY M μ := by
        obtain ⟨k, rfl⟩ := hn
        exact conversion_H1Plus_checkZ_odd hM (K1 : ℂ) μ k   -- 人手 1: (h1.z) の奇数の場合
    _ = (Complex.I * ((K1 : ℂ) ^ n * checkPhase M 1 μ)) • checkY M μ := by
        rw [mul_assoc]                                        -- 人手 2: 積の結合律
    _ = (Complex.I * (checkPhase M 1 μ * (K1 : ℂ) ^ n)) • checkY M μ := by
        rw [mul_comm ((K1 : ℂ) ^ n)]                          -- 人手 3: 積の可換律
    _ = ((Complex.I * checkPhase M 1 μ) * (K1 : ℂ) ^ n) • checkY M μ := by
        rw [← mul_assoc]                                      -- 人手 4: 積の結合律

/-- **人手 (h1.y) の `n` 偶数の場合**: `ad^n_{G_1}(check(Y)_μ) = (K_1)_ℂ^n check(Y)_μ`。 -/
theorem adPow_G1_checkY_of_even (hM : M ≠ 0) (K1 : ℝ) (μ : ℤ) {n : ℕ} (hn : Even n) :
    adPow (((1 / 2 : ℂ) * Complex.I * (K1 : ℂ)) • H1plus M) n (checkY M μ)
      = (K1 : ℂ) ^ n • checkY M μ := by
  obtain ⟨k, rfl⟩ := hn
  rw [← two_mul]
  exact conversion_H1Plus_checkY_even hM (K1 : ℂ) μ k  -- 人手 1: (h1.y) の偶数の場合

/-- **人手 (h1.y) の `n` 奇数の場合**: `ad^n_{G_1}(check(Y)_μ) = (((-i)e_+)(K_1)_ℂ^n)check(Z)_μ`。
人手の 4 行と calc の 4 段が 1 対 1 である。 -/
theorem adPow_G1_checkY_of_odd (hM : M ≠ 0) (K1 : ℝ) (μ : ℤ) {n : ℕ} (hn : Odd n) :
    adPow (((1 / 2 : ℂ) * Complex.I * (K1 : ℂ)) • H1plus M) n (checkY M μ)
      = ((-Complex.I * checkPhase M (-1) μ) * (K1 : ℂ) ^ n) • checkZ M μ :=
  calc adPow (((1 / 2 : ℂ) * Complex.I * (K1 : ℂ)) • H1plus M) n (checkY M μ)
      = (-Complex.I * (K1 : ℂ) ^ n * checkPhase M (-1) μ) • checkZ M μ := by
        obtain ⟨k, rfl⟩ := hn
        exact conversion_H1Plus_checkY_odd hM (K1 : ℂ) μ k   -- 人手 1: (h1.y) の奇数の場合
    _ = (-Complex.I * ((K1 : ℂ) ^ n * checkPhase M (-1) μ)) • checkZ M μ := by
        rw [mul_assoc]                                        -- 人手 2: 積の結合律
    _ = (-Complex.I * (checkPhase M (-1) μ * (K1 : ℂ) ^ n)) • checkZ M μ := by
        rw [mul_comm ((K1 : ℂ) ^ n)]                          -- 人手 3: 積の可換律
    _ = ((-Complex.I * checkPhase M (-1) μ) * (K1 : ℂ) ^ n) • checkZ M μ := by
        rw [← mul_assoc]                                      -- 人手 4: 積の結合律

/-- **人手 (h2.z) の `n` 偶数の場合**: `ad^n_{G_2}(check(Z)_μ) = ((2K_2^*)_ℂ)^n check(Z)_μ`。
人手の 2 行と calc の 2 段が 1 対 1 である。 -/
theorem adPow_G2_checkZ_of_even (K2star : ℝ) (μ : ℤ) {n : ℕ} (hn : Even n) :
    adPow ((Complex.I * (K2star : ℂ)) • H2 M) n (checkZ M μ)
      = ((2 * K2star : ℝ) : ℂ) ^ n • checkZ M μ :=
  calc adPow ((Complex.I * (K2star : ℂ)) • H2 M) n (checkZ M μ)
      = (2 * (K2star : ℂ)) ^ n • checkZ M μ := by
        obtain ⟨k, rfl⟩ := hn
        rw [← two_mul]
        exact conversion_H2_checkZ_even (K2star : ℂ) μ k      -- 人手 1: (h2.z) の偶数の場合
    _ = ((2 * K2star : ℝ) : ℂ) ^ n • checkZ M μ := by
        rw [two_mul_real_inclusion]                           -- 人手 2: 準備

/-- **人手 (h2.z) の `n` 奇数の場合**: `ad^n_{G_2}(check(Z)_μ) = ((-i)((2K_2^*)_ℂ)^n)check(Y)_μ`。
人手の 2 行と calc の 2 段が 1 対 1 である。 -/
theorem adPow_G2_checkZ_of_odd (K2star : ℝ) (μ : ℤ) {n : ℕ} (hn : Odd n) :
    adPow ((Complex.I * (K2star : ℂ)) • H2 M) n (checkZ M μ)
      = (-Complex.I * ((2 * K2star : ℝ) : ℂ) ^ n) • checkY M μ :=
  calc adPow ((Complex.I * (K2star : ℂ)) • H2 M) n (checkZ M μ)
      = (-Complex.I * (2 * (K2star : ℂ)) ^ n) • checkY M μ := by
        obtain ⟨k, rfl⟩ := hn
        exact conversion_H2_checkZ_odd (K2star : ℂ) μ k       -- 人手 1: (h2.z) の奇数の場合
    _ = (-Complex.I * ((2 * K2star : ℝ) : ℂ) ^ n) • checkY M μ := by
        rw [two_mul_real_inclusion]                           -- 人手 2: 準備

/-- **人手 (h2.y) の `n` 偶数の場合**: `ad^n_{G_2}(check(Y)_μ) = ((2K_2^*)_ℂ)^n check(Y)_μ`。
人手の 2 行と calc の 2 段が 1 対 1 である。 -/
theorem adPow_G2_checkY_of_even (K2star : ℝ) (μ : ℤ) {n : ℕ} (hn : Even n) :
    adPow ((Complex.I * (K2star : ℂ)) • H2 M) n (checkY M μ)
      = ((2 * K2star : ℝ) : ℂ) ^ n • checkY M μ :=
  calc adPow ((Complex.I * (K2star : ℂ)) • H2 M) n (checkY M μ)
      = (2 * (K2star : ℂ)) ^ n • checkY M μ := by
        obtain ⟨k, rfl⟩ := hn
        rw [← two_mul]
        exact conversion_H2_checkY_even (K2star : ℂ) μ k      -- 人手 1: (h2.y) の偶数の場合
    _ = ((2 * K2star : ℝ) : ℂ) ^ n • checkY M μ := by
        rw [two_mul_real_inclusion]                           -- 人手 2: 準備

/-- **人手 (h2.y) の `n` 奇数の場合**: `ad^n_{G_2}(check(Y)_μ) = (i((2K_2^*)_ℂ)^n)check(Z)_μ`。
人手の 2 行と calc の 2 段が 1 対 1 である。 -/
theorem adPow_G2_checkY_of_odd (K2star : ℝ) (μ : ℤ) {n : ℕ} (hn : Odd n) :
    adPow ((Complex.I * (K2star : ℂ)) • H2 M) n (checkY M μ)
      = (Complex.I * ((2 * K2star : ℝ) : ℂ) ^ n) • checkZ M μ :=
  calc adPow ((Complex.I * (K2star : ℂ)) • H2 M) n (checkY M μ)
      = (Complex.I * (2 * (K2star : ℂ)) ^ n) • checkZ M μ := by
        obtain ⟨k, rfl⟩ := hn
        exact conversion_H2_checkY_odd (K2star : ℂ) μ k       -- 人手 1: (h2.y) の奇数の場合
    _ = (Complex.I * ((2 * K2star : ℝ) : ℂ) ^ n) • checkZ M μ := by
        rw [two_mul_real_inclusion]                           -- 人手 2: 準備

/-! ## 4 つの級数（`exponential_series_of_even_odd_power_terms` を `Φ` で移して当てる） -/

/-- **人手 (h1.z)**: `Σ_{n=0}^{∞}(1/n!)_ℂ ad^n_{G_1}(check(Z)_μ) = (cosh K_1)_ℂ check(Z)_μ + ((ie_-)(sinh K_1)_ℂ)check(Y)_μ`。
1 つ目は `Φ` で移した部分和の収束、2 つ目は級数の和の値である。印 `人手` の段が人手の 1 行に当たる。 -/
theorem extract_taylor_H1Plus_checkZ (hM : M ≠ 0) (K1 : ℝ) (μ : ℤ) :
    Tendsto (fun N => evenOddPartialSum (fun n => toFinPowAlgEquiv M
          (adPow (((1 / 2 : ℂ) * Complex.I * (K1 : ℂ)) • H1plus M) n (checkZ M μ))) N) atTop
        (𝓝 (toFinPowAlgEquiv M (((Real.cosh K1 : ℝ) : ℂ) • checkZ M μ
          + ((Complex.I * checkPhase M 1 μ) * ((Real.sinh K1 : ℝ) : ℂ)) • checkY M μ)))
      ∧ ∑' n : ℕ, ((n ! : ℂ))⁻¹ •
          adPow (((1 / 2 : ℂ) * Complex.I * (K1 : ℂ)) • H1plus M) n (checkZ M μ)
        = ((Real.cosh K1 : ℝ) : ℂ) • checkZ M μ
          + ((Complex.I * checkPhase M 1 μ) * ((Real.sinh K1 : ℝ) : ℂ)) • checkY M μ := by
  set G := ((1 / 2 : ℂ) * Complex.I * (K1 : ℂ)) • H1plus M with hG
  set Φ := toFinPowAlgEquiv M with hΦ
  -- `exponential_series_of_even_odd_power_terms` を `A = Φ(check(Z)_μ)`、`B = Φ(check(Y)_μ)`、`x = K_1`、`c = ie_-`、
  -- `T_n := Φ(ad^n_{G_1}(check(Z)_μ))` で当てる（仮定は各項の 2 つの場合。続く `map_smul` は `Φ` をスカラー倍の内側へ移す段で、人手の行ではない）
  have h := exponential_series_of_even_odd_power_terms (Φ (checkZ M μ)) (Φ (checkY M μ)) K1
    (Complex.I * checkPhase M 1 μ) (fun n => Φ (adPow G n (checkZ M μ)))
    (fun _ hn => by rw [hG, adPow_G1_checkZ_of_even hM K1 μ hn, map_smul])
    (fun _ hn => by rw [hG, adPow_G1_checkZ_of_odd hM K1 μ hn, map_smul])
  -- 1 つ目（部分和の収束）: `Φ` を右辺の和とスカラー倍へ移す段（人手の行ではない）のあと `h.1`
  refine ⟨by rw [map_add, map_smul, map_smul]; exact h.1, ?_⟩
  calc ∑' n : ℕ, ((n ! : ℂ))⁻¹ • adPow G n (checkZ M μ)
      = Φ.symm (Φ (∑' n : ℕ, ((n ! : ℂ))⁻¹ • adPow G n (checkZ M μ))) :=
        (Φ.symm_apply_apply _).symm                           -- `Φ` で移して戻す
    _ = Φ.symm (evenOddSeriesSum (fun n => Φ (adPow G n (checkZ M μ)))) := by
        rw [toFinPow_eq_evenOddSeriesSum_of_hasSum (hasSum_matExp_conj G (checkZ M μ)).summable.hasSum]
                                                              -- 級数の和を部分和の極限で読む
    _ = Φ.symm (((Real.cosh K1 : ℝ) : ℂ) • Φ (checkZ M μ)
          + ((Complex.I * checkPhase M 1 μ) * ((Real.sinh K1 : ℝ) : ℂ)) • Φ (checkY M μ)) := by
        rw [h.2]                                              -- 人手: `exponential_series_of_even_odd_power_terms`
    _ = ((Real.cosh K1 : ℝ) : ℂ) • checkZ M μ
          + ((Complex.I * checkPhase M 1 μ) * ((Real.sinh K1 : ℝ) : ℂ)) • checkY M μ := by
        rw [map_add, map_smul, map_smul, AlgEquiv.symm_apply_apply, AlgEquiv.symm_apply_apply]
                                                              -- `Φ^{-1}` で戻す

/-- **人手 (h1.y)**: `Σ_{n=0}^{∞}(1/n!)_ℂ ad^n_{G_1}(check(Y)_μ) = (((-i)e_+)(sinh K_1)_ℂ)check(Z)_μ + (cosh K_1)_ℂ check(Y)_μ`。
印 `人手 1`・`人手 2` の段が人手の 2 行に当たる。 -/
theorem extract_taylor_H1Plus_checkY (hM : M ≠ 0) (K1 : ℝ) (μ : ℤ) :
    Tendsto (fun N => evenOddPartialSum (fun n => toFinPowAlgEquiv M
          (adPow (((1 / 2 : ℂ) * Complex.I * (K1 : ℂ)) • H1plus M) n (checkY M μ))) N) atTop
        (𝓝 (toFinPowAlgEquiv M (((-Complex.I * checkPhase M (-1) μ) * ((Real.sinh K1 : ℝ) : ℂ)) • checkZ M μ
          + ((Real.cosh K1 : ℝ) : ℂ) • checkY M μ)))
      ∧ ∑' n : ℕ, ((n ! : ℂ))⁻¹ •
          adPow (((1 / 2 : ℂ) * Complex.I * (K1 : ℂ)) • H1plus M) n (checkY M μ)
        = ((-Complex.I * checkPhase M (-1) μ) * ((Real.sinh K1 : ℝ) : ℂ)) • checkZ M μ
          + ((Real.cosh K1 : ℝ) : ℂ) • checkY M μ := by
  set G := ((1 / 2 : ℂ) * Complex.I * (K1 : ℂ)) • H1plus M with hG
  set Φ := toFinPowAlgEquiv M with hΦ
  -- `A = Φ(check(Y)_μ)`、`B = Φ(check(Z)_μ)`、`x = K_1`、`c = (-i)e_+` で当てる
  have h := exponential_series_of_even_odd_power_terms (Φ (checkY M μ)) (Φ (checkZ M μ)) K1
    (-Complex.I * checkPhase M (-1) μ) (fun n => Φ (adPow G n (checkY M μ)))
    (fun _ hn => by rw [hG, adPow_G1_checkY_of_even hM K1 μ hn, map_smul])
    (fun _ hn => by rw [hG, adPow_G1_checkY_of_odd hM K1 μ hn, map_smul])
  -- 1 つ目（部分和の収束）: `Φ` を右辺の和とスカラー倍へ移す段（人手の行ではない）と
  -- `matrix_sum_is_commutative`（`matrix_add_comm`。人手 2）のあと `h.1`
  refine ⟨by rw [map_add, map_smul, map_smul, matrix_add_comm]; exact h.1, ?_⟩
  calc ∑' n : ℕ, ((n ! : ℂ))⁻¹ • adPow G n (checkY M μ)
      = Φ.symm (Φ (∑' n : ℕ, ((n ! : ℂ))⁻¹ • adPow G n (checkY M μ))) :=
        (Φ.symm_apply_apply _).symm                           -- `Φ` で移して戻す
    _ = Φ.symm (evenOddSeriesSum (fun n => Φ (adPow G n (checkY M μ)))) := by
        rw [toFinPow_eq_evenOddSeriesSum_of_hasSum (hasSum_matExp_conj G (checkY M μ)).summable.hasSum]
                                                              -- 級数の和を部分和の極限で読む
    _ = Φ.symm (((Real.cosh K1 : ℝ) : ℂ) • Φ (checkY M μ)
          + ((-Complex.I * checkPhase M (-1) μ) * ((Real.sinh K1 : ℝ) : ℂ)) • Φ (checkZ M μ)) := by
        rw [h.2]                                              -- 人手 1: `exponential_series_of_even_odd_power_terms`
    _ = Φ.symm (((-Complex.I * checkPhase M (-1) μ) * ((Real.sinh K1 : ℝ) : ℂ)) • Φ (checkZ M μ)
          + ((Real.cosh K1 : ℝ) : ℂ) • Φ (checkY M μ)) := by
        rw [matrix_add_comm]                                  -- 人手 2: `matrix_sum_is_commutative`
    _ = ((-Complex.I * checkPhase M (-1) μ) * ((Real.sinh K1 : ℝ) : ℂ)) • checkZ M μ
          + ((Real.cosh K1 : ℝ) : ℂ) • checkY M μ := by
        rw [map_add, map_smul, map_smul, AlgEquiv.symm_apply_apply, AlgEquiv.symm_apply_apply]
                                                              -- `Φ^{-1}` で戻す

/-- **人手 (h2.z)**: `Σ_{n=0}^{∞}(1/n!)_ℂ ad^n_{G_2}(check(Z)_μ) = (cosh 2K_2^*)_ℂ check(Z)_μ + ((-i)(sinh 2K_2^*)_ℂ)check(Y)_μ`。
印 `人手` の段が人手の 1 行に当たる。 -/
theorem extract_taylor_H2_checkZ (K2star : ℝ) (μ : ℤ) :
    Tendsto (fun N => evenOddPartialSum (fun n => toFinPowAlgEquiv M
          (adPow ((Complex.I * (K2star : ℂ)) • H2 M) n (checkZ M μ))) N) atTop
        (𝓝 (toFinPowAlgEquiv M (((Real.cosh (2 * K2star) : ℝ) : ℂ) • checkZ M μ
          + (-Complex.I * ((Real.sinh (2 * K2star) : ℝ) : ℂ)) • checkY M μ)))
      ∧ ∑' n : ℕ, ((n ! : ℂ))⁻¹ • adPow ((Complex.I * (K2star : ℂ)) • H2 M) n (checkZ M μ)
        = ((Real.cosh (2 * K2star) : ℝ) : ℂ) • checkZ M μ
          + (-Complex.I * ((Real.sinh (2 * K2star) : ℝ) : ℂ)) • checkY M μ := by
  set G := (Complex.I * (K2star : ℂ)) • H2 M with hG
  set Φ := toFinPowAlgEquiv M with hΦ
  -- `A = Φ(check(Z)_μ)`、`B = Φ(check(Y)_μ)`、`x = 2K_2^*`、`c = -i` で当てる
  have h := exponential_series_of_even_odd_power_terms (Φ (checkZ M μ)) (Φ (checkY M μ)) (2 * K2star)
    (-Complex.I) (fun n => Φ (adPow G n (checkZ M μ)))
    (fun _ hn => by rw [hG, adPow_G2_checkZ_of_even K2star μ hn, map_smul])
    (fun _ hn => by rw [hG, adPow_G2_checkZ_of_odd K2star μ hn, map_smul])
  -- 1 つ目（部分和の収束）: `Φ` を右辺の和とスカラー倍へ移す段（人手の行ではない）のあと `h.1`
  refine ⟨by rw [map_add, map_smul, map_smul]; exact h.1, ?_⟩
  calc ∑' n : ℕ, ((n ! : ℂ))⁻¹ • adPow G n (checkZ M μ)
      = Φ.symm (Φ (∑' n : ℕ, ((n ! : ℂ))⁻¹ • adPow G n (checkZ M μ))) :=
        (Φ.symm_apply_apply _).symm                           -- `Φ` で移して戻す
    _ = Φ.symm (evenOddSeriesSum (fun n => Φ (adPow G n (checkZ M μ)))) := by
        rw [toFinPow_eq_evenOddSeriesSum_of_hasSum (hasSum_matExp_conj G (checkZ M μ)).summable.hasSum]
                                                              -- 級数の和を部分和の極限で読む
    _ = Φ.symm (((Real.cosh (2 * K2star) : ℝ) : ℂ) • Φ (checkZ M μ)
          + (-Complex.I * ((Real.sinh (2 * K2star) : ℝ) : ℂ)) • Φ (checkY M μ)) := by
        rw [h.2]                                              -- 人手: `exponential_series_of_even_odd_power_terms`
    _ = ((Real.cosh (2 * K2star) : ℝ) : ℂ) • checkZ M μ
          + (-Complex.I * ((Real.sinh (2 * K2star) : ℝ) : ℂ)) • checkY M μ := by
        rw [map_add, map_smul, map_smul, AlgEquiv.symm_apply_apply, AlgEquiv.symm_apply_apply]
                                                              -- `Φ^{-1}` で戻す

/-- **人手 (h2.y)**: `Σ_{n=0}^{∞}(1/n!)_ℂ ad^n_{G_2}(check(Y)_μ) = (i(sinh 2K_2^*)_ℂ)check(Z)_μ + (cosh 2K_2^*)_ℂ check(Y)_μ`。
印 `人手 1`・`人手 2` の段が人手の 2 行に当たる。 -/
theorem extract_taylor_H2_checkY (K2star : ℝ) (μ : ℤ) :
    Tendsto (fun N => evenOddPartialSum (fun n => toFinPowAlgEquiv M
          (adPow ((Complex.I * (K2star : ℂ)) • H2 M) n (checkY M μ))) N) atTop
        (𝓝 (toFinPowAlgEquiv M ((Complex.I * ((Real.sinh (2 * K2star) : ℝ) : ℂ)) • checkZ M μ
          + ((Real.cosh (2 * K2star) : ℝ) : ℂ) • checkY M μ)))
      ∧ ∑' n : ℕ, ((n ! : ℂ))⁻¹ • adPow ((Complex.I * (K2star : ℂ)) • H2 M) n (checkY M μ)
        = (Complex.I * ((Real.sinh (2 * K2star) : ℝ) : ℂ)) • checkZ M μ
          + ((Real.cosh (2 * K2star) : ℝ) : ℂ) • checkY M μ := by
  set G := (Complex.I * (K2star : ℂ)) • H2 M with hG
  set Φ := toFinPowAlgEquiv M with hΦ
  -- `A = Φ(check(Y)_μ)`、`B = Φ(check(Z)_μ)`、`x = 2K_2^*`、`c = i` で当てる
  have h := exponential_series_of_even_odd_power_terms (Φ (checkY M μ)) (Φ (checkZ M μ)) (2 * K2star)
    Complex.I (fun n => Φ (adPow G n (checkY M μ)))
    (fun _ hn => by rw [hG, adPow_G2_checkY_of_even K2star μ hn, map_smul])
    (fun _ hn => by rw [hG, adPow_G2_checkY_of_odd K2star μ hn, map_smul])
  -- 1 つ目（部分和の収束）: `Φ` を右辺の和とスカラー倍へ移す段（人手の行ではない）と
  -- `matrix_sum_is_commutative`（`matrix_add_comm`。人手 2）のあと `h.1`
  refine ⟨by rw [map_add, map_smul, map_smul, matrix_add_comm]; exact h.1, ?_⟩
  calc ∑' n : ℕ, ((n ! : ℂ))⁻¹ • adPow G n (checkY M μ)
      = Φ.symm (Φ (∑' n : ℕ, ((n ! : ℂ))⁻¹ • adPow G n (checkY M μ))) :=
        (Φ.symm_apply_apply _).symm                           -- `Φ` で移して戻す
    _ = Φ.symm (evenOddSeriesSum (fun n => Φ (adPow G n (checkY M μ)))) := by
        rw [toFinPow_eq_evenOddSeriesSum_of_hasSum (hasSum_matExp_conj G (checkY M μ)).summable.hasSum]
                                                              -- 級数の和を部分和の極限で読む
    _ = Φ.symm (((Real.cosh (2 * K2star) : ℝ) : ℂ) • Φ (checkY M μ)
          + (Complex.I * ((Real.sinh (2 * K2star) : ℝ) : ℂ)) • Φ (checkZ M μ)) := by
        rw [h.2]                                              -- 人手 1: `exponential_series_of_even_odd_power_terms`
    _ = Φ.symm ((Complex.I * ((Real.sinh (2 * K2star) : ℝ) : ℂ)) • Φ (checkZ M μ)
          + ((Real.cosh (2 * K2star) : ℝ) : ℂ) • Φ (checkY M μ)) := by
        rw [matrix_add_comm]                                  -- 人手 2: `matrix_sum_is_commutative`
    _ = (Complex.I * ((Real.sinh (2 * K2star) : ℝ) : ℂ)) • checkZ M μ
          + ((Real.cosh (2 * K2star) : ℝ) : ℂ) • checkY M μ := by
        rw [map_add, map_smul, map_smul, AlgEquiv.symm_apply_apply, AlgEquiv.symm_apply_apply]
                                                              -- `Φ^{-1}` で戻す

end Ising2D
