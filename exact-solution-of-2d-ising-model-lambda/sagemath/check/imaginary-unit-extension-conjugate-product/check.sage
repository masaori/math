# 虚数単位を足した元の共役、係数の共役、および主張
# 「虚数単位を足した体を係数とする多項式と係数の共役の積は部分体係数である」を一行ずつ確かめる。
# 対象ラベル: def_imaginary_unit_extension_conjugate,
#             def_imaginary_unit_extension_conjugate_polynomial,
#             claim_imaginary_unit_extension_conjugate_product_subfield_coefficient
# 帰属: 恒等式は整係数多項式環、標本は QQbar の厳密な元。浮動小数点は使わない。

failures = []
passes = 0
def check(cond, msg):
    global passes
    if not cond:
        failures.append(msg)
    else:
        passes += 1

# 式鎖の各等号を、係数 a_0..a_n, b_0..b_n と ω を不定元とする整係数多項式環で確かめる。
# 「ω·ω = -1」を使う段は、差が ω·ω+1 の倍数であることで確かめる。
for n in range(0, 7):
    names = ['a%d' % i for i in range(n + 1)] + ['b%d' % i for i in range(n + 1)] + ['w']
    P = PolynomialRing(ZZ, names)
    gens = P.gens()
    A = gens[:n + 1]
    B = gens[n + 1:2 * n + 2]
    w = gens[-1]
    for k in range(0, n + 1):
        # 第1行: ac_k(g·cjp(g)) = Σ_i ac_i(g)·ac_{k-i}(cjp(g))（積の係数の定義）。ここでは右辺を作る
        line1 = sum((A[i] + B[i] * w) * (A[k - i] - B[k - i] * w) for i in range(k + 1))
        # 第2行の各項: (a_i + b_i ω)(a_{k-i} - b_{k-i} ω) を分配法則と ω·ω = -1 で書き換える
        line2 = sum((A[i] * A[k - i] + B[i] * B[k - i]) + (B[i] * A[k - i] - A[i] * B[k - i]) * w
                    for i in range(k + 1))
        diff = line1 - line2
        check(diff % (w * w + 1) == 0 and (diff // (w * w + 1)) * (w * w + 1) == diff,
              "n=%d k=%d 分配法則と ω·ω=-1 の段" % (n, k))
        # 有限和の分配
        S0 = sum(A[i] * A[k - i] + B[i] * B[k - i] for i in range(k + 1))
        S1 = sum(B[i] * A[k - i] for i in range(k + 1))
        S2 = sum(A[i] * B[k - i] for i in range(k + 1))
        check(line2 == S0 + (S1 - S2) * w, "n=%d k=%d 有限和の分配" % (n, k))
        # 積の交換法則
        S2c = sum(B[k - i] * A[i] for i in range(k + 1))
        check(S2 == S2c, "n=%d k=%d 交換法則" % (n, k))
        # 番号の付け替え i -> k-i
        S2r = sum(B[j] * A[k - j] for j in range(k + 1))
        check(S2c == S2r and S2r == S1, "n=%d k=%d 番号の付け替え" % (n, k))
        # 四則: S0 + (S1 - S1)ω = S0
        check(S0 + (S1 - S1) * w == S0, "n=%d k=%d 四則" % (n, k))

# 標本: F = QQ(√2)（正錐は QQbar の実の正の元）、ω = i。
s2 = QQbar(2).sqrt()
I = QQbar(-1).sqrt()
check(I * I == -1, "ω·ω = -1")
Qx.<xx> = PolynomialRing(QQ)
Fnum.<r> = NumberField(xx^2 - 2)
emb = Fnum.hom([s2])
def in_F(z):
    # z ∈ QQ(√2) ⊂ QQbar の判定: z = p + q√2（p, q ∈ QQ）を厳密に解く
    z = QQbar(z)
    if z.imag() != 0:
        return False
    zr = AA(z)
    # 最小多項式の次数が二以下で、その根の一つが QQ(√2) の元の正の √2 での像に一致すること
    m = zr.minpoly()
    if m.degree() > 2:
        return False
    roots = m.change_ring(Fnum).roots(multiplicities=False)
    return any(emb(t) == z for t in roots)

samplesF = [QQ(0), QQ(1), QQ(-3) / 2, s2, QQ(1) / 3 - s2, QQ(2) + QQ(5) / 7 * s2]

# 共役の定義: z = a + bω の表示から cj(z) = a - bω。表示は一意なので、
# 同じ値を与える係数の対は一つだけで、cj は値だけで決まる（well-defined）。
pairs = [(QQbar(u), QQbar(v)) for u in samplesF for v in samplesF]
cj_table = {}
for (u, v) in pairs:
    z = u + v * I
    val = u - v * I
    found = None
    for (z0, v0) in cj_table.items():
        if z0 == z:
            found = v0
    if found is None:
        cj_table[z] = val
    else:
        check(found == val, "cj は表示に依らない")
check(len(cj_table) == len(pairs), "表示の異なる対は異なる値を与える")
check(QQbar(0) - QQbar(0) * I == 0, "cj(0) = 0")

def cj(u, v):
    return QQbar(u) - QQbar(v) * I

# 多項式の標本: 係数を F の元の対から作り、積 g·cjp(g) の各係数が F に属することを確かめる
coef_pairs = [(samplesF[i], samplesF[j]) for i in range(len(samplesF)) for j in range(len(samplesF))]
Rq.<t> = PolynomialRing(QQbar)
set_random_seed(20261120)
for trial in range(40):
    deg = ZZ.random_element(0, 5)
    cs = [coef_pairs[ZZ.random_element(0, len(coef_pairs))] for _ in range(deg + 1)]
    g = sum((QQbar(u) + QQbar(v) * I) * t^i for i, (u, v) in enumerate(cs))
    gc = sum(cj(u, v) * t^i for i, (u, v) in enumerate(cs))
    prod = g * gc
    for k in range(prod.degree() + 1 if prod != 0 else 1):
        c = prod[k]
        # 式鎖の最終行 Σ (a_i a_{k-i} + b_i b_{k-i})
        expected = sum(QQbar(cs[i][0]) * QQbar(cs[k - i][0]) + QQbar(cs[i][1]) * QQbar(cs[k - i][1])
                       for i in range(k + 1) if i <= deg and k - i <= deg)
        check(c == expected, "標本で式鎖の最終行に一致")
        check(in_F(c), "標本で係数が F に属する")

# 主張を弱めていないことの確認: 係数を共役しないで掛けた g·g は一般に F 係数でない
g = (QQbar(1) + I) * t + 1
check(not in_F((g * g)[1]), "共役をとらない積 g·g は F 係数とは限らない")

if failures:
    print("FAIL", len(failures))
    for f in failures[:20]:
        print("  ", f)
else:
    print("PASS", passes)
