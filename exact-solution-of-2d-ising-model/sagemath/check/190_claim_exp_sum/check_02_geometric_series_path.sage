# exp_sum の proof (b) が使う等比数列の和の公式そのものを独立に検証する。
#   r := exp(2 pi i k / M) != 1 のとき  sum_{j=1}^{M} r^j = r (1 - r^M) / (1 - r) = 0
#
# 経路 A: r^j を 1 項ずつ足す（べき乗として計算。check_01 の exp(...) 直接評価とは別の計算経路）
# 経路 B: 等比級数の閉じた表示 r (1 - r^M) / (1 - r)
# 経路 C: 0
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))

rep = CheckReport("exp_sum proof(b): 等比数列の和の公式と 0 への一致")

M_LIST = [2, 3, 4, 5, 6, 7, 8]

for M in M_LIST:
    for k in range(-3 * int(M), 3 * int(M) + 1):
        r = _np.exp(1j * 2 * _np.pi * float(k) / float(M))
        # 経路 A: 累乗和
        powsum = 0.0 + 0.0j
        p = 1.0 + 0.0j
        for _ in range(int(M)):
            p = p * r
            powsum += p
        if (k % int(M)) == 0:
            # r = 1 なので公式は使えない。和は M になる。
            rep.close(powsum, float(M), "M=%d k=%d (r=1, 和=M)" % (M, k))
            rep.truth(abs(r - 1.0) < 1e-12, "M=%d k=%d で r=1" % (M, k))
        else:
            rep.truth(abs(r - 1.0) > 1e-12, "M=%d k=%d で r!=1（公式の適用条件）" % (M, k))
            # 経路 B: 閉じた表示
            closed = r * (1.0 - r ** int(M)) / (1.0 - r)
            rep.close(powsum, closed, "M=%d k=%d 累乗和 vs 等比公式" % (M, k))
            rep.close(closed, 0.0, "M=%d k=%d 等比公式の値が 0" % (M, k))

rep.finish()
