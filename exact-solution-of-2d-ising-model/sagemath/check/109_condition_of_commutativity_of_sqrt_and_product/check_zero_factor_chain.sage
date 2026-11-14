# 対象ラベル: condition_of_commutativity_of_sqrt_and_product
# r_1 = 0 の場合の鎖 (0,0)·√z_2 = 0_C √z_2 = 0_C = (0,0) を、ℂ を実数の組 (a,b) とし
# definition_of_cc の積 (a,b)(c,d) = (ac - bd, ad + bc) を成分どおりに書いて厳密に確かめる。
# √z_2 は任意の複素数なので、その成分を多項式環 QQ[c, d] の不定元 c, d に置く（浮動小数点は使わない）。
R.<c, d> = PolynomialRing(QQ)

def cc_mul(z, w):
    (a, b), (x, y) = z, w
    return (a * x - b * y, a * y + b * x)

def iota(r):  # inclusion_rr_to_cc: ι(r) = (r, 0)
    return (R(r), R(0))

sqrt_z2 = (c, d)
zero_pair = (R(0), R(0))
zero_cc = iota(0)

rows = [
    ("(0,0)·√z_2", cc_mul(zero_pair, sqrt_z2)),
    ("0_C·√z_2", cc_mul(zero_cc, sqrt_z2)),
    ("0_C", zero_cc),
    ("(0,0)", zero_pair),
]
ok = True
for (n1, v1), (n2, v2) in zip(rows, rows[1:]):
    eq = (v1 == v2)
    print(f"{n1} = {n2}: {'PASS' if eq else 'FAIL'}  ({v1} vs {v2})")
    ok = ok and eq
# 否定コントロール: 0_C の代わりに 1_C = ι(1) を掛けると (0,0) にならない
neg = cc_mul(iota(1), sqrt_z2) == zero_pair
print(f"否定コントロール 1_C·√z_2 = (0,0): {'一致してしまった (FAIL)' if neg else '一致しない (PASS)'}")
ok = ok and not neg
print("ALL PASS" if ok else "SOME FAILED")
if not ok:
    raise SystemExit(1)
