# 対象ラベル: claim_support_invariance
# 冗長拡大の本質的依存台が元の依存台と一致することを、|T|<=3 の全 S、全規則で検査する。
# 帰属: 有限集合と 0/1 の等号だけを使う。R/C 脱出なし。

from itertools import combinations, product


def subsets(items):
    for size in range(len(items) + 1):
        yield from combinations(items, size)


def configurations(size):
    return tuple(product((0, 1), repeat=size))


def restrict_input(y, subset):
    return tuple(y[u] for u in subset)


def support(table, xs):
    return {
        w
        for w in range(len(xs[0]) if xs else 0)
        if any(
            table[x] != table[x_prime]
            and all(x[u] == x_prime[u] for u in range(len(x)) if u != w)
            for x in xs
            for x_prime in xs
        )
    }


tested = 0
for total_size in range(4):
    total = tuple(range(total_size))
    total_inputs = configurations(total_size)
    for subset in subsets(total):
        source_inputs = configurations(len(subset))
        for outputs in product((0, 1), repeat=len(source_inputs)):
            source_table = dict(zip(source_inputs, outputs))
            extended_table = {
                y: source_table[restrict_input(y, subset)] for y in total_inputs
            }
            source_support = {subset[position] for position in support(source_table, source_inputs)}
            assert support(extended_table, total_inputs) == source_support
            tested += 1

print("support equalities checked: {}".format(tested))
print("RESULT: PASS")
