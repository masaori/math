# 対象ラベル: claim_finite_internal_scattering_compatibilities_decidable
# 判定: 三つの型付き成分交換と整数位相持ち上げについて、Yang--Baxter 等式を記号的整数次数で検査する。
# 帰属: 有限集合、有限写像表、ZZ 上の多項式環。実数体・複素数体・浮動小数点は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

degrees = PolynomialRing(ZZ, names=('d_B', 'd_C', 'd_D'))
d_B, d_C, d_D = degrees.gens()
states = {
    'B': ('b0', 'b1'),
    'C': ('c0', 'c1'),
    'D': ('d0', 'd1'),
}
energy = {('B', 'C'): ZZ(1), ('B', 'D'): ZZ(-2), ('C', 'D'): ZZ(3)}

def lift(first_type, second_type, first, second):
    return swap_affine(first, second, energy[(first_type, second_type)])

checked = ZZ(0)
for b, c, d in product(states['B'], states['C'], states['D']):
    initial = ((d_B, b), (d_C, c), (d_D, d))

    c_part, b_part = lift('B', 'C', initial[0], initial[1])
    d_part, b_part = lift('B', 'D', b_part, initial[2])
    d_part, c_part = lift('C', 'D', c_part, d_part)
    left = (d_part, c_part, b_part)

    d_part, c_part = lift('C', 'D', initial[1], initial[2])
    d_part, b_part = lift('B', 'D', initial[0], d_part)
    c_part, b_part = lift('B', 'C', b_part, c_part)
    right = (d_part, c_part, b_part)

    assert left == right
    assert left[0][0] == d_D + ZZ(1)
    assert left[1][0] == d_C - ZZ(2)
    assert left[2][0] == d_B + ZZ(1)
    checked += 1

assert checked == len(states['B']) * len(states['C']) * len(states['D'])
print('typed affine Yang--Baxter internal triples checked:', checked)
print('RESULT: PASS')
