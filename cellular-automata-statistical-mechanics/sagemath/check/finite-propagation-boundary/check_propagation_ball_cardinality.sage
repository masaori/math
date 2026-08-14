# 対象ラベル: claim_propagation_ball_finite
# 伝播球の再帰と、合併の個数が各集合の個数の和以下であることを全数検査する。
# 帰属: 有限集合と ZZ の非負元だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

families = 0
comparisons = 0
for stage_size in range(4):
    for supports in support_families(stage_size):
        for target in range(stage_size):
            assert propagation_ball(supports, 1, target) == supports[target]
            for depth in range(1, 5):
                next_ball = propagation_ball(supports, depth + 1, target)
                union = frozenset(
                    source
                    for cell in supports[target]
                    for source in propagation_ball(supports, depth, cell)
                )
                cardinality_sum = sum(
                    ZZ(len(propagation_ball(supports, depth, cell)))
                    for cell in supports[target]
                )
                assert next_ball == union
                assert ZZ(len(next_ball)) <= cardinality_sum
                comparisons += 1
        families += 1

print("support families checked: {}; cardinality comparisons: {}".format(families, comparisons))
print("RESULT: PASS")
