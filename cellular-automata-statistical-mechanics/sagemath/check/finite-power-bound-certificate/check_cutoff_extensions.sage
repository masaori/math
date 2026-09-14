# 対象ラベル: claim_finite_power_bound_cutoff_not_global
# 同じ有限表を持つ二列が次の交差冪上界では分かれる打ち切り反例を検査する。
# 帰属: 有限集合、ZZ。浮動小数点、商、根、対数、極限、R/C 脱出はない。


def a_value(cutoff, index):
    return ZZ(1)


def b_value(cutoff, numerator, index):
    if index == cutoff + 1:
        return ZZ(cutoff + 1) ** numerator + 1
    return ZZ(1)


cutoff_count = ZZ(0)
exponent_pair_count = ZZ(0)
shared_entry_count = ZZ(0)
certificate_comparison_count = ZZ(0)
next_stage_comparison_count = ZZ(0)
for cutoff in range(1, 33):
    cutoff_count += 1
    for numerator in range(1, 9):
        for denominator in range(1, 9):
            exponent_pair_count += 1
            for index in range(1, cutoff + 1):
                assert a_value(cutoff, index) == b_value(cutoff, numerator, index) == ZZ(1)
                shared_entry_count += 1
                assert a_value(cutoff, index) ** denominator <= ZZ(index) ** numerator
                assert b_value(cutoff, numerator, index) ** denominator <= ZZ(index) ** numerator
                certificate_comparison_count += 2

            next_index = ZZ(cutoff + 1)
            a_next_power = a_value(cutoff, next_index) ** denominator
            b_next_base = b_value(cutoff, numerator, next_index)
            b_next_power = b_next_base ** denominator
            index_power = next_index ** numerator
            assert a_next_power == ZZ(1)
            assert a_next_power <= index_power
            assert b_next_base == index_power + 1
            assert b_next_power >= b_next_base
            assert b_next_power > index_power
            next_stage_comparison_count += 5

assert cutoff_count == ZZ(32)
assert exponent_pair_count == ZZ(2048)
assert shared_entry_count == ZZ(33792)
assert certificate_comparison_count == ZZ(67584)
assert next_stage_comparison_count == ZZ(10240)
print('cutoffs checked:', cutoff_count)
print('positive integer exponent pairs checked:', exponent_pair_count)
print('shared finite-table entries checked:', shared_entry_count)
print('finite certificate comparisons checked:', certificate_comparison_count)
print('next-stage proof steps checked:', next_stage_comparison_count)
print('RESULT: PASS')
