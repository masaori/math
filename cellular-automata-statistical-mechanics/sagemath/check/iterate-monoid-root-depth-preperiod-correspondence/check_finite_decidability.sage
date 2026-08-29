# 対象ラベル: claim_iterate_monoid_root_depth_preperiod_correspondence_finite_decidability
# μ(y)（最小前周期の有限走査）と λ_F から、d = 0, 1, 2, ... の順の自然数比較だけで
# r_F(y) を返す走査が有限回で停止し、返した値が定義どおりの r_F(y) と根付き木の深さ
# d_F(y) の両方に一致すること、返した値で全配位を分けた各深さの配位集合が
# 深さの定義で分けた集合に一致することを検査する。
# 帰属: 有限写像の反復適用、有限集合の等号、非負整数の乗算・大小比較だけを使う。R/C 脱出なし。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
comparisons = 0
points = 0
for stage_size, rule, table in exhaustive_instances():
    F, mu, lam, e, m, E, R, Q, fibers, mu_of = correspondence_data(table)
    scanned = {}
    for y in range(len(F)):
        mu_y = mu_of[y]
        value = None
        for d in range(m + 1):
            comparisons += 1
            if mu_y <= d * lam:
                value = d
                break
        assert value is not None
        assert value == rounded_preperiod(mu_y, lam, m)
        scanned[y] = value
        points += 1
    for q in Q:
        for y in fibers[q]:
            assert scanned[y] == tree_depth(F, lam, m, y, q)
    depths = sorted(set(scanned.values()))
    for d in depths:
        by_scan = frozenset(y for y in scanned if scanned[y] == d)
        by_depth = frozenset(
            y for q in Q for y in fibers[q] if tree_depth(F, lam, m, y, q) == d
        )
        assert by_scan == by_depth
    instances += 1

print("global maps checked: {}".format(instances))
print("configurations scanned: {}".format(points))
print("natural number comparisons in the scan: {}".format(comparisons))
print("RESULT: PASS")
