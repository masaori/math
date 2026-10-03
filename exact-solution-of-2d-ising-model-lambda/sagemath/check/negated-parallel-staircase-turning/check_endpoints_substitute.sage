# 対象ラベル: claim_negated_parallel_staircase_turning_zero
# 式ペア: 階段の両端点を周期ベクトルと零へ置換。帰属: ZZ。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))

checked = 0
for length, horizontal, vertical, p, q, a, b, n, points, steps in negated_cases():
    period = (length * vertical, length * horizontal)
    assert vector_subtract(vector_scale(-1, points[n]), vector_scale(-1, points[0])) == vector_subtract(vector_scale(-1, period), vector_scale(-1, (ZZ(0), ZZ(0))))
    checked += 1
print(f'RESULT: PASS ({checked} cases, endpoints_substitute)')
