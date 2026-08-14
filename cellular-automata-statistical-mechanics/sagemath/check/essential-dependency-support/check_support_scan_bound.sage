# 対象ラベル: claim_support_finite_decidability
# 一点反転による走査が本質的依存台を返し、比較回数が |S|*2^|S| 以下であることを、
# |S|<=3 の全真理値表で検査する。
# 帰属: 比較回数は NN、他は有限集合と 0/1 の等号。ℝ/ℂ 脱出なし。

from itertools import product


def configurations(size):
    return tuple(product((0, 1), repeat=size))


def flip(x, w):
    y = list(x)
    y[w] = 1 - y[w]
    return tuple(y)


def direct_support(table, xs, size):
    support = set()
    for w in range(size):
        for x in xs:
            for x_prime in xs:
                same_away = all(x[u] == x_prime[u] for u in range(size) if u != w)
                if same_away and table[x] != table[x_prime]:
                    support.add(w)
    return support


def scan_support(table, xs, size):
    support = set()
    comparisons = 0
    for w in range(size):
        for x in xs:
            comparisons += 1
            if table[x] != table[flip(x, w)]:
                support.add(w)
                break
    return support, comparisons


for size in range(4):
    xs = configurations(size)
    bound = size * (2 ** size)
    rule_count = 0
    maximum_comparisons = 0
    for outputs in product((0, 1), repeat=len(xs)):
        table = dict(zip(xs, outputs))
        expected = direct_support(table, xs, size)
        actual, comparisons = scan_support(table, xs, size)
        assert actual == expected
        assert comparisons <= bound
        maximum_comparisons = max(maximum_comparisons, comparisons)
        rule_count += 1
    print("|S|={}: rules={}, bound={}, maximum comparisons={}".format(
        size, rule_count, bound, maximum_comparisons
    ))

print("RESULT: PASS")
