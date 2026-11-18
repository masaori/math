# 対象ラベル: real_log_of_power
# 3 行の根拠を set_and_algebra_notation（ℝ は順序体）の参照に替えた:
#   a^1 の鎖の最後の行 1·a = a（1·x = x、x → a）
#   n = 1 の log の鎖の 2 行目 log a = 1_ℝ·log a（1_ℝ·x = x、x → log a、右辺から左辺へ）
#   帰納段の鎖の 4 行目 ι(n) log a + log a = ι(n) log a + 1_ℝ·log a（同じ形と代入、右辺から左辺へ）
# a・log a・ι(n) を不定元に置いた QQ[a, L, N] の等号で、行に書いた形と代入どおりに確かめる（厳密。log の値は不定元 L に置くので ℝ へ脱出しない）。
R.<a, L, N> = QQ[]
def mul_left_identity(x): return (R(1) * x, x)   # 1·x = x
n = 0
l, r = mul_left_identity(a); assert l == r; n += 1
l, r = mul_left_identity(L); assert r == l; n += 1                 # 右辺から左辺へ
assert N*L + L == N*L + R(1)*L; n += 1                              # 帰納段の 4 行目
# 否定コントロール: 単位元を取り違えると等号は成り立たない。
assert R(2)*a != a and N*L + L != N*L + R(0)*L
print("multiplicative identity rows of real_log_of_power: %d checks" % n)
print("negative controls (broken lines detected): 2")
print("RESULT: PASS")
