import Ising2DLambda.KacWard.HighTemperaturePartitionBounds
import Ising2DLambda.NecSuf.KacWard.HighTemperaturePartitionBounds

/-!
具体版 `highTemperaturePartitionBounds`（`claim_high_temperature_partition_bounds`）を、必要十分版から得る導出版。

`K = ℚ`、`ι = SpinStructure`（`|𝒮| = 4` は `spinStructures_card`）、`f = Q^{·}_L(q)`、`g = Q^{·}_L(t)`、
`Z = Z_L(q)`、`t = KW(q)`、`Zt = Z_L(t)`、`c = (1+q)^{2L²}`、`d = 2^{L²}`、`G^{c,d} = G^{c,d}_L(t)` に特殊化する。
符号を除いた自己双対性は `dualityUpToSign_eval_rat`、`g` の正値性は `signedEvenSubgraphPolynomial_rational_sign` が与える。
-/

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero
open Ising2DLambda.PartitionPolynomial

theorem highTemperaturePartitionBounds_from_necSuf (data : RealClosedSubfieldData) {L : ℕ}
    [NeZero L] (z : Qbar) (hz4 : z ^ 4 = -1) (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1)
    (hc : 0 < q ^ 2 + 2 * q - 1) :
    signedEvenSubgraphAbsMax L q / 4 ≤ partitionValue L q ∧
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
  have h1q : (0 : ℚ) < 1 + q := by linarith
  exact Ising2DLambda.NecSuf.KacWard.high_temperature_partition_bounds_necSuf
    spinStructure_univ_nonempty spinStructures_card (signedEvenSubgraphValue L q)
    (signedEvenSubgraphValue L t) (partitionValue L q) (partitionValue L t)
    ((1 + q) ^ (2 * L ^ 2)) (2 ^ (L ^ 2)) _ _ _ _ (by positivity) (by positivity) hfac
    (sectorGeneratingPolynomial_eval_nonneg L _ ht0.le)
    (sectorGeneratingPolynomial_eval_nonneg L _ ht0.le)
    (sectorGeneratingPolynomial_eval_nonneg L _ ht0.le) htriv
    (lowTemperaturePartitionBounds data z hz4 t ht0 ht1 htc).1
    (finiteTorusPolynomial_eval_rat L q)
    (fun s => dualityUpToSign_eval_rat L z hz4 s hq0)
    (fun s => (signedEvenSubgraphPolynomial_rational_sign data z hz4 s t ht0 ht1).1 htc)

end Ising2DLambda.KacWard
