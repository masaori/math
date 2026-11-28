# 対象ラベル: claim_tagged_matching_quadratic_crossing_weight
# 閉路内・閉路間の横断対の分割と二次符号の合成を厳密に照合する。
from itertools import product

K = CyclotomicField(8)
zeta = K.gen()
R = PolynomialRing(K, 'x')
x = R.gen()

def chi(a, b, h, v):
    return ZZ(-1) ** (h*v + (1-a)*h + (1-b)*v)

checked = 0
for n in range(4):
    for winding in product(product((0, 1), repeat=2), repeat=n):
        for crossings in product((0, 1, 2), repeat=n):
            for a, b in product((0, 1), repeat=2):
                lengths = tuple(i + 1 for i in range(n))
                mixed = tuple(winding[i][0]*winding[j][1] + winding[i][1]*winding[j][0]
                              for i in range(n) for j in range(i+1, n))
                h = sum(pair[0] for pair in winding) % 2
                v = sum(pair[1] for pair in winding) % 2
                t = sum(crossings) + sum(mixed)
                # 閉路別の位相と二次符号の既証等式から、回転位相を戻す。
                phases = tuple(-K(chi(a, b, *winding[i]) * (-1)**crossings[i])
                               * (-1)**(a*winding[i][0] + b*winding[i][1])
                               for i in range(n))
                assert all(phase**8 == 1 for phase in phases)
                first = prod((-R((-1)**(a*winding[i][0] + b*winding[i][1]) * phases[i])
                              * x**lengths[i] for i in range(n)), R.one())
                second = x**sum(lengths) * prod(
                    R(chi(a, b, *winding[i]) * (-1)**crossings[i]) for i in range(n))
                third = x**sum(lengths) * R(chi(a, b, h, v) * (-1)**t)
                fourth = R(chi(a, b, h, v) * (-1)**t) * x**sum(lengths)
                assert first == second == third == fourth
                checked += 1

# 回転位相の冪表示: rho(e,f) = zeta^{tau(e,f)}（直進・左・右の三つの場合）と、
# 閉歩道の位相積が一歩の回転数の和の冪になること（整数指数の加法則）。
rho = {0: K.one(), 1: zeta, -1: zeta**(-1)}
turnings = 0
for k in range(1, 7):
    for taus in product((-1, 0, 1), repeat=k):
        assert all(rho[tau] == zeta**tau for tau in taus)
        assert prod((rho[tau] for tau in taus), K.one()) == zeta**sum(taus)
        turnings += 1

# 定数埋込みは加法逆元と積を保つ: -x^k C(a) = x^k C(-a)、prod_C x^{k_C} C(a_C) = x^{sum k_C} C(prod a_C)。
for a_vals in product((K.one(), -K.one(), zeta, -zeta**3), repeat=3):
    ks = (1, 2, 3)
    assert all(-x**k * R(a) == x**k * R(-a) for k, a in zip(ks, a_vals))
    assert prod((x**k * R(a) for k, a in zip(ks, a_vals)), R.one()) == x**sum(ks) * R(prod(a_vals))

print(f'PASS: {checked} exact cyclotomic family assignments, {turnings} turning sequences')
