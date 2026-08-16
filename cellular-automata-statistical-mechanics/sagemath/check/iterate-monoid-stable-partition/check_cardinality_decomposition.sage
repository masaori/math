# 対象ラベル: claim_iterate_monoid_stable_fiber_cardinality_decomposition
# 指示値 δ_F(q, y) ∈ {0,1} を定め、人手証明の各等号
#   Σ_q |B_F(q)| = Σ_q Σ_y δ = Σ_y Σ_q δ = Σ_y 1 = |A^V| = |A|^{|V|} = 2^{|V|}
# をそれぞれ別に確かめる。
# 帰属: 有限集合の元の個数、非負整数の加算・冪だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
for stage_size, rule, table in exhaustive_instances():
    mu, lam, e, E, Q, fibers = stable_partition_data(table)
    size = len(E)
    Q_list = sorted(Q)
    delta = lambda q, y: ZZ(1) if y in fibers[q] else ZZ(0)
    lhs = sum(ZZ(len(fibers[q])) for q in Q_list)
    s1 = sum(sum(delta(q, y) for y in range(size)) for q in Q_list)   # 指示値で数える
    assert lhs == s1
    s2 = sum(sum(delta(q, y) for q in Q_list) for y in range(size))   # 有限和の順序交換
    assert s1 == s2
    for y in range(size):
        assert sum(delta(q, y) for q in Q_list) == 1                    # claim_iterate_monoid_stable_fiber_unique_representative
    s3 = sum(ZZ(1) for y in range(size))
    assert s2 == s3
    assert s3 == ZZ(size)                                               # |A^V|
    assert ZZ(size) == ZZ(2) ** ZZ(stage_size)                          # |A|^{|V|}、|A| = 2
    assert lhs == ZZ(2) ** ZZ(stage_size)
    instances += 1

print("global maps checked: {}".format(instances))
print("RESULT: PASS")
