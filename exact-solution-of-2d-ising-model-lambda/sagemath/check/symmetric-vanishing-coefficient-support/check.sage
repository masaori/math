# 「零代入で消える対称多項式の係数は全ての変数を含む指数にだけ残る」の式変形を一行ずつ確かめる。
# 対象ラベル: claim_symmetric_vanishing_last_variable_coefficient_support
# 帰属: 係数環は QQbar（代数的数）。多項式環 QQbar[X_0, ..., X_n] の等号と係数は厳密に判定する。
# 浮動小数点は使わない。n+1 = 1, 2, 3, 4 変数で、対称で lz_n(P) = 0 を満たす多項式の標本を作り、
# 各成分が 0..3 の指数 a と a(k) = 0 となる各 k について総当たりする。

from itertools import product as iproduct, permutations

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

def comp(a, rho):
    return tuple(a[rho[k]] for k in range(len(a)))

def vs(R, rho, P):
    X = R.gens()
    return P(*[X[rho[k]] for k in range(len(rho))])

def lz(n, P):
    # lz_n: X_k -> X_k (k < n), X_n -> 0
    if n == 0:
        S = QQbar
        return S(P(0))
    S = ring(n)
    Y = S.gens()
    return P(*(list(Y) + [S(0)]))

def symmetrize(R, P):
    m = R.ngens()
    return sum((vs(R, rho, P) for rho in permutations(range(m))), R(0))

s2 = QQbar(2).sqrt()
w3 = QQbar(-3).sqrt()
coeff_pool = [QQbar(1), QQbar(-2), s2, w3, 1 + s2 * w3]

for m in range(1, 5):
    n = m - 1
    R = ring(m)
    X = R.gens()
    e_top = prod(X, R(1))  # 全変数の積
    # 対称で lz_n(P) = 0 の標本: 全変数の積と、対称化した多項式の積。
    seeds = [R(1), X[0], X[0]**2 + coeff_pool[2] * X[0], X[0] * X[-1] + coeff_pool[3]]
    samples = []
    for i, s in enumerate(seeds):
        samples.append(coeff_pool[i % len(coeff_pool)] * e_top * symmetrize(R, s))
    # 零代入で消えない対称多項式（対照）: 主張の仮定が効いていることを見る。
    controls = [symmetrize(R, X[0]) + 1, symmetrize(R, R(1))]
    exps = list(iproduct(range(4), repeat=m))
    for P in samples:
        # 仮定: 対称、lz_n(P) = 0
        for rho in permutations(range(m)):
            check(vs(R, rho, P) == P, "symmetric m=%d" % m)
        check(lz(n, P) == 0, "lz zero m=%d" % m)
        for a in exps:
            for k in range(m):
                if a[k] != 0:
                    continue
                # tau = (k n)
                tau = list(range(m)); tau[k] = n; tau[n] = k; tau = tuple(tau)
                check(comp(tau, tau) == tuple(range(m)), "tau involution m=%d k=%d" % (m, k))
                at = comp(a, tau)
                # 準備: (a ∘ tau)(n) = a(tau(n)) = a(k) = 0
                check(at[n] == a[tau[n]] == a[k] == 0, "prep m=%d a=%s k=%d" % (m, a, k))
                b = at[:n]
                ezb = tuple(list(b) + [0])
                check(at == ezb, "ez m=%d a=%s k=%d" % (m, a, k))
                v0 = mco(P, a)
                v1 = mco(vs(R, tau, P), a)
                v2 = mco(P, at)
                v3 = mco(P, ezb)
                L = lz(n, P)
                v4 = (mco(L, b) if n > 0 else QQbar(L)) if L != 0 else QQbar(0)
                check(v0 == v1, "line1 m=%d a=%s k=%d" % (m, a, k))
                check(v1 == v2, "line2 m=%d a=%s k=%d" % (m, a, k))
                check(v2 == v3, "line3 m=%d a=%s k=%d" % (m, a, k))
                check(v3 == v4, "line4 m=%d a=%s k=%d" % (m, a, k))
                check(v4 == 0, "line5-6 m=%d a=%s k=%d" % (m, a, k))
    # 対照: 仮定 lz_n(P) = 0 を外すと、a(k) = 0 の指数にも非零の係数が現れる。
    for Pc in controls:
        check(lz(n, Pc) != 0, "control lz nonzero m=%d" % m)
        check(any(mco(Pc, a) != 0 for a in exps if 0 in a), "control has zero-entry support m=%d" % m)

if failures:
    print("FAIL %d" % len(failures))
    for f in failures[:20]:
        print("  " + f)
else:
    print("PASS %d" % passes)
