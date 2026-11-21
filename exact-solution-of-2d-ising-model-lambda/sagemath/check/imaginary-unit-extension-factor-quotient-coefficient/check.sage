# 主張「虚数単位を足した体の根で割った商の係数は虚数単位を足した体に入る」を一行ずつ確かめる。
# 対象ラベル: claim_imaginary_unit_extension_factor_quotient_coefficient
# 帰属: 標本は QQbar の厳密な元。浮動小数点は使わない。

failures = []
passes = 0
def check(cond, msg):
    global passes
    if not cond:
        failures.append(msg)
    else:
        passes += 1

# 標本: F = QQ(√2)、ω = i。Lin_F(ω) = {u + vω | u, v ∈ F}。
s2 = QQbar(2).sqrt()
I = QQbar(-1).sqrt()
check(I * I == -1, "ω·ω = -1")
Fbasis = [QQ(0), QQ(1), QQ(-2), QQ(1)/3]
Fels = [p + q * s2 for p in Fbasis for q in Fbasis]


# Lin_F(ω) の所属判定: z = a + b i で a, b ∈ QQ(√2)。実部・虚部を QQbar で取り、
# それぞれが QQ(√2) に入るかを最小多項式の次数と √2 との線型関係で判定する。
def in_QQsqrt2(x):
    x = QQbar(x)
    if x.imag() != 0:
        return False
    m = x.minpoly()
    if m.degree() == 1:
        return True
    if m.degree() != 2:
        return False
    # x = p + q√2 なら (x - p)^2 = 2 q^2。p = -m[1]/2（根の和の半分）。
    p = -m[1] / 2
    q2 = (x - p)^2 / 2
    q2 = QQbar(q2)
    if q2.minpoly().degree() != 1:
        return False
    q = QQ(q2).sqrt() if QQ(q2).is_square() else None
    if q is None:
        return False
    return x == p + q * s2 or x == p - q * s2
def in_Lin(z):
    z = QQbar(z)
    return in_QQsqrt2(z.real()) and in_QQsqrt2(z.imag())

R.<t> = PolynomialRing(QQbar)
def K(w, k):
    # claim_qbar_poly_power_difference_factorization の約束: K_0 = 0, K_{k+1} = K_k ŵ + t^k
    h = R(0)
    for i in range(k):
        h = h * R(w) + t^i
    return h

# (一) Lin の閉性（標本の上で）
linels = [Fels[i] + Fels[j] * I for (i, j) in [(1, 2), (5, 7), (10, 3), (0, 15), (6, 9)]]
for y in linels:
    for z in linels:
        check(in_Lin(y + z) and in_Lin(y * z), "(一) 和と積の閉性")
check(in_Lin(0) and in_Lin(1), "(一) 0, 1 の所属")

# (六) t^k の係数は 0 か 1
for k in range(6):
    check(all(c in (0, 1) for c in (t^k).list()), "(六) t^k の係数")

# (七) K_k(w) の係数と、その一歩の等式
for w in linels:
    for k in range(6):
        check(K(w, k + 1) == K(w, k) * R(w) + t^k, "(七) 一歩の等式")
        check(all(in_Lin(c) for c in K(w, k).list()), "(七) K_k(w) の係数の所属")

# (三)・(四) 係数の公式
import itertools
polys = [R([linels[0], linels[1]]), R([linels[2], 0, linels[3]]), R([linels[4], linels[0], linels[2]])]
for h1 in polys:
    for h2 in polys:
        for j in range(5):
            check((h1 + h2)[j] == h1[j] + h2[j], "(三) 和の係数")
            check((h1 * h2)[j] == sum(h1[i] * h2[j - i] for i in range(j + 1)), "(四) 積の係数")
            check(in_Lin((h1 * h2)[j]), "(四) 積の係数の所属")

# 主張: g = Σ_{k=0}^{n} ac_k(f)^ K_k(w) の係数の所属。根の条件の有無の両方で確かめる。
samples = 0
for (f_coeffs, w) in [([linels[0], linels[1], 1], linels[2]),
                     ([linels[3], 0, linels[4], 1], linels[1]),
                     ([0, linels[2]], linels[0])]:
    f = R(f_coeffs)
    n = f.degree()
    for nn in [n, n + 2]:
        g = sum(R(f[k]) * K(w, k) for k in range(nn + 1))
        check(all(in_Lin(c) for c in g.list()), "主張: g の係数の所属")
        samples += 1
# 根を持つ場合: f = (t - ŵ) h（h の係数は Lin）なら g は因数定理の商 h に一致する
for w in linels[:3]:
    h = R([linels[3], linels[4], 1])
    f = (t - R(w)) * h
    check(all(in_Lin(c) for c in f.list()), "根を持つ f の係数の所属")
    n = f.degree()
    g = sum(R(f[k]) * K(w, k) for k in range(n + 1))
    check(f == (t - R(w)) * g, "根を持つ場合 f = (t - ŵ) g")
    check(g == h, "根を持つ場合 g は商")
    check(all(in_Lin(c) for c in g.list()), "根を持つ場合の g の係数の所属")
# 仮定 ac_k(f) ∈ Lin を外すと崩れる例: f = √3 t, w = 1 なら g = √3 ∉ Lin
s3 = QQbar(3).sqrt()
g_bad = R(s3) * K(1, 1)
check(not in_Lin(g_bad[0]), "反例: 係数の仮定を外すと所属が崩れる")

if failures:
    print("FAIL", len(failures))
    for m in failures[:20]:
        print(" ", m)
else:
    print("PASS", passes)
