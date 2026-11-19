# 節「対称式の基本定理」の本体を、証明の構成どおりに再帰で実行し、式鎖を一行ずつ確かめる。
# 対象ラベル: claim_symmetric_polynomial_fundamental_theorem
# 帰属: 係数は二次体 Q(√2)（QuadraticField(2)。代数的数の部分体）とその部分体 Q。次数は ZZ の非負元。
# 浮動小数点は使わない。本文の n+1 変数の段は、ここでは変数の個数 m = n+1 の段として書く。
import itertools

failures = []
passes = 0
def check(cond, msg):
    global passes
    if not cond:
        failures.append(msg)
    else:
        passes += 1

K.<s2> = QuadraticField(2)

def ring(m):
    if m == 0:
        return PolynomialRing(K, 'Z', 0)
    return PolynomialRing(K, ['X%d' % k for k in range(m)])

def cdict(P, m):
    out = {}
    for a, c in P.dict().items():
        if m == 1 and not hasattr(a, '__iter__'):
            a = (int(a),)
        else:
            a = tuple(int(t) for t in a)
        if c != 0:
            out[a] = c
    return out

def from_dict(D, m):
    R = ring(m)
    if m == 0:
        return R(sum(D.values(), K(0)))
    X = R.gens()
    return sum((R(c) * prod((X[k]**a[k] for k in range(m)), R(1)) for a, c in D.items()), R(0))

def tdeg(P, m):
    return max([0] + [sum(a) for a in cdict(P, m)])

def wsz(a):
    return sum((k + 1) * a[k] for k in range(len(a)))

def wdeg(Q, m):
    return max([0] + [wsz(a) for a in cdict(Q, m)])

def in_field(P, m, F):
    # F は 'K'（Q(√2)）か 'Q'。
    return all(F == 'K' or c in QQ for c in cdict(P, m).values())

def es(m, j):
    R = ring(m)
    if j == 0:
        return R(1)
    if j > m:
        return R(0)
    X = R.gens()
    return sum((prod((X[k] for k in S), R(1)) for S in itertools.combinations(range(m), j)), R(0))

def se(Q, m):
    R = ring(m)
    if m == 0:
        return R(Q)
    return R(Q(*[es(m, j + 1) for j in range(m)]))

def vs(P, m, perm):
    R = ring(m)
    if m == 0:
        return R(P)
    X = R.gens()
    return R(P(*[X[perm[k]] for k in range(m)]))

def is_sym(P, m):
    return all(vs(P, m, perm) == P for perm in itertools.permutations(range(m)))

def lz(P, m):
    # m 変数から m-1 変数へ: 末尾の指数が零の係数だけを残す（claim_last_variable_zero_coefficient）。
    return from_dict({a[:-1]: c for a, c in cdict(P, m).items() if a[-1] == 0}, m - 1)

def ex(Q, m1):
    # m1 変数から m1+1 変数へ: 末尾の指数を零にした指数へ係数を置く（def_last_variable_extension）。
    return from_dict({a + (0,): c for a, c in cdict(Q, m1).items()}, m1 + 1)

def sd(R, m):
    return from_dict({tuple(t - 1 for t in a): c for a, c in cdict(R, m).items()}, m)

def mk(m, c):
    return ring(m)(c)

