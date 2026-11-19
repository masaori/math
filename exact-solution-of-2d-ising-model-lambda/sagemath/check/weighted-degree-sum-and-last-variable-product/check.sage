# 節「対称式の基本定理」の重み付き次数の和の上界と末尾の変数倍の上界を一行ずつ確かめる。
# 対象ラベル: claim_qbar_weighted_degree_sum_bound, claim_qbar_weighted_degree_last_variable_product_bound
# 帰属: 係数環は QQbar（代数的数）、次数は ZZ の非負元。重み付き次数は係数が零でない指数の集合から定義どおりに数える。
# 浮動小数点は使わない。
import itertools

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
    out = {}
    for a, c in P.dict().items():
        if n == 1 and not hasattr(a, '__iter__'):
            a = (int(a),)
        else:
            a = tuple(int(t) for t in a)
        if c != 0:
            out[a] = c
    return out

def mco(D, a):
    return D.get(tuple(a), QQbar(0))

def wsz(a):
    return sum((k + 1) * a[k] for k in range(len(a)))

def wdeg(D):
    return max([0] + [wsz(a) for a, c in D.items() if c != 0])

def delta(m, k):
    return tuple(1 if i == k else 0 for i in range(m))

def mon(m, a):
    R = ring(m)
    X = R.gens()
    return prod((X[k]**a[k] for k in range(m)), R(1))

def samples(n):
    R = ring(n)
    X = R.gens()
    out = [R(0), R(3), R(1 + s2)]
    if n >= 1:
        out += [X[0]**2 + s2 * X[0] - 7, (2 - s2) * X[-1]**3 + X[0]**2 + 1, -X[-1]**2]
    if n >= 2:
        out += [X[0] * X[1]**2 + s2 * X[1] - X[0]**3, X[0]**4 - X[1]**2, -X[0]**4 + 5 * X[1]]
    if n >= 3:
        out += [X[2]**3 * X[0] - X[1] * X[2] + s2 * X[0] * X[1] + 4, X[2] - X[0]**3]
    return out

# claim_qbar_weighted_degree_sum_bound
for n in range(0, 4):
    S = samples(n)
    for A in S:
        for B in S:
            DA, DB, DAB = cdict(A, n), cdict(B, n), cdict(A + B, n)
            for a in DAB:
                # 和の係数
                check(mco(DA, a) + mco(DB, a) == mco(DAB, a) and mco(DAB, a) != 0, "sum coeff n=%d" % n)
                if mco(DA, a) != 0:
                    check(wsz(a) <= wdeg(DA) and wdeg(DA) <= max(wdeg(DA), wdeg(DB)), "case A n=%d" % n)
                else:
                    check(mco(DB, a) == mco(DA, a) + mco(DB, a) and mco(DB, a) != 0, "case B coeff n=%d" % n)
                    check(wsz(a) <= wdeg(DB) and wdeg(DB) <= max(wdeg(DA), wdeg(DB)), "case B n=%d" % n)
            check(wdeg(DAB) <= max(wdeg(DA), wdeg(DB)), "sum conclusion n=%d" % n)
    # 対照: 打ち消しで真に小さくなることがある（等号とは限らない）。
    if n >= 1:
        X = ring(n).gens()
        A = X[-1]**2 + X[0]; B = -X[-1]**2
        check(wdeg(cdict(A + B, n)) < max(wdeg(cdict(A, n)), wdeg(cdict(B, n))), "control strict n=%d" % n)

# claim_qbar_weighted_degree_last_variable_product_bound（S ∈ QQbar[X_{<n+1}]）
for n in range(0, 3):
    m = n + 1
    R = ring(m)
    X = R.gens()
    d = delta(m, n)
    # 準備の式鎖の四つの値
    p1 = prod((X[k]**d[k] for k in range(m)), R(1))
    p2 = prod((X[k]**d[k] for k in range(n)), R(1)) * X[n]**d[n]
    p3 = prod((X[k]**0 for k in range(n)), R(1)) * X[n]**1
    check(mon(m, d) == p1 and p1 == p2 and p2 == p3 and p3 == X[n], "prep chain n=%d" % n)
    for S in samples(m):
        DS = cdict(S, m)
        P = X[n] * S
        DP = cdict(P, m)
        # claim_qbar_monomial_multiplication_coefficient の場合分け（小さな箱の全ての a）
        for a in itertools.product(range(5), repeat=m):
            le = all(d[k] <= a[k] for k in range(m))
            want = mco(DS, tuple(a[k] - d[k] for k in range(m))) if le else QQbar(0)
            check(mco(DP, a) == want, "monomial coeff n=%d a=%s" % (n, a))
        for a in DP:
            check(all(d[k] <= a[k] for k in range(m)), "delta <= a n=%d" % n)
            r = tuple(a[k] - d[k] for k in range(m))
            check(mco(DS, r) != 0, "a - delta in spt n=%d" % n)
            check(all(a[k] == d[k] + r[k] for k in range(m)), "split n=%d" % n)
            vals = [
                wsz(a),
                sum((k + 1) * a[k] for k in range(m)),
                sum((k + 1) * (d[k] + r[k]) for k in range(m)),
                sum((k + 1) * d[k] for k in range(m)) + sum((k + 1) * r[k] for k in range(m)),
                (n + 1) + sum((k + 1) * r[k] for k in range(m)),
                (n + 1) + wsz(r),
            ]
            check(all(vals[i] == vals[i + 1] for i in range(len(vals) - 1)), "wsz chain n=%d" % n)
            check(vals[-1] <= (n + 1) + wdeg(DS), "last inequality n=%d" % n)
        check(wdeg(DP) <= (n + 1) + wdeg(DS), "product conclusion n=%d" % n)
        # 体の上では零因子が無いので S ≠ 0 なら等号（主張は上界だけを述べる）。
        if S != 0:
            check(wdeg(DP) == (n + 1) + wdeg(DS), "equality over field n=%d" % n)

# 対照: 末尾でない変数を掛けると増分は n+1 ではなく k+1。
R = ring(2); X = R.gens()
check(wdeg(cdict(X[0] * X[1], 2)) == 1 + wdeg(cdict(X[1], 2)), "control non-last variable")

print("PASS %d" % passes)
if failures:
    print("FAIL %d" % len(failures))
    for f in failures[:20]:
        print("  " + f)
    raise SystemExit(1)
