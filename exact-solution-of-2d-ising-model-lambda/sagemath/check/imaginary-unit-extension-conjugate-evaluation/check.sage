# 主張「虚数単位を足した体の共役は多項式の値と入れ替わる」を一行ずつ確かめる。
# 対象ラベル: claim_imaginary_unit_extension_conjugate_evaluation
# 帰属: 準備の恒等式は整係数多項式環を ω·ω+1 で割った環、標本は QQbar の厳密な元。浮動小数点は使わない。

failures = []
passes = 0
def check(cond, msg):
    global passes
    if not cond:
        failures.append(msg)
    else:
        passes += 1

# 準備 (二)・(三)・(四) の式鎖の各行を、a, b, c, e と ω を不定元とする整係数多項式環で確かめる。
# 「ω·ω = -1」を使う段は、差が ω·ω+1 の倍数であることで確かめる。
P.<a, b, c, e, w> = PolynomialRing(ZZ)
def same(x, y):
    d = x - y
    return (d % (w * w + 1)) == 0 and (d // (w * w + 1)) * (w * w + 1) == d
def cjP(re, im):
    return re - im * w
# (二) 和: cj(u+v) の各行
u = a + b * w; v = c + e * w
check(u + v == (a + c) + (b + e) * w, "(二) 第一行の四則")
check(cjP(a + c, b + e) == (a - b * w) + (c - e * w), "(二) 第三行の四則")
check((a - b * w) + (c - e * w) == cjP(a, b) + cjP(c, e), "(二) 第四行")
# (三) 積
check(same(u * v, (a * c - b * e) + (a * e + b * c) * w), "(三) 第一行: 分配法則と ω·ω=-1")
line2 = cjP(a * c - b * e, a * e + b * c)
line3 = a * c - a * e * w - b * c * w + b * e * (w * w)
check(same(line2, line3), "(三) 第三行: ω·ω=-1 と四則")
check(line3 == (a - b * w) * (c - e * w), "(三) 第四行: 分配法則")
check((a - b * w) * (c - e * w) == cjP(a, b) * cjP(c, e), "(三) 第五行")
# (四) 共役の共役
check(cjP(a, b) == a + (-b) * w, "(四) a - bω = a + (-b)ω")
check(cjP(a, -b) == a + b * w, "(四) 第二・第三行")

# 標本: F = QQ(√2)（正錐は QQbar の実の正の元）、ω = i。
s2 = QQbar(2).sqrt()
I = QQbar(-1).sqrt()
check(I * I == -1, "ω·ω = -1")
samplesF = [QQ(0), QQ(1), QQ(-3) / 2, s2, QQ(1) / 3 - s2, QQ(2) + QQ(5) / 7 * s2]

def rep(z):
    # z ∈ Lin_F(ω) の表示 (実部, 虚部)。F ⊂ QQbar の実の元なので、QQbar の実部・虚部が表示を与える。
    z = QQbar(z)
    return (QQbar(z.real()), QQbar(z.imag()))
def cj(z):
    x, y = rep(z)
    return x - y * I

Rq.<t> = PolynomialRing(QQbar)
set_random_seed(20261120)
pairs = [(QQbar(x), QQbar(y)) for x in samplesF for y in samplesF]
for trial in range(40):
    deg = ZZ.random_element(0, 5)
    cs = [pairs[ZZ.random_element(0, len(pairs))] for _ in range(deg + 1)]
    g = sum((x + y * I) * t^k for k, (x, y) in enumerate(cs))
    gc = sum((x - y * I) * t^k for k, (x, y) in enumerate(cs))   # cjp(g)
    zx, zy = pairs[ZZ.random_element(0, len(pairs))]
    z = zx + zy * I
    cz = zx - zy * I
    n = deg
    # 準備 (五): cj(z^k) = cj(z)^k
    for k in range(n + 1):
        check(cj(z^k) == cz^k, "(五) 冪の共役")
    # 所属の式鎖
    v1 = gc(z)
    v2 = sum(gc[k] * z^k for k in range(n + 1))
    v3 = sum(cj(g[k]) * z^k for k in range(n + 1))
    check(v1 == v2, "所属の第一行")
    check(v2 == v3, "所属の第二行")
    # 七行の式鎖
    l1 = g(cz)
    l2 = sum(g[k] * cz^k for k in range(n + 1))
    l3 = sum(cj(cj(g[k])) * cz^k for k in range(n + 1))
    l4 = sum(cj(cj(g[k])) * cj(z^k) for k in range(n + 1))
    l5 = sum(cj(cj(g[k]) * z^k) for k in range(n + 1))
    l6 = cj(sum(cj(g[k]) * z^k for k in range(n + 1)))
    l7 = cj(sum(gc[k] * z^k for k in range(n + 1)))
    l8 = cj(gc(z))
    for i, (x, y) in enumerate([(l1, l2), (l2, l3), (l3, l4), (l4, l5), (l5, l6), (l6, l7), (l7, l8)]):
        check(x == y, "七行の式鎖の第 %d 行" % (i + 1))

# 主張を弱めていないことの確認: cjp を取らずに g そのものを z で評価した値の共役とは一般に一致しない。
g = (QQbar(1) + I) * t + 1
check(g(cj(I)) != cj(g(I)), "cjp(g) を g に替えると等号は一般に崩れる")

if failures:
    print("FAIL", len(failures))
    for f in failures[:20]:
        print("  ", f)
else:
    print("PASS", passes)
