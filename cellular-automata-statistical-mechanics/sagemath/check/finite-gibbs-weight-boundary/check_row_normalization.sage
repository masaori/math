# 対象ラベル: claim_finite_gibbs_transition_weight_normalized
# 式ペア: sum_y exp_R(-beta E(x,y))/Z_{beta,E}(x) = Z_{beta,E}(x)/Z_{beta,E}(x) = 1。
# 帰属: ZZ、QQ、記号的な実指数値。正の実数値による除算の箇所で RR へ脱出する。
# 浮動小数点、実対数、極限は使わない。有限和の等式を記号的に簡約する。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

normalization_count = ZZ(0)
for beta in positive_inverse_temperatures():
    for energy_row in finite_energy_rows():
        partition_sum = row_partition_sum(beta, energy_row)
        assert bool(partition_sum > 0)

        normalized_sum = sum(gibbs_row(beta, energy_row))
        assert normalized_sum - partition_sum / partition_sum == 0
        assert partition_sum / partition_sum - 1 == 0
        assert normalized_sum - 1 == 0
        normalization_count += 1

assert normalization_count == ZZ(75)
print('finite Gibbs rows normalized symbolically:', normalization_count)
print('RESULT: PASS')
