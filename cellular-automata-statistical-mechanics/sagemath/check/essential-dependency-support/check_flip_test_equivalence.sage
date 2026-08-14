# 対象ラベル: claim_flip_test_equivalence
# 本質的依存の存在量化と一点反転検査の同値を、|S|<=3 の全真理値表で検査する。
# |S|=3 では 2^(2^3)=256 個の局所規則をすべて調べる。
# 帰属: 有限集合と 0/1 の等号だけを使う。ℝ/ℂ 脱出なし。

from itertools import product


def configurations(size):
    return tuple(product((0, 1), repeat=size))


def flip(x, w):
    y = list(x)
    y[w] = 1 - y[w]
    return tuple(y)


def essentially_depends(table, xs, w):
    for x in xs:
        for x_prime in xs:
            if all(x[u] == x_prime[u] for u in range(len(x)) if u != w):
                if table[x] != table[x_prime]:
                    return True
    return False


def flip_detects(table, xs, w):
    return any(table[x] != table[flip(x, w)] for x in xs)


for size in range(4):
    xs = configurations(size)
    rule_count = 0
    tested_memberships = 0
    for outputs in product((0, 1), repeat=len(xs)):
        table = dict(zip(xs, outputs))
        rule_count += 1
        for w in range(size):
            assert essentially_depends(table, xs, w) == flip_detects(table, xs, w)
            tested_memberships += 1
    print("|S|={}: rules={}, membership equivalences={}".format(
        size, rule_count, tested_memberships
    ))

print("RESULT: PASS")
