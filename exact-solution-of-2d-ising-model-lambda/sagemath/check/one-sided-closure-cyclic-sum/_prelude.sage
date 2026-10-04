# 対象ラベル: claim_one_sided_closure_cyclic_sum
# 帰属: ZZ^2 の点列、ZZ の重みと有限和。
import os
import sys

check_directory = os.path.dirname(os.path.abspath(sys.argv[0]))
if 'junction_rows' not in globals():
    load(os.path.join(check_directory, '../one-sided-closure-junction-pairs/construction.sage'))


def turning(a, b):
    return ZZ(a[1]) * ZZ(b[0]) - ZZ(a[0]) * ZZ(b[1])


def internal_sum(word):
    return sum((turning(word[j], word[j + 1]) for j in range(len(word) - 1)), ZZ(0))


def cyclic_sum(word):
    return sum((turning(word[j], word[(j + 1) % len(word)])
                for j in range(len(word))), ZZ(0))


def extend(word):
    return lambda j: word[j] if j < len(word) else vector(ZZ, (0, 0))


def join(left, right, length):
    return lambda j: left(j) if j < length else right(j - length)


def four_join(a, v, r, x, cm, b, cn):
    return join(join(join(a, v, cm), r, cm + b), x, cm + b + cn)


if 'closure_sum_rows' not in globals():
    closure_sum_rows = []
    for m, n, b, c, u, v, r, x, A, V, R, X, points, independent in junction_rows:
        cm, cn = c * m, c * n
        N = cm + b + cn + b
        actual = adjacent_steps(points)
        U = lambda j, u=u, m=m: u[j % m]
        P = lambda j, r=r, n=n: r[j % n]
        ae, ve, re, xe = map(extend, (A, V, R, X))
        vf, xf = map(extend, (v, x))
        functions = [four_join(ae, ve, re, xe, cm, b, cn),
                     four_join(U, ve, re, xe, cm, b, cn),
                     four_join(U, vf, re, xe, cm, b, cn),
                     four_join(U, vf, P, xe, cm, b, cn),
                     four_join(U, vf, P, xf, cm, b, cn)]
        stages = [actual] + [[f(j) for j in range(N)] for f in functions]
        z = stages[-1]
        sums = [cyclic_sum(actual),
                internal_sum(actual) + turning(actual[-1], actual[0]),
                internal_sum(z) + turning(actual[-1], actual[0]),
                internal_sum(z) + turning(z[-1], z[0]), cyclic_sum(z)]
        closure_sum_rows.append((m, n, b, c, u, v, r, x, A, V, R, X,
                                 stages, sums, points, independent))
