# 対象ラベル: power_of_two_in_integers_is_at_least_one
# 帰納段の鎖の 2 行の根拠を set_and_algebra_notation（ℤ は整数環）の参照に替えた:
#   2^M·1 + 2^M·1 = 2^M + 2^M（x ·_ℤ 1_ℤ = x、x → 2_ℤ^M、2 箇所へ）
#   1 + 0 = 1（x +_ℤ 0_ℤ = x、x → 1_ℤ）
# 2^M を不定元 P に置いた ZZ[P] と、M = 0..39 の ZZ の値で、行に書いた形と代入どおりに確かめる（厳密）。
R.<P> = ZZ[]
def mul_right_identity(x): return (x * 1, x)   # x ·_ℤ 1_ℤ = x
def add_right_identity(x): return (x + 0, x)   # x +_ℤ 0_ℤ = x
n = 0
l, r = mul_right_identity(P); assert l == r; n += 1
assert P*1 + P*1 == P + P; n += 1                 # 2 箇所へ同時に当てた行
l, r = add_right_identity(ZZ(1)); assert l == r and ZZ(1) + ZZ(0) == ZZ(1); n += 1
for M in range(40):
    p = ZZ(2)^M
    assert p*1 + p*1 == p + p; n += 1
# 否定コントロール: 単位元を取り違えると等号は成り立たない。
assert P*0 + P*0 != P + P and ZZ(1) + ZZ(1) != ZZ(1)
print("identity rows of power_of_two_in_integers_is_at_least_one: %d checks" % n)
print("negative controls (broken lines detected): 2")
print("RESULT: PASS")
