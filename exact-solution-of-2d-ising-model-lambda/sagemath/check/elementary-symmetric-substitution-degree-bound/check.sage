# 節「基本対称式への代入」の全次数の七つのブロックを一行ずつ確かめる。
# 対象ラベル: def_qbar_multivariate_weighted_degree, claim_qbar_total_degree_constant,
#   claim_qbar_total_degree_finite_sum_bound, claim_qbar_total_degree_product_bound,
#   claim_qbar_total_degree_finite_product_bound, claim_qbar_elementary_symmetric_total_degree_bound,
#   claim_elementary_symmetric_substitution_degree_bound
# 帰属: 係数環は QQbar（代数的数）、次数は ZZ の非負元。全次数・重み付き次数は指数の台から
# 定義どおりに数える（Sage の degree() は使わない）。浮動小数点は使わない。

from itertools import combinations

failures = []
passes = 0
def check(cond, msg):
    global passes
    if not cond:
        failures.append(msg)
    else:
        passes += 1

s2 = QQbar(2).sqrt()

def ring(m):
    if m == 0:
        return PolynomialRing(QQbar, 'Z', 0)
    return PolynomialRing(QQbar, ['X%d' % k for k in range(m)])

def cdict(P, n):
    # 係数を指数（n 成分の組）から引く辞書。零の係数は載せない。
    out = {}
    for a, c in P.dict().items():
        if n == 1 and not hasattr(a, '__iter__'):
            a = (int(a),)
        else:
            a = tuple(int(x) for x in a)
        if c != 0:
            out[a] = c
    return out

def spt(P, n):
    # def_qbar_multivariate_total_degree の spt_n(P): 係数が零でない指数の全体。
    return list(cdict(P, n).keys())

def sz(a):
    return sum(a)

def wsz(a):
    # def_qbar_multivariate_weighted_degree: Σ_k (k+1)·a(k)。
    return sum((k + 1) * a[k] for k in range(len(a)))

def tdeg(P, n):
    return max([0] + [sz(a) for a in spt(P, n)])

def wdeg(Q, n):
    return max([0] + [wsz(a) for a in spt(Q, n)])

def es(R, j):
    X = R.gens()
    n = len(X)
    return sum((prod((X[k] for k in S), R(1)) for S in combinations(range(n), j)), R(0))

def samples(R):
    X = R.gens()
    n = len(X)
    out = [R(0), R(1), R(s2) - 3]
    if n >= 1:
        out.append(X[0]**2 - s2 * X[0] + 5)
    if n >= 2:
        out.append(X[0] * X[1]**2 + (1 + s2) * X[1] - QQbar(2)/3)
        out.append(X[1]**3 - X[0]**4)
    if n >= 3:
        out.append(X[2]**3 * X[0] - s2 * X[1] * X[2] + 4)
        out.append(X[2]**2 + X[0] * X[1] * X[2])
    if n >= 4:
        out.append(X[3] * X[0] - X[1]**2 + X[2])
    return out

