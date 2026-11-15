import Ising2DLambda.KacWard.HighTemperatureDualBounds
import Ising2DLambda.NecSuf.KacWard.HighTemperatureDualBounds

/-!
具体版 `highTemperatureDualBounds`（`claim_high_temperature_partition_bounds` の、自己双対変換の符号を
引かずに済む段）を、必要十分版から得る導出版。

`K = ℚ`、`ι = SpinStructure`（`|𝒮| = 4` は `spinStructures_card`）、`f = Q^{·}_L(q)`、`Z = Z_L(q)`、
`t = KW(q)`、`Zt = Z_L(t)`、`M = M_L(t)`、`c = (1+q)^{2L²}`、`d = 2^{L²}`、`G^{c,d} = G^{c,d}_L(t)` に特殊化する。
`2^{L²+2} = 2^{L²} · 4` で分母を合わせる。
-/

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero
open Ising2DLambda.PartitionPolynomial

theorem highTemperatureDualBounds_from_necSuf (data : RealClosedSubfieldData) {L : ℕ}
    [NeZero L] (z : Qbar) (hz4 : z ^ 4 = -1) (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1)
    (hc : 0 < q ^ 2 + 2 * q - 1) :
    (1 + q) ^ (2 * L ^ 2) / 2 ^ (L ^ 2 + 2) * signedEvenSubgraphMax L (kwDualRational q) ≤
        partitionValue L q ∧
      partitionValue L q ≤ 2 * signedEvenSubgraphAbsMax L q := by
  have hqI : q ∈ unitIntervalRationals := ⟨hq0, hq1⟩
  obtain ⟨⟨ht0, ht1⟩, -⟩ := kwDualTransform_preservesUnitInterval hqI
  have htc := kwDualRational_selfDual_neg hq0 hc
  set t := kwDualRational q with ht
  have hfac : 2 ^ (L ^ 2) * partitionValue L q =
      (1 + q) ^ (2 * L ^ 2) *
        (intPolynomialEval t (sectorGeneratingPolynomial L (0, 0)) +
          intPolynomialEval t (sectorGeneratingPolynomial L (0, 1)) +
          intPolynomialEval t (sectorGeneratingPolynomial L (1, 0)) +
          intPolynomialEval t (sectorGeneratingPolynomial L (1, 1))) := by
    rw [partitionValue_eq_aeval]
    exact partitionValueDualFactorization L hqI
  have htriv : partitionValue L t =
      2 * intPolynomialEval t (sectorGeneratingPolynomial L (0, 0)) := by
    rw [partitionValue_eq_aeval, ← intPolynomialEval_eq_aeval,
      partitionPolynomial_eq_two_mul_trivialSectorGeneratingPolynomial]
    simp [intPolynomialEval]
  have hpow : (2 : ℚ) ^ (L ^ 2 + 2) = 2 ^ (L ^ 2) * 4 := by
    rw [pow_add]
    norm_num
  rw [hpow]
  exact Ising2DLambda.NecSuf.KacWard.high_temperature_dual_bounds_necSuf
    spinStructure_univ_nonempty spinStructures_card (signedEvenSubgraphValue L q)
    (partitionValue L q) (partitionValue L t) (signedEvenSubgraphMax L t)
    ((1 + q) ^ (2 * L ^ 2)) (2 ^ (L ^ 2)) _ _ _ _ (by positivity) (by positivity) hfac
    (sectorGeneratingPolynomial_eval_nonneg L _ ht0.le)
    (sectorGeneratingPolynomial_eval_nonneg L _ ht0.le)
    (sectorGeneratingPolynomial_eval_nonneg L _ ht0.le) htriv
    (lowTemperaturePartitionBounds data z hz4 t ht0 ht1 htc).1
    (finiteTorusPolynomial_eval_rat L q)

end Ising2DLambda.KacWard
