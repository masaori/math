# def_hatZ_hatY: hatZ^{(+)} と hatZ^{(-)} の差が j=1 の項の符号だけであることを明示的に確認する。
#
# 定義から従う帰結（本文が「j=1 の重みが ∓1」と述べていることの内容）:
#   hatZ^{(+)}_mu - hatZ^{(-)}_mu = (-1 - (+1)) Z_1 exp(-i 2 pi mu / M) = -2 Z_1 exp(-i 2 pi mu / M)
#   hatZ^{(+)}_mu + hatZ^{(-)}_mu = 2 sum_{j=2}^{M} Z_j exp(-i 2 pi j mu / M)
#
# 独立経路: 左辺は hatZ_op（ライブラリ）から、右辺は Zop から素朴に組む。
# さらに「差が j=1 の項だけ」を、j>=2 の各項が両者で完全一致することでも確かめる（同語反復回避）。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))

rep = CheckReport("def_hatZ_hatY: hatZ^{(+)} と hatZ^{(-)} の差は j=1 の項の符号のみ")

M_LIST = [2, 3, 4, 5]

for M in M_LIST:
    calM = [m for m in range(-int(M), int(M) + 1) if m != 0]
    for mu in calM:
        zp = hatZ_op(mu, M, '+')
        zm = hatZ_op(mu, M, '-')
        e1 = _np.exp(-1j * 2 * _np.pi * float(mu) / float(M))

        rep.close(zp - zm, -2.0 * Zop(1, M) * e1,
                  "M=%d mu=%+d: hatZ^{(+)} - hatZ^{(-)} = -2 Z_1 e^{-i2πμ/M}" % (M, mu))

        tail = _np.zeros((2 ** int(M), 2 ** int(M)), dtype=complex)
        for j in range(2, int(M) + 1):
            tail = tail + Zop(j, M) * _np.exp(-1j * 2 * _np.pi * float(j) * float(mu) / float(M))
        rep.close(zp + zm, 2.0 * tail,
                  "M=%d mu=%+d: hatZ^{(+)} + hatZ^{(-)} = 2 Σ_{j>=2}" % (M, mu))

        # j=1 の項を各々から取り除くと完全に一致する（＝差は j=1 の項に限る）
        rep.close(zp - (-1.0) * Zop(1, M) * e1, zm - (+1.0) * Zop(1, M) * e1,
                  "M=%d mu=%+d: j=1 の項を除くと両符号で一致" % (M, mu))

        # 反例探し: 差が本当に 0 でないこと（＝ (+) と (-) は別物であること）を確認する。
        # -2 Z_1 e^{...} は Z_1 が可逆（Z_1^2 = I）なのでノルムは 0 にならないはず。
        d = float(_np.max(_np.abs(zp - zm)))
        rep.truth(d > 1.0, "M=%d mu=%+d: hatZ^{(+)} != hatZ^{(-)}（最大成分差 %.3f）" % (M, mu, d))

rep.finish()
