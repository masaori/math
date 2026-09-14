# 対象ラベル: claim_finite_power_bound_certificate_decidable
# 正整数値有限表の交差冪上界証明書が有限個の自然数比較で決定できることを検査する。
# 帰属: 有限集合、ZZ。浮動小数点、商、根、対数、極限、R/C 脱出はない。
from itertools import product


def certificate_by_scan(table, cutoff, numerator, denominator):
    for index in range(1, cutoff + 1):
        if table[index] ** denominator > ZZ(index) ** numerator:
            return False
    return True


table_count = ZZ(0)
candidate_count = ZZ(0)
comparison_count = ZZ(0)
true_candidate_count = ZZ(0)
false_candidate_count = ZZ(0)
for cutoff in range(1, 7):
    for values in product(range(1, 5), repeat=cutoff):
        table = {index + 1: ZZ(value) for index, value in enumerate(values)}
        table_count += 1
        for numerator in range(1, 5):
            for denominator in range(1, 5):
                scanned = certificate_by_scan(table, cutoff, numerator, denominator)
                conjunction = all(
                    table[index] ** denominator <= ZZ(index) ** numerator
                    for index in range(1, cutoff + 1)
                )
                assert scanned == conjunction
                candidate_count += 1
                comparison_count += cutoff
                if scanned:
                    true_candidate_count += 1
                else:
                    false_candidate_count += 1

assert table_count == ZZ(5460)
assert candidate_count == ZZ(87360)
assert comparison_count == ZZ(495168)
assert true_candidate_count == ZZ(9020)
assert false_candidate_count == ZZ(78340)
print('positive integer tables checked:', table_count)
print('positive integer exponent pairs checked:', candidate_count)
print('finite comparisons checked:', comparison_count)
print('true certificates:', true_candidate_count)
print('false certificates:', false_candidate_count)
print('RESULT: PASS')
