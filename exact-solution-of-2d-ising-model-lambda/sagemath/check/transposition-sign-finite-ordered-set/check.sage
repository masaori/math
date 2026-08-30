"""有限線型順序集合の相異なる二点の互換の符号が -1 であることを検査する。

対象: claim_transposition_sign_on_finite_ordered_set。
標準順序を持つ大きさ 2 から 8 の集合について、全ての相異なる二点の互換の
転倒数を直接数え、符号が ZZ の -1 に一致することを確かめる。
"""


def transposition(size, a, b):
    return [b if u == a else a if u == b else u for u in range(size)]


checked = 0
for size in range(2, 9):
    for a in range(size):
        for b in range(a + 1, size):
            image = transposition(size, a, b)
            inversions = sum(
                1
                for u in range(size)
                for v in range(u + 1, size)
                if image[u] > image[v]
            )
            between = b - a - 1
            assert inversions == 2 * between + 1
            assert ZZ(-1) ** inversions == -1
            checked += 1

assert checked == sum(binomial(size, 2) for size in range(2, 9))
print(f"PASS: every tested transposition has sign -1 ({checked} transpositions)")
