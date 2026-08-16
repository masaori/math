# 対象ラベル: claim_rational_embedding_commutes_with_integer_multiple
# 帰属: ZZ・QQ と有限台辞書だけを使う厳密計算。

from itertools import product


def iota(v):
    # ι: Λ → Λ_Q（各素数での整数値を分母 1 の有理数として読む）
    return {p: QQ(a) for p, a in v.items()}


def qsmul(c, v):
    # Λ_Q の有理数倍
    return {p: QQ(c) * a for p, a in v.items() if QQ(c) * a != 0}


def zsmul(n, v):
    # Λ の整数倍
    return {p: ZZ(n) * a for p, a in v.items() if ZZ(n) * a != 0}


samples = [
    {},
    {2: ZZ(1)},
    {3: ZZ(-2)},
    {2: ZZ(3), 5: ZZ(-1)},
    {2: ZZ(-4), 3: ZZ(7), 11: ZZ(2)},
]

count = 0
for n, nu in product(range(-6, 7), samples):
    lhs = qsmul(QQ(n), iota(nu))          # n·ι(ν)
    rhs = iota(zsmul(n, nu))              # ι(nν)
    assert lhs == rhs
    # 各素数での値の五段の鎖: (n·ι(ν))(p) = n·(ν(p)/1) = (n·ν(p))/1 = (nν)(p)/1
    for p in set(nu.keys()):
        assert QQ(n) * (QQ(nu[p]) / QQ(1)) == QQ(ZZ(n) * nu[p]) / QQ(1)
        assert QQ(ZZ(n) * nu[p]) / QQ(1) == QQ(zsmul(n, nu).get(p, ZZ(0)))
        count += 2
    count += 1

print("PASS: rational-embedding-commutes-with-integer-multiple (%d checks)" % count)
