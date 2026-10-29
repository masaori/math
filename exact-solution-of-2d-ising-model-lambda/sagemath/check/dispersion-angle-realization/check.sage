# 対象ラベル: claim_dispersion_angle_realization
# 複素指数を使う有限例だけを数値で照合し、分散因子の代数等式は QQbar で検算する。
complex_field = ComplexField(160)
for L in range(1, 9):
    root = QQbar.zeta(2 * L)
    for a in (0, 1):
        for b in (0, 1):
            for k in range(L):
                z = root ** (2*k+a)
                theta_z = 2*pi*(k+QQ(a)/2)/L
                assert abs(complex_field(z) - complex_field((I*theta_z).exp())) < 1e-30
                assert abs(complex_field(z+z**(-1)) - 2*complex_field(theta_z.cos())) < 1e-30
                for l in range(L):
                    w = root ** (2*l+b)
                    theta_w = 2*pi*(l+QQ(b)/2)/L
                    assert abs(complex_field(w+w**(-1)) - 2*complex_field(theta_w.cos())) < 1e-30
                    for q in (QQ(1)/4, QQ(2)/3):
                        dispersion = (1+q**2)**2-q*(1-q**2)*(z+z**(-1)+w+w**(-1))
                        angle_form = (1+q**2)**2-2*q*(1-q**2)*(
                            (z+z**(-1))/2+(w+w**(-1))/2)
                        assert dispersion == angle_form
                        assert abs(complex_field(dispersion) - (
                            (1+q**2)**2-2*q*(1-q**2)*(
                                complex_field(theta_z.cos())+complex_field(theta_w.cos())))) < 1e-28
print('RESULT: PASS')
