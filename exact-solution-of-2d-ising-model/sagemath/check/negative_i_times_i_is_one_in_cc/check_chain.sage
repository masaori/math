# 対象ラベル: negative_i_times_i_is_one_in_cc
# 証明の四行の鎖の五つの項:
#   (-i) i = -(i i) = -(-1_C) = (-1_C)(-1_C) = 1_C
# ℂ を実数の対として持ち（definition_of_cc）、積は definition_of_cc の式、
# 符号反転 -z := (-1_C) z（multiply_by_minus_one）、i := (0,1)（def_imaginary_unit）、r_C := (r, 0)（inclusion_rr_to_cc）。
# 帰属: 成分はすべて QQ の元。浮動小数点と RR / CC への脱出はない。

def incl(r):
    return (QQ(r), QQ(0))

def pair_mul(z, w):
    return (z[0] * w[0] - z[1] * w[1], z[0] * w[1] + z[1] * w[0])

def neg(z):
    """multiply_by_minus_one: -z := (-1_C) z。"""
    return pair_mul(incl(-1), z)

i = (QQ(0), QQ(1))
m1 = incl(-1)
chain = [
    pair_mul(neg(i), i),          # (-i) i
    neg(pair_mul(i, i)),          # -(i i)              negative_i_times_complex_is_negation_of_i_times（z → i）
    neg(m1),                      # -(-1_C)             i_times_i_is_minus_one_in_cc
    pair_mul(m1, m1),             # (-1_C)(-1_C)        multiply_by_minus_one（z → -1_C）
    incl(1),                      # 1_C                 minus_one_times_minus_one_is_one_in_cc
]
for k in range(len(chain) - 1):
    assert chain[k] == chain[k + 1], k
# 引く主張の当てはめ
assert pair_mul(i, i) == m1                                   # i_times_i_is_minus_one_in_cc
assert pair_mul(m1, m1) == incl(1)                            # minus_one_times_minus_one_is_one_in_cc
# 独立な経路: QQ(i) の積
K.<I> = QuadraticField(-1)
assert (-I) * I == K(1)
# 否定の対照: i i は 1_C ではない（-(i i) を i i と読むと鎖が 1_C に着かない）
assert pair_mul(i, i) != incl(1)
print("checked the chain of 5 terms over QQ pairs")
print("RESULT: PASS")
