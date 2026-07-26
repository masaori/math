# recover_Z_Y_from_hatZ_hatY: 逆変換
#   sum_{mu=1}^{M} hatY_mu exp(i m 2 pi mu / M) = M Y_m
#   sum_{mu=1}^{M} hatZ^{(-)}_mu exp(i m 2 pi mu / M) = M Z_m
#   ゆえに Y_m = (1/M) sum ...,  Z_m = (1/M) sum ...
#
# 独立経路:
#   左辺: hatZ_op / hatY_op（Fourier 側）を mu について足し上げる
#   右辺: Zop / Yop（実空間側）を直接構成する
# 両者は別の作り方なので、一致は非自明である。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))

rep = CheckReport("recover_Z_Y_from_hatZ_hatY: hat から Z, Y の復元")

M_LIST = [2, 3, 4, 5]

for M in M_LIST:
    Mi = int(M)
    for m in range(1, Mi + 1):
        sY = _np.zeros((2 ** Mi, 2 ** Mi), dtype=complex)
        sZ = _np.zeros((2 ** Mi, 2 ** Mi), dtype=complex)
        for mu in range(1, Mi + 1):
            ph = _np.exp(1j * float(m) * 2 * _np.pi * float(mu) / float(Mi))
            sY = sY + hatY_op(mu, M) * ph
            sZ = sZ + hatZ_op(mu, M, '-') * ph
        rep.close(sY, float(Mi) * Yop(m, M), "M=%d m=%d: Σ_μ hatY_μ e^{imθ_μ} = M Y_m" % (M, m))
        rep.close(sZ, float(Mi) * Zop(m, M), "M=%d m=%d: Σ_μ hatZ^{(-)}_μ e^{imθ_μ} = M Z_m" % (M, m))
        rep.close(sY / float(Mi), Yop(m, M), "M=%d m=%d: Y_m = (1/M) Σ_μ ..." % (M, m))
        rep.close(sZ / float(Mi), Zop(m, M), "M=%d m=%d: Z_m = (1/M) Σ_μ ..." % (M, m))

    # 証明が使う直交性 (∗): Σ_{mu=1}^{M} exp((m-j) 2πiμ/M) = M (j=m), 0 (j≠m)
    for m in range(1, Mi + 1):
        for j in range(1, Mi + 1):
            s = sum(_np.exp(1j * float(m - j) * 2 * _np.pi * float(mu) / float(Mi))
                    for mu in range(1, Mi + 1))
            rep.close(s, float(Mi) if j == m else 0.0,
                      "M=%d m=%d j=%d: 直交性 (∗)" % (M, m, j))

    # hatZ^{(-)} の重みが全 j で +1 であること（statement の前置き）
    for mu in [1, -1, Mi, -Mi]:
        naive = _np.zeros((2 ** Mi, 2 ** Mi), dtype=complex)
        for j in range(1, Mi + 1):
            naive = naive + Zop(j, M) * _np.exp(-1j * float(j) * 2 * _np.pi * float(mu) / float(Mi))
        rep.close(hatZ_op(mu, M, '-'), naive,
                  "M=%d mu=%+d: hatZ^{(-)} は全 j で重み +1" % (M, mu))

rep.finish()
