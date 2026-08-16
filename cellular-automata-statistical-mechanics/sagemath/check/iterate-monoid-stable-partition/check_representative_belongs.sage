# 対象ラベル: claim_iterate_monoid_stable_representative_belongs_to_fiber
# 各 q ∈ Q_F について、E_F(q) = q（claim_iterate_monoid_cycle_idempotent_retracts_stable_image）から
# 定義どおり q ∈ B_F(q) となることを確かめる。
# 帰属: 有限集合の写像の等号だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
points = 0
for stage_size, rule, table in exhaustive_instances():
    mu, lam, e, E, Q, fibers = stable_partition_data(table)
    for q in Q:
        assert E[q] == q                             # claim_iterate_monoid_cycle_idempotent_retracts_stable_image
        assert q in fibers[q]                        # def_iterate_monoid_stable_fiber
        assert len(fibers[q]) >= 1                   # |B_F(q)| ∈ N_{>0}
        points += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("stable image points checked: {}".format(points))
print("RESULT: PASS")
