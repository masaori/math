# 対象ラベル: minus_one_times_minus_one_is_one_in_cc
# 証明の四行の鎖の五つの項:
#   (-1_C)(-1_C) = (-1)_C (-1)_C = ((-1)(-1))_C = (1)_C = 1_C
# ℂ を実数の対として持ち（definition_of_cc）、対の積は definition_of_cc の式
# (x,y)(u,v) = (xu - yv, xv + yu) を書いた関数で作る。r_C := (r, 0)（inclusion_rr_to_cc）。
# 帰属: 成分はすべて QQ の元。浮動小数点と RR / CC への脱出はない。

def incl(r):
    """inclusion_rr_to_cc: r_C := (r, 0)。"""
    return (QQ(r), QQ(0))

def pair_mul(z, w):
    """definition_of_cc の積。"""
    return (z[0] * w[0] - z[1] * w[1], z[0] * w[1] + z[1] * w[0])

minus_one_C = incl(-1)       # -1_C は略記 r_C の r = -1
one_C = incl(1)              # 1_C は略記 r_C の r = 1

chain = [
    pair_mul(minus_one_C, minus_one_C),     # (-1_C)(-1_C)
    pair_mul(incl(-1), incl(-1)),           # (-1)_C (-1)_C          略記の読み替え
    incl(QQ(-1) * QQ(-1)),                  # ((-1)(-1))_C           real_inclusion_preserves_product
    incl(1),                                # (1)_C                  ℝ で (-1)(-1) = 1
    one_C,                                  # 1_C                    略記の読み替え
]
for k in range(len(chain) - 1):
    assert chain[k] == chain[k + 1], k
# 1 行目の読みの対照: (-1)_C は definition_of_cc の和で 1_C の加法の逆元である
def pair_add(z, w):
    return (z[0] + w[0], z[1] + w[1])
assert pair_add(minus_one_C, one_C) == incl(0)
# 独立な経路: QQ(i) の積で (-1)(-1) を計算する
K.<I> = QuadraticField(-1)
assert K(-1) * K(-1) == K(1)
# 対照: (-1_C) と 1_C の積は 1_C ではない
assert pair_mul(minus_one_C, one_C) != one_C
print("checked the chain of 5 terms over QQ pairs")
print("RESULT: PASS")
