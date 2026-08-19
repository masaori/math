# 対象ラベル: claim_iterate_monoid_conjugacy_transports_stable_fibers
# 併せて claim_iterate_monoid_conjugacy_transports_stable_image を検査する。
# h(Q_F)=Q_G、制限の全単射性（個数一致）、各 q∈Q_F で h(B_F(q))=B_G(h(q)) を確かめる。
# 帰属: 有限集合の像・等号・個数だけを使う。R/C 脱出なし。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

pairs = 0
fiber_checks = 0
for stage_size, rule, table, h, g_table in conjugate_instances():
    _, _, _, _, _, _, _, Q_f, fibers_f, _ = rooted_tree_data(table)
    _, _, _, _, _, _, _, Q_g, fibers_g, _ = rooted_tree_data(g_table)
    image_Q = frozenset(h[q] for q in Q_f)
    assert image_Q == Q_g
    assert len(Q_f) == len(image_Q)
    for q in Q_f:
        image_fiber = frozenset(h[y] for y in fibers_f[q])
        assert image_fiber == fibers_g[h[q]]
        assert len(fibers_f[q]) == len(image_fiber)
        fiber_checks += 1
    pairs += 1

print("conjugate pairs checked: {}".format(pairs))
print("stable fibers checked: {}".format(fiber_checks))
print("RESULT: PASS")
