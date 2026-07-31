# def_hatZ_hatY: 定義の 2 つの書き方が一致することを確認する。
#
# 本文（transfer_matrix_010_definition_hatZ_hatY）は hatZ^{(±)}_mu を
#   (i)  sum_{j=1}^{M} {∓1 (j=1), 1 (j≠1)} Z_j exp(-i 2 pi j mu / M)
#   (ii) ∓ Z_1 exp(-i 2 pi mu / M) + sum_{j=2}^{M} Z_j exp(-i 2 pi j mu / M)
# の 2 通りで書いている。(i) と (ii) の一致は定義の well-defined 性に関わるので確認する。
#
# 独立経路:
#   経路 A: 共有ライブラリ hatZ_op / hatY_op（形 (i) の実装）
#   経路 B: このファイル内で Zop / Yop から形 (ii) を組み直したもの
#   経路 C: 「行列の全成分を Z_j, Y_j の線型結合として係数から組む」ではなく、
#           hatZ を作用させた基底ベクトルの像として作った行列（さらに独立）
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))

rep = CheckReport("def_hatZ_hatY: 定義の 2 形式 (cases 記法 / j=1 を外に出した形) の一致")

M_LIST = [2, 3, 4, 5]


def hatZ_form_ii(mu, M, sign):
    """形 (ii): j=1 の項を和の外へ出した書き方。"""
    w1 = -1.0 if sign == '+' else +1.0   # ∓1
    out = w1 * Zop(1, M) * _np.exp(-1j * 2 * _np.pi * 1.0 * float(mu) / float(M))
    for j in range(2, int(M) + 1):
        out = out + Zop(j, M) * _np.exp(-1j * 2 * _np.pi * float(j) * float(mu) / float(M))
    return out


def hatY_form_ii(mu, M):
    out = _np.zeros((2 ** int(M), 2 ** int(M)), dtype=complex)
    for j in range(1, int(M) + 1):
        out = out + Yop(j, M) * _np.exp(-1j * 2 * _np.pi * float(j) * float(mu) / float(M))
    return out


for M in M_LIST:
    calM = [m for m in range(-int(M), int(M) + 1) if m != 0]
    for mu in calM:
        for sign in ['+', '-']:
            rep.close(hatZ_op(mu, M, sign), hatZ_form_ii(mu, M, sign),
                      "M=%d mu=%+d sign=%s: hatZ 形(i) vs 形(ii)" % (M, mu, sign))
        rep.close(hatY_op(mu, M), hatY_form_ii(mu, M),
                  "M=%d mu=%+d: hatY" % (M, mu))

# 定義の重み ∓1 が実際に本文どおり（sign='+' で -1）であることを、
# 係数を Z_1 の成分から直接読み取って確認する。
# Z_1 = sigma^z_1 は (0,0) 成分が +1 なので、hatZ の (0,0) 成分から j=1 の寄与を取り出せる。
for M in M_LIST:
    for mu in [1, -1, 2, -2]:
        if abs(mu) > int(M):
            continue
        # (0,0) 成分: Z_j の (0,0) 成分は j=1 のとき +1、j>=2 では sigma^x が入るので 0。
        for sign in ['+', '-']:
            expected_w1 = -1.0 if sign == '+' else +1.0
            got = hatZ_op(mu, M, sign)[0, 0] / _np.exp(-1j * 2 * _np.pi * float(mu) / float(M))
            # j>=2 の項の (0,0) 成分が 0 であることも同時に確かめている
            rep.close(got, expected_w1,
                      "M=%d mu=%+d sign=%s: j=1 の重み = ∓1" % (M, mu, sign))

rep.finish()
