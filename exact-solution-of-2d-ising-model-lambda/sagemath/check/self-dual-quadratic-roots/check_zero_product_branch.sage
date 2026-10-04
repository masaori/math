# 対象ラベル: claim_self_dual_quadratic_roots
# claim_qbar_no_zero_divisors を使う二つの場合を検査する。
if 'sd_line_cases' not in globals():
    load('sagemath/check/self-dual-quadratic-roots/_prelude.sage')
sd_branch_counts = [0, 0]
for s, xi in sd_inputs('zero_product'):
    first = (xi + 1) - s
    second = (xi + 1) + s
    assert first * second == 0
    if first == 0:
        sd_branch_counts[0] += 1
    else:
        assert second == 0, (s, xi)
        sd_branch_counts[1] += 1
assert sd_branch_counts == [2, 2]
print('PASS zero_product_branch: 4 exact cases (2 first-zero, 2 second-zero)')
