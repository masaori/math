# commutator_of_H_and_Z_Y（反例探し）:
# 本文が [H_2, hatZ^{(+)}_mu] にだけ補正項を付けている理由を数値的に確定させる。
#
#   補正項なしの式  [H_2, hatZ^{(+)}_mu] = -2 hatY_mu  は破れるはずである。
#   また、補正項の中身（係数 -2、位相 e^{-i(2π/M)(-j+μ)}、hatY_j の添字 j、前因子 1/M）を
#   1 つずつ壊した変種も破れるはずである。
#
# さらに、この補正項が hatZ^{(-)} 側には現れない（= 補正項を足すと逆に破れる）ことも確認する。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))

rep = CheckReport("commutator_of_H_and_Z_Y: [H_2, hatZ^{(+)}] の補正項が必要かつ一意であること")

M_LIST = [2, 3, 4, 5]

for M in M_LIST:
    Mi = int(M)
    calM = [m for m in range(-Mi, Mi + 1) if m != 0]
    H2 = H2_op(M)
    for mu in calM:
        hY = hatY_op(mu, M)
        lhs = comm(H2, hatZ_op(mu, M, '+'))

        # (a) 補正項なしでは破れる
        r = float(_np.max(_np.abs(lhs - (-2.0 * hY))))
        rep.truth(r > 1e-6,
                  "M=%d mu=%+d: 補正項なしの [H_2,hatZ^{(+)}] = -2hatY は破れる（残差 %.3f）"
                  % (M, mu, r))

        # (b) 補正項の変種が破れる
        def corr_of(coef, psign, use_mu_index, prefac):
            out = _np.zeros((2 ** Mi, 2 ** Mi), dtype=complex)
            for j in range(1, Mi + 1):
                ph = _np.exp(psign * 1j * (2 * _np.pi / float(Mi)) * float(-j + mu))
                hj = hY if use_mu_index else hatY_op(j, M)
                out = out + coef * ph * hj
            return out * prefac

        true_corr = corr_of(-2.0, -1.0, False, 1.0 / float(Mi))
        rep.close(lhs, -2.0 * hY + true_corr,
                  "M=%d mu=%+d: 本文の補正項で一致" % (M, mu))

        VARIANTS = [
            ("係数を +2 にする", corr_of(+2.0, -1.0, False, 1.0 / float(Mi))),
            ("位相の符号を反転", corr_of(-2.0, +1.0, False, 1.0 / float(Mi))),
            ("hatY_j を hatY_mu にする", corr_of(-2.0, -1.0, True, 1.0 / float(Mi))),
            ("前因子 1/M を落とす", corr_of(-2.0, -1.0, False, 1.0)),
        ]
        for (name, c) in VARIANTS:
            if float(_np.max(_np.abs(c - true_corr))) < 1e-12:
                continue   # この (M,mu) では変種が本文と一致し判定不能
            r = float(_np.max(_np.abs(lhs - (-2.0 * hY + c))))
            rep.truth(r > 1e-6,
                      "M=%d mu=%+d 変種「%s」は破れる（残差 %.3f）" % (M, mu, name, r))

        # (c) hatZ^{(-)} 側に同じ補正項を足すと破れる
        r = float(_np.max(_np.abs(comm(H2, hatZ_op(mu, M, '-')) - (-2.0 * hY + true_corr))))
        rep.truth(r > 1e-6,
                  "M=%d mu=%+d: hatZ^{(-)} 側に補正項を足すと破れる（残差 %.3f）" % (M, mu, r))

rep.finish()
