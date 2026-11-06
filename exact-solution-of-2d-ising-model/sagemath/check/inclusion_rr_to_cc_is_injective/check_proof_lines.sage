# 対象ラベル: inclusion_rr_to_cc_is_injective
# a_ℂ = b_ℂ なら a = b の鎖 (a, 0) = a_ℂ = b_ℂ = (b, 0) と、第 1 成分の比較を、点の組の全てで確かめる。
# 帰属: ℂ = ℝ² を (実部, 虚部) の組として持ち、成分は QQ と AA。浮動小数点は使わない。
def iota(x):
    """inclusion_rr_to_cc: ι(x) := (x, 0)。"""
    return (x, AA(0))


PTS = [QQ(-7), QQ(-5)/2, QQ(-1), QQ(0), QQ(1)/4, QQ(1), QQ(3)/2] + [AA(2).sqrt(), -AA(3).sqrt(), AA(2).sqrt() + 0]

n_eq = 0
n_ne = 0
for a in PTS:
    for b in PTS:
        if iota(a) == iota(b):                                       # 仮定 a_ℂ = b_ℂ
            assert (a, 0) == iota(a) and iota(a) == iota(b) and iota(b) == (b, 0)   # 鎖の 3 行
            assert (a, 0)[0] == (b, 0)[0]                            # ℝ² の等号は成分ごと: 第 1 成分
            assert a == b                                            # 主張
            n_eq += 1
        else:
            assert a != b                                            # 対偶の側: a ≠ b なら a_ℂ ≠ b_ℂ
            n_ne += 1
assert n_eq > len(PTS) and n_ne > 0                                  # sqrt(2) を 2 回入れたので、対角以外の等しい組も含む
print(f"a_ℂ = b_ℂ の {n_eq} 組で鎖と主張を、a_ℂ ≠ b_ℂ の {n_ne} 組で a ≠ b を確かめた")
print("RESULT: PASS")
