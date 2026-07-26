# hatZ_hatY_M_periodicity: 本文が述べている特殊値
#   hatZ^{(-)}_M = hatZ^{(-)}_{-M},  hatY_M = hatY_{-M}
# を確認する。
#
# 同語反復を避けるため、両辺を「係数を hatZ_op に渡して作った行列」ではなく、
# Zop / Yop から独立に組み上げた 2 つの行列として構成して比べる。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))

rep = CheckReport("hatZ_hatY_M_periodicity: mu = ±M の特殊値")

M_LIST = [2, 3, 4, 5]


def build_hatZ(mu, M, sign):
    """定義から素朴に組む（ライブラリとは別実装）。"""
    w1 = -1.0 if sign == '+' else +1.0
    out = _np.zeros((2 ** int(M), 2 ** int(M)), dtype=complex)
    for j in range(1, int(M) + 1):
        w = w1 if j == 1 else 1.0
        out = out + w * Zop(j, M) * _np.exp(-1j * 2 * _np.pi * float(j) * float(mu) / float(M))
    return out


def build_hatY(mu, M):
    out = _np.zeros((2 ** int(M), 2 ** int(M)), dtype=complex)
    for j in range(1, int(M) + 1):
        out = out + Yop(j, M) * _np.exp(-1j * 2 * _np.pi * float(j) * float(mu) / float(M))
    return out


for M in M_LIST:
    rep.close(build_hatZ(int(M), M, '-'), build_hatZ(-int(M), M, '-'),
              "M=%d: hatZ^{(-)}_M = hatZ^{(-)}_{-M}" % M)
    rep.close(build_hatY(int(M), M), build_hatY(-int(M), M),
              "M=%d: hatY_M = hatY_{-M}" % M)
    # ライブラリ実装でも同じ結論になることを併せて確認（実装差による見落としを防ぐ）
    rep.close(hatZ_op(int(M), M, '-'), hatZ_op(-int(M), M, '-'),
              "M=%d: (ライブラリ) hatZ^{(-)}_M = hatZ^{(-)}_{-M}" % M)
    rep.close(hatY_op(int(M), M), hatY_op(-int(M), M),
              "M=%d: (ライブラリ) hatY_M = hatY_{-M}" % M)
    # 本文が述べていない (+) 側でも同じことが成り立つか（重み ∓1 は mu に依らないので成り立つはず）
    rep.close(build_hatZ(int(M), M, '+'), build_hatZ(-int(M), M, '+'),
              "M=%d: hatZ^{(+)}_M = hatZ^{(+)}_{-M}（本文外の確認）" % M)

    # 証明が使っている補題: exp(-i j 2πM/M) = 1 = exp(-i j 2π(-M)/M)
    for j in range(1, int(M) + 1):
        rep.close(_np.exp(-1j * float(j) * 2 * _np.pi * float(M) / float(M)), 1.0,
                  "M=%d j=%d: exp(-i j 2πM/M) = 1" % (M, j))
        rep.close(_np.exp(-1j * float(j) * 2 * _np.pi * float(-int(M)) / float(M)), 1.0,
                  "M=%d j=%d: exp(-i j 2π(-M)/M) = 1" % (M, j))

rep.finish()
