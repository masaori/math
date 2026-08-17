# 対象ラベル: claim_iterate_monoid_stable_fiber_depth_partition
# 各 q ∈ Q_F, y ∈ B_F(q) について、y ∈ L_F(q, μ(y)) であり、y ∈ L_F(q,k) となる k がただ一つであること、
# k ≠ ℓ なら L_F(q,k) ∩ L_F(q,ℓ) = ∅ であることを、定義（def_iterate_monoid_stable_fiber_depth_layer）から
# 直接確かめる。
# 帰属: 有限集合の所属・等号と非負整数の等号だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
memberships = 0
pairs = 0
for stage_size, rule, table in exhaustive_instances():
    F, E, Q, fibers, sigma, mp, mu_of, layers = depth_data(table)
    M = len(F)
    for q in Q:
        for y in fibers[q]:
            # 存在: y ∈ B_F(q) かつ μ(y) = μ(y) なので y ∈ L_F(q, μ(y))
            assert y in layers[q][mu_of[y]]
            # 一意性: y ∈ L_F(q,k) なら k = μ(y)
            ks = [k for k in range(M + 1) if y in layers[q][k]]
            assert ks == [mu_of[y]]
            memberships += 1
        # 非交差: k ≠ ℓ なら共通元なし（共通元 y があれば k = μ(y) = ℓ の矛盾）
        for k in range(M + 1):
            for l in range(M + 1):
                if k != l:
                    assert len(layers[q][k] & layers[q][l]) == 0
                    pairs += 1
        # 層の元は全てファイバーの元
        for k in range(M + 1):
            assert layers[q][k] <= fibers[q]
    instances += 1

print("global maps checked: {}".format(instances))
print("fiber memberships checked: {}".format(memberships))
print("ordered layer pairs checked: {}".format(pairs))
print("RESULT: PASS")
