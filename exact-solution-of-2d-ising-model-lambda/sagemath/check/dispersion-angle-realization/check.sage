# 対象ラベル: claim_dispersion_angle_realization
# 本文の証明の式鎖を一行ずつ検算する。代数的な行（係数表示・分散因子の書き直し・最後の分配法則）は
# QQbar・AA・多項式環で厳密に確かめる。複素指数関数・実余弦・実正弦を含む行（指数評価への脱出）だけを
# 160 ビットの複素数近似で照合する。R は AA（実代数的数）、ω は虚数単位 i ∈ QQbar、ρ_{R→ℝ} は AA の実数値、
# ρ_{Qbar→ℂ} は QQbar の複素数値に取る。有限例は任意の辺長・任意の実現の証明ではない。
count = 0
def check(cond, label):
    global count
    assert cond, label
    count += 1

CF = ComplexField(160)
RF = RealField(160)
EPS = RF(2)**(-120)
omega = QQbar(I)
def close(x, y):
    return abs(CF(x) - CF(y)) < EPS
def rho_C(xi):
    return CF(xi)
def rho_R(a):
    return RF(AA(a))
def Re(z):
    return CF(z).real()

def decompose(z):
    # 一意表示 z = α + βω（α, β ∈ AA）
    alpha = AA(z.real()); beta = AA(z.imag())
    check(QQbar(alpha) + QQbar(beta)*omega == z, 'unique decomposition')
    return alpha, beta

# 最後の分配法則の行と、包含写像の加法・乗法の保存の行（r, c1, c2 を不定元とする恒等式）
P = PolynomialRing(QQ, names=('r', 'c1', 'c2')); r, c1, c2 = P.gens()
check((1+r**2)**2 - r*(1-r**2)*(2*c1+2*c2) == (1+r**2)**2 - 2*r*(1-r**2)*(c1+c2), 'distributive line')
check(QQ(1)/3*(1-QQ(1)/9) == QQ(8)/27, 'n at q=1/3')
check((1+r**2)**2 - r*(1-r**2)*(2*c1+2*c2) != (1+r**2)**2 - r*(1-r**2)*(c1+c2), 'negative control: factor 2')

