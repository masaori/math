# 対象ラベル: claim_iterate_monoid_generated_ideal_finite_chain_decidable
# 有限代表 P_F と合成表だけから全生成主イデアル、包含関係、主イデアル同値類を走査し、相異なる主イデアルが有限鎖をなすことを検査する。
# 帰属: 有限集合、有限集合の等号と包含だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

instances = 0
distinct_ideals_total = 0
classes_total = 0
for stage_size, rule, table in exhaustive_instances():
    powers, i, j, monoid, ideals = finite_monoid_data(table)

    distinct_ideals = []
    for ideal in ideals:
        if ideal not in distinct_ideals:
            distinct_ideals.append(ideal)

    inclusion = {
        (a, b)
        for a in range(len(distinct_ideals))
        for b in range(len(distinct_ideals))
        if distinct_ideals[a] <= distinct_ideals[b]
    }
    for a in range(len(distinct_ideals)):
        for b in range(len(distinct_ideals)):
            assert (a, b) in inclusion or (b, a) in inclusion
            if (a, b) in inclusion and (b, a) in inclusion:
                assert distinct_ideals[a] == distinct_ideals[b]

    classes = []
    unseen = set(range(j))
    while unseen:
        representative = min(unseen)
        equivalence_class = frozenset(a for a in range(j) if ideals[a] == ideals[representative])
        assert equivalence_class
        classes.append(equivalence_class)
        unseen.difference_update(equivalence_class)
    assert set().union(*classes) == set(range(j))
    assert all(classes[a].isdisjoint(classes[b]) for a in range(len(classes)) for b in range(a))
    assert len(classes) == len(distinct_ideals)

    distinct_ideals_total += len(distinct_ideals)
    classes_total += len(classes)
    instances += 1

print("global maps checked: {}".format(instances))
print("distinct generated ideals total: {}".format(distinct_ideals_total))
print("principal-ideal equivalence classes total: {}".format(classes_total))
print("RESULT: PASS")
