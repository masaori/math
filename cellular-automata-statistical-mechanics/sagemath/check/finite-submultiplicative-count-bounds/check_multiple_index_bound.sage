# 対象ラベル: claim_finite_submultiplicative_count_multiple_index_density_bound
# 有限劣乗法証明書から倍数添字上界と交差冪の密度比較が従うことを検査する。
# 帰属: 有限集合、ZZ。浮動小数点、対数、除算、極限、R/C 脱出はない。
from itertools import product


def is_submultiplicative(table, cutoff):
    return all(table[m + n] <= table[m] * table[n]
               for m in range(1, cutoff + 1)
               for n in range(1, cutoff + 1) if m + n <= cutoff)


certificate_count = ZZ(0)
multiple_bound_count = ZZ(0)
density_comparison_count = ZZ(0)
for cutoff in range(1, 7):
    for values in product(range(1, 5), repeat=cutoff):
        table = {index + 1: ZZ(value) for index, value in enumerate(values)}
        if not is_submultiplicative(table, cutoff):
            continue
        certificate_count += 1
        for m in range(1, cutoff + 1):
            for q in range(1, cutoff // m + 1):
                assert table[q * m] <= table[m] ** q
                multiple_bound_count += 1
                assert table[q * m] ** m <= table[m] ** (q * m)
                density_comparison_count += 1

assert certificate_count == ZZ(2253)
assert multiple_bound_count == ZZ(28055)
assert density_comparison_count == multiple_bound_count
print('finite certificates checked:', certificate_count)
print('multiple-index bounds checked:', multiple_bound_count)
print('cross-power density comparisons checked:', density_comparison_count)
print('RESULT: PASS')
