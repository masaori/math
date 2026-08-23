/-
人手証明の主張「有理点 1 では極限量が存在して 2 に等しい」
（ラベル `claim_limit_quantity_at_one_equals_two`）の具体版。

人手証明の各行とこのファイルの対応:

  Z_L(1) = 2^(#V_L)                    `NullModel.partitionPolynomial_value_at_one`
  a_L(1) = Z_L(1)^{1/#V_L}             `rootSeq` の定義（`def_limit_quantity_from_finite_box_sequence`）
         = (2^(#V_L))^{1/#V_L}         `isingValueSeq_one`
         = 2                           `eq_posRoot_of_pow_eq`（正の実数の正の乗根の一意性）
  L↦a_L(1) は定数列 2                  `rootSeq_isingValueSeq_one`
  α(1) = 2                             `tendsto_rootSeq_isingValueSeq_one`

ℝ への脱出は、既に取ってある箱の大きさの極限（`Tendsto`）だけである。
ここで新たな脱出は行わず、定数列の極限がその値に等しいことだけを使う。
-/
import Ising3DCut.LimitQuantity.LimitQuantityDeterminedBySequence
import Ising3DCut.LimitQuantity.SiteCountIndependentOfQ
import Ising3DCut.NullModel.PartitionValueAtOne
import Ising3DCut.CoarseGrainingValuesAgree

namespace Ising3DCut.LimitQuantity

open Filter Topology NullModel

/-- 実際の Ising 有限箱データの有理点 `q` での値を実数として並べた列 `L ↦ Z_L(q)`。 -/
noncomputable def isingValueSeq (q : ℚ) : ℕ → ℝ :=
  fun L => ((evalAtRational q (partitionPolynomial L) : ℚ) : ℝ)

/-- 箱の点の個数の列 `L ↦ #V_L`。 -/
def siteCountSeq : ℕ → ℕ := fun L => Fintype.card (Site L)

/-- 人手証明の第一行。分配多項式の 1 での値は配位の個数 `2^(#V_L)` である。 -/
theorem isingValueSeq_one (L : ℕ) :
    isingValueSeq 1 L = (2 : ℝ) ^ siteCountSeq L := by
  have h : (evalAtRational 1) (partitionPolynomial L)
      = (((partitionPolynomial L).eval 1 : ℤ) : ℚ) := by
    simp [evalAtRational, Polynomial.eval₂_at_one]
  unfold isingValueSeq siteCountSeq
  rw [h, partitionPolynomial_value_at_one]
  push_cast
  ring

/-- 人手証明の第二行から第四行。`L ≥ 1` のとき `a_L(1) = 2`。
`2` は `2^(#V_L)` の正の `#V_L` 乗根であり、正の実数の正の乗根は一意である。 -/
theorem rootSeq_isingValueSeq_one {L : ℕ} (hL : 0 < L) :
    rootSeq (isingValueSeq 1) siteCountSeq L = 2 := by
  have hN : siteCountSeq L ≠ 0 := by
    unfold siteCountSeq
    rw [card_site]
    exact pow_ne_zero 3 hL.ne'
  have hx : (0 : ℝ) < isingValueSeq 1 L := by
    rw [isingValueSeq_one]
    positivity
  unfold rootSeq
  exact (eq_posRoot_of_pow_eq (isingValueSeq 1 L) 2 hx (by norm_num)
    (siteCountSeq L) hN (isingValueSeq_one L).symm).symm

/-- `claim_limit_quantity_at_one_equals_two` の具体版。
定数列は自身の値へ収束するので、極限量 `α(1)` は存在して `2` に等しい。 -/
theorem tendsto_rootSeq_isingValueSeq_one :
    Tendsto (rootSeq (isingValueSeq 1) siteCountSeq) atTop (𝓝 2) := by
  apply Tendsto.congr' _ tendsto_const_nhds
  filter_upwards [eventually_gt_atTop 0] with L hL
  exact (rootSeq_isingValueSeq_one hL).symm

end Ising3DCut.LimitQuantity
