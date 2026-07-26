# exp_sum: sum_{j=1}^{M} exp(2 pi i j k / M) = M delta^M_{(k,0)}
#
# 独立経路:
#   経路 A（素朴）: j=1..M の複素指数を 1 つずつ足し上げる（定義そのもの）
#   経路 B（閉じた表示）: M * delta^M_{(k,0)}
# 両者を M = 2..8、k = -3M..3M（0 を含む）で突き合わせる。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))

rep = CheckReport("exp_sum: 素朴な有限和 vs M*delta^M_{(k,0)}")

M_LIST = [2, 3, 4, 5, 6, 7, 8]


def exp_sum_naive(k, M):
    """定義どおり j=1..M を 1 項ずつ足す。"""
    tot = 0.0 + 0.0j
    for j in range(1, int(M) + 1):
        tot += _np.exp(1j * 2 * _np.pi * float(j) * float(k) / float(M))
    return tot


n_zero = 0
n_nonzero = 0
for M in M_LIST:
    for k in range(-3 * int(M), 3 * int(M) + 1):
        lhs = exp_sum_naive(k, M)
        rhs = float(M) * delta_M(k, 0, M)
        rep.close(lhs, rhs, "M=%d k=%d" % (M, k))
        if (k % int(M)) == 0:
            n_zero += 1
        else:
            n_nonzero += 1

print("  k が M の倍数の場合: %d 件、そうでない場合: %d 件" % (n_zero, n_nonzero))

# 反例探し: k が M の倍数でないのに和が 0 にならないケースが無いか、
# 絶対値の最大を明示的に見る（相対誤差だけだと見落としうるため）。
worst = 0.0
worst_at = None
for M in M_LIST:
    for k in range(-3 * int(M), 3 * int(M) + 1):
        if (k % int(M)) == 0:
            continue
        v = abs(exp_sum_naive(k, M))
        if v > worst:
            worst = v
            worst_at = (M, k)
print("  k 非倍数のときの |和| の最大: %.3e at (M,k)=%s" % (worst, worst_at))
rep.truth(worst < 1e-9, "k が M の倍数でないとき和は 0（|和|最大 %.3e）" % worst)

rep.finish()
