# 主張「基本対称式への代入は末尾の変数への零代入と入れ替わる」の式変形を一行ずつ確かめる。
# 対象ラベル: claim_elementary_symmetric_substitution_last_variable_zero
# 帰属: 係数環は QQbar（代数的数）。多項式環 QQbar[X_0, ..., X_{n-1}] の等号は厳密に判定する。
# 浮動小数点は使わない。

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

def support(Q):
    n = Q.parent().ngens()
    out = []
    for a, c in Q.dict().items():
        a = tuple(a) if hasattr(a, '__iter__') else (int(a),)
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

def samples(R):
    X = R.gens()
    n = len(X)
    out = [R(0), R(1), R(-3 + s2)]
    if n >= 1:
        out.append(X[0]**2 - s2 * X[0] + 5)
        out.append(X[n - 1]**2 + X[0] * X[n - 1] - 2)
    if n >= 2:
        out.append(X[0] * X[1]**2 + (1 + s2) * X[1] - QQbar(2)/3)
    if n >= 3:
        out.append(X[2]**3 * X[0] - X[1] * X[2] + s2)
    return out

for n in range(0, 5):
    R1 = ring(n + 1)   # QQbar[X_{<n+1}]
    R0 = ring(n)       # QQbar[X_{<n}]
    X0 = R0.gens()
    z = [X0[k] for k in range(n)] + [R0(0)]          # z_n
    ee1 = [es(R1, j + 1) for j in range(n + 1)]       # ee_{n+1}
    ee0 = [es(R0, j + 1) for j in range(n)]           # ee_n
    lz = lambda P: ms(z, P, R0)
    # 準備: ms_{z_n} ∘ ee_{n+1} = ms_{ee_n} ∘ z_n、場合ごとに一行ずつ。
    left = [lz(ee1[j]) for j in range(n + 1)]
    right = [ms(ee0, z[j], R0) for j in range(n + 1)]
    for j in range(n):
        l1 = lz(ee1[j]); l1a = ms(z, es(R1, j + 1), R0); l2 = lz(es(R1, j + 1)); l3 = es(R0, j + 1); l4 = ee0[j]
        l5 = ms(ee0, X0[j], R0); l6 = ms(ee0, z[j], R0)
        check(l1 == l1a == l2 == l3 == l4 == l5 == l6, "prep j<n n=%d j=%d" % (n, j))
    l1 = lz(ee1[n]); l1a = ms(z, es(R1, n + 1), R0); l2 = lz(es(R1, n + 1)); l3 = es(R0, n + 1); l4 = R0(0)
    l5 = ms(ee0, R0(0), R0); l6 = ms(ee0, z[n], R0)
    check(l1 == l1a == l2 == l3 == l4 == l5 == l6, "prep j=n n=%d" % n)
    check(left == right, "prep maps equal n=%d" % n)
    # 主張の五つの等号。
    for Q in samples(R1):
        se1Q = ms(ee1, Q, R1)
        m0 = lz(se1Q)
        m0a = lz(ms(ee1, Q, R1))
        m1 = ms(z, ms(ee1, Q, R1), R0)
        m2 = ms(left, Q, R0)
        m3 = ms(right, Q, R0)
        m4 = ms(ee0, ms(z, Q, R0), R0)
        m4a = ms(ee0, lz(Q), R0)
        m5 = ms(ee0, lz(Q), R0)
        check(m0 == m0a == m1 == m2 == m3 == m4 == m4a == m5, "claim n=%d Q=%s" % (n, Q))

# 対照: 末尾の値を零でなく 1 にした代入では入れ替わらない例がある。
R1 = ring(2); R0 = ring(1); X0 = R0.gens(); X1 = R1.gens()
bad = [X0[0], R0(1)]
ee1 = [es(R1, 1), es(R1, 2)]; ee0 = [es(R0, 1)]
Q = X1[1]
check(ms(bad, ms(ee1, Q, R1), R0) != ms(ee0, ms(bad, Q, R0), R0), "control: nonzero last value breaks commutation")

print("PASS %d" % passes if not failures else "FAIL %d: %s" % (len(failures), failures[:5]))
