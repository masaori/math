# 対象ラベル: claim_iterate_monoid_stable_fiber_unique_representative
# 各 y ∈ A^V について、E_F(y) ∈ Q_F、y ∈ B_F(E_F(y))（存在）を確かめ、
# さらに y ∈ B_F(q) ∩ B_F(r) なら q = E_F(y) = r（一意性）を人手証明の等号ごとに確かめる。
# 帰属: 有限集合の写像の等号だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
configuration_count = 0
pair_checks = 0
for stage_size, rule, table in exhaustive_instances():
    mu, lam, e, E, Q, fibers = stable_partition_data(table)
    for y in range(len(E)):
        q0 = E[y]
        assert q0 in Q                               # def_iterate_monoid_stable_image
        assert E[y] == q0                            # E_F(y) = E_F(y)
        assert y in fibers[q0]                       # def_iterate_monoid_stable_fiber
        # 一意性: y を含む安定ファイバーの元 q ∈ Q_F は E_F(y) だけ
        containing = [q for q in Q if y in fibers[q]]
        assert containing == [q0] or set(containing) == {q0}
        for q in Q:
            for r in Q:
                if y in fibers[q] and y in fibers[r]:
                    assert q == E[y]                 # y ∈ B_F(q)
                    assert E[y] == r                 # y ∈ B_F(r)
                    assert q == r
                    pair_checks += 1
        configuration_count += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("configurations checked: {}".format(configuration_count))
print("pair checks (q, r) with common configuration: {}".format(pair_checks))
print("RESULT: PASS")
