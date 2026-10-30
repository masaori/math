# 対象ラベル: theorem_periodic_density_onsager_integral
# 有限体積の対数評価と最大値への移行を検算する。
# 極限と積分の等号は有限検算では証明できない。
R = RealField(150)
for L in range(1, 6):
    for M in (QQ(1)/9, QQ(2)/3, QQ(7)/4):
        for Z in (M/4, M, 2*M):
            assert M/4 <= Z <= 2*M
            v = R(M).log()/L**2
            density = R(Z).log()/L**2
            assert v-2*R(2).log()/L**2 <= density+R(1)/10**35
            assert density <= v+R(2).log()/L**2+R(1)/10**35
    values = [R(1)/L**2 + R(j)/(10*L**3) for j in range(4)]
    maximum = max(values)
    assert maximum == R(1)/L**2 + R(3)/(10*L**3)
print('RESULT: PASS')
