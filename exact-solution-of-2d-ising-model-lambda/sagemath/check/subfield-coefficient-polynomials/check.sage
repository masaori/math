# 「部分体を係数とする多項式と部分体上の次数」の段を厳密計算で確かめる。
# 対象ラベル: claim_subfield_contains_rationals, def_subfield_coefficient_polynomials,
#   claim_subfield_coefficient_vanishing_polynomial_exists, def_degree_over_subfield
# 帰属: QQ・数体・QQbar の厳密計算。浮動小数点を使わない。

import random
random.seed(int(20261117))

failures = []
def check(cond, msg):
    if not cond:
        failures.append(msg)

# モデル: F = Q(s)（s*s = 2）。数体 K の元として表す。
R.<x> = QQ[]
K.<s> = NumberField(x^2 - 2)

# 有理数の所属の段: 自然数の帰納法・整数の符号反転・商。
acc = K(0)
for n in range(0, 50):
    check(acc == K(n), "自然数の段 n=%d" % n)
    acc = acc + K(1)
for _ in range(200):
    a = ZZ(random.randint(-10**6, 10**6))
    b = ZZ(random.randint(1, 10**6))
    if a < 0:
        check(K(a) == -K(-a), "整数の段 a=%d" % a)
    q = QQ(a) / QQ(b)
    check(K(a) / K(b) == K(q), "商の段 q=%s" % q)
    check(K(q) in K, "所属 q=%s" % q)

# 零化多項式の存在と次数: 代数的数 α ごとに、有理係数の最小多項式 p を取り、
# (1) p の係数が有理数（したがって F に属する）、p ≠ 0、p(α) = 0。
# (2) F = Q と F = Q(s) のそれぞれで、D_F(α) の最小元を、
#     「1, α, …, α^(d-1) が F 上一次独立で、1, α, …, α^d が一次従属」となる d として求め、
#     既知の値（Q 上なら最小多項式の次数、Q(s) 上なら p の Q(s) 上の因子のうち α を根とするものの次数）と照合する。
alphas = [QQbar(2).sqrt(), QQbar(3).sqrt(), QQbar(2)^(1/3), QQbar(2).sqrt() + QQbar(3).sqrt(),
          QQbar(-1).sqrt(), QQbar(5)^(1/5), QQbar(2)^(1/4), QQbar(7)/QQbar(3)]

def least_degree_over_F(alpha, basis):
    # basis: F の Q 上の基底（QQbar の元）。F 上の一次従属を Q 上の一次従属として判定する。
    d = 0
    while True:
        vecs = []
        for j in range(d + 1):
            for b in basis:
                vecs.append(b * alpha^j)
        # QQbar の元を共通の数体へ送り、Q 上の行列の階数を見る
        field, elems, _ = number_field_elements_from_algebraics(vecs, minimal=True)
        M = matrix(QQ, [list(e.vector()) if hasattr(e, 'vector') else [e] for e in elems])
        if M.rank() < len(vecs):
            return d
        d += 1

for alpha in alphas:
    p = alpha.minpoly()
    check(p != 0, "p ≠ 0")
    check(all(c in QQ for c in p.list()), "係数が有理数")
    check(all(K(c) in K for c in p.list()), "係数が F に属する")
    check(p(alpha) == 0, "p(α) = 0")
    # D_F(α) の最大係数番号 d0 = deg p が D_F(α) に属する
    d0 = p.degree()
    check(p.list()[d0] != 0 and all(c == 0 for c in p.list()[d0+1:]), "d0 の上界")
    # F = Q 上の次数
    dQ = least_degree_over_F(alpha, [QQbar(1)])
    check(dQ == d0, "Q 上の次数 %s: %d vs %d" % (alpha, dQ, d0))
    # F = Q(s) 上の次数
    dK = least_degree_over_F(alpha, [QQbar(1), QQbar(2).sqrt()])
    emb = K.embeddings(QQbar)
    phi = [e for e in emb if e(s) == QQbar(2).sqrt()][0]
    S.<y> = K[]
    facs = [f for f, _ in S(p).factor() if f.change_ring(phi)(alpha) == 0]
    check(len(facs) == 1 and facs[0].degree() == dK,
          "Q(s) 上の次数 %s: %d vs %s" % (alpha, dK, [f.degree() for f in facs]))
    check(dK <= dQ, "最小元は上界以下")
    print("alpha =", alpha, " deg_Q =", dQ, " deg_Q(s) =", dK)

if failures:
    print("FAILED:", len(failures))
    for f in failures[:20]:
        print("  ", f)
    raise SystemExit(1)
print("ALL PASSED")