for n in range(0, 5):
    R = ring(n)
    X = R.gens()
    S = samples(R)
    # claim_qbar_total_degree_constant: spt(mk_n(c)) ⊆ {0}、sz_n(0) = 0、tdeg_n(mk_n(c)) = 0。
    for c in [QQbar(0), QQbar(5)/3, s2]:
        P = R(c)
        check(all(all(x == 0 for x in a) for a in spt(P, n)), "constant support n=%d" % n)
        check(sz(tuple([0] * n)) == 0, "sz of zero n=%d" % n)
        check(tdeg(P, n) == 0, "constant tdeg n=%d c=%s" % (n, c))
    # def_qbar_multivariate_weighted_degree: 台の元の wsz は wdeg 以下。
    for Q in S:
        check(all(wsz(a) <= wdeg(Q, n) for a in spt(Q, n)), "wdeg max n=%d" % n)
    # claim_qbar_total_degree_finite_sum_bound: 和の係数は係数の和、台の元は或る項の台にあり、上界が保たれる。
    for r in range(0, 4):
        for I in combinations(range(len(S)), r):
            T = sum((S[i] for i in I), R(0))
            m = max([0] + [tdeg(S[i], n) for i in I])
            for a in spt(T, n):
                check(cdict(T, n)[a] == sum((cdict(S[i], n).get(a, 0) for i in I), QQbar(0)), "sum coeff n=%d" % n)
                check(any(a in spt(S[i], n) for i in I), "sum support n=%d" % n)
                check(sz(a) <= m, "sum bound element n=%d" % n)
            check(tdeg(T, n) <= m, "sum bound n=%d" % n)
    # claim_qbar_total_degree_product_bound: sz(b+c) = sz(b)+sz(c)、積の台の元は台の元の和、上界。
    for A in S:
        for B in S:
            AB = A * B
            for a in spt(AB, n):
                pairs = [(b, c) for b in spt(A, n) for c in spt(B, n) if tuple(b[k] + c[k] for k in range(n)) == a]
                check(len(pairs) > 0, "product support n=%d" % n)
                for b, c in pairs:
                    check(sz(tuple(b[k] + c[k] for k in range(n))) == sz(b) + sz(c), "sz additive n=%d" % n)
                    check(sz(a) <= tdeg(A, n) + sz(c) <= tdeg(A, n) + tdeg(B, n), "product chain n=%d" % n)
            check(tdeg(AB, n) <= tdeg(A, n) + tdeg(B, n), "product bound n=%d" % n)
    # claim_qbar_total_degree_finite_product_bound: 空の積 mk_n(1) の全次数 0、帰納法の各段。
    check(tdeg(R(1), n) == 0, "empty product n=%d" % n)
    acc = R(1)
    accbound = 0
    for P in S:
        new = P * acc
        check(tdeg(new, n) <= tdeg(P, n) + tdeg(acc, n), "finite product step1 n=%d" % n)
        check(tdeg(P, n) + tdeg(acc, n) <= tdeg(P, n) + accbound, "finite product step2 n=%d" % n)
        accbound = tdeg(P, n) + accbound
        acc = new
        check(tdeg(acc, n) <= accbound, "finite product bound n=%d" % n)
    # claim_qbar_elementary_symmetric_total_degree_bound: tdeg(X_k) ≤ 1、各項の評価、tdeg(es_{n,j}) ≤ j。
    for k in range(n):
        check(spt(X[k], n) == [tuple(1 if i == k else 0 for i in range(n))], "variable support n=%d" % n)
        check(tdeg(X[k], n) <= 1, "variable tdeg n=%d" % n)
    for j in range(0, n + 2):
        for Sset in combinations(range(n), j):
            term = prod((X[k] for k in Sset), R(1))
            check(tdeg(term, n) <= sum(tdeg(X[k], n) for k in Sset) <= len(Sset) == j, "es term n=%d j=%d" % (n, j))
        check(tdeg(es(R, j), n) <= j, "es bound n=%d j=%d" % (n, j))
    # claim_elementary_symmetric_substitution_degree_bound: 準備二つ、T_a の式鎖の各行、結論。
    ee = [es(R, k + 1) for k in range(n)]
    for A in S:
        for e in range(0, 4):
            check(tdeg(A**e, n) <= e * tdeg(A, n), "power bound n=%d e=%d" % (n, e))
    for k in range(n):
        check(tdeg(ee[k], n) <= k + 1, "ee bound n=%d k=%d" % (n, k))
    for Q in S:
        Qd = cdict(Q, n)
        terms = []
        for a in spt(Q, n):
            c = Qd[a]
            pr = prod((ee[k]**a[k] for k in range(n)), R(1))
            Ta = R(c) * pr
            terms.append(Ta)
            rows = [tdeg(Ta, n),
                    tdeg(R(c), n) + tdeg(pr, n),
                    tdeg(pr, n),
                    sum(tdeg(ee[k]**a[k], n) for k in range(n)),
                    sum(a[k] * tdeg(ee[k], n) for k in range(n)),
                    sum(a[k] * (k + 1) for k in range(n)),
                    sum((k + 1) * a[k] for k in range(n)),
                    wsz(a),
                    wdeg(Q, n)]
            check(all(rows[i] <= rows[i + 1] for i in range(len(rows) - 1)), "T_a chain n=%d a=%s" % (n, a))
            check(rows[1] - rows[2] == 0 and rows[5] == rows[6] == rows[7], "T_a equalities n=%d" % n)
        if n == 0:
            seQ = Q
        else:
            seQ = Q(*ee)
        check(seQ == sum(terms, R(0)), "se_n(Q) = Σ T_a n=%d" % n)
        check(tdeg(seQ, n) <= wdeg(Q, n), "main bound n=%d" % n)

# 対照: 等号が成り立つ例と、重みを全て 1 にした上界が成り立たない例。
R = ring(2)
X = R.gens()
Q = X[1]
seQ = Q(*[es(R, 1), es(R, 2)])
check(tdeg(seQ, 2) == wdeg(Q, 2) == 2, "equality example")
check(not (tdeg(seQ, 2) <= tdeg(Q, 2)), "unweighted bound fails")

print("PASS %d" % passes)
if failures:
    print("FAIL %d" % len(failures))
    for f in failures[:20]:
        print(f)
    raise SystemExit(1)
