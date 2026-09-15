# 対象ラベル: claim_finite_gibbs_transition_weight_strictly_positive
# 併せて検証: def_finite_real_row_partition_sum、def_finite_gibbs_transition_weight
# 式ペア: exp_R(-beta E(x,y)) > 0、従って有限行分配和 Z_{beta,E}(x) > 0 と Gibbs 重み > 0。
# 帰属: ZZ、QQ、記号的な実指数値。実指数関数の使用箇所で RR へ脱出する。
# 浮動小数点、実対数、極限は使わない。指数式の正値性を記号計算で判定する。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

row_count = ZZ(0)
weight_count = ZZ(0)
for beta in positive_inverse_temperatures():
    assert beta > 0
    for energy_row in finite_energy_rows():
        weights = tuple(exponential_weight(beta, energy) for energy in energy_row)
        for weight in weights:
            assert bool(weight > 0)
            weight_count += 1

        partition_sum = sum(weights)
        assert partition_sum == row_partition_sum(beta, energy_row)
        assert bool(partition_sum > 0)

        normalized_row = gibbs_row(beta, energy_row)
        for normalized_weight in normalized_row:
            assert bool(normalized_weight > 0)
        row_count += 1

assert row_count == ZZ(75)
assert weight_count == ZZ(150)
print('finite energy rows checked:', row_count)
print('positive exponential weights checked:', weight_count)
print('RESULT: PASS')
