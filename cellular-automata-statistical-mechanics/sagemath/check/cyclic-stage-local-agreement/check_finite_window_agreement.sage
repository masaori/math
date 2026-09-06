# 対象ラベル: claim_cyclic_stages_eventually_match_integer_window
# 併せて検証: claim_cyclic_stage_projection_not_globally_injective
# 式ペア・判定: L>=2s+1 で有限窓上の剰余等号と整数等号が一致し、整数全体では単射でない。
# 帰属: 有限集合と ZZ・NN。浮動小数点と R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

pairs_checked = 0
for radius in range(0, 13):
    window = offsets(radius)
    threshold = 2 * radius + 1
    for length in range(threshold, threshold + 5):
        cyclic_relation = {(left, right) for left in window for right in window
                           if left % length == right % length}
        integer_relation = {(left, right) for left in window for right in window
                            if left == right}
        assert cyclic_relation == integer_relation
        pairs_checked += len(window) ** 2

for length in range(1, 50):
    assert ZZ(0) != ZZ(length)
    assert ZZ(0) % ZZ(length) == ZZ(length) % ZZ(length)

assert pairs_checked > 0
print('window pairs checked:', pairs_checked)
print('RESULT: PASS')
