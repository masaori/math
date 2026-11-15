/-
「自己双対点より高温側での分配多項式の両側評価」（`claim_high_temperature_partition_bounds`）のうち、
自己双対変換の符号を引かずに済む段の具体版。下界 `Z_L(q) ≥ (1+q)^{2L²}/2^{L²+2} · M_L(t)` と
上界 `Z_L(q) ≤ 2 M^abs_L(q)` を示す。

  人手証明                                                    このファイル・引く具体版
  `t := KW(q) = (1−q)/(1+q)`、`0 < t < 1`（`claim_kw_dual_preserves_unit_interval`）
                                                              `FisherZero.kwDualTransform_preservesUnitInterval`
  `t² + 2t − 1 = −2(q² + 2q − 1)/(1+q)² < 0`（ℚ の通分と分配律）  `kwDualRational_selfDual_neg`
  `Z_L(t) ≥ ½ M_L(t)`（`claim_low_temperature_partition_bounds`）  `lowTemperaturePartitionBounds` の第一成分
  `G^{c,d}_L(t) ≥ 0`（`def_sector_generating_polynomial` の係数は非負）
                                                              `sectorGeneratingPolynomial_eval_nonneg`
  下界の鎖
    `Z_L(q) = (1+q)^{2L²}/2^{L²} Σ G^{c,d}_L(t)`（`claim_partition_value_dual_factorization`）
                                                              `FisherZero.partitionValueDualFactorization`
    `≥ (1+q)^{2L²}/2^{L²} G^{0,0}_L(t)`（`G^{c,d}_L(t) ≥ 0`）
    `= (1+q)^{2L²}/2^{L²+1} Z_L(t)`（`claim_low_temperature_trivial_sector_expression`）
                                                              `FisherZero.partitionPolynomial_eq_two_mul_trivialSectorGeneratingPolynomial`
    `≥ (1+q)^{2L²}/2^{L²+2} M_L(t)`（`claim_low_temperature_partition_bounds`）
  上界の鎖
    `Z_L(q) = ½ Σ Q^{a,b}_L(q)`（`claim_finite_torus_polynomial`）  `finiteTorusPolynomial_eval_rat`
    `≤ ½ Σ |Q^{a,b}_L(q)|`（`r ≤ |r|`）
    `≤ ½ Σ M^abs_L(q)`（`M^abs_L(q)` は四つの絶対値の最大）
    `= 2 M^abs_L(q)`（`|𝒮| = 4`、`def_spin_structures`）

人手証明の残り（`claim_signed_even_subgraph_duality_sign` を `x = q` で評価して
`(1+q)^{2L²}/2^{L²} M_L(t) = M^abs_L(q)` を得、下界を `¼ M^abs_L(q)` に書き直すこと）は、
自己双対変換の符号の具体版を引いて合成する段で与える。
必要十分版の定理・定義は使わない。住処は ℚ（四つの値の符号の判定だけ実閉部分体 R ⊂ Qbar を通る）。
実数体・複素数体は現れない。
-/
import Ising2DLambda.KacWard.LowTemperaturePartitionBounds
import Ising2DLambda.KacWard.PartitionLogOrderTransfer
import Ising2DLambda.FisherZero.FreeEntropyDualRelation

namespace Ising2DLambda.KacWard

open Polynomial
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero
open Ising2DLambda.PartitionPolynomial

/-- `q² + 2q − 1 > 0` なら双対点 `t = (1−q)/(1+q)` は `t² + 2t − 1 < 0` を満たす。 -/
theorem kwDualRational_selfDual_neg {q : ℚ} (hq0 : 0 < q) (hc : 0 < q ^ 2 + 2 * q - 1) :
    kwDualRational q ^ 2 + 2 * kwDualRational q - 1 < 0 := by
  have h1q : 0 < 1 + q := by linarith
  have h1qne : 1 + q ≠ 0 := ne_of_gt h1q
  calc kwDualRational q ^ 2 + 2 * kwDualRational q - 1
      = ((1 - q) / (1 + q)) ^ 2 + 2 * ((1 - q) / (1 + q)) - 1 := by
        -- `t = (1−q)/(1+q)`
        rw [kwDualRational, div_eq_mul_inv]
    _ = ((1 - q) ^ 2 + 2 * (1 - q) * (1 + q) - (1 + q) ^ 2) / (1 + q) ^ 2 := by
        -- ℚ の通分
        field_simp
    _ = -(2 * (q ^ 2 + 2 * q - 1)) / (1 + q) ^ 2 := by
        -- ℚ の分配律
        ring
    _ < 0 := by
        -- `q² + 2q − 1 > 0`、`(1+q)² > 0`
        apply div_neg_of_neg_of_pos
        · linarith
        · positivity

/-- `def_sector_generating_polynomial` の係数は非負整数なので、`0 ≤ t` なら `G^{c,d}_L(t) ≥ 0`。 -/
theorem sectorGeneratingPolynomial_eval_nonneg (L : ℕ) [NeZero L] (sector : Fin 2 × Fin 2)
    {t : ℚ} (ht : 0 ≤ t) : 0 ≤ intPolynomialEval t (sectorGeneratingPolynomial L sector) := by
  classical
  simp only [sectorGeneratingPolynomial, intPolynomialEval_sum, intPolynomialEval_pow,
    intPolynomialEval_X]
  exact Finset.sum_nonneg fun _ _ => pow_nonneg ht _

