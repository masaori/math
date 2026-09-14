# 対象ラベル: claim_finite_submultiplicative_count_certificate_decidable
# 正整数値有限表の劣乗法証明書が有限個の自然数比較で決定できることを検査する。
# 帰属: 有限集合、ZZ。浮動小数点、対数、除算、極限、R/C 脱出はない。
from itertools import product


def admissible_pairs(cutoff):
    return [(m, n) for m in range(1, cutoff + 1)
            for n in range(1, cutoff + 1) if m + n <= cutoff]


def certificate_by_scan(table, cutoff):
    for m, n in admissible_pairs(cutoff):
        if table[m + n] > table[m] * table[n]:
            return False
    return True


table_count = ZZ(0)
comparison_count = ZZ(0)
for cutoff in range(1, 7):
    pairs = admissible_pairs(cutoff)
    assert len(pairs) == (cutoff - 1) * cutoff // 2
    for values in product(range(1, 4), repeat=cutoff):
        table = {index + 1: ZZ(value) for index, value in enumerate(values)}
        scanned = certificate_by_scan(table, cutoff)
        conjunction = all(table[m + n] <= table[m] * table[n] for m, n in pairs)
        assert scanned == conjunction
        table_count += 1
        comparison_count += len(pairs)

assert table_count == ZZ(1092)
assert comparison_count == ZZ(13941)
print('positive integer tables checked:', table_count)
print('finite comparisons checked:', comparison_count)
print('RESULT: PASS')
