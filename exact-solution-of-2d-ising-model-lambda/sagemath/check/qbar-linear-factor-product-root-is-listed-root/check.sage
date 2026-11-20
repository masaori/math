# 主張「代数的数を根とする一次因子の有限積の根は、因子の根のどれかである」の式鎖を一行ずつ確かめる。
# 対象ラベル: claim_qbar_linear_factor_product_root_is_listed_root
# 帰属: 値は円分体 Q(ζ_8) と、x^3 - 2 の Q 上の分解体（数体）の元。どちらも代数的数の部分体。
# 浮動小数点は使わない。

failures = []
passes = 0
def check(cond, msg):
    global passes
    if not cond:
        failures.append(msg)
    else:
        passes += 1

def run(T, beta, z, tag):
    t = T.gen()
    N = len(beta)
    P = prod([t - T(b) for b in beta], T(1))
    # 第一の式鎖の各行の値
    l1 = P(z)
    l2 = prod([t - T(b) for b in beta], T(1))(z)
    l3 = prod([(t - T(b))(z) for b in beta], T.base_ring()(1))
    l4 = prod([t(z) - T(b)(z) for b in beta], T.base_ring()(1))
    l5 = prod([z - b for b in beta], T.base_ring()(1))
    check(l1 == l2, tag + ": 第二の等号（P の置き方）")
    check(l2 == l3, tag + ": 第三の等号（値は積を保つ）")
    check(l3 == l4, tag + ": 第四の等号（値は和と逆元を保つ）")
    check(l4 == l5, tag + ": 第五の等号（aev_z(t) = z、aev_z(â) = a）")
    listed = [r for r in range(N) if z == beta[r]]
    if l1 == 0:
        # 有限積が零なら零の因子がある（claim_qbar_prod_eq_zero）
        zeros = [r for r in range(N) if z - beta[r] == 0]
        check(len(zeros) >= 1, tag + ": 零の因子がある")
        r0 = zeros[0]
        m1 = (z - beta[r0]) + beta[r0]
        m2 = 0 + beta[r0]
        check(z == m1, tag + ": 第二の式鎖 第一の等号")
        check(m1 == m2, tag + ": 第二の式鎖 第二の等号")
        check(m2 == beta[r0], tag + ": 第二の式鎖 第三の等号")
        check(r0 < N and z == beta[r0], tag + ": 結論 r0 < N かつ z = β(r0)")
    else:
        # 対照: 値が零でないなら、z は列挙された根のどれでもない
        check(len(listed) == 0, tag + ": 対照（値が零でない点は列挙された根でない）")

K8.<w> = CyclotomicField(8)
T8.<t> = PolynomialRing(K8)
s2 = w + w^-1
betas8 = [[], [w], [s2, -s2, 1/3], [1, 1, 1, -w^2], [w, w^3, w^5, w^7], [0, s2 + w^2]]
points8 = [K8(0), K8(1), w, -s2, 1/3, w^2, w^7, s2 + w^2, K8(5)]
for i, b in enumerate(betas8):
    for z in points8:
        run(T8, b, z, "Q(ζ8) 列 %d, z = %s" % (i, z))

xq = polygen(QQ, 'xq')
L = NumberField(xq^3 - 2, 'b').galois_closure('a')
TL.<u> = PolynomialRing(L)
rts = [r for r, m in (u^3 - 2).roots()]
om = [r for r, m in (u^2 + u + 1).roots()]
betasL = [rts, rts + om, [rts[0] + rts[1], rts[0] * rts[1]]]
pointsL = rts + om + [rts[0] + rts[1], rts[0] * rts[1], L(2)]
for i, b in enumerate(betasL):
    for z in pointsL:
        run(TL, b, z, "分解体 列 %d" % i)

# N = 0: 空積の値は 1 で零でないので、仮定を満たす点が無い
check(prod([], K8(1)) != 0, "N = 0: 空積の値は 1 で零でない")

if failures:
    print("FAIL", len(failures))
    for m in failures:
        print("  ", m)
else:
    print("PASS", passes)
