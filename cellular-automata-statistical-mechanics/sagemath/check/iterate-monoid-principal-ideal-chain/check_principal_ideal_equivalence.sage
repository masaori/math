# 対象ラベル: claim_iterate_monoid_principal_ideal_equivalence_relation
# G ~_F H iff J_F(G) = J_F(H) が反射的・対称的・推移的であることを、有限反復モノイドの全元で検査する。
# 帰属: 有限集合と有限集合の等号だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

instances = 0
relation_checks = 0
for stage_size, rule, table in exhaustive_instances():
    powers, i, j, monoid, ideals = finite_monoid_data(table)
    relation = {(a, b) for a in range(j) for b in range(j) if ideals[a] == ideals[b]}

    for a in range(j):
        assert (a, a) in relation
        relation_checks += 1
    for a in range(j):
        for b in range(j):
            if (a, b) in relation:
                assert ideals[b] == ideals[a]
                assert (b, a) in relation
                relation_checks += 1
    for a in range(j):
        for b in range(j):
            for c in range(j):
                if (a, b) in relation and (b, c) in relation:
                    assert ideals[a] == ideals[c]
                    assert (a, c) in relation
                    relation_checks += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("equivalence-law instances checked: {}".format(relation_checks))
print("RESULT: PASS")
