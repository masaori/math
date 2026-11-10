# 対象ラベル: exp_of_negative_i_real_as_cos_minus_i_sin
# 証明の準備の二つの鎖を一行ずつ確かめる。
#   第一の鎖（4 行）: 1_C + 1_C = (1)_C + (1)_C = (1+1)_C = (2)_C = 2_C
#   第二の鎖（17 行）: (a+b) - (a-b) = … = 2_C b
# ℂ を実数の対として持ち（definition_of_cc）、和・積は definition_of_cc の式、r_C := (r, 0)（inclusion_rr_to_cc）、
# -z := (-1_C) z（multiply_by_minus_one）、z - w := z + (-w)（def_complex_difference）を、それぞれ書いた関数で作る。
# a, b は成分を QQ 上の独立な不定元 a0, a1, b0, b1 にした一般の点。帰属: 成分は QQ[a0,a1,b0,b1] の元。ℝ への脱出はない。

R.<a0, a1, b0, b1> = PolynomialRing(QQ)

def incl(r):
    """inclusion_rr_to_cc: r_C := (r, 0)。"""
    return (R(r), R(0))

def add(z, w):
    """definition_of_cc の和。"""
    return (z[0] + w[0], z[1] + w[1])

def mul(z, w):
    """definition_of_cc の積。"""
    return (z[0] * w[0] - z[1] * w[1], z[0] * w[1] + z[1] * w[0])

m1 = incl(-1)          # -1_C
one = incl(1)          # 1_C
two = incl(2)          # 2_C
zero = incl(0)         # 0_C

def neg(z):
    """multiply_by_minus_one: -z := (-1_C) z。"""
    return mul(m1, z)

def sub(z, w):
    """def_complex_difference: z - w := z + (-w)。"""
    return add(z, neg(w))

a = (a0, a1)
b = (b0, b1)

first = [
    add(one, one),                      # 1_C + 1_C
    add(incl(1), incl(1)),              # (1)_C + (1)_C
    incl(QQ(1) + QQ(1)),                # (1+1)_C               real_inclusion_preserves_sum
    incl(2),                            # (2)_C                 ℝ で 1+1 = 2
    two,                                # 2_C
]
for k in range(len(first) - 1):
    assert first[k] == first[k + 1], ("first", k)
print(f"  第一の鎖: {len(first)} 項が QQ の対で一致する")

second = [
    sub(add(a, b), sub(a, b)),                                          # (a+b) - (a-b)
    add(add(a, b), neg(sub(a, b))),                                     # (a+b) + (-(a-b))
    add(add(a, b), neg(add(a, neg(b)))),                                # (a+b) + (-(a+(-b)))
    add(add(a, b), mul(m1, add(a, neg(b)))),                            # (a+b) + (-1)(a+(-b))
    add(add(a, b), add(mul(m1, a), mul(m1, neg(b)))),                   # 左からの分配律
    add(add(a, b), add(mul(m1, a), mul(m1, mul(m1, b)))),               # multiply_by_minus_one (z → b)
    add(add(a, b), add(mul(m1, a), mul(mul(m1, m1), b))),               # 積の結合律
    add(add(a, b), add(mul(m1, a), mul(one, b))),                       # (-1)(-1) = 1
    add(add(a, b), add(mul(m1, a), b)),                                 # 積の単位元
    add(add(a, b), add(neg(a), b)),                                     # multiply_by_minus_one を右辺から左辺へ
    add(add(add(a, b), neg(a)), b),                                     # 加法の結合律
    add(add(add(b, a), neg(a)), b),                                     # 加法の可換律
    add(add(b, add(a, neg(a))), b),                                     # 加法の結合律
    add(add(b, zero), b),                                               # 加法の逆元
    add(b, b),                                                          # 加法の単位元
    add(mul(one, b), mul(one, b)),                                      # 積の単位元（右辺から左辺へ）
    mul(add(one, one), b),                                              # 右からの分配律（右辺から左辺へ）
    mul(two, b),                                                        # 準備の第一の鎖
]
assert len(second) == 18
for k in range(len(second) - 1):
    assert second[k] == second[k + 1], ("second", k)
print(f"  第二の鎖: {len(second)} 項（17 等号）が QQ[a0,a1,b0,b1] の対で恒等的に一致する")

# 対照: 7 行目の根拠を (-1_C)(-1_C) = -1_C に替えると鎖が切れる
bad = add(add(a, b), add(mul(m1, a), mul(m1, b)))
assert bad != second[7]
# 対照: 13 行目で a + (-a) を 0_C でなく a に替えると鎖が切れる
assert add(add(b, a), b) != second[13]
print("  対照: 7 行目・13 行目の根拠を誤った値に替えると等号が成り立たない")
print("RESULT: PASS")
