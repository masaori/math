# 節「対称式の基本定理」の二つのブロックを一行ずつ確かめる。
# 対象ラベル: claim_last_variable_zero_subfield_coefficient, claim_last_variable_zero_total_degree_bound
# 帰属: 係数環は QQbar（代数的数）、部分体は F = QQ と F = QQ(√2)、次数は ZZ の非負元。
# 全次数は指数の台から定義どおりに数える（Sage の degree() は使わない）。浮動小数点は使わない。

failures = []
passes = 0
def check(cond, msg):
    global passes
    if not cond:
        failures.append(msg)
    else:
        passes += 1

s2 = QQbar(2).sqrt()
x = polygen(QQ)
K = NumberField(x**2 - 2, 'r')
emb = [e for e in K.embeddings(QQbar) if e(K.gen()) == s2][0]

def in_QQ(c):
    return c.minpoly().degree() == 1

def in_QQs2(c):
    return any(emb(t) == c for t in c.minpoly().roots(K, multiplicities=False))

FIELDS = [("QQ", in_QQ), ("QQ(sqrt2)", in_QQs2)]

def ring(m):
    if m == 0:
        return PolynomialRing(QQbar, 'Z', 0)
    return PolynomialRing(QQbar, ['X%d' % k for k in range(m)])

def cdict(P, n):
    out = {}
    for a, c in P.dict().items():
        if n == 1 and not hasattr(a, '__iter__'):
            a = (int(a),)
        else:
            a = tuple(int(t) for t in a)
        if c != 0:
            out[a] = c
    return out

def mco(P, n, a):
    return cdict(P, n).get(tuple(a), QQbar(0))

def spt(P, n):
    return list(cdict(P, n).keys())

def sz(a):
    return sum(a)

def tdeg(P, n):
    return max([0] + [sz(a) for a in spt(P, n)])

def ez(b):
    # def_exponent_zero_extension: 末尾に零を足す。
    return tuple(b) + (0,)

def lz(P, n, R1, R0):
    # def_last_variable_zero_substitution: X_k ↦ X_k（k < n）、X_n ↦ 0。
    phi = R1.hom(list(R0.gens()) + [R0(0)], R0)
    return phi(P)

def samples(R, coeffs):
    X = R.gens()
    m = len(X)
    a, b, c = coeffs
    out = [R(0), R(a), R(b) * X[-1]]
    if m >= 1:
        out.append(X[0]**2 * X[-1] + a * X[0] - c)
        out.append(b * X[-1]**3 + c * X[0]**2 + a)
    if m >= 2:
        out.append(X[0] * X[1]**2 + b * X[1] - c * X[0]**3)
        out.append(X[1]**4 * X[0] + a * X[-1] * X[0] + b)
    if m >= 3:
        out.append(X[2]**3 * X[0] - b * X[1] * X[2] + c * X[0] * X[1] + 4)
    if m >= 4:
        out.append(a * X[3] * X[0] - X[1]**2 * X[2] + c * X[2])
    return out

COEFFS = {"QQ": (QQbar(3), QQbar(-2)/5, QQbar(7)), "QQ(sqrt2)": (1 + s2, QQbar(2)/3 - s2, 5 * s2)}

for n in range(0, 4):
    R1 = ring(n + 1)
    R0 = ring(n)
    for (fname, in_F) in FIELDS:
        for P in samples(R1, COEFFS[fname]):
            L = lz(P, n, R1, R0)
            # 標本が F[X_{<n+1}] に属すること（前提）。
            check(all(in_F(c) for c in cdict(P, n + 1).values()), "sample in F n=%d F=%s" % (n, fname))
            # claim_last_variable_zero_subfield_coefficient: 各 b ∈ spt_n(lz P) で
            #   mco_b(lz_n(P)) = mco_{ez_n(b)}(P) ∈ F。（spt の外の b は係数 0 ∈ F。）
            for b in spt(L, n):
                check(mco(L, n, b) == mco(P, n + 1, ez(b)), "coeff formula n=%d" % n)
                check(in_F(mco(P, n + 1, ez(b))), "ez coeff in F n=%d F=%s" % (n, fname))
            check(all(in_F(c) for c in cdict(L, n).values()), "lz in F n=%d F=%s" % (n, fname))
            # claim_last_variable_zero_total_degree_bound の式鎖。
            for b in spt(L, n):
                e = ez(b)
                # 準備: mco_{ez(b)}(P) = mco_b(lz P) ≠ 0、ez(b) ∈ spt_{n+1}(P)。
                check(mco(P, n + 1, e) == mco(L, n, b) and mco(L, n, b) != 0, "prep n=%d" % n)
                check(e in spt(P, n + 1), "ez in spt n=%d" % n)
                vals = [
                    sz(b),
                    sum(b[k] for k in range(n)),
                    sum(e[k] for k in range(n)),
                    sum(e[k] for k in range(n)) + 0,
                    sum(e[k] for k in range(n)) + e[n],
                    sum(e[k] for k in range(n + 1)),
                    sz(e),
                ]
                check(all(vals[i] == vals[i + 1] for i in range(len(vals) - 1)), "chain equalities n=%d" % n)
                check(vals[-1] <= tdeg(P, n + 1), "chain last inequality n=%d" % n)
            check(tdeg(L, n) <= tdeg(P, n + 1), "conclusion n=%d" % n)

# 対照: 等号が成り立たない例。P = X_0 + X_1^3（n = 1）では lz_1(P) = X_0 で 1 < 3。
R1 = ring(2); R0 = ring(1)
P = R1.gens()[0] + R1.gens()[1]**3
check(tdeg(lz(P, 1, R1, R0), 1) == 1 and tdeg(P, 2) == 3, "strict example")
# 対照: 部分体の外の係数は残りうる。P = √2·X_0 は QQ 係数でなく、lz_1(P) = √2·X_0 も QQ 係数でない。
P = s2 * R1.gens()[0]
check((not in_QQ(mco(lz(P, 1, R1, R0), 1, (1,)))), "non-QQ coefficient survives")

if failures:
    print("FAIL", len(failures))
    for f in failures[:20]:
        print(" ", f)
else:
    print("PASS", passes)
