# 対象ラベル: claim_finite_submultiplicative_count_cutoff_not_global
# 同じ有限表を持つ二列が次の劣乗法不等式では分かれる打ち切り反例を検査する。
# 帰属: 有限集合、ZZ。浮動小数点、対数、除算、極限、R/C 脱出はない。


def u_value(cutoff, index):
    return ZZ(1)


def v_value(cutoff, index):
    return ZZ(2) if index == cutoff + 1 else ZZ(1)


cutoff_count = ZZ(0)
shared_entry_count = ZZ(0)
certificate_comparison_count = ZZ(0)
for cutoff in range(1, 65):
    for index in range(1, cutoff + 1):
        assert u_value(cutoff, index) == v_value(cutoff, index) == ZZ(1)
        shared_entry_count += 1
    for m in range(1, cutoff + 1):
        for n in range(1, cutoff + 1):
            if m + n > cutoff:
                continue
            assert u_value(cutoff, m + n) <= u_value(cutoff, m) * u_value(cutoff, n)
            assert v_value(cutoff, m + n) <= v_value(cutoff, m) * v_value(cutoff, n)
            certificate_comparison_count += 2
    assert u_value(cutoff, cutoff + 1) <= u_value(cutoff, cutoff) * u_value(cutoff, 1)
    assert v_value(cutoff, cutoff + 1) > v_value(cutoff, cutoff) * v_value(cutoff, 1)
    cutoff_count += 1

assert cutoff_count == ZZ(64)
assert shared_entry_count == ZZ(2080)
assert certificate_comparison_count == ZZ(87360)
print('cutoffs checked:', cutoff_count)
print('shared finite-table entries checked:', shared_entry_count)
print('certificate comparisons checked:', certificate_comparison_count)
print('next-stage separating witnesses checked:', cutoff_count)
print('RESULT: PASS')
