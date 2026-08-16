# 対象ラベル: claim_iterate_monoid_distinct_stable_fibers_disjoint
# q ≠ r ∈ Q_F の全ての組について、B_F(q) ∩ B_F(r) = ∅ を確かめる。
# 共通元 y があれば claim_iterate_monoid_stable_fiber_unique_representative により q = r となり矛盾する
# ことを、共通元が一つも無いことの直接検査で裏取りする。
# 帰属: 有限集合の交わりの空判定だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
distinct_pairs = 0
for stage_size, rule, table in exhaustive_instances():
    mu, lam, e, E, Q, fibers = stable_partition_data(table)
    for q in Q:
        for r in Q:
            if q != r:
                assert len(fibers[q] & fibers[r]) == 0   # B_F(q) ∩ B_F(r) = ∅
                for y in fibers[q]:
                    assert E[y] == q and E[y] != r      # 共通元があれば q = E_F(y) = r となる
                distinct_pairs += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("distinct pairs (q, r) checked: {}".format(distinct_pairs))
print("RESULT: PASS")
