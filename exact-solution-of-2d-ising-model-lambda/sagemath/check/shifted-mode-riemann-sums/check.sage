# 対象ラベル: claim_shifted_mode_riemann_sums
# 有限モードの角への再添字付けと標本点の区画内所属を検算する。
# 実数の極限と Riemann 積分の等式は有限検算では証明できない。
R = RealField(150)
for L in range(1, 5):
    root = QQbar.zeta(2*L)
    h = 2*R.pi()/L
    for a in (0, 1):
        for b in (0, 1):
            for q in (QQ(1)/3, QQ(2)/3):
                mode_sum = R(0)
                angle_sum = R(0)
                for k in range(L):
                    theta_1 = h*(k+QQ(a)/2)
                    assert k*h <= theta_1 <= (k+1)*h
                    z = root**(2*k+a)
                    for l in range(L):
                        theta_2 = h*(l+QQ(b)/2)
                        assert l*h <= theta_2 <= (l+1)*h
                        w = root**(2*l+b)
                        dispersion = AA((1+q**2)**2-q*(1-q**2)*(z+z**(-1)+w+w**(-1)))
                        angle_value = (1+R(q)**2)**2-2*R(q)*(1-R(q)**2)*(theta_1.cos()+theta_2.cos())
                        assert dispersion > 0
                        assert abs(R(dispersion)-angle_value) < R(1)/10**35
                        mode_sum += R(dispersion).log()
                        angle_sum += angle_value.log()
                assert abs(mode_sum/(2*L**2)-angle_sum/(2*L**2)) < R(1)/10**35
print('RESULT: PASS')
