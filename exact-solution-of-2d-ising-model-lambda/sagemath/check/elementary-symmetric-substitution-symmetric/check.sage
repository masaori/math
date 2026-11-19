# 節「基本対称式への代入」（対称性の部分）の式変形を一行ずつ確かめる。
# 対象ラベル: claim_qbar_multivariate_substitution_composition,
#   claim_qbar_elementary_symmetric_is_symmetric, def_elementary_symmetric_substitution,
#   claim_elementary_symmetric_substitution_symmetric
# 帰属: 係数環は QQbar（代数的数）。多項式環 QQbar[X_0, ..., X_{n-1}] の等号は厳密に判定する。
# 浮動小数点は使わない。

from itertools import permutations, combinations

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

def support(Q):
    # mco_a(Q) ≠ 0 となる指数 a と係数の組。
    R = Q.parent()
    n = R.ngens()
    out = []
    for a, c in Q.dict().items():
        a = tuple(a) if n != 1 else (tuple(a) if hasattr(a, '__iter__') else (int(a),))
        if c != 0:
            out.append((a, c))
    return out

def ms(y, Q, Rt):
    # def_qbar_multivariate_substitution の定義どおりの和: Σ mk(mco_a(Q)) · Π y(k)^{a(k)}。
    n = Q.parent().ngens()
    total = Rt(0)
    for a, c in support(Q):
        term = Rt(c)
        for k in range(n):
            term = term * y[k]**a[k]
        total = total + term
    return total

def es(R, j):
    X = R.gens()
    n = len(X)
    return sum((prod((X[k] for k in S), R(1)) for S in combinations(range(n), j)), R(0))

def vs(R, rho, P):
    X = R.gens()
    return ms([X[rho[k]] for k in range(R.ngens())], P, R)

# 標本の種。
def samples(R):
    X = R.gens()
    n = len(X)
    out = [R(0), R(1), R(-3 + s2)]
    if n >= 1:
        out.append(X[0]**2 - s2 * X[0] + 5)
    if n >= 2:
        out.append(X[0] * X[1]**2 + (1 + s2) * X[1] - QQbar(2)/3)
    if n >= 3:
        out.append(X[2]**3 * X[0] - X[1] * X[2] + s2)
    return out

# 代入の合成: 各行を確かめる。
for (n, m, p) in [(1, 2, 1), (2, 2, 3), (3, 2, 2), (2, 3, 1)]:
    Rn, Rm, Rp = ring(n), ring(m), ring(p)
    Xm = Rm.gens(); Xp = Rp.gens()
    e = [Xm[k % m]**2 + (k + 1) * Xm[(k + 1) % m] - s2 for k in range(n)]
    y = [Xp[(i + 1) % p] - i * Xp[0]**2 + 1 for i in range(m)]
    for Q in samples(Rn):
        supp = support(Q)
        inner = sum((Rm(c) * prod((e[k]**a[k] for k in range(n)), Rm(1)) for a, c in supp), Rm(0))
        line0 = ms(y, ms(e, Q, Rm), Rp)
        line1 = ms(y, inner, Rp)
        line2 = sum((ms(y, Rm(c), Rp) * prod((ms(y, e[k], Rp)**a[k] for k in range(n)), Rp(1)) for a, c in supp), Rp(0))
        line3 = sum((Rp(c) * prod((ms(y, e[k], Rp)**a[k] for k in range(n)), Rp(1)) for a, c in supp), Rp(0))
        comp = [ms(y, e[k], Rp) for k in range(n)]
        line4 = sum((Rp(c) * prod((comp[k]**a[k] for k in range(n)), Rp(1)) for a, c in supp), Rp(0))
        line5 = ms(comp, Q, Rp)
        check(inner == ms(e, Q, Rm), "composition line1 n=%d" % n)
        check(line0 == line1 == line2 == line3 == line4 == line5, "composition chain n=%d m=%d p=%d Q=%s" % (n, m, p, Q))
        # Sage の代入（環準同型）とも一致すること。
        check(line5 == Rp(Q(*comp)) if n > 0 else True, "composition vs sage subs")

# 基本対称式の対称性: 二つの準備と六つの等号。
for n in range(0, 5):
    R = ring(n)
    X = R.gens()
    for rho in permutations(range(n)):
        rinv = [rho.index(i) for i in range(n)]
        for j in range(0, n + 2):
            subsets = [frozenset(S) for S in combinations(range(n), j)]
            img = lambda S: frozenset(rho[k] for k in S)
            # 第一の準備。
            for S in subsets:
                check(prod((X[rho[k]] for k in S), R(1)) == prod((X[i] for i in img(S)), R(1)), "prep1")
            # 第二の準備: S ↦ ϱ(S) は j 元部分集合の全単射、逆は T ↦ ϱ^{-1}(T)。
            images = [img(S) for S in subsets]
            check(all(len(T) == j for T in images), "prep2 card")
            check(set(images) == set(subsets) and len(set(images)) == len(subsets), "prep2 bijective")
            check(all(frozenset(rinv[i] for i in img(S)) == S for S in subsets), "prep2 inverse")
            l1 = vs(R, rho, sum((prod((X[k] for k in S), R(1)) for S in subsets), R(0)))
            l2 = sum((prod((vs(R, rho, X[k]) for k in S), R(1)) for S in subsets), R(0))
            l3 = sum((prod((X[rho[k]] for k in S), R(1)) for S in subsets), R(0))
            l4 = sum((prod((X[i] for i in img(S)), R(1)) for S in subsets), R(0))
            l5 = sum((prod((X[i] for i in T), R(1)) for T in subsets), R(0))
            check(vs(R, rho, es(R, j)) == l1 == l2 == l3 == l4 == l5 == es(R, j), "es symmetric n=%d j=%d" % (n, j))

# 基本対称式への代入の対称性: 準備の四つの等号と主張の四つの等号。
for n in range(1, 5):
    R = ring(n)
    X = R.gens()
    ee = [es(R, j + 1) for j in range(n)]
    def se(Q):
        return ms(ee, Q, R)
    for Q in samples(R):
        S = se(Q)
        for rho in permutations(range(n)):
            xv = [X[rho[k]] for k in range(n)]
            comp = [ms(xv, ee[j], R) for j in range(n)]
            check(all(comp[j] == ms(xv, es(R, j + 1), R) == vs(R, rho, es(R, j + 1)) == es(R, j + 1) == ee[j] for j in range(n)), "prep comp = ee")
            m0 = vs(R, rho, S)
            m1a = ms(xv, S, R)
            m1 = ms(xv, ms(ee, Q, R), R)
            m2 = ms(comp, Q, R)
            m3 = ms(ee, Q, R)
            check(m0 == m1a == m1 == m2 == m3 == S, "se symmetric n=%d" % n)

# 対照: 基本対称式でない値（変数そのものを一つずらしたもの）を代入すると対称でない例がある。
R = ring(2); X = R.gens()
bad = ms([X[0], X[0] * X[1]], X[0], R)  # = X0、対称でない
check(vs(R, (1, 0), bad) != bad, "control: non-symmetric values give non-symmetric result")

print("PASS %d" % passes if not failures else "FAIL %d: %s" % (len(failures), failures[:5]))
