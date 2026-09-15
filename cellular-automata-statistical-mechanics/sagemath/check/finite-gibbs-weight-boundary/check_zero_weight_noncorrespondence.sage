# 対象ラベル: claim_rational_transition_weight_not_always_finite_gibbs
# 併せて検証: def_single_cell_identity_rational_transition_weight、claim_finite_gibbs_transition_weight_strictly_positive
# 式ペア: iota_Q,R(K_id(x_0,x_1)) = 0 != G_{beta,E}(x_0,x_1)。
# 帰属: QQ、実代数的数体 AA、記号的な実指数値。Gibbs 重みとの比較で RR へ脱出する。
# 浮動小数点、実対数、極限は使わない。有限範囲のエネルギーについて記号的に不等号を判定する。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

rational_zero_image = AA(QQ(0))
assert rational_zero_image == AA(0)

counterexample_count = ZZ(0)
for beta in positive_inverse_temperatures():
    for energy_row in finite_energy_rows():
        off_diagonal_gibbs_weight = gibbs_row(beta, energy_row)[1]
        assert bool(off_diagonal_gibbs_weight > 0)
        assert off_diagonal_gibbs_weight != 0
        assert rational_zero_image != off_diagonal_gibbs_weight
        counterexample_count += 1

assert counterexample_count == ZZ(75)
print('zero-versus-positive Gibbs comparisons checked:', counterexample_count)
print('RESULT: PASS')
