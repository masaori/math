# 対象ラベル: i_times_i_is_minus_one_in_cc
# 証明の十行の鎖の十一の項:
#   i i = (0,1)(0,1) = (0·0 - 1·1, 0·1 + 1·0) = (0 - 1·1, 0·1 + 1·0) = (0 - 1, 0·1 + 1·0)
#       = (0 - 1, 0 + 1·0) = (0 - 1, 0 + 0) = (0 - 1, 0) = (0 + (-1), 0) = (-1, 0) = -1_C
# ℂ を実数の対として持ち（definition_of_cc）、対の積は definition_of_cc の式
# (x,y)(u,v) = (xu - yv, xv + yu) を書いた関数で作る。i := (0,1)（def_imaginary_unit）、r_C := (r, 0)（inclusion_rr_to_cc）。
# 帰属: 成分はすべて QQ の元。浮動小数点と RR / CC への脱出はない。

def incl(r):
    """inclusion_rr_to_cc: r_C := (r, 0)。"""
    return (QQ(r), QQ(0))

def pair_mul(z, w):
    """definition_of_cc の積。"""
    return (z[0] * w[0] - z[1] * w[1], z[0] * w[1] + z[1] * w[0])

i = (QQ(0), QQ(1))           # def_imaginary_unit
chain = [
    pair_mul(i, i),                                          # i i
    pair_mul((QQ(0), QQ(1)), (QQ(0), QQ(1))),                # (0,1)(0,1)              def_imaginary_unit を 2 か所へ
    (QQ(0) * 0 - QQ(1) * 1, QQ(0) * 1 + QQ(1) * 0),          # (0·0-1·1, 0·1+1·0)      definition_of_cc の積
    (QQ(0) - QQ(1) * 1, QQ(0) * 1 + QQ(1) * 0),              # (0-1·1, 0·1+1·0)        real_zero_times_is_zero (x → 0)
    (QQ(0) - QQ(1), QQ(0) * 1 + QQ(1) * 0),                  # (0-1, 0·1+1·0)          ℝ で 1·x = x (x → 1)
    (QQ(0) - QQ(1), QQ(0) + QQ(1) * 0),                      # (0-1, 0+1·0)            real_zero_times_is_zero (x → 1)
    (QQ(0) - QQ(1), QQ(0) + QQ(0)),                          # (0-1, 0+0)              real_times_zero_is_zero (x → 1)
    (QQ(0) - QQ(1), QQ(0)),                                  # (0-1, 0)                0 + 0 = 0
    (QQ(0) + (-QQ(1)), QQ(0)),                               # (0+(-1), 0)             def_real_difference (y → 0, z → 1)
    (QQ(-1), QQ(0)),                                         # (-1, 0)                 ℝ の加法の単位元 (0 + (-1) = -1)
    incl(-1),                                                # -1_C                    略記 r_C の r = -1
]
for k in range(len(chain) - 1):
    assert chain[k] == chain[k + 1], k
# 独立な経路: QQ(i) の積
K.<I> = QuadraticField(-1)
assert I * I == K(-1)
# 否定の対照: 積の第 1 成分の式を xu + yv と書き違えると 1_C になり、-1_C にならない
assert (QQ(0) * 0 + QQ(1) * 1, QQ(0) * 1 + QQ(1) * 0) != incl(-1)
# 各行で使った等式そのもの（不定元 x, a, y, z を置いた多項式環で）
R.<x, a, y, z> = QQ[]
assert 0 * x == 0 and x * 0 == 0 and 1 * x == x and 0 + a == a and R(0) + R(0) == R(0)
assert y - z == y + (-z)                                    # def_real_difference
assert (y - z).subs(y=0, z=1) == QQ(0) + (-QQ(1))           # その y → 0, z → 1
print("checked the chain of 11 terms over QQ pairs")
print("RESULT: PASS")
