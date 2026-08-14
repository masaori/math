# 対象ラベル: claim_dependency_transfer
# w in S への本質的依存が冗長拡大の前後で一致することを、|T|<=3 の全 S、全規則で検査する。
# 帰属: 有限集合と 0/1 の等号だけを使う。R/C 脱出なし。

from itertools import combinations, product


def subsets(items):
    for size in range(len(items) + 1):
        yield from combinations(items, size)


def configurations(size):
    return tuple(product((0, 1), repeat=size))


def restrict_input(y, subset):
    return tuple(y[u] for u in subset)


def essentially_depends(table, xs, w):
    return any(
        table[x] != table[x_prime]
        and all(x[u] == x_prime[u] for u in range(len(x)) if u != w)
        for x in xs
        for x_prime in xs
    )


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
            for source_position, w in enumerate(subset):
                assert essentially_depends(extended_table, total_inputs, w) == essentially_depends(
                    source_table, source_inputs, source_position
                )
                tested += 1

print("dependency transfers checked: {}".format(tested))
print("RESULT: PASS")
