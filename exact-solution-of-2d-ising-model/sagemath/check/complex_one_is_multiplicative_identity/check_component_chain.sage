# 対象ラベル: complex_one_is_multiplicative_identity
# 証明の z·1_C = z の鎖の 8 行と、1_C·z = z の鎖の 2 行を、各行に書かれた式どおりに組み、隣り合う項が等しいことを確かめる。
# 帰属: QQ 上の多項式環（a, b は不定元）。不定元で成り立つ等号は、任意の実数を代入しても成り立つ。
load("_prelude.sage")

P.<a, b> = PolynomialRing(QQ)
z = (a, b)
one = (P(1), P(0))   # inclusion_rr_to_cc の 1_C = (1, 0)
chain = [
    cc_mul(z, one),                 # z·1_C
    cc_mul((a, b), one),            # z = (a,b)
    cc_mul((a, b), (P(1), P(0))),   # inclusion_rr_to_cc の 1_C = (1,0)
    (a*1 - b*0, a*0 + b*1),         # definition_of_cc の積
    (a - b*0, a*0 + b),             # x·1 = x (x → a, x → b)
    (a - 0, 0 + b),                 # real_times_zero_is_zero (x → b, x → a)
    (a, 0 + b),                     # real_minus_zero_is_self (a → a)
    (a, b),                         # 0 + x = x (x → b)
    z,                              # z = (a,b)
]
for t in range(len(chain) - 1):
    assert chain[t] == chain[t + 1], t
# 1_C·z = z·1_C = z（complex_multiplication_is_commutative の w → 1_C, z → z と上の鎖）
chain2 = [cc_mul(one, z), cc_mul(z, one), z]
for t in range(len(chain2) - 1):
    assert chain2[t] == chain2[t + 1], t
# 0_C でも成り立つ（主張は C^× に限らない）
zero = {a: 0, b: 0}
assert tuple(x.subs(zero) for x in cc_mul(z, one)) == (0, 0)
# 対照: (1, 1) は単位元ではない
assert cc_mul(z, (P(1), P(1))) != z
print(f"checked {len(chain) - 1} + {len(chain2) - 1} rows")
print("RESULT: PASS")
