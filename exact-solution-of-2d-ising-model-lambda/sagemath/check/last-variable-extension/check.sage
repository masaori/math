# 節「対称式の基本定理」の末尾に変数を足す持ち上げの四つのブロックを一行ずつ確かめる。
# 対象ラベル: def_last_variable_extension, claim_last_variable_zero_of_extension,
#   claim_last_variable_extension_subfield_coefficient, claim_last_variable_extension_weighted_degree_bound
# 帰属: 係数環は QQbar（代数的数）、部分体は F = QQ と F = QQ(√2)、次数は ZZ の非負元。
# 持ち上げは係数の定義どおりに辞書で作る（Sage の環の埋め込みは使わない）。浮動小数点は使わない。
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

def from_cdict(D, n):
    R = ring(n)
    if n == 0:
        return R(D.get((), QQbar(0)))
    X = R.gens()
    return sum((c * prod(X[k]**a[k] for k in range(n)) for a, c in D.items()), R(0))

def mco(D, a):
    return D.get(tuple(a), QQbar(0))

def wsz(a):
    return sum((k + 1) * a[k] for k in range(len(a)))

def wdeg(D):
    return max([0] + [wsz(a) for a, c in D.items() if c != 0])

def ez(b):
    return tuple(b) + (0,)

def restr(a):
    return tuple(a[:-1])

def ex(DQ, n):
    # def_last_variable_extension: 末尾の指数が零の a には mco_{a|<n}(Q)、零でない a には 0。
    # 係数が零でない a は ez(b)（b ∈ spt_n(Q)）に限られるので、それだけを辞書に置く。
    return {ez(b): c for b, c in DQ.items() if c != 0}

def lz(P, n):
    R1 = ring(n + 1); R0 = ring(n)
    phi = R1.hom(list(R0.gens()) + [R0(0)], R0)
    return phi(P)

def samples(n, coeffs):
    R = ring(n)
    X = R.gens()
    a, b, c = coeffs
    out = [R(0), R(a)]
    if n >= 1:
        out.append(X[0]**2 + a * X[0] - c)
        out.append(b * X[-1]**3 + c * X[0]**2 + a)
    if n >= 2:
        out.append(X[0] * X[1]**2 + b * X[1] - c * X[0]**3)
        out.append(X[0]**2 + X[1]**2 + a * X[0] * X[1])
    if n >= 3:
        out.append(X[2]**3 * X[0] - b * X[1] * X[2] + c * X[0] * X[1] + 4)
    return out

COEFFS = {"QQ": (QQbar(3), QQbar(-2)/5, QQbar(7)), "QQ(sqrt2)": (1 + s2, QQbar(2)/3 - s2, 5 * s2)}

for n in range(0, 4):
    for (fname, in_F) in FIELDS:
        for Q in samples(n, COEFFS[fname]):
            DQ = cdict(Q, n)
            DE = ex(DQ, n)
            E = from_cdict(DE, n + 1)
            # 前提: Q ∈ F[X_{<n}]。
            check(all(in_F(c) for c in DQ.values()), "sample in F n=%d" % n)
            # def_last_variable_extension: 指数の小さな箱の全ての a で係数の場合分けの式が成り立つこと。
            top = 4
            for a in itertools.product(range(top + 1), repeat=n + 1):
                want = mco(DQ, restr(a)) if a[n] == 0 else QQbar(0)
                check(mco(DE, a) == want, "definition coefficient n=%d a=%s" % (n, a))
            # 定義の段落: 係数が零でない a は a(n) = 0、a|<n ∈ spt_n(Q)、a = ez_n(a|<n)。
            for a in DE:
                check(a[n] == 0 and restr(a) in DQ and a == ez(restr(a)), "support n=%d" % n)
            # claim_last_variable_zero_of_extension の式鎖（b ∈ spt_n(Q) と、spt の外の b を数個）。
            bs = list(DQ.keys()) + [tuple([1] * n), tuple([5] * n)]
            for b in bs:
                L = cdict(lz(E, n), n)
                vals = [mco(L, b), mco(DE, ez(b)), mco(DQ, restr(ez(b))), mco(DQ, b)]
                check(ez(b)[n] == 0 and restr(ez(b)) == b, "ez facts n=%d" % n)
                check(all(vals[i] == vals[i + 1] for i in range(3)), "lz-ex chain n=%d b=%s" % (n, b))
            check(lz(E, n) == Q, "lz(ex(Q)) = Q n=%d" % n)
            # claim_last_variable_extension_subfield_coefficient: 二つの場合の係数の所属。
            for a in itertools.product(range(3), repeat=n + 1):
                cf = mco(DE, a)
                if a[n] == 0:
                    check(cf == mco(DQ, restr(a)) and in_F(cf), "subfield case a(n)=0 n=%d" % n)
                else:
                    check(cf == 0 and in_F(cf), "subfield case a(n)!=0 n=%d" % n)
            check(all(in_F(c) for c in cdict(E, n + 1).values()), "ex in F n=%d F=%s" % (n, fname))
            # claim_last_variable_extension_weighted_degree_bound の準備と式鎖。
            for a in cdict(E, n + 1):
                check(a[n] == 0, "support last zero n=%d" % n)
                check(mco(DQ, restr(a)) == mco(DE, a) and mco(DE, a) != 0, "prep n=%d" % n)
                r = restr(a)
                vals = [
                    wsz(a),
                    sum((k + 1) * a[k] for k in range(n + 1)),
                    sum((k + 1) * a[k] for k in range(n)) + (n + 1) * a[n],
                    sum((k + 1) * a[k] for k in range(n)) + (n + 1) * 0,
                    sum((k + 1) * a[k] for k in range(n)),
                    sum((k + 1) * r[k] for k in range(n)),
                    wsz(r),
                ]
                check(all(vals[i] == vals[i + 1] for i in range(len(vals) - 1)), "wsz chain n=%d" % n)
                check(vals[-1] <= wdeg(DQ), "wsz last inequality n=%d" % n)
            check(wdeg(cdict(E, n + 1)) <= wdeg(DQ), "conclusion n=%d" % n)

# 対照: 末尾の指数が零でない指数に係数を置くと lz で消え、元に戻らない。
R1 = ring(2)
Q = ring(1).gens()[0]
bad = R1.gens()[0] + R1.gens()[1]
check(lz(bad, 1) == Q and bad != from_cdict(ex(cdict(Q, 1), 1), 2), "control: lz is not injective")
# 対照: 同じ単項式でも末尾の変数に置くと重み付き次数が上がる（X_1 は重み 2、X_0 は重み 1）。
check(wdeg(cdict(R1.gens()[1], 2)) == 2 and wdeg(cdict(Q, 1)) == 1, "control: weight of last variable")

if failures:
    print("FAIL", len(failures))
    for f in failures[:20]:
        print(" ", f)
else:
    print("PASS", passes)
