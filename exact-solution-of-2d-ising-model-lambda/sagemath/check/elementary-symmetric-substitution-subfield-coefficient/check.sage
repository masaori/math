# 節「基本対称式への代入」の部分体係数の六つの主張を一行ずつ確かめる。
# 対象ラベル: claim_subfield_coefficient_multivariate_constant, claim_subfield_coefficient_multivariate_variable,
#   claim_subfield_coefficient_multivariate_finite_sum, claim_subfield_coefficient_multivariate_finite_product,
#   claim_qbar_elementary_symmetric_subfield_coefficient,
#   claim_elementary_symmetric_substitution_subfield_coefficient
# 帰属: 係数環は QQbar（代数的数）。部分体 F は QQ と QQ(√2)（QQbar の部分体）。
# 所属の判定は最小多項式と根の厳密な比較で行い、浮動小数点は使わない。

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
s3 = QQbar(3).sqrt()
K = NumberField(polygen(QQ)**2 - 2, 'r')
emb = [e for e in K.embeddings(QQbar) if e(K.gen()) == s2][0]

def in_QQ(c):
    return QQbar(c).minpoly().degree() == 1

def in_QQs2(c):
    c = QQbar(c)
    m = c.minpoly()
    if m.degree() > 2:
        return False
    return any(emb(rho) == c for rho, _ in m.change_ring(K).roots())

FIELDS = [("QQ", in_QQ), ("QQ(sqrt2)", in_QQs2)]

def ring(m):
    if m == 0:
        return PolynomialRing(QQbar, 'Z', 0)
    return PolynomialRing(QQbar, ['X%d' % k for k in range(m)])

def coeffs(P):
    return [c for c in P.dict().values()]

def in_FX(P, inF):
    # def_subfield_coefficient_multivariate_polynomials: 全ての係数が F に属する（零の係数は 0 ∈ F）。
    return all(inF(c) for c in coeffs(P))

def support(Q):
    out = []
    for a, c in Q.dict().items():
        a = tuple(a) if hasattr(a, '__iter__') else (int(a),)
        if c != 0:
            out.append((a, c))
    return out

def es(R, j):
    X = R.gens()
    n = len(X)
    return sum((prod((X[k] for k in S), R(1)) for S in combinations(range(n), j)), R(0))

def samples(R, name):
    X = R.gens()
    n = len(X)
    c = QQbar(1) if name == "QQ" else s2
    out = [R(0), R(1), R(QQbar(-3)/7) + R(c)]
    if n >= 1:
        out.append(X[0]**2 - c * X[0] + 5)
    if n >= 2:
        out.append(X[0] * X[1]**2 + (1 + c) * X[1] - QQbar(2)/3)
    if n >= 3:
        out.append(X[2]**3 * X[0] - c * X[1] * X[2] + 4)
    return out

for name, inF in FIELDS:
    for n in range(0, 5):
        R = ring(n)
        X = R.gens()
        # 定数: a が零写像なら係数 c、そうでなければ 0。
        for c in [QQbar(0), QQbar(5)/3, (s2 if name != "QQ" else QQbar(-2))]:
            check(inF(c), "sample constant in F")
            P = R(c)
            check(in_FX(P, inF), "constant %s n=%d" % (name, n))
        # 変数: δ_k の係数 1、他は 0。
        for k in range(n):
            check(list(X[k].dict().values()) == [1], "variable coeffs")
            check(in_FX(X[k], inF), "variable %s n=%d k=%d" % (name, n, k))
        # 有限和・有限積: 標本の部分族ごとに、帰納法の各段（空、一つ足す）を確かめる。
        fam = samples(R, name)
        for P in fam:
            check(in_FX(P, inF), "sample in F[X]")
        acc_s = R(0); acc_p = R(1)
        check(in_FX(acc_s, inF) and in_FX(acc_p, inF), "empty sum/product")
        check(acc_p == R(QQbar(1)), "empty product is mk_n(1)")
        for P in fam:
            new_s = P + acc_s
            # 和の係数 mco_a(P + S') = mco_a(P) + mco_a(S')
            dP, dS, dN = P.dict(), acc_s.dict(), new_s.dict()
            for a in set(list(dP.keys()) + list(dS.keys())):
                check(dN.get(a, 0) == dP.get(a, 0) + dS.get(a, 0), "sum coefficient")
            acc_s = new_s
            check(in_FX(acc_s, inF), "finite sum %s n=%d" % (name, n))
            acc_p = P * acc_p
            check(in_FX(acc_p, inF), "finite product %s n=%d" % (name, n))
        # 基本対称式。
        for j in range(n + 2):
            check(in_FX(es(R, j), inF), "es %s n=%d j=%d" % (name, n, j))
        # 主張: se_n(Q) の式鎖と所属。
        ee = [es(R, k + 1) for k in range(n)]
        for Q in samples(R, name):
            AQ = support(Q)
            T = {}
            for a, c in AQ:
                mk = R(c)
                check(in_FX(mk, inF), "mk_n(mco_a(Q))")
                pw = [ee[k]**a[k] for k in range(n)]
                for P in pw:
                    check(in_FX(P, inF), "ee^a")
                pr = prod(pw, R(1))
                check(in_FX(pr, inF), "product of powers")
                T[a] = mk * pr
                check(in_FX(T[a], inF), "T_a")
            l0 = Q(*ee) if n > 0 else Q          # se_n(Q) = ms_{ee_n}(Q)（Sage の代入）
            l1 = sum((T[a] for a, _ in AQ), R(0))
            check(l0 == l1, "chain se_n(Q) = Σ T_a %s n=%d" % (name, n))
            check(in_FX(l1, inF), "claim %s n=%d Q=%s" % (name, n, Q))

# 対照: 係数が F の外（√3 ∉ QQ(√2)）にある Q では se_n(Q) は F[X] に属さない例がある。
R = ring(2); X = R.gens()
Q = s3 * X[0]
check(not in_FX(Q(es(R, 1), es(R, 2)), in_QQs2), "control: coefficient outside F")

print("PASS %d" % passes if not failures else "FAIL %d: %s" % (len(failures), failures[:5]))
