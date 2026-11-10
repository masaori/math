# 対象ラベル: one_plus_one_is_two_in_cc
# 証明の四行の鎖の五つの項:
#   1_C + 1_C = (1)_C + (1)_C = (1+1)_C = (2)_C = 2_C
# ℂ を実数の対として持ち（definition_of_cc）、対の和は definition_of_cc の式
# (x,y) + (u,v) = (x + u, y + v) を書いた関数で作る。r_C := (r, 0)（inclusion_rr_to_cc）。
# 帰属: 成分はすべて QQ の元。浮動小数点と RR / CC への脱出はない。

def incl(r):
    """inclusion_rr_to_cc: r_C := (r, 0)。"""
    return (QQ(r), QQ(0))

def pair_add(z, w):
    """definition_of_cc の和。"""
    return (z[0] + w[0], z[1] + w[1])

one_C = incl(1)              # 1_C は略記 r_C の r = 1
two_C = incl(2)              # 2_C は略記 r_C の r = 2

chain = [
    pair_add(one_C, one_C),                 # 1_C + 1_C
    pair_add(incl(1), incl(1)),             # (1)_C + (1)_C          略記の読み替えを 2 か所へ
    incl(QQ(1) + QQ(1)),                    # (1+1)_C                real_inclusion_preserves_sum（a → 1, b → 1）
    incl(2),                                # (2)_C                  ℝ で 1 + 1 = 2
    two_C,                                  # 2_C                    略記の読み替え
]
for k in range(len(chain) - 1):
    assert chain[k] == chain[k + 1], k
# 2 行目の根拠 real_inclusion_preserves_sum を、対の和の式から独立に確かめる（a, b を不定元として）
R.<a, b> = QQ[]
def incl_R(r):
    """inclusion_rr_to_cc を QQ[a, b] の元へ: r_C := (r, 0)。"""
    return (R(r), R(0))
assert pair_add(incl_R(a), incl_R(b)) == incl_R(a + b)
# 独立な経路: QQ(i) の和で 1 + 1 を計算する
K.<I> = QuadraticField(-1)
assert K(1) + K(1) == K(2)
# 対照: 1_C + 1_C は 1_C でも (2, 1) でもない
assert pair_add(one_C, one_C) != one_C
assert pair_add(one_C, one_C) != (QQ(2), QQ(1))
print("checked the chain of 5 terms over QQ pairs")
print("RESULT: PASS")
