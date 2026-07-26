# H1_H2_via_hatZ_hatY（反例探し）:
# 本文の表式は符号・順序・位相因子のどれを取り替えても壊れるはずである。
# 「たまたま何を入れても通る式」でないことを確かめるために、次の変種が破れることを示す。
#
#   (a) H_2 の hatZ^{(-)} を hatZ^{(+)} に取り替える
#   (b) H_2 の積の順序を入れ替える（hatY_j hatZ^{(-)}_{-j}）
#   (c) H_1 の位相因子 exp(-i2πj/M) を落とす
#   (d) H_1 の hatZ の添字 -j を +j にする
#   (e) H_1 で異なる符号を混ぜる（hatZ^{(∓)} を使う）
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))

rep = CheckReport("H1_H2_via_hatZ_hatY: 変種が破れること（式の一意性の確認）")

M_LIST = [2, 3, 4, 5]


def flip(sign):
    return '-' if sign == '+' else '+'


for M in M_LIST:
    Mi = int(M)
    n = 2 ** Mi

    def big_resid(A, B):
        return float(_np.max(_np.abs(A - B)))

    # (a) H_2 で hatZ^{(+)} を使う
    v = _np.zeros((n, n), dtype=complex)
    for j in range(1, Mi + 1):
        v = v + hatZ_op(-j, M, '+') @ hatY_op(j, M)
    v = v / float(Mi)
    r = big_resid(v, H2_op(M))
    rep.truth(r > 1e-6, "M=%d (a) H_2 に hatZ^{(+)} を使うと破れる（残差 %.3f）" % (M, r))

    # (b) H_2 の積の順序を入れ替える
    v = _np.zeros((n, n), dtype=complex)
    for j in range(1, Mi + 1):
        v = v + hatY_op(j, M) @ hatZ_op(-j, M, '-')
    v = v / float(Mi)
    r = big_resid(v, H2_op(M))
    rep.truth(r > 1e-6, "M=%d (b) H_2 の積の順序を入れ替えると破れる（残差 %.3f）" % (M, r))

    for sign in ['+', '-']:
        # (c) H_1 の位相因子を落とす
        v = _np.zeros((n, n), dtype=complex)
        for j in range(1, Mi + 1):
            v = v + hatY_op(j, M) @ hatZ_op(-j, M, sign)
        v = v / float(Mi)
        r = big_resid(v, H1_op(M, sign))
        rep.truth(r > 1e-6,
                  "M=%d sign=%s (c) 位相因子を落とすと破れる（残差 %.3f）" % (M, sign, r))

        # (d) hatZ の添字 -j を +j にする
        # ただし M=2 では全ての j について -j ≡ +j (mod 2) なので hat の M 周期性により
        # 変種と原式が恒等的に一致する。区別できないので M>=3 でのみ判定する。
        if Mi >= 3:
            v = _np.zeros((n, n), dtype=complex)
            for j in range(1, Mi + 1):
                v = v + (hatY_op(j, M) @ hatZ_op(j, M, sign)) \
                    * _np.exp(-1j * 2 * _np.pi * float(j) / float(Mi))
            v = v / float(Mi)
            r = big_resid(v, H1_op(M, sign))
            rep.truth(r > 1e-6,
                      "M=%d sign=%s (d) hatZ の添字を +j にすると破れる（残差 %.3f）" % (M, sign, r))
        else:
            print("  [skip] M=2 sign=%s (d): -j ≡ +j (mod 2) のため変種と原式が一致し判定不能" % sign)

        # (e) 符号を混ぜる（hatZ^{(∓)}）
        v = _np.zeros((n, n), dtype=complex)
        for j in range(1, Mi + 1):
            v = v + (hatY_op(j, M) @ hatZ_op(-j, M, flip(sign))) \
                * _np.exp(-1j * 2 * _np.pi * float(j) / float(Mi))
        v = v / float(Mi)
        r = big_resid(v, H1_op(M, sign))
        rep.truth(r > 1e-6,
                  "M=%d sign=%s (e) hatZ^{(∓)} を混ぜると破れる（残差 %.3f）" % (M, sign, r))

rep.finish()
