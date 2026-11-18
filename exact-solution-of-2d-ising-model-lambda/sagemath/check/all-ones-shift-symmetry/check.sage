# 「対称多項式の全ての指数を一つ下げた多項式は対称である」の式変形を一行ずつ確かめる。
# 対象ラベル: claim_qbar_all_ones_shift_preserves_symmetry
# 帰属: 係数環は QQbar（代数的数）。多項式環 QQbar[X_0, ..., X_{n-1}] の等号と係数は厳密に判定する。
# 浮動小数点は使わない。n = 1, 2, 3, 4 変数で対称多項式の標本を作り、全ての置換 ϱ と、
# 各成分が 0..3 の全ての指数 d について総当たりする。

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

def vs(R, rho, P):
    X = R.gens()
    return P(*[X[rho[k]] for k in range(len(rho))])

def symmetrize(R, P):
    m = R.ngens()
    return sum((vs(R, rho, P) for rho in permutations(range(m))), R(0))

def mon(R, a):
    X = R.gens()
    return prod((X[k]**a[k] for k in range(len(a))), R(1))

def shift(R, P):
    # sd(P): mco_d(sd(P)) = mco_{d+1}(P)。P の各項 c に対し、c >= 1 なら c - 1 へ写す。
    Q = R(0)
    for c, v in P.dict().items():
        c = tuple(c) if not isinstance(c, (int, Integer)) else (int(c),)
        if all(ci >= 1 for ci in c):
            Q += v * mon(R, tuple(ci - 1 for ci in c))
    return Q

def comp(a, rho):
    # (a ∘ ϱ)(k) = a(ϱ(k))
    return tuple(a[rho[k]] for k in range(len(rho)))

def add(a, b):
    return tuple(a[k] + b[k] for k in range(len(a)))

s2 = QQbar(2).sqrt()
w3 = QQbar(-3).sqrt()
coeff_pool = [QQbar(1), QQbar(-2), s2, w3, 1 + s2 * w3]

for m in range(1, 5):
    R = ring(m)
    X = R.gens()
    ones = tuple([1] * m)
    # 零代入で消えない標本も含める（主張は lz の条件を要しない）。
    seeds = [R(1), X[0], X[0]**3 + s2 * X[0], X[0]**2 * X[-1] + w3 * X[0], X[0] * X[-1]**2 + X[0]**2]
    samples = [coeff_pool[i % len(coeff_pool)] * symmetrize(R, s) + coeff_pool[(i + 1) % len(coeff_pool)]
               for i, s in enumerate(seeds)]
    exps = list(iproduct(range(4), repeat=m))
    perms = list(permutations(range(m)))
    for P in samples:
        for rho in perms:
            check(vs(R, rho, P) == P, "symmetric m=%d" % m)
        Q = shift(R, P)
        for d in exps:
            check(mco(Q, d) == mco(P, add(d, ones)), "shift def m=%d d=%s" % (m, d))
        for rho in perms:
            VQ = vs(R, rho, Q)
            VP = vs(R, rho, P)
            for d in exps:
                # 準備の五つの等号（各成分で）
                dp1 = add(d, ones)
                for k in range(m):
                    p0 = comp(dp1, rho)[k]
                    p1 = dp1[rho[k]]
                    p2 = d[rho[k]] + ones[rho[k]]
                    p3 = d[rho[k]] + 1
                    p4 = comp(d, rho)[k] + ones[k]
                    p5 = add(comp(d, rho), ones)[k]
                    check(p0 == p1 == p2 == p3 == p4 == p5, "prep m=%d d=%s k=%d" % (m, d, k))
                check(comp(dp1, rho) == add(comp(d, rho), ones), "prep total m=%d d=%s" % (m, d))
                # 本文の六つの等号
                v0 = mco(VQ, d)
                v1 = mco(Q, comp(d, rho))
                v2 = mco(P, add(comp(d, rho), ones))
                v3 = mco(P, comp(dp1, rho))
                v4 = mco(VP, dp1)
                v5 = mco(P, dp1)
                v6 = mco(Q, d)
                check(v0 == v1, "line1 m=%d d=%s" % (m, d))
                check(v1 == v2, "line2 m=%d d=%s" % (m, d))
                check(v2 == v3, "line3 m=%d d=%s" % (m, d))
                check(v3 == v4, "line4 m=%d d=%s" % (m, d))
                check(v4 == v5, "line5 m=%d d=%s" % (m, d))
                check(v5 == v6, "line6 m=%d d=%s" % (m, d))
            check(VQ == Q, "claim vs(sd P) = sd P m=%d" % m)
    # 対照: 対称でない多項式では sd(P) が対称にならない例がある（m >= 2）。
    if m >= 2:
        Pc = mon(R, ones) * (X[0]**2 * X[1] + X[0] * X[1]**3)
        Qc = shift(R, Pc)
        check(any(vs(R, rho, Qc) != Qc for rho in perms), "control asymmetric m=%d" % m)

if failures:
    print("FAIL %d" % len(failures))
    for f in failures[:20]:
        print("  " + f)
else:
    print("PASS %d" % passes)
