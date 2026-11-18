# 「零代入で消える対称多項式は全変数の積と指数を一つ下げた多項式の積である」と
# 「変数の個数と同じ次数の基本対称式は全ての指数が一の単項式である」の式変形を一行ずつ確かめる。
# 対象ラベル: claim_symmetric_vanishing_last_variable_shifted_quotient_product,
#             claim_qbar_full_elementary_symmetric_is_all_ones_monomial, def_qbar_all_ones_shift
# 帰属: 係数環は QQbar（代数的数）。多項式環 QQbar[X_0, ..., X_n] の等号と係数は厳密に判定する。
# 浮動小数点は使わない。n+1 = 1, 2, 3, 4 変数で、対称で lz_n(P) = 0 を満たす多項式の標本を作り、
# 各成分が 0..4 の指数 c について総当たりする。

from itertools import product as iproduct, permutations, combinations

failures = []
passes = 0
def check(cond, msg):
    global passes
    if not cond:
        failures.append(msg)
    else:
        passes += 1

def ring(m):
    return PolynomialRing(QQbar, ['X%d' % k for k in range(m)], order='lex')

def mco(P, a):
    return P.monomial_coefficient(P.parent().monomial(*a)) if P != 0 else QQbar(0)

def vs(R, rho, P):
    X = R.gens()
    return P(*[X[rho[k]] for k in range(len(rho))])

def lz(n, P):
    if n == 0:
        return QQbar(P(0))
    S = ring(n)
    Y = S.gens()
    return P(*(list(Y) + [S(0)]))

def symmetrize(R, P):
    m = R.ngens()
    return sum((vs(R, rho, P) for rho in permutations(range(m))), R(0))

def es(R, j):
    X = R.gens()
    m = R.ngens()
    return sum((prod((X[k] for k in S), R(1)) for S in combinations(range(m), j)), R(0))

def mon(R, a):
    X = R.gens()
    return prod((X[k]**a[k] for k in range(len(a))), R(1))

def shift(R, P):
    # sd(P): mco_d(sd(P)) = mco_{d+1}(P)。P の各項 c に対し、c >= 1 なら c - 1 へ写す。
    m = R.ngens()
    Q = R(0)
    for c, v in P.dict().items():
        c = tuple(c) if not isinstance(c, (int, Integer)) else (int(c),)
        if all(ci >= 1 for ci in c):
            Q += v * mon(R, tuple(ci - 1 for ci in c))
    return Q

s2 = QQbar(2).sqrt()
w3 = QQbar(-3).sqrt()
coeff_pool = [QQbar(1), QQbar(-2), s2, w3, 1 + s2 * w3]

for m in range(1, 5):
    n = m - 1
    R = ring(m)
    X = R.gens()
    ones = tuple([1] * m)
    # 変数の個数と同じ次数の基本対称式: 唯一の m 元部分集合、一乗、単項式の定義。
    subsets = list(combinations(range(m), m))
    check(subsets == [tuple(range(m))], "only full subset m=%d" % m)
    line1 = prod((X[k] for k in range(m)), R(1))
    line2 = prod((X[k]**ones[k] for k in range(m)), R(1))
    check(es(R, m) == line1, "full es line1 m=%d" % m)
    check(line1 == line2, "full es line2 m=%d" % m)
    check(line2 == mon(R, ones), "full es line3 m=%d" % m)
    e_top = es(R, m)
    seeds = [R(1), X[0], X[0]**2 + coeff_pool[2] * X[0], X[0] * X[-1] + coeff_pool[3]]
    samples = [coeff_pool[i % len(coeff_pool)] * e_top * symmetrize(R, s) for i, s in enumerate(seeds)]
    exps = list(iproduct(range(5), repeat=m))
    for P in samples:
        for rho in permutations(range(m)):
            check(vs(R, rho, P) == P, "symmetric m=%d" % m)
        check(lz(n, P) == 0, "lz zero m=%d" % m)
        Q = shift(R, P)
        # 定義: mco_d(sd(P)) = mco_{d+1}(P)
        for d in exps:
            check(mco(Q, d) == mco(P, tuple(d[k] + 1 for k in range(m))), "shift def m=%d d=%s" % (m, d))
        prodPQ = e_top * Q
        for c in exps:
            ge = all(c[k] >= 1 for k in range(m))
            cm1 = tuple(c[k] - 1 for k in range(m)) if ge else None
            v0 = mco(prodPQ, c)
            v1 = mco(mon(R, ones) * Q, c)
            v2 = mco(Q, cm1) if ge else QQbar(0)
            v3 = mco(P, tuple(cm1[k] + 1 for k in range(m))) if ge else QQbar(0)
            v4 = mco(P, c) if ge else QQbar(0)
            v5 = mco(P, c)
            check(v0 == v1, "line1 m=%d c=%s" % (m, c))
            check(v1 == v2, "line2 m=%d c=%s" % (m, c))
            check(v2 == v3, "line3 m=%d c=%s" % (m, c))
            check(v3 == v4, "line4 m=%d c=%s" % (m, c))
            check(v4 == v5, "line5 m=%d c=%s" % (m, c))
        check(prodPQ == P, "claim P = es * sd(P) m=%d" % m)
    # 対照: lz_n(P) = 0 を外すと P = es * sd(P) は成り立たない。
    Pc = symmetrize(R, X[0]) + 1
    check(lz(n, Pc) != 0, "control lz nonzero m=%d" % m)
    check(e_top * shift(R, Pc) != Pc, "control not divisible m=%d" % m)

if failures:
    print("FAIL %d" % len(failures))
    for f in failures[:20]:
        print("  " + f)
else:
    print("PASS %d" % passes)
