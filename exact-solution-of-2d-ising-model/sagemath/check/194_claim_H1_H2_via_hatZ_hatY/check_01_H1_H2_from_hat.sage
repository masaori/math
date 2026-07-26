# H1_H2_via_hatZ_hatY:
#   H_1^{(±)} = (1/M) Σ_{j=1}^{M} hatY_j hatZ^{(±)}_{-j} exp(-i 2πj/M)
#   H_2       = (1/M) Σ_{j=1}^{M} hatZ^{(-)}_{-j} hatY_j
#
# 独立経路:
#   左辺（実空間側）: H1_op / H2_op = Y_m Z_{m+1} などの積和として直接構成
#   右辺（Fourier 側）: hatY_op / hatZ_op の積を j について足し上げる
# 2 つは全く別の作り方なので一致は非自明。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))

rep = CheckReport("H1_H2_via_hatZ_hatY: H_1^{(±)}, H_2 の hat による表示")

M_LIST = [2, 3, 4, 5]

for M in M_LIST:
    Mi = int(M)

    for sign in ['+', '-']:
        rhs = _np.zeros((2 ** Mi, 2 ** Mi), dtype=complex)
        for j in range(1, Mi + 1):
            rhs = rhs + (hatY_op(j, M) @ hatZ_op(-j, M, sign)) \
                * _np.exp(-1j * 2 * _np.pi * float(j) / float(Mi))
        rhs = rhs / float(Mi)
        rep.close(H1_op(M, sign), rhs, "M=%d sign=%s: H_1^{(±)} の hat 表示" % (M, sign))

    rhs2 = _np.zeros((2 ** Mi, 2 ** Mi), dtype=complex)
    for j in range(1, Mi + 1):
        rhs2 = rhs2 + (hatZ_op(-j, M, '-') @ hatY_op(j, M))
    rhs2 = rhs2 / float(Mi)
    rep.close(H2_op(M), rhs2, "M=%d: H_2 の hat 表示" % M)

    # 定義側の確認: H_1^{(±)} の最後の項の符号が ∓ であること
    #   H_1^{(±)} = Y_1Z_2 + … + Y_{M-1}Z_M ∓ Y_M Z_1
    for sign in ['+', '-']:
        expl = _np.zeros((2 ** Mi, 2 ** Mi), dtype=complex)
        for m in range(1, Mi):
            expl = expl + Yop(m, M) @ Zop(m + 1, M)
        expl = expl + (-1.0 if sign == '+' else +1.0) * (Yop(Mi, M) @ Zop(1, M))
        rep.close(H1_op(M, sign), expl, "M=%d sign=%s: H_1 の定義式" % (M, sign))
    expl2 = _np.zeros((2 ** Mi, 2 ** Mi), dtype=complex)
    for m in range(1, Mi + 1):
        expl2 = expl2 + Zop(m, M) @ Yop(m, M)
    rep.close(H2_op(M), expl2, "M=%d: H_2 の定義式" % M)

rep.finish()
