# 節「部分体を係数とする多変数多項式と全次数」の式変形を一行ずつ確かめる。
# 対象ラベル: claim_symmetric_vanishing_last_variable_divisible_by_product,
#   claim_symmetric_vanishing_last_variable_shift_total_degree,
#   claim_qbar_all_ones_shift_subfield_coefficient,
#   def_subfield_coefficient_multivariate_polynomials, def_qbar_multivariate_total_degree
# 帰属: 係数環は QQbar（代数的数）。部分体 F は Q(√2)。多項式環 QQbar[X_0, ..., X_n] の等号・係数・
# F への所属は厳密に判定する。浮動小数点は使わない。

from itertools import product as iproduct, permutations

failures = []
passes = 0
def check(cond, msg):
    global passes
    if not cond:
        failures.append(msg)
    else:
        passes += 1

s2 = QQbar(2).sqrt()
s3 = QQbar(3).sqrt()

def in_F(x):
    # x ∈ Q(√2) ⊂ QQbar の判定: 最小多項式が一次、または二次で判別式が 2 × (有理数の平方)。
    x = QQbar(x)
    f = x.minpoly()
    if f.degree() == 1:
        return True
    if f.degree() != 2:
        return False
    disc = f.discriminant()
    return (disc / 2).is_square()

check(in_F(1 + s2 / 3) and in_F(-2) and not in_F(s3) and not in_F(s2 * s3), "in_F sanity")

def ring(m):
    return PolynomialRing(QQbar, ['X%d' % k for k in range(m)], order='lex')

def exps_of(P):
    out = []
    for c, v in P.dict().items():
        c = tuple(c) if not isinstance(c, (int, Integer)) else (int(c),)
        if v != 0:
            out.append(c)
    return out

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
    Q = R(0)
    for c in exps_of(P):
        if all(ci >= 1 for ci in c):
            Q += mco(P, c) * mon(R, tuple(ci - 1 for ci in c))
    return Q

def lz(R, P):
    X = R.gens()
    return P(*(list(X[:-1]) + [0]))

def sz(a):
    return sum(a)

def tdeg(P):
    # max({0} ∪ {sz(a) | a ∈ spt(P)})
    return max([0] + [sz(a) for a in exps_of(P)])

def add(a, b):
    return tuple(a[k] + b[k] for k in range(len(a)))

def sub(a, b):
    return tuple(a[k] - b[k] for k in range(len(a)))

def es(R, j):
    X = R.gens()
    m = R.ngens()
    from itertools import combinations
    return sum((prod((X[k] for k in S), R(1)) for S in combinations(range(m), j)), R(0))

def in_FX(P):
    return all(in_F(mco(P, a)) for a in exps_of(P))

F_pool = [QQbar(1), QQbar(-2), s2, 1 + s2 / 3]

for m in range(1, 5):          # m = n + 1
    R = ring(m)
    X = R.gens()
    ones = tuple([1] * m)
    seeds = [R(1), X[0], X[0]**2 + s2 * X[0], X[0]**3 * X[-1] + X[0] + 1, X[0]**2 * X[-1]**2 + 3 * X[0]]
    samples = [F_pool[i % len(F_pool)] * es(R, m) * symmetrize(R, sd) for i, sd in enumerate(seeds)]
    for P in samples:
        # 仮定: F 係数、対称、lz(P) = 0、P ≠ 0
        check(in_FX(P), "P in F[X] m=%d" % m)
        check(all(vs(R, rho, P) == P for rho in permutations(range(m))), "P symmetric m=%d" % m)
        check(lz(R, P) == 0, "lz P = 0 m=%d" % m)
        check(P != 0, "P nonzero m=%d" % m)
        Q = shift(R, P)
        # 部分体係数の主張: mco_d(sd P) = mco_{d+1}(P) ∈ F
        for d in exps_of(Q):
            check(mco(Q, d) == mco(P, add(d, ones)) and in_F(mco(Q, d)), "subfield coeff m=%d d=%s" % (m, d))
        check(in_FX(Q), "sd P in F[X] m=%d" % m)
        # 第一の準備の六つの等号（各成分が 0..3 の全ての d）
        for d in iproduct(range(4), repeat=m):
            v0 = sz(add(d, ones))
            v1 = sum(add(d, ones)[k] for k in range(m))
            v2 = sum(d[k] + ones[k] for k in range(m))
            v3 = sum(d[k] + 1 for k in range(m))
            v4 = sum(d[k] for k in range(m)) + sum(1 for k in range(m))
            v5 = sz(d) + sum(1 for k in range(m))
            v6 = sz(d) + m
            check(v0 == v1 == v2 == v3 == v4 == v5 == v6, "prep1 m=%d d=%s" % (m, d))
        # 第二の準備: c ∈ spt(P) なら 1 ≤ c、mco_{c-1}(sd P) = mco_{(c-1)+1}(P) = mco_c(P) ≠ 0
        for c in exps_of(P):
            check(all(ci >= 1 for ci in c), "prep2 1<=c m=%d c=%s" % (m, c))
            cm = sub(c, ones)
            check(add(cm, ones) == c, "prep2 (c-1)+1=c m=%d" % m)
            check(mco(Q, cm) == mco(P, add(cm, ones)) == mco(P, c) != 0, "prep2 chain m=%d c=%s" % (m, c))
            # 上からの評価の三行
            u0 = sz(c); u1 = sz(add(cm, ones)); u2 = sz(cm) + m; u3 = tdeg(Q) + m
            check(u0 == u1 == u2 <= u3, "upper chain m=%d c=%s" % (m, c))
        # 第三の準備: d ∈ spt(sd P) なら d + 1 ∈ spt(P)
        for d in exps_of(Q):
            check(mco(P, add(d, ones)) == mco(Q, d) != 0, "prep3 m=%d d=%s" % (m, d))
        check(tdeg(P) <= tdeg(Q) + m, "upper m=%d" % m)
        # 下からの評価: d_* で tdeg(sd P) = sz(d_*)
        dstar = max(exps_of(Q), key=sz)
        w0 = tdeg(Q) + m; w1 = sz(dstar) + m; w2 = sz(add(dstar, ones)); w3 = tdeg(P)
        check(w0 == w1 == w2 <= w3, "lower chain m=%d" % m)
        # 主張の等号とまとめの主張
        check(tdeg(Q) + m == tdeg(P), "claim tdeg m=%d" % m)
        check(all(vs(R, rho, Q) == Q for rho in permutations(range(m))), "Q symmetric m=%d" % m)
        check(P == es(R, m) * Q, "P = es * Q m=%d" % m)
    # 対照: P = 0 では全次数の等号が成り立たない（P ≠ 0 が効いている）。
    check(tdeg(shift(R, R(0))) + m != tdeg(R(0)), "control P=0 m=%d" % m)
    # 対照: 係数に √3 を持つ P では sd(P) も F 係数でない（F 係数の仮定が効いている）。
    Pc = s3 * es(R, m) * symmetrize(R, X[0] + 1)
    check(not in_FX(shift(R, Pc)), "control coeff not in F m=%d" % m)

if failures:
    print("FAIL %d" % len(failures))
    for f in failures[:20]:
        print("  " + f)
else:
    print("PASS %d" % passes)
