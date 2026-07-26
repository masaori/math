# hatZ_hatY_M_periodicity（本文の主張の一般化）:
# 本文は mu = ±M の特殊値だけを述べているが、定義から従うのは一般の M 周期性である。
#   任意の mu ∈ Z, s ∈ {+,-} について  hatZ^{(s)}_{mu+M} = hatZ^{(s)}_{mu},  hatY_{mu+M} = hatY_{mu}
#
# ここではさらに「周期が M より小さくないこと」（M が最小周期であること）も反例探しとして確認する。
# 1 <= d < M について hatY_{mu+d} != hatY_mu を確かめる。これが破れていれば
# 「M 周期性」という言い方が弱すぎる（もっと強い性質がある）ことになる。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))

rep = CheckReport("hatZ_hatY_M_periodicity: 一般の mu ∈ Z についての M 周期性と最小性")

M_LIST = [2, 3, 4, 5]

for M in M_LIST:
    Mi = int(M)
    # (1) 一般の mu についての M 周期性
    for mu in range(-3 * Mi, 3 * Mi + 1):
        for sign in ['+', '-']:
            rep.close(hatZ_op(mu + Mi, M, sign), hatZ_op(mu, M, sign),
                      "M=%d mu=%+d sign=%s: hatZ_{mu+M} = hatZ_mu" % (M, mu, sign))
        rep.close(hatY_op(mu + Mi, M), hatY_op(mu, M),
                  "M=%d mu=%+d: hatY_{mu+M} = hatY_mu" % (M, mu))

    # (2) 任意の整数 l 倍のシフトでも成り立つ
    for mu in [-Mi, -1, 1, Mi]:
        for l in [-3, -2, 2, 3]:
            rep.close(hatZ_op(mu + l * Mi, M, '-'), hatZ_op(mu, M, '-'),
                      "M=%d mu=%+d l=%+d: hatZ^{(-)}_{mu+lM} = hatZ^{(-)}_mu" % (M, mu, l))
            rep.close(hatY_op(mu + l * Mi, M), hatY_op(mu, M),
                      "M=%d mu=%+d l=%+d: hatY_{mu+lM} = hatY_mu" % (M, mu, l))

    # (3) 反例探し: 周期は M より真に小さくならない
    for mu in range(1, Mi + 1):
        for d in range(1, Mi):
            gap = float(_np.max(_np.abs(hatY_op(mu + d, M) - hatY_op(mu, M))))
            rep.truth(gap > 1e-6,
                      "M=%d mu=%d d=%d: hatY_{mu+d} != hatY_mu（最大成分差 %.3e）" % (M, mu, d, gap))

rep.finish()
