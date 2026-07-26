# commutator_of_H_and_Z_Y: H_1^{(±)}, H_2 と hatZ^{(±)}_mu, hatY_mu の交換関係（6 式）
#
#   [H_1^{(±)}, hatZ^{(±)}_mu] = 2 e^{-i2πμ/M} hatY_mu
#   [H_1^{(±)}, hatZ^{(∓)}_mu] = 2 e^{-i2πμ/M} hatY_mu
#   [H_1^{(±)}, hatY_mu]       = -2 e^{ i2πμ/M} hatZ^{(±)}_mu
#   [H_2,       hatZ^{(-)}_mu] = -2 hatY_mu
#   [H_2,       hatZ^{(+)}_mu] = -2 hatY_mu + (1/M) Σ_j ( -2 e^{-i(2π/M)(-j+μ)} hatY_j )
#   [H_2,       hatY_mu]       =  2 hatZ^{(-)}_mu
#
# 独立経路:
#   左辺: H1_op / H2_op（Z_m Y_m の積和として実空間で構成）と hatZ_op / hatY_op の行列積で
#         交換子を直接計算する
#   右辺: 本文の閉じた表示（hat のみで書かれる）
# 本文の証明は反交換関係を経由するが、ここでは行列積を素朴に評価するだけなので経路が独立である。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))

rep = CheckReport("commutator_of_H_and_Z_Y: 6 つの交換関係")

M_LIST = [2, 3, 4, 5]


def flip(s):
    return '-' if s == '+' else '+'


for M in M_LIST:
    Mi = int(M)
    calM = [m for m in range(-Mi, Mi + 1) if m != 0]
    for mu in calM:
        th = 2 * _np.pi * float(mu) / float(Mi)
        hY = hatY_op(mu, M)

        for sign in ['+', '-']:
            H1 = H1_op(M, sign)
            # (1) [H_1^{(±)}, hatZ^{(±)}]
            rep.close(comm(H1, hatZ_op(mu, M, sign)),
                      2.0 * _np.exp(-1j * th) * hY,
                      "M=%d sign=%s mu=%+d: [H_1^{(±)}, hatZ^{(±)}]" % (M, sign, mu))
            # (2) [H_1^{(±)}, hatZ^{(∓)}]
            rep.close(comm(H1, hatZ_op(mu, M, flip(sign))),
                      2.0 * _np.exp(-1j * th) * hY,
                      "M=%d sign=%s mu=%+d: [H_1^{(±)}, hatZ^{(∓)}]" % (M, sign, mu))
            # (3) [H_1^{(±)}, hatY]
            rep.close(comm(H1, hY),
                      -2.0 * _np.exp(1j * th) * hatZ_op(mu, M, sign),
                      "M=%d sign=%s mu=%+d: [H_1^{(±)}, hatY]" % (M, sign, mu))

        H2 = H2_op(M)
        # (4) [H_2, hatZ^{(-)}]
        rep.close(comm(H2, hatZ_op(mu, M, '-')), -2.0 * hY,
                  "M=%d mu=%+d: [H_2, hatZ^{(-)}]" % (M, mu))
        # (5) [H_2, hatZ^{(+)}]（補正項つき）
        corr = _np.zeros((2 ** Mi, 2 ** Mi), dtype=complex)
        for j in range(1, Mi + 1):
            corr = corr + (-2.0) * _np.exp(-1j * (2 * _np.pi / float(Mi)) * float(-j + mu)) \
                * hatY_op(j, M)
        corr = corr / float(Mi)
        rep.close(comm(H2, hatZ_op(mu, M, '+')), -2.0 * hY + corr,
                  "M=%d mu=%+d: [H_2, hatZ^{(+)}]（第 2 項込み）" % (M, mu))
        # (6) [H_2, hatY]
        rep.close(comm(H2, hY), 2.0 * hatZ_op(mu, M, '-'),
                  "M=%d mu=%+d: [H_2, hatY]" % (M, mu))

rep.finish()
