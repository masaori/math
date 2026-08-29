# 対象ラベル: claim_iterate_monoid_stable_fiber_branching_finite_decidability
# 前章の走査で得た Q_F、B_F(q)、σ_F から、A^V×A^V の全組 (y,z) で F(y)=z を検査して
# 全ての Pre_F(z) と b_F(z) を得、各 B_F(σ_F(q)) 上で有限加算した総和が定義どおりの値に一致することを確かめる。
# 帰属: 有限集合の走査、配位番号の等号、非負整数の加算だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
comparisons = 0
additions = 0
for stage_size, rule, table in exhaustive_instances():
    F, E, Q, fibers, sigma, pre, d = branching_data(table)
    n = len(F)
    # 全組 (y, z) の走査で一段前像集合と一段前像数を得る
    pre_scan = {z: [] for z in range(n)}
    for y in range(n):
        for z in range(n):
            comparisons += 1
            if F[y] == z:
                pre_scan[z].append(y)
    d_scan = {}
    for z in range(n):
        assert frozenset(pre_scan[z]) == pre[z]
        d_scan[z] = len(pre_scan[z])
        assert d_scan[z] == d[z]
    # 各 q で B_F(σ_F(q)) 上の有限加算
    for q in Q:
        total = 0
        for z in fibers[sigma[q]]:
            total = total + d_scan[z]
            additions += 1
        assert total == sum(d[z] for z in fibers[sigma[q]])
        assert total == len(fibers[q])                        # 保存式との一致
    instances += 1

print("global maps checked: {}".format(instances))
print("configuration comparisons: {}".format(comparisons))
print("additions performed: {}".format(additions))
print("RESULT: PASS")
