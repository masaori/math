# 対象ラベル: claim_integer_sequence_level_crossing / def_integer_sequence_level_crossing_counts
#
# 隣接差が -1,0,1 の整数の有限列 a=(a_1,...,a_n) と任意の水準 c について
#   U_c(a) - D_c(a) = 1   (a_1 <= c < a_n)
#                   = -1  (a_n <= c < a_1)
#                   = 0   (それ以外)
# を全列挙で検査する。すべて ZZ の比較と加法だけで行い、浮動小数点は使わない。

from itertools import product

first_values = [ZZ(v) for v in range(-2, 3)]   # a_1 in {-2,...,2}
steps = [ZZ(-1), ZZ(0), ZZ(1)]
max_len = 6

checked_sequences = 0
checked_pairs = 0

for n in range(1, max_len + 1):
    for a1 in first_values:
        for step_tuple in product(steps, repeat=n - 1):
            a = [a1]
            for s in step_tuple:
                a.append(a[-1] + s)
            checked_sequences += 1
            lo = min(a) - 2
            hi = max(a) + 2
            for c in range(lo, hi + 1):
                c = ZZ(c)
                up = sum(
                    1
                    for k in range(n - 1)
                    if a[k] == c and a[k + 1] == c + 1
                )
                down = sum(
                    1
                    for k in range(n - 1)
                    if a[k] == c + 1 and a[k + 1] == c
                )
                if a[0] <= c and c < a[n - 1]:
                    expected = ZZ(1)
                elif a[n - 1] <= c and c < a[0]:
                    expected = ZZ(-1)
                else:
                    expected = ZZ(0)
                assert ZZ(up) - ZZ(down) == expected, (a, c, up, down, expected)
                checked_pairs += 1

print(f"PASS: sequences={checked_sequences} (n<=%d, a_1 in -2..2), (sequence, level) pairs={checked_pairs}" % max_len)
