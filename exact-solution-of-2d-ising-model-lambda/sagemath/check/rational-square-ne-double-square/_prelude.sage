# 対象ラベル: claim_rational_square_ne_double_square
# 相異なる有理数の標本を QQ 内で作り、全ての組で b != 0 を保つ。
_rsds_values = sorted({QQ(n) / QQ(d) for n in range(-12, 13) for d in range(1, 13)})
_rsds_nonzero = [b for b in _rsds_values if b != 0]
assert len(_rsds_values) == 183
assert len(_rsds_nonzero) == 182
_rsds_cases = [(a, b, b^(-1), a * b^(-1))
               for a in _rsds_values for b in _rsds_nonzero]
assert len(_rsds_cases) == 33306


def _rsds_check_pair(left, right, label):
    checked = 0
    for a, b, binv, r in _rsds_cases:
        assert b != 0
        assert left(a, b, binv, r) == right(a, b, binv, r), (label, a, b)
        checked += 1
    assert checked == 33306
    print('RESULT: PASS (%s: %d 有理数組、b != 0)' % (label, checked))
