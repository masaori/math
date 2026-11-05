# 対象ラベル: gamma_kappa_identity
# 証明の各行と主張を、具体の (K_1, K_2^*) と θ で、値を囲む実数のボール（RealBallField）で確かめる。
# ℝ への脱出: cosh・sinh・cos・sin・arccosh・arcsinh の値が実数（極限・平方根・実対数）なので、ここだけ区間計算を使う。
#   許容誤差は置かず、ボールの重なり（等号）と符号の確定（不等号）で判定する。
# - cosh・sinh は本文の実数の exp を囲むボール（body_real_exp_ball。本文の部分和に尾の評価を半径として足したもの）から作る。
#   引数 2K_1, 2K_2^*, κ は QQ に取る。γ(θ) は実数なので、cosh γ・sinh(γ/2) だけは Arb の cosh・sinh を使う。
# - arccosh・arcsinh は本文の定義 log(y + √(y^2 ∓ 1)) から作り、Arb の arccosh・arcsinh と重なることも確かめる。
# - cos θ・sin(θ/2) は θ = πr（r ∈ QQ）で Arb の cos・sin を使う（本文に全実数上の cos・sin が未整備のため）。
# - 主張は K_1, K_2^* だけで決まるので (K_1, K_2^*) ∈ QQ_{>0}^2 を選ぶ。K_2^* が K_2 > 0 から得られることは、
#   K_2 := artanh(exp(−2K_2^*)) とおいて −(1/2)log(tanh K_2) と sinh 2K_2 sinh 2K_2^* = 1 が重なることで確かめる。
load("../../_shared/one_by_one_matrix.sage")

PREC = 256
RB = RealBallField(PREC)
ok = True
ncount = {"check": 0, "control": 0}
def check(name, cond):
    global ok
    ncount["check"] += 1
    if name.startswith("対照"):
        ncount["control"] += 1
    if not cond:
        print("FAIL " + name)
    ok = ok and bool(cond)
ncheck = [0]
def eq(x, y, name):
    ncheck[0] += 1
    check(name, RB(x).overlaps(RB(y)) and float((RB(x) - RB(y)).rad()) < 2.0^(-100))
def ge0(x, name):
    ncheck[0] += 1
    check(name, RB(x) >= 0 or (RB(x).contains_zero() and float(RB(x).rad()) < 2.0^(-100)))

def bexp(q):
    return RB(body_real_exp_ball(q, prec=PREC))
def bcosh(q):
    return (bexp(q) + bexp(-q)) / 2
def bsinh(q):
    return (bexp(q) - bexp(-q)) / 2
def body_arccosh(y):
    return (y + (y^2 - 1).sqrt()).log()
def body_arcsinh(y):
    return (y + (y^2 + 1).sqrt()).log()

params = [(QQ(1)/2, QQ(1)/3), (QQ(1)/3, QQ(1)/2), (QQ(3)/10, QQ(3)/10), (QQ(2), QQ(1)/5), (QQ(1)/20, QQ(3)/2), (QQ(7)/10, QQ(7)/10)]
rs = [QQ(r) for r in [0, 1, -1, 1/2, -1/3, 2/5, 7/6, -9/4, 13/3, 3]]

