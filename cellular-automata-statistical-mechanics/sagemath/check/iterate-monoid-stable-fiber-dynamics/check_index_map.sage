# 対象ラベル: def_iterate_monoid_stable_fiber_index_map
# σ_F(q) := F(q) が Q_F の元を Q_F へ移し（定義が意味をもつ）、Q_F 上で全単射であることを確かめる。
# 帰属: 有限集合の所属判定と写像の単射・全射の有限検査だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
points = 0
for stage_size, rule, table in exhaustive_instances():
    F, mu, lam, e, E, FE1, Q, fibers, sigma = stable_fiber_dynamics_data(table)
    for q in Q:
        assert sigma[q] == F[q]            # 定義
        assert sigma[q] in Q               # F(q) ∈ Q_F（claim_iterate_monoid_generator_bijective_on_stable_image）
        points += 1
    assert len(frozenset(sigma[q] for q in Q)) == len(Q)   # 単射
    assert frozenset(sigma[q] for q in Q) == Q             # 全射
    instances += 1

print("global maps checked: {}".format(instances))
print("stable image points checked: {}".format(points))
print("RESULT: PASS")
