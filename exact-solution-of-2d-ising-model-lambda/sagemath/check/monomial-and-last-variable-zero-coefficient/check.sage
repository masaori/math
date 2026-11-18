# 「単項式を掛けると係数は指数をずらしたものになる」と
# 「末尾の変数に零を代入した多項式の係数は末尾の指数が零の係数である」の式変形を一行ずつ確かめる。
# 対象ラベル: claim_qbar_monomial_multiplication_coefficient, claim_last_variable_zero_coefficient
# 帰属: 係数環は QQbar（代数的数）。多項式環 QQbar[X_0, ..., X_{n-1}] の等号と係数は厳密に判定する。
# 浮動小数点は使わない。n = 1, 2, 3 と、各成分が 0..2 の指数、代数的数を係数に持つ多項式の標本を総当たりする。

from itertools import product as iproduct

failures = []
passes = 0
def check(cond, msg):
    global passes
    if not cond:
        failures.append(msg)
    else:
        passes += 1

def ring(n):
    return PolynomialRing(QQbar, ['X%d' % k for k in range(n)], order='lex')

def mco(P, a):
    # 指数 a の係数 mco_a(P)
    return P.monomial_coefficient(P.parent().monomial(*a)) if P != 0 else QQbar(0)

def mon(R, a):
    X = R.gens()
    return prod((X[k]**a[k] for k in range(len(a))), R(1))

def le(a, c):
    return all(a[k] <= c[k] for k in range(len(a)))

def sub(c, a):
    return tuple(c[k] - a[k] for k in range(len(a)))

s2 = QQbar(2).sqrt()
w3 = QQbar(-3).sqrt()
coeff_pool = [QQbar(1), QQbar(-2), s2, w3, 1 + s2 * w3]

def sample_polys(R, n):
    X = R.gens()
    exps = list(iproduct(range(3), repeat=n))
    polys = [R(0), R(1)]
    for t in range(4):
        P = R(0)
        for i, e in enumerate(exps):
            if (i * 7 + t * 3) % 5 < 2:
                P += coeff_pool[(i + t) % len(coeff_pool)] * mon(R, e)
        polys.append(P)
    return polys

# 単項式を掛けたときの係数
for n in range(1, 4):
    R = ring(n)
    X = R.gens()
    exps = list(iproduct(range(3), repeat=n))
    for Q in sample_polys(R, n):
        # 準備: mco_c(X_k * Q)
        for k in range(n):
            dk = tuple(1 if i == k else 0 for i in range(n))
            for c in exps:
                lhs = mco(X[k] * Q, c)
                # 第一の等号: 積の係数の定義（b + e = c の組にわたる和）
                pairs = [(b, sub(c, b)) for b in iproduct(*[range(c[i] + 1) for i in range(n)])]
                line1 = sum((mco(X[k], b) * mco(Q, e) for (b, e) in pairs), QQbar(0))
                check(lhs == line1, "n=%d k=%d c=%s 準備の第一の等号" % (n, k, c))
                # 第二の等号: b = δ_k の項だけが残る
                line2 = sum((mco(Q, e) for (b, e) in pairs if b == dk), QQbar(0))
                check(line1 == line2, "n=%d k=%d c=%s 準備の第二の等号" % (n, k, c))
                # 第三の等号: δ_k ≤ c なら mco_{c-δ_k}(Q)、そうでなければ 0
                line3 = mco(Q, sub(c, dk)) if le(dk, c) else QQbar(0)
                check(line2 == line3, "n=%d k=%d c=%s 準備の第三の等号" % (n, k, c))
        # 本題: 各 a, c で主張と帰納法の段
        for a in exps:
            for c in exps:
                lhs = mco(mon(R, a) * Q, c)
                rhs = mco(Q, sub(c, a)) if le(a, c) else QQbar(0)
                check(lhs == rhs, "n=%d a=%s c=%s 主張" % (n, a, c))
                if sum(a) == 0:
                    check(mon(R, a) == R(1), "n=%d 零の段 mon(0) = 1" % n)
                    continue
                k = min(i for i in range(n) if a[i] >= 1)
                dk = tuple(1 if i == k else 0 for i in range(n))
                ap = sub(a, dk)
                check(mon(R, a) == X[k] * mon(R, ap), "n=%d a=%s mon(a) = X_k mon(a')" % (n, a))
                l1 = mco(X[k] * (mon(R, ap) * Q), c)
                check(lhs == l1, "n=%d a=%s c=%s 段の第一の等号" % (n, a, c))
                l2 = mco(mon(R, ap) * Q, sub(c, dk)) if le(dk, c) else QQbar(0)
                check(l1 == l2, "n=%d a=%s c=%s 段の第二の等号" % (n, a, c))
                l3 = mco(Q, sub(sub(c, dk), ap)) if (le(dk, c) and le(ap, sub(c, dk))) else QQbar(0)
                check(l2 == l3, "n=%d a=%s c=%s 段の第三の等号" % (n, a, c))
                check(l3 == rhs, "n=%d a=%s c=%s 段の第四の等号" % (n, a, c))

# 末尾の変数への零代入の係数
for n in range(1, 3):
    R1 = ring(n + 1)
    R0 = ring(n)
    X0 = R0.gens()
    vals = list(X0) + [R0(0)]
    for P in sample_polys(R1, n + 1):
        LZ = R0(P(*vals))
        support = [tuple(e) for e in P.exponents()] if P != 0 else []
        A0 = [a for a in support if a[n] == 0]
        A1 = [a for a in support if a[n] >= 1]
        for a in A1:
            check(prod((vals[k]**a[k] for k in range(n + 1)), R0(1)) == R0(0), "n=%d a=%s A_1 の項は零" % (n, a))
        for a in A0:
            check(prod((vals[k]**a[k] for k in range(n + 1)), R0(1)) == mon(R0, a[:n]), "n=%d a=%s A_0 の項は単項式" % (n, a))
        line2 = sum((R0(mco(P, a)) * mon(R0, a[:n]) for a in A0), R0(0))
        check(LZ == line2, "n=%d 第二の等号" % n)
        for b in iproduct(range(4), repeat=n):
            lhs = mco(LZ, b)
            line3 = sum((mco(R0(mco(P, a)) * mon(R0, a[:n]), b) for a in A0), QQbar(0))
            check(lhs == line3, "n=%d b=%s 第三の等号" % (n, b))
            line4 = sum((mco(P, a) for a in A0 if a[:n] == b), QQbar(0))
            check(line3 == line4, "n=%d b=%s 第四の等号" % (n, b))
            ez = tuple(b) + (0,)
            check(line4 == mco(P, ez), "n=%d b=%s 第五の等号（主張）" % (n, b))

if failures:
    print("FAIL", len(failures))
    for f in failures[:20]:
        print("  ", f)
else:
    print("PASS", passes)