/-- 具体版: `0 < q < 1`、`q² + 2q − 1 > 0`、`t = KW(q)` なら
`(1+q)^{2L²}/2^{L²+2} · M_L(t) ≤ Z_L(q) ≤ 2 M^abs_L(q)`。 -/
theorem highTemperatureDualBounds (data : RealClosedSubfieldData) {L : ℕ} [NeZero L]
    (z : Qbar) (hz4 : z ^ 4 = -1) (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1)
    (hc : 0 < q ^ 2 + 2 * q - 1) :
    (1 + q) ^ (2 * L ^ 2) / 2 ^ (L ^ 2 + 2) * signedEvenSubgraphMax L (kwDualRational q) ≤
        partitionValue L q ∧
      partitionValue L q ≤ 2 * signedEvenSubgraphAbsMax L q := by
  have hqI : q ∈ unitIntervalRationals := ⟨hq0, hq1⟩
  -- `0 < t < 1`
  obtain ⟨⟨ht0, ht1⟩, -⟩ := kwDualTransform_preservesUnitInterval hqI
  -- `t² + 2t − 1 < 0`
  have htc := kwDualRational_selfDual_neg hq0 hc
  set t := kwDualRational q with ht
  -- 低温側の下界 `Z_L(t) ≥ ½ M_L(t)`
  have hlowt : signedEvenSubgraphMax L t / 2 ≤ partitionValue L t :=
    (lowTemperaturePartitionBounds data z hz4 t ht0 ht1 htc).1
  -- `G^{c,d}_L(t) ≥ 0`
  have hG : ∀ sector, 0 ≤ intPolynomialEval t (sectorGeneratingPolynomial L sector) :=
    fun sector => sectorGeneratingPolynomial_eval_nonneg L sector ht0.le
  -- `claim_partition_value_dual_factorization` を `q` で評価したもの
  have hfac : 2 ^ (L ^ 2) * partitionValue L q =
      (1 + q) ^ (2 * L ^ 2) * dualSectorValueSum L q := by
    rw [partitionValue_eq_aeval]
    exact partitionValueDualFactorization L hqI
  -- `claim_low_temperature_trivial_sector_expression` を `t` で評価したもの
  have htriv : partitionValue L t =
      2 * intPolynomialEval t (sectorGeneratingPolynomial L (0, 0)) := by
    rw [partitionValue_eq_aeval, ← intPolynomialEval_eq_aeval,
      partitionPolynomial_eq_two_mul_trivialSectorGeneratingPolynomial]
    simp [intPolynomialEval]
  have h2pos : (0 : ℚ) < 2 ^ (L ^ 2) := by positivity
  have hcpos : (0 : ℚ) ≤ (1 + q) ^ (2 * L ^ 2) := by positivity
  constructor
  · -- 下界の鎖
    calc (1 + q) ^ (2 * L ^ 2) / 2 ^ (L ^ 2 + 2) * signedEvenSubgraphMax L t
        = (1 + q) ^ (2 * L ^ 2) / 2 ^ (L ^ 2 + 1) * (signedEvenSubgraphMax L t / 2) := by
          rw [pow_succ, pow_succ, pow_succ]
          ring
      _ ≤ (1 + q) ^ (2 * L ^ 2) / 2 ^ (L ^ 2 + 1) * partitionValue L t := by
          -- `claim_low_temperature_partition_bounds`
          gcongr
      _ = (1 + q) ^ (2 * L ^ 2) / 2 ^ (L ^ 2) *
            intPolynomialEval t (sectorGeneratingPolynomial L (0, 0)) := by
          -- `claim_low_temperature_trivial_sector_expression`
          rw [htriv, pow_succ (2 : ℚ) (L ^ 2)]
          field_simp
      _ ≤ (1 + q) ^ (2 * L ^ 2) / 2 ^ (L ^ 2) * dualSectorValueSum L q := by
          -- `G^{c,d}_L(t) ≥ 0`
          gcongr
          rw [dualSectorValueSum, ← ht]
          linarith [hG (0, 1), hG (1, 0), hG (1, 1)]
      _ = partitionValue L q := by
          -- `claim_partition_value_dual_factorization`
          rw [div_mul_eq_mul_div, ← hfac]
          field_simp
  · -- 上界の鎖
    have hZ : partitionValue L q = (1 / 2) * ∑ s : SpinStructure, signedEvenSubgraphValue L q s := by
      rw [← finiteTorusPolynomial_eval_rat L q]
      ring
    calc partitionValue L q
        = (1 / 2) * ∑ s : SpinStructure, signedEvenSubgraphValue L q s := hZ
      _ ≤ (1 / 2) * ∑ s : SpinStructure, |signedEvenSubgraphValue L q s| := by
          -- `r ≤ |r|`
          gcongr with s
          exact le_abs_self _
      _ ≤ (1 / 2) * ∑ _s : SpinStructure, signedEvenSubgraphAbsMax L q := by
          -- `M^abs_L(q)` は四つの絶対値の最大
          gcongr with s
          exact Finset.le_sup' (fun s => |signedEvenSubgraphValue L q s|) (Finset.mem_univ s)
      _ = 2 * signedEvenSubgraphAbsMax L q := by
          -- `|𝒮| = 4`
          rw [Finset.sum_const, Finset.card_univ, spinStructures_card, nsmul_eq_mul]
          norm_num
          ring

end Ising2DLambda.KacWard
