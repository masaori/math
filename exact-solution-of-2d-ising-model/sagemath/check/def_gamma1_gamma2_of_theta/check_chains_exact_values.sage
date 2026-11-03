# 対象ラベル: def_gamma1_gamma2_of_theta
# 具体の結合定数と角度で、二つの鎖の全行、(∵) が引く三つの事実、主張を代数的数（QQbar）の中で厳密に確かめる。
#
# ℝ への脱出: K_1 = (1/2) log Y、K_2^* = (1/2) log X（X, Y ∈ QQ_{>1}）と選び、exp(±2K_1) = Y^{±1}、exp(±2K_2^*) = X^{±1} とする。
# K_2 は K_2^* = -(1/2) log(tanh K_2) を解いて exp(2K_2) = (X+1)/(X-1) とする。
# θ = 2πk/n とし、cos θ・sin θ・exp(iθ)・exp(-iθ) と、-θ での cos(-θ)・sin(-θ)・exp(i(-θ)) を、
# それぞれ Sage の記号式から独立に AA・QQbar へ変換する（偶奇性と i(-θ) = -iθ を作り方から通さないため）。
load("_prelude.sage")

rep = Report("def_gamma1_gamma2_of_theta: 具体値での厳密検算")

PARAMS = [(QQ(4), QQ(3)), (QQ(9), QQ(7)/3), (QQ(25)/4, QQ(2))]   # (Y, X)
ANGLES = [(0, 1), (1, 3), (1, 4), (1, 5), (2, 5), (1, 6), (3, 7), (5, 8), (7, 12)]

def cosh_from_exp(E):
    return (E + 1/E) / 2

def sinh_from_exp(E):
    return (E - 1/E) / 2

II = QQbar(I)

def ev(f, vals):
    """多項式 f に値を入れる。係数 QQ(i) の元は実部 + I・虚部として QQbar へ送る。"""
    g = R(f)
    if g == 0:
        return QQbar(0)
    tot = QQbar(0)
    for cf, m in zip(g.coefficients(), g.exponents()):
        mon = prod(vals[v]**e for v, e in zip(R.gens(), m))
        tot += (QQbar(Ki(cf).real()) + II * QQbar(Ki(cf).imag())) * mon
    return tot

for (Y, X) in PARAMS:
    q = (X + 1) / (X - 1)
    for (k, n) in ANGLES:
        th = 2 * pi * k / n
        mth = -th
        vals = {c1: QQbar(cosh_from_exp(Y)), s1: QQbar(sinh_from_exp(Y)), c2: QQbar(cosh_from_exp(q)),
                c2s: QQbar(cosh_from_exp(X)), s2s: QQbar(sinh_from_exp(X)),
                co: QQbar(AA(cos(th))), si: QQbar(AA(sin(th))), ep: QQbar(exp(I * th)), em: QQbar(exp(-I * th)),
                com: QQbar(AA(cos(mth))), sim: QQbar(AA(sin(mth))), epm: QQbar(exp(I * mth))}
        tag = f"(Y,X)=({Y},{X}), θ=2π·{k}/{n}"
        for nm, rel in RELATIONS.items():
            rep.check(ev(rel, vals) == 0, f"{tag} (∵) の事実 {nm} が具体値で成り立つ")
        for name, lines in CHAINS.items():
            vs = [ev(e, vals) for e, _ in lines]
            rep.check(all(v == vs[0] for v in vs), f"{tag} {name} の鎖の全 {len(vs)} 行が同じ値")
        Av = matrix(QQbar, 2, 2, [ev(A[r, c], vals) for r in range(2) for c in range(2)])
        Gv = matrix(QQbar, 2, 2, [ev(gamma1_def(co), vals), ev(gamma2_def(ep, co, si), vals),
                                  -ev(gamma2_def(epm, com, sim), vals), ev(gamma1_def(co), vals)])
        rep.check(Av == Gv, f"{tag} 主張 A(θ) = [[γ_1(θ), γ_2(θ)], [−γ_2(−θ), γ_1(θ)]]")
        rep.check(Av[0, 0] in AA, f"{tag} γ_1(θ) ∈ ℝ（虚部が 0）")

rep.finish()
