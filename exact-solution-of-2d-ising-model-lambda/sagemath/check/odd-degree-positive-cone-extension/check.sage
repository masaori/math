# 「奇数次の元を付け足しても正錐は延長できる」の主張を実例で確かめる。
# 対象ラベル: claim_odd_degree_positive_cone_extension
# 帰属: F = Q（正錐は正の有理数）と F = Q(s)（s*s = 2、正錐は s -> +sqrt(2) で正の元）。
# Val_F(alpha) は F 上の最小多項式による剰余体（数体）で表し、等号はすべてその中で判定する。
# 主張は存在なので、証人として「F の正錐と両立する実代数的数への埋め込みで正の元」の集合 C_alpha を取り、
# それが Val_F(alpha) の正錐で C_F を延長することを標本で確かめる。符号は AA（実代数的数）の厳密な比較で決める。
# 本文の証明は列挙に沿った増大列で C_alpha を作るが、ここでは別の証人で存在の実例を見る（証明ではない）。
# 併せて、証明の前段の仮定（T := Sq(C_F; E) の元は C_alpha ∪ {0} に入り、-1 ∉ T）を標本で確かめる。

import random
random.seed(int(20261118))

failures = []
passes = 0
def check(cond, msg):
    global passes
    if not cond:
        failures.append(msg)
    else:
        passes += 1

sqrt2 = AA(2).sqrt()

def run_case(name, Fring, F_to_AA, in_CF, rand_F, rand_cone, minpoly, real_root, trials):
    n = minpoly.degree()
    check(n % 2 == 1, name + ": deg_F(alpha) は奇数")
    check(minpoly.is_irreducible(), name + ": 最小多項式は既約")
    Pt = minpoly.parent()
    K = Fring.extension(minpoly, 'a')
    a = K.gen()
    # 埋め込み phi: K -> AA。a -> real_root、F の元は F_to_AA。
    check(sum(F_to_AA(minpoly[k]) * real_root^k for k in range(n + 1)) == 0, name + ": 実根は最小多項式の根")
    def phi(z):
        coeffs = z.list() if hasattr(z, 'list') else [z]
        return sum(F_to_AA(Fring(coeffs[k])) * real_root^k for k in range(len(coeffs)))
    def rand_E():
        return sum((rand_F() * a^k for k in range(n)), K(0))
    def in_Calpha(z):
        return z != 0 and phi(z) > 0
    for _ in range(trials):
        x = rand_E(); y = rand_E()
        # 正錐の第一条件は構成から（C_alpha ⊆ E）。和・積の閉性。
        if in_Calpha(x) and in_Calpha(y):
            check(in_Calpha(x + y), name + ": 和で閉じる")
            check(in_Calpha(x * y), name + ": 積で閉じる")
        # 三分法: z = 0、z ∈ C_alpha、-z ∈ C_alpha のちょうど一つ。
        for z in [x, y, x - x, x * y - y * x]:
            cnt = int(z == 0) + int(in_Calpha(z)) + int(in_Calpha(-z))
            check(cnt == 1, name + ": 三分法")
        # 延長: F の元 c について、c ∈ C_alpha ⟺ c ∈ C_F。
        c = rand_F()
        check(in_Calpha(K(c)) == (c != 0 and in_CF(c)), name + ": C_alpha ∩ F = C_F")
        # 前段: T = Sq(C_F; E) の元は C_alpha ∪ {0} に入り、-1 でない。
        r = random.randint(1, 4)
        w = sum((K(rand_cone()) * (lambda u: u * u)(rand_E()) for _ in range(r)), K(0))
        check(w == 0 or in_Calpha(w), name + ": 平方和は C_alpha ∪ {0} に入る")
        check(w != -1, name + ": 平方和は -1 でない")

# F = Q
Rq.<t> = QQ[]
def rand_Q():
    return QQ(random.randint(-9, 9)) / QQ(random.randint(1, 5))
def rand_Qpos():
    return QQ(random.randint(1, 9)) / QQ(random.randint(1, 5))
for mp in [t^3 - 2, t^3 - 3*t - 1, t^5 - t - 1, t^5 - 4*t + 2, t^7 - 3]:
    roots = [r for r in mp.roots(AA, multiplicities=False)]
    check(len(roots) >= 1, "奇数次の有理係数多項式は実根を持つ")
    for r in roots:
        run_case("F=Q, " + str(mp) + ", 根 " + str(r.n(20)), QQ, lambda q: AA(q), lambda q: q > 0,
                 rand_Q, rand_Qpos, mp, r, 30)

# F = Q(s)、s*s = 2、正錐は s -> +sqrt(2) で正の元
Rs.<x> = QQ[]
Fs.<s> = NumberField(x^2 - 2)
def Fs_to_AA(z):
    c = z.list()
    return AA(c[0]) + AA(c[1]) * sqrt2
def in_CFs(z):
    return Fs_to_AA(z) > 0
def rand_Fs():
    return Fs(rand_Q()) + Fs(rand_Q()) * s
def rand_Fs_pos():
    while True:
        z = rand_Fs()
        if z != 0 and in_CFs(z):
            return z
Ru.<u> = Fs[]
for mp in [u^3 - s, u^3 + s*u + 1, u^5 - 2*u + s]:
    mpAA = PolynomialRing(AA, 'v')([Fs_to_AA(c) for c in mp.list()])
    roots = mpAA.roots(multiplicities=False)
    check(len(roots) >= 1, "奇数次の多項式は実根を持つ")
    for r in roots:
        run_case("F=Q(s), " + str(mp) + ", 根 " + str(r.n(20)), Fs, Fs_to_AA, in_CFs,
                 rand_Fs, rand_Fs_pos, mp, r, 20)

print("PASS", passes)
if failures:
    print("FAIL", len(failures))
    for f in failures[:20]:
        print(f)
    raise SystemExit(1)
print("全検査通過")
