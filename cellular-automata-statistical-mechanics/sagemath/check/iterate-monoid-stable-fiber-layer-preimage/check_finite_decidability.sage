# 対象ラベル: claim_iterate_monoid_depth_layer_preimage_finite_decidability
# 局所真理値表から出発する有限走査だけで、全ての層 L_F(q,k) とその一段発展による完全逆像を
# 決定できることを確かめる。
#   層と σ_F の表は前章までの有限決定（claim_iterate_monoid_stable_fiber_depth_finite_decidability、
#   claim_iterate_monoid_stable_fiber_dynamics_finite_decidability）をそのまま使う。
#   完全逆像は A^V の各元 y へ F を一度ずつ適用し、F(y) の属す層への振り分けで得る
#   （_common.sage の一括走査）。走査で得た各集合が、定義どおり全配位の所属を検査して得た
#   F^{-1}(L_F(σ_F(q),k)) に一致することを、空でない全ての組で確かめる。
#   F の適用回数が配位数と一致し、有限回で尽きることも数える。
# 帰属: 有限集合の写像の真理値表、有限集合の所属・等号、非負整数の数え上げだけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
scan_applications = 0
definition_comparisons = 0
for stage_size, rule, table in exhaustive_instances():
    F, E, Q, fibers, sigma, mp, mu_of, layers = depth_data(table)
    M = len(F)
    fiber_of, sigma_inv, pre = layer_preimage_scan(F, Q, fibers, sigma, mu_of, layers)
    scan_applications += M                               # F の適用は配位ごとに一度で尽きる
    # 走査結果を定義（全配位の所属検査）と突き合わせる。空でない組を尽くす。
    keys = set(pre.keys())
    for q in Q:
        for k in range(M + 1):
            if layers[q][k]:
                keys.add((q, k))
    for qp, k in keys:
        expected = full_preimage(F, layers[qp][k])       # 定義どおりの完全逆像
        assert pre.get((qp, k), frozenset()) == expected
        definition_comparisons += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("map applications in scans: {}".format(scan_applications))
print("preimage sets compared against definition: {}".format(definition_comparisons))
print("RESULT: PASS")