def fund(P, m, F, depth=0):
    """本文の証明の構成。m 変数の対称な P について Q を返し、各段を検査する。"""
    R_ = ring(m)
    d = tdeg(P, m)
    if m == 0:
        # P = mk_0(mco_0(P)) = se_0(mk_0(mco_0(P))) = se_0(P)
        c0 = cdict(P, 0).get((), K(0))
        check(P == mk(0, c0), "base: P = mk_0(mco_0 P)")
        check(se(mk(0, c0), 0) == mk(0, c0), "base: se_0(mk_0(c)) = mk_0(c)")
        check(wdeg(P, 0) == 0 and wdeg(P, 0) <= d, "base: wdeg_0 = 0 <= tdeg")
        return P
    n = m - 1
    # 準備: P_0 と Q_0
    P0 = lz(P, m)
    check(in_field(P0, n, F), "P0 in F")
    check(is_sym(P0, n), "P0 symmetric")
    check(tdeg(P0, n) <= d, "tdeg(P0) <= d")
    Q0 = fund(P0, n, F, depth + 1)
    check(P0 == se(Q0, n) and wdeg(Q0, n) <= tdeg(P0, n), "outer IH for P0")
    # 準備: Q_1
    Q1 = ex(Q0, n)
    check(in_field(Q1, m, F), "Q1 in F")
    chain = [wdeg(Q1, m), wdeg(Q0, n), tdeg(P0, n), d]
    check(all(chain[i] <= chain[i + 1] for i in range(3)), "Q1 wdeg chain")
    # 準備: R
    seQ1 = se(Q1, m)
    R = P + mk(m, -1) * seQ1
    check(in_field(mk(m, -1), m, F) and in_field(seQ1, m, F) and in_field(R, m, F), "R in F")
    for perm in itertools.permutations(range(m)):
        vals = [vs(R, m, perm),
                vs(P, m, perm) + vs(mk(m, -1), m, perm) * vs(seQ1, m, perm),
                P + vs(mk(m, -1), m, perm) * vs(seQ1, m, perm),
                P + mk(m, -1) * vs(seQ1, m, perm),
                P + mk(m, -1) * seQ1,
                R]
        check(all(vals[i] == vals[i + 1] for i in range(5)), "R symmetry chain")
    lzQ1 = lz(Q1, m)
    vals = [lz(R, m),
            lz(P, m) + lz(mk(m, -1), m) * lz(seQ1, m),
            P0 + mk(n, -1) * lz(seQ1, m),
            P0 + mk(n, -1) * se(lzQ1, n),
            P0 + mk(n, -1) * se(Q0, n),
            P0 + mk(n, -1) * P0,
            mk(n, 1) * P0 + mk(n, -1) * P0,
            (mk(n, 1) + mk(n, -1)) * P0,
            mk(n, 0) * P0,
            ring(n)(0)]
    check(all(vals[i] == vals[i + 1] for i in range(len(vals) - 1)), "lz(R) chain")
    t = mk(m, -1) * seQ1
    chain = [tdeg(t, m), tdeg(mk(m, -1), m) + tdeg(seQ1, m), 0 + tdeg(seQ1, m), 0 + wdeg(Q1, m), d]
    check(chain[0] <= chain[1] and chain[1] == chain[2] and chain[2] <= chain[3] and chain[3] <= chain[4],
          "tdeg term chain")
    check(tdeg(R, m) <= d, "tdeg(R) <= d")
    vals = [P, P + 0, P + mk(m, 0) * seQ1, P + (mk(m, 1) + mk(m, -1)) * seQ1,
            P + (mk(m, 1) * seQ1 + mk(m, -1) * seQ1), P + (seQ1 + mk(m, -1) * seQ1), seQ1 + R]
    check(all(vals[i] == vals[i + 1] for i in range(len(vals) - 1)), "P = se(Q1) + R chain")
    # 割り切れ
    S = sd(R, m)
    e_top = es(m, m)
    check(in_field(S, m, F) and is_sym(S, m) and R == e_top * S, "divisibility")
    X = R_.gens()
    if R == 0:
        Q = Q1
        check(P == seQ1 + 0 and P == se(Q, m) and wdeg(Q, m) <= d, "R = 0 case")
        return Q
    check(tdeg(S, m) + m == tdeg(R, m), "tdeg(S) + m = tdeg(R)")
    check(tdeg(S, m) < tdeg(S, m) + m and tdeg(S, m) + m <= d, "tdeg(S) < d")
    Q2 = fund(S, m, F, depth + 1)
    check(S == se(Q2, m) and wdeg(Q2, m) <= tdeg(S, m), "inner IH for S")
    Q = Q1 + X[n] * Q2
    check(in_field(Q, m, F), "Q in F")
    vals = [P, seQ1 + R, seQ1 + e_top * S, seQ1 + e_top * se(Q2, m), seQ1 + es(m, n + 1) * se(Q2, m),
            seQ1 + se(X[n], m) * se(Q2, m), se(Q1 + X[n] * Q2, m)]
    check(all(vals[i] == vals[i + 1] for i in range(len(vals) - 1)), "P = se(Q) chain")
    XQ2 = X[n] * Q2
    chain = [wdeg(Q, m), max(wdeg(Q1, m), wdeg(XQ2, m)), max(d, wdeg(XQ2, m)), max(d, m + wdeg(Q2, m)),
             max(d, m + tdeg(S, m)), max(d, tdeg(R, m)), d]
    ok = (chain[0] <= chain[1] <= chain[2] <= chain[3] <= chain[4]) and chain[4] == chain[5] == chain[6]
    check(ok, "wdeg(Q) chain")
    return Q

def symmetrize(P, m):
    return sum((vs(P, m, perm) for perm in itertools.permutations(range(m))), ring(m)(0))

set_random_seed(20261119)
count = 0
for m in range(0, 5):
    R_ = ring(m)
    X = R_.gens()
    samples = [(R_(0), 'Q'), (R_(3), 'Q'), (R_(1 + s2), 'K')]
    if m >= 1:
        samples += [(sum(x**2 for x in X), 'Q'), (sum(x**3 for x in X) + s2 * es(m, 1), 'K'),
                    (es(m, m)**2 - 5 * es(m, 1)**3 + 7, 'Q')]
    # 無作為な多項式の対称化
    for trial in range(6 if m <= 3 else 3):
        D = {}
        for _ in range(4):
            a = tuple(ZZ.random_element(0, 4 if m <= 3 else 3) for _ in range(m))
            D[a] = D.get(a, K(0)) + K(ZZ.random_element(-3, 4)) + (K(ZZ.random_element(-2, 3)) * s2 if trial % 2 else 0)
        P = symmetrize(from_dict(D, m), m)
        samples.append((P, 'K' if trial % 2 else 'Q'))
    for P, F in samples:
        check(is_sym(P, m) and in_field(P, m, F), "sample is symmetric with F coefficients")
        Q = fund(P, m, F)
        check(in_field(Q, m, F) and P == se(Q, m) and wdeg(Q, m) <= tdeg(P, m), "conclusion")
        count += 1
# 対照: 古典的な例 X0^2 + X1^2 = e1^2 - 2 e2（係数 -2 は Q にあり、N には無い）
R2 = ring(2)
Qc = fund(sum(x**2 for x in R2.gens()), 2, 'Q')
check(Qc == R2.gens()[0]**2 - 2 * R2.gens()[1], "classical example: Q = X0^2 - 2 X1")

print("samples:", count)
if failures:
    print("FAIL", len(failures), failures[:10])
else:
    print("PASS", passes)
