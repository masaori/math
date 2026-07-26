# recover_Z_Y_from_hatZ_hatY（本文が hatZ^{(-)} に限定している理由の確認）:
# hatZ^{(+)} では同じ形の逆変換が成り立たない。j=1 の重みが -1 なので
#   Σ_{mu=1}^{M} hatZ^{(+)}_mu e^{i m 2πμ/M} = M w_m Z_m,   w_1 = -1, w_{m≠1} = +1
# となり、m = 1 のときだけ符号が反転する。
#
# 反例探しとして「m=1 でどれだけずれるか」を定量化し、m>=2 では一致することも示す。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))

rep = CheckReport("recover_Z_Y: hatZ^{(+)} では逆変換が成り立たない（m=1 で符号反転）")

M_LIST = [2, 3, 4, 5]

for M in M_LIST:
    Mi = int(M)
    for m in range(1, Mi + 1):
        s = _np.zeros((2 ** Mi, 2 ** Mi), dtype=complex)
        for mu in range(1, Mi + 1):
            s = s + hatZ_op(mu, M, '+') * _np.exp(1j * float(m) * 2 * _np.pi * float(mu) / float(Mi))

        w = -1.0 if m == 1 else +1.0
        # (a) 実際に成り立つ形（重み込み）
        rep.close(s, float(Mi) * w * Zop(m, M),
                  "M=%d m=%d: Σ_μ hatZ^{(+)}_μ e^{imθ_μ} = M w_m Z_m" % (M, m))

        # (b) 本文と同じ形（= M Z_m）が m=1 で破れることを、残差の大きさで示す
        resid = float(_np.max(_np.abs(s - float(Mi) * Zop(m, M))))
        if m == 1:
            rep.truth(resid > 1.0,
                      "M=%d m=1: hatZ^{(+)} 版の逆変換は破れる（残差 %.3f = 2M）" % (M, resid))
            rep.close(resid, 2.0 * float(Mi), "M=%d m=1: 残差の大きさが 2M" % M)
        else:
            rep.truth(resid < 1e-9,
                      "M=%d m=%d: m≠1 では hatZ^{(+)} でも一致（残差 %.3e）" % (M, m, resid))

    # 正しい復元公式（hatZ^{(+)} 用に符号を入れた版）が全 m で成り立つこと
    for m in range(1, Mi + 1):
        s = _np.zeros((2 ** Mi, 2 ** Mi), dtype=complex)
        for mu in range(1, Mi + 1):
            s = s + hatZ_op(mu, M, '+') * _np.exp(1j * float(m) * 2 * _np.pi * float(mu) / float(Mi))
        w = -1.0 if m == 1 else +1.0
        rep.close(Zop(m, M), s / (float(Mi) * w),
                  "M=%d m=%d: 重みを補正すれば復元できる" % (M, m))

rep.finish()