for (K1, K2s) in params:
    # K_2^* が K_2 > 0 から得られること（def_second_dual_coupling_constant）
    K2 = RB(exp(-2 * K2s)).arctanh()
    check(f"K2>0 ({K1},{K2s})", K2 > 0)
    eq(-(K2.tanh().log()) / 2, RB(K2s), f"K_2^* = −(1/2)log tanh K_2 ({K1},{K2s})")
    eq((2 * K2).sinh() * bsinh(2 * K2s), 1, f"sinh 2K_2 sinh 2K_2^* = 1 ({K1},{K2s})")

    c1, s1, c2s, s2s = bcosh(2 * K1), bsinh(2 * K1), bcosh(2 * K2s), bsinh(2 * K2s)
    eq(c1, RB(2 * K1).cosh(), "本文の exp から作った cosh と Arb の cosh")
    kappa = 2 * K1 - 2 * K2s           # QQ（def_kappa）
    A = s1 * s2s                       # def_critical_sinh_product_A
    check(f"A > 0 ({K1},{K2s})", A > 0)
    for r in rs:
        tag = f"(K1,K2*)=({K1},{K2s}), θ={r}π"
        th = RB(pi) * r
        co = th.cos()
        v = (th / 2).sin()
        g1 = c1 * c2s - s1 * s2s * co                       # def_gamma1_gamma2_of_theta
        # Step 1 の鎖
        L = [
            g1,
            (c1 * c2s - s1 * s2s) + s1 * s2s * (1 - co),
            (bcosh(2 * K1) * bcosh(2 * K2s) - bsinh(2 * K1) * bsinh(2 * K2s)) + s1 * s2s * (1 - co),
            bcosh(2 * K1 - 2 * K2s) + s1 * s2s * (1 - co),
            bcosh(kappa) + s1 * s2s * (1 - co),
            bcosh(kappa) + A * (1 - co),
            bcosh(kappa) + 2 * A * v^2,
        ]
        for k in range(len(L) - 1):
            eq(L[k], L[k + 1], f"Step 1: {k+1}→{k+2} 行目 {tag}")
        # γ(θ) = arccosh(γ_1(θ))（def_gamma_theta。γ_1 ≥ 1）。θ = 0 かつ κ = 0 では γ_1 = 1 で、
        # ボールの √(y^2 − 1) が定まらないので γ = 0 を直接置く（arccosh(1) = log 1 = 0）
        check(f"γ_1 ≥ 1 {tag}", g1 >= 1 or g1.overlaps(RB(1)))
        if r == 0 and kappa == 0:
            gamma = RB(0)
            eq(g1, 1, f"κ = 0, θ = 0 で γ_1 = 1 {tag}")
        else:
            gamma = body_arccosh(g1)
            eq(gamma, g1.arccosh(), f"本文の arccosh と Arb の arccosh {tag}")
        ge0(gamma, f"γ ≥ 0（arccosh_properties (1)） {tag}")
        eq(gamma.cosh(), g1, f"cosh γ = γ_1（arccosh_properties (2)） {tag}")
        eq(gamma.cosh(), L[-1], f"1 番目の式 {tag}")
        # Step 2 の鎖
        t = (gamma / 2).sinh()
        u = bsinh(kappa / 2)
        M = [
            t^2,
            ((1 + 2 * t^2) - 1) / 2,
            (gamma.cosh() - 1) / 2,
            ((bcosh(kappa) + 2 * A * v^2) - 1) / 2,
            ((1 + 2 * u^2 + 2 * A * v^2) - 1) / 2,
            u^2 + A * v^2,
        ]
        for k in range(len(M) - 1):
            eq(M[k], M[k + 1], f"Step 2: {k}→{k+1} 行目 {tag}")
        # Step 3
        S = u^2 + A * v^2
        ge0(S, f"S ≥ 0 {tag}")
        ge0(t, f"sinh(γ/2) ≥ 0 {tag}")
        eq(S, t^2, f"S = (sinh(γ/2))^2 {tag}")
        sqS = RB(0) if (r == 0 and kappa == 0) else S.sqrt()
        eq(t, sqS, f"sinh(γ/2) = √S {tag}")
        eq(body_arcsinh(sqS), sqS.arcsinh(), f"本文の arcsinh と Arb の arcsinh {tag}")
        eq(gamma / 2, body_arcsinh(sqS), f"γ/2 = arcsinh(√S) {tag}")
        eq(gamma, 2 * (gamma / 2), f"γ = 2·(γ/2) {tag}")
        eq(2 * (gamma / 2), 2 * body_arcsinh(t), f"2·(γ/2) = 2 arcsinh(sinh(γ/2)) {tag}")
        eq(2 * body_arcsinh(t), 2 * body_arcsinh(sqS), f"2 arcsinh(sinh(γ/2)) = 2 arcsinh(√S) {tag}")
        eq(gamma, 2 * body_arcsinh(sqS), f"3 番目の式 {tag}")
        # 偶関数性
        um = bsinh(-kappa / 2)
        eq(um, -u, f"sinh(−κ/2) = −sinh(κ/2) {tag}")
        Sm = um^2 + A * v^2
        sqSm = RB(0) if (r == 0 and kappa == 0) else Sm.sqrt()
        eq(2 * body_arcsinh(sqSm), gamma, f"κ → −κ で 3 番目の式の右辺は不変 {tag}")
        # 対照（重ならないこと）: 2 番目の式の A を 2A に誤る（v ≠ 0 のとき）、3 番目の式の 2 を落とす（γ ≠ 0 のとき）
        if not v.contains_zero():
            check(f"対照 sinh^2(γ/2) ≠ sinh^2(κ/2) + 2A sin^2(θ/2) {tag}", not (t^2).overlaps(u^2 + 2 * A * v^2))
        if gamma > 0:
            check(f"対照 γ ≠ arcsinh(√S) {tag}", not gamma.overlaps(body_arcsinh(sqS)))

print(f"真偽の確認 {ncount['check']} 件（うち対照 {ncount['control']} 件。等号・不等号の確認 {ncheck[0]} 件を含む）")
print(f"等号・不等号の確認 {ncheck[0]} 件（(K_1, K_2^*) {len(params)} 組 × θ {len(rs)} 点）")
print("RESULT: " + ("PASS" if ok else "FAIL"))
if not ok:
    sys.exit(1)
