# 「変数を置換した多項式の係数は指数を合成した係数である」の式変形を一行ずつ確かめる。
# 対象ラベル: claim_qbar_variable_permutation_coefficient
# 帰属: 係数環は QQbar（代数的数）。多項式環 QQbar[X_0, ..., X_{n-1}] の等号と係数は厳密に判定する。
# 浮動小数点は使わない。n = 1, 2, 3 の全ての置換と、各成分が 0..2 の指数、代数的数を係数に持つ多項式の標本を総当たりする。

from itertools import product as iproduct, permutations

failures = []
passes = 0
def check(cond, msg):
    global passes
    if not cond:
        failures.append(msg)
    else:
        passes += 1

def ring(n):
    return PolynomialRing(QQbar, ['X%d' % k for k in range(n)], order='lex')

def mco(P, a):
    return P.monomial_coefficient(P.parent().monomial(*a)) if P != 0 else QQbar(0)

def mon(R, a):
    X = R.gens()
    return prod((X[k]**a[k] for k in range(len(a))), R(1))

def comp(a, rho):
    # (a ∘ rho)(k) = a(rho(k))
    return tuple(a[rho[k]] for k in range(len(a)))

def inverse(rho):
    inv = [None] * len(rho)
    for k, j in enumerate(rho):
        inv[j] = k
    return tuple(inv)

def vs(R, rho, P):
    # vs_rho = ms_{xv_{n,rho}}、xv_{n,rho}(k) = X_{rho(k)}
    X = R.gens()
    return P(*[X[rho[k]] for k in range(len(rho))])

s2 = QQbar(2).sqrt()
w3 = QQbar(-3).sqrt()
coeff_pool = [QQbar(1), QQbar(-2), s2, w3, 1 + s2 * w3]

def sample_polys(R, n):
    exps = list(iproduct(range(3), repeat=n))
    polys = [R(0), R(1)]
    for t in range(4):
        P = R(0)
        for i, e in enumerate(exps):
            if (i * 7 + t * 3) % 5 < 2:
                P += coeff_pool[(i + t) % len(coeff_pool)] * mon(R, e)
        polys.append(P)
    return polys

for n in range(1, 4):
    R = ring(n)
    X = R.gens()
    exps = list(iproduct(range(3), repeat=n))
    big_exps = list(iproduct(range(5), repeat=n))
    for rho in permutations(range(n)):
        rinv = inverse(rho)
        # 定義: vs_rho(X_k) = X_{rho(k)}
        for k in range(n):
            check(vs(R, rho, X[k]) == X[rho[k]], "vs(X_k) n=%d rho=%s k=%d" % (n, rho, k))
        # 準備の一つ目: prod_k X_{rho(k)}^{b(k)} = prod_j X_j^{b(rho^{-1}(j))} = mon(b ∘ rho^{-1})
        for b in exps:
            lhs = prod((X[rho[k]]**b[k] for k in range(n)), R(1))
            mid = prod((X[j]**b[rinv[j]] for j in range(n)), R(1))
            check(lhs == mid, "prep1 reindex n=%d rho=%s b=%s" % (n, rho, b))
            check(mid == mon(R, comp(b, rinv)), "prep1 mon n=%d rho=%s b=%s" % (n, rho, b))
        # b ∘ rho^{-1} = a ⟺ b = a ∘ rho
        for a in exps:
            for b in exps:
                check((comp(b, rinv) == a) == (b == comp(a, rho)), "iff n=%d rho=%s a=%s b=%s" % (n, rho, a, b))
        for P in sample_polys(R, n):
            A = [b for b in exps if mco(P, b) != 0]
            lines = []
            line1 = sum((mco(P, b) * prod((X[rho[k]]**b[k] for k in range(n)), R(1)) for b in A), R(0))
            line2 = sum((mco(P, b) * mon(R, comp(b, rinv)) for b in A), R(0))
            check(vs(R, rho, P) == line1, "line1 n=%d rho=%s" % (n, rho))
            check(line1 == line2, "line2 n=%d rho=%s" % (n, rho))
            for a in big_exps:
                v0 = mco(vs(R, rho, P), a)
                v3 = sum((mco(R(mco(P, b)) * mon(R, comp(b, rinv)), a) for b in A), QQbar(0))
                v4 = sum((mco(P, b) for b in A if comp(b, rinv) == a), QQbar(0))
                v5 = sum((mco(P, b) for b in A if b == comp(a, rho)), QQbar(0))
                v6 = mco(P, comp(a, rho))
                check(v0 == mco(line2, a) == v3, "line3 n=%d rho=%s a=%s" % (n, rho, a))
                check(v3 == v4, "line4 n=%d rho=%s a=%s" % (n, rho, a))
                check(v4 == v5, "line5 n=%d rho=%s a=%s" % (n, rho, a))
                check(v5 == v6, "line6 n=%d rho=%s a=%s" % (n, rho, a))
        # 準備の二つ目: mco_a(mk(d) * mon(e)) = d (e = a), 0 (e != a)
        for d in coeff_pool:
            for e in exps:
                for a in exps:
                    v = mco(R(d) * mon(R, e), a)
                    check(v == (d if e == a else 0), "prep2 n=%d d=%s e=%s a=%s" % (n, d, e, a))

if failures:
    print("FAIL %d" % len(failures))
    for f in failures[:20]:
        print("  " + f)
else:
    print("PASS %d" % passes)
