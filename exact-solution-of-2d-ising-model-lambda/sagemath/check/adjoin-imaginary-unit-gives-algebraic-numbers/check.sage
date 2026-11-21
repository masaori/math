# 主張「正の元が平方で奇数次の多項式が根を持つ部分体に虚数単位を足すと代数的数の全体になる」
# の証明を一行ずつ確かめる。
# 対象ラベル: claim_adjoin_imaginary_unit_gives_algebraic_numbers
# 帰属: 標本は QQbar の厳密な元と QQbar[t] の多項式。浮動小数点は使わない。
# 標本の部分体は二つ。
#   F = AA（実代数的数）: 主張の仮定（正の元は平方、奇数次の多項式は根を持つ）を満たす。
#     ξ ごとに F 上の最小次数の零化多項式 p に零でない有理数を掛けたものを取り、(一)〜(五) と結論を確かめる。
#   F = QQ: 主張の仮定を満たさない。準備と (一)〜(五) は仮定を使わないので同じく通るが、
#     g の一次因子の根は Lin_QQ(ω) に入らないことがあり、仮定が一次因子の積の主張を通してだけ効くことを確かめる。

failures = []
passes = 0
def check(cond, msg):
    global passes
    if not cond:
        failures.append(msg)
    else:
        passes += 1

I = QQbar(-1).sqrt()
check(I * I == -1, "ω·ω = -1")
R.<t> = PolynomialRing(QQbar)

def ac(f, k):
    return f[k] if k <= f.degree() else QQbar(0)

def in_AA(x):
    return QQbar(x).imag() == 0
def in_QQ(x):
    x = QQbar(x)
    return x.imag() == 0 and x.minpoly().degree() == 1
def in_lin(z, inF):
    # Lin_F(ω) = {u + vω | u, v ∈ F}。ω = i なので u, v は実部と虚部に限る（表示の一意性）
    z = QQbar(z)
    return inF(z.real()) and inF(z.imag())

def min_vanishing_AA(xi):
    # AA 上の最小次数の零化多項式（定数倍を除く）: 実なら t - ξ、そうでなければ (t - ξ)(t - ξ̄)
    if in_AA(xi):
        return t - R(xi)
    return t^2 - R(2 * xi.real()) * t + R(xi.real()^2 + xi.imag()^2)
def min_vanishing_QQ(xi):
    m = QQbar(xi).minpoly()
    return R(m)

def run(xi, inF, minpoly, scale, tag, expect_member):
    xi = QQbar(xi)
    # 準備: n := deg_F(ξ) の零化多項式 p（最小次数の零化多項式の零でない有理数倍）
    p = R(scale) * minpoly(xi)
    n = p.degree()
    check(all(inF(ac(p, k)) for k in range(n + 3)), tag + ": p ∈ F[t]")
    check(p != 0 and p(xi) == 0, tag + ": p ≠ 0 かつ aev_ξ(p) = 0")
    check(all(ac(p, k) == 0 for k in range(n + 1, n + 3)), tag + ": k > n で ac_k(p) = 0")
    # n が最小: 次数 n-1 以下の F 係数の零化多項式は零（最小多項式の次数が n であること）
    check(QQbar(xi).minpoly().degree() >= n, tag + ": n は最小次数（Q 上の次数以下ではない）")
    c = ac(p, n)
    check(c != 0 and inF(c) and inF(c^-1), tag + ": c = ac_n(p) ≠ 0、c, c⁻¹ ∈ F")
    g = R(c^-1) * p
    # (一) ac_k(g) = Σ ac_i(ĉ⁻¹) ac_{k-i}(p) = ac_0(ĉ⁻¹) ac_k(p) + Σ_{i≥1} … = c⁻¹ ac_k(p)
    for k in range(n + 3):
        l1 = ac(g, k)
        l2 = sum(ac(R(c^-1), i) * ac(p, k - i) for i in range(k + 1))
        l3 = ac(R(c^-1), 0) * ac(p, k) + sum(ac(R(c^-1), i) * ac(p, k - i) for i in range(1, k + 1))
        l4 = c^-1 * ac(p, k) + sum(0 * ac(p, k - i) for i in range(1, k + 1))
        l5 = c^-1 * ac(p, k)
        check(l1 == l2 == l3 == l4 == l5, tag + ": (一) k = %d の四行の式鎖" % k)
        # (二) 係数は F、よって Lin_F(ω)
        check(inF(l1) and l1 == l1 + 0 * I and in_lin(l1, inF), tag + ": (二) ac_k(g) ∈ F ⊂ Lin_F(ω)")
    # (三)
    check(ac(g, n) == c^-1 * ac(p, n) == c^-1 * c == 1, tag + ": (三) ac_n(g) = 1")
    # (四)
    for k in range(n + 1, n + 3):
        check(ac(g, k) == c^-1 * ac(p, k) == c^-1 * 0 == 0, tag + ": (四) k = %d で ac_k(g) = 0" % k)
    # (五)
    e1 = g(xi)
    e2 = R(c^-1)(xi) * p(xi)
    e3 = c^-1 * p(xi)
    e4 = c^-1 * 0
    check(e1 == e2 == e3 == e4 == 0, tag + ": (五) aev_ξ(g) = 0 の四行の式鎖")
    # 一次因子の積（根の列 α）と、積の根は因子の根
    alpha = []
    for r, m in g.roots(QQbar):
        alpha += [r] * m
    check(len(alpha) == n and g == prod([t - R(a) for a in alpha], R(1)), tag + ": g = Π_{i<n}(t - α(i)^)")
    rs = [r for r in range(n) if alpha[r] == xi]
    check(len(rs) >= 1, tag + ": ξ = α(r) となる r < n がある")
    member = all(in_lin(a, inF) for a in alpha)
    check(member == expect_member, tag + ": α の値が全て Lin_F(ω) か（期待 %s）" % expect_member)
    check(in_lin(xi, inF) == expect_member, tag + ": ξ ∈ Lin_F(ω) か（期待 %s）" % expect_member)
    if expect_member:
        a, b = xi.real(), xi.imag()
        check(inF(a) and inF(b) and xi == a + b * I, tag + ": ξ = a + bω、a, b ∈ F")

s2 = QQbar(2).sqrt()
cr2 = QQbar(2).nth_root(3)
samples = [
    QQbar(3) / 7,
    s2,
    I,
    1 + s2 * I,
    cr2 + I,
    QQbar(-5).sqrt() + QQbar(1) / 2,
    QQbar(2 + I).sqrt(),
]
for j, xi in enumerate(samples):
    run(xi, in_AA, min_vanishing_AA, QQ(3) / (j + 2), "AA 標本 %d" % j, True)

# F = QQ: 準備と (一)〜(五) は通るが、一次因子の根は Lin_QQ(ω) に入らないことがある
run(QQbar(1) / 2 + 2 * I, in_QQ, min_vanishing_QQ, QQ(5), "QQ 標本（所属する）", True)
run(s2 + I, in_QQ, min_vanishing_QQ, QQ(-2) / 3, "QQ 標本（所属しない）", False)
run(cr2, in_QQ, min_vanishing_QQ, QQ(4), "QQ 標本（所属しない、奇数次）", False)

print("PASS %d" % passes)
if failures:
    print("FAIL:", failures)
    raise SystemExit(1)
