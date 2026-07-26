# ---------------------------------------------------------
# <tensor_anticommutation_from_single_site> の仮定を崩したときに結論が破れることの確認。
#
# 本文の仮定は「反可換なサイトがちょうど 1 つ」である。これを崩すと:
#   - 反可換なサイトが 2 つ（偶数個）: 符号が (-1)^2 = +1 になり、YX = +XY。
#     したがって [X,Y]_+ = 2XY となり、一般に 0 ではない（反交換しない）。
#   - 反可換なサイトが 0 個: YX = XY で、やはり [X,Y]_+ = 2XY != 0。
#   - 反可換なサイトが 3 つ（奇数個）: 符号は -1 に戻り [X,Y]_+ = 0 となる。
#     すなわち本文の仮定「ちょうど 1 つ」は十分条件であって必要条件ではない。
#     この点も併せて数値で示す（本文の主張は破れない）。
#
# 「破れる条件を見つける」ことがこの check の目的なので、
# 2 サイト・0 サイトのケースでは [X,Y]_+ が 0 から**十分離れている**ことを要求する。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))
load(os.path.join(_dir, '_prelude.sage'))

import numpy as np

rep = CheckReport("<tensor_anticommutation_from_single_site>: 仮定を崩すと結論が破れる")

rng = np.random.RandomState(31415926)


def build(M, anti_sites, rng):
    xs, ys = [], []
    for i in range(1, M + 1):
        if i in anti_sites:
            a, b = rand_anticommuting_pair(rng)
        else:
            a, b = rand_commuting_pair(rng)
        xs.append(a)
        ys.append(b)
    return kron_list(xs), kron_list(ys)


for M in [2, 3, 4, 5]:
    # (i) 反可換サイトが 2 つ -> 結論は破れる
    for t in range(5):
        X, Y = build(M, {1, 2}, rng)
        ac = acomm(X, Y)
        scale = max(1.0, float(np.max(np.abs(X @ Y))))
        rel = float(np.max(np.abs(ac))) / scale
        rep.truth(rel > 1e-3,
                  "M=%d 反可換 2 サイト #%d: [X,Y]_+ != 0（相対 %.3e）" % (M, t, rel))
        # 実際には YX = +XY なので [X,Y]_+ = 2XY になっているはず
        rep.close(ac, 2.0 * (X @ Y),
                  "M=%d 反可換 2 サイト #%d: [X,Y]_+ = 2XY" % (M, t))

    # (ii) 反可換サイトが 0 -> 結論は破れる
    for t in range(5):
        X, Y = build(M, set(), rng)
        ac = acomm(X, Y)
        scale = max(1.0, float(np.max(np.abs(X @ Y))))
        rel = float(np.max(np.abs(ac))) / scale
        rep.truth(rel > 1e-3,
                  "M=%d 反可換 0 サイト #%d: [X,Y]_+ != 0（相対 %.3e）" % (M, t, rel))

    # (iii) 反可換サイトが 3 つ（M >= 3）-> 奇数個なので結論は保たれる
    if M >= 3:
        for t in range(5):
            X, Y = build(M, {1, 2, 3}, rng)
            rep.close(acomm(X, Y), np.zeros((2 ** M, 2 ** M), dtype=complex),
                      "M=%d 反可換 3 サイト #%d: [X,Y]_+ = 0（奇数個なら成立）" % (M, t))

rep.finish()