for L in range(1, 9):
    root = QQbar.zeta(2*L)
    for a in (0, 1):
        for b in (0, 1):
            for k in range(L):
                varpi = root**(2*k+a)
                theta1 = 2*pi*(k+QQ(a)/2)/L
                # 前提: ϖ ∈ U_a, ϖ ∈ μ_{2L}
                check(varpi**L == (-1)**a, 'varpi in U_a')
                check(varpi**(2*L) == 1, 'varpi in mu_2L')
                # ϖ = 0 なら 1 = ϖ^{2L} = 0^{2L} = 0（0^{2L} = 0 の行）と、ϖ ≠ 0
                check(QQbar(0)**(2*L) == 0, '0^{2L}=0')
                check(varpi != 0, 'varpi != 0')
                check(varpi*varpi**(-1) == 1, 'varpi varpi^-1 = 1')
                alpha, beta = decompose(varpi)
                # 共役: ϖ^{-1} = α − βω
                check(varpi**(-1) == QQbar(alpha) - QQbar(beta)*omega, 'conj')
                # 係数表示の三行
                s1 = (QQbar(alpha)+QQbar(beta)*omega) + (QQbar(alpha)-QQbar(beta)*omega)
                check(varpi + varpi**(-1) == s1, 'sum line1')
                check(s1 == 2*QQbar(alpha), 'sum line2')
                check(2*QQbar(alpha) == QQbar(2*alpha) + QQbar(0)*omega, 'sum line3')
                # ρ_C(ϖ) = pr_1(Θ) = exp(2πi(k+a/2)/L) = exp(iθ_1)
                e1 = (2*pi*I*(k+QQ(a)/2)/L).exp()
                check(close(rho_C(varpi), e1), 'rho_C(varpi) = exp(2 pi i (k+a/2)/L)')
                check(close(e1, (I*theta1).exp()), 'theta definition')
                # ρ_C(ϖ^{-1}) の八行
                inv = rho_C(varpi**(-1))
                ep = CF((I*theta1).exp()); em = CF((-I*theta1).exp())
                check(close(inv, 1*inv), 'inv line1')
                check(close(1*inv, CF(exp(0))*inv), 'inv line2')
                check(close(CF(exp(0))*inv, CF((-I*theta1 + I*theta1).exp())*inv), 'inv line3')
                check(close(CF((-I*theta1+I*theta1).exp())*inv, em*ep*inv), 'inv line4')
                check(close(em*ep*inv, em*rho_C(varpi)*inv), 'inv line5')
                check(close(em*rho_C(varpi)*inv, em*rho_C(varpi*varpi**(-1))), 'inv line6')
                check(close(em*rho_C(varpi*varpi**(-1)), em*rho_C(QQbar(1))), 'inv line7')
                check(close(em*rho_C(QQbar(1)), em), 'inv line8')
                # ρ_R(2α) の九行
                cth = RF(cos(theta1)); sth = RF(sin(theta1))
                v1 = CF(rho_R(2*alpha)) + CF(I)*CF(rho_R(0))
                check(abs(rho_R(2*alpha) - Re(v1)) < EPS, 'Re line1')
                check(close(v1, rho_C(QQbar(2*alpha) + QQbar(0)*omega)), 'Re line2 (def)')
                check(close(rho_C(QQbar(2*alpha)), rho_C(varpi + varpi**(-1))), 'Re line3')
                check(close(rho_C(varpi + varpi**(-1)), rho_C(varpi) + rho_C(varpi**(-1))), 'Re line4')
                check(close(rho_C(varpi) + rho_C(varpi**(-1)), ep + em), 'Re line5')
                euler = (CF(cth) + CF(I)*CF(sth)) + (CF(cos(-theta1)) + CF(I)*CF(sin(-theta1)))
                check(close(ep + em, euler), 'Re line6 (Euler)')
                parity = (CF(cth) + CF(I)*CF(sth)) + (CF(cth) - CF(I)*CF(sth))
                check(close(euler, parity), 'Re line7 (parity)')
                check(close(parity, CF(2*cth) + CF(I)*0), 'Re line8')
                check(abs(Re(CF(2*cth) + CF(I)*0) - 2*cth) < EPS, 'Re line9')
                check(abs(rho_R(2*alpha) - 2*cth) < EPS, 'rho_R(2 alpha) = 2 cos theta_1')
                # 否定の対照: スピン構造の半格子ずれを取り違えた角 θ_1 + π/L では余弦表示が崩れる
                # （cos(θ+π/L) = cos θ には 2(2k+a) ≡ −1 (mod 2L) が要り、偶奇から起きない）
                wrong = RF(cos(theta1 + pi/L))
                check(abs(rho_R(2*alpha) - 2*wrong) > EPS, 'negative control: half-shifted angle')
                for l in range(L):
                    varsigma = root**(2*l+b)
                    theta2 = 2*pi*(l+QQ(b)/2)/L
                    gamma, delta = decompose(varsigma)
                    check(varsigma**(-1) == QQbar(gamma) - QQbar(delta)*omega, 'conj vertical')
                    check(varsigma + varsigma**(-1) == QQbar(2*gamma) + QQbar(0)*omega, 'sum vertical')
                    check(close(rho_C(varsigma), (2*pi*I*(l+QQ(b)/2)/L).exp()), 'rho_C(varsigma)')
                    check(abs(rho_R(2*gamma) - 2*RF(cos(theta2))) < EPS, 'rho_R(2 gamma) = 2 cos theta_2')
                    for q in (QQ(1)/4, QQ(1)/3, QQ(2)/3):
                        m = (1+q**2)**2; n = q*(1-q**2)
                        Delta = (1+q**2)**2 - q*(1-q**2)*(varpi+varpi**(-1)+varsigma+varsigma**(-1))
                        # 分散因子の書き直しの三行
                        check(Delta == m - n*(varpi+varpi**(-1)+varsigma+varsigma**(-1)), 'Delta line2')
                        check(m - n*(varpi+varpi**(-1)+varsigma+varsigma**(-1))
                              == QQbar(m - n*(2*alpha+2*gamma)), 'Delta line3')
                        w = n*(2*alpha+2*gamma)
                        D = AA(Delta)
                        # 十行（ρ_{R→ℝ} を AA の実数値に取る）
                        rhoD = rho_R(D)
                        check(abs(rhoD - rho_R(m - w)) < EPS, 'rho line1')
                        check(abs(rho_R(m-w) - (rho_R(m-w) + rho_R(w) - rho_R(w))) < EPS, 'rho line2')
                        check(abs(rho_R(m-w) + rho_R(w) - rho_R((m-w)+w)) < EPS, 'rho line3 (additive)')
                        check(AA((m-w)+w) == AA(m), 'rho line4')
                        check(abs(rho_R(w) - rho_R(n)*rho_R(2*alpha+2*gamma)) < EPS, 'rho line5 (multiplicative)')
                        check(abs(rho_R(2*alpha+2*gamma) - (rho_R(2*alpha)+rho_R(2*gamma))) < EPS, 'rho line6')
                        check(AA(m) == m and AA(n) == n and abs(rho_R(m) - RF(m)) < EPS and abs(rho_R(n) - RF(n)) < EPS, 'rho line7 (rationals)')
                        c1v = RF(cos(theta1)); c2v = RF(cos(theta2))
                        rv = RF(q)
                        line8 = RF(m) - RF(n)*(2*c1v + 2*c2v)
                        line9 = (1+rv**2)**2 - rv*(1-rv**2)*(2*c1v+2*c2v)
                        line10 = (1+rv**2)**2 - 2*rv*(1-rv**2)*(c1v+c2v)
                        check(abs(RF(m) - RF(n)*(rho_R(2*alpha)+rho_R(2*gamma)) - line8) < EPS, 'rho line8')
                        check(abs(line8 - line9) < EPS, 'rho line9')
                        check(abs(line9 - line10) < EPS, 'rho line10')
                        check(abs(rhoD - line10) < EPS, 'conclusion')
                        # 否定の対照: 係数 2 を落とすと結論が崩れる（余弦の和が零でないとき）
                        if abs(c1v + c2v) > EPS:
                            check(abs(rhoD - ((1+rv**2)**2 - rv*(1-rv**2)*(c1v+c2v))) > EPS,
                                  'negative control: coefficient')
print('checks:', count)
print('RESULT: PASS')
