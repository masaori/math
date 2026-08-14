# 対象ラベル: claim_finite_propagation_boundary
# 依存元集合の包含、個数上界、時刻 0 での空性を全数検査する。
# 帰属: 有限集合と ZZ の非負元だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

instances = 0
events = 0
for tau, stage_size, supports in exhaustive_instances():
    for time in range(tau + 1):
        for target in range(stage_size):
            sources = dependency_sources(tau, supports, (time, target))
            boundary = boundary_union(supports, time, target)
            cardinality_sum = sum(
                ZZ(len(propagation_ball(supports, depth, target)))
                for depth in range(1, time + 1)
            )
            assert sources.issubset(boundary)
            assert ZZ(len(sources)) <= ZZ(len(boundary))
            assert ZZ(len(boundary)) <= cardinality_sum
            if time == 0:
                assert sources == frozenset()
            events += 1
    instances += 1

print("instances checked: {}; target events checked: {}".format(instances, events))
print("RESULT: PASS")
