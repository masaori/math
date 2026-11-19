# 対象ラベル: real_times_zero_is_zero
# x0 = x0 + 0 = x0 + (x0 + (-(x0))) = (x0 + x0) + (-(x0)) = x(0 + 0) + (-(x0)) = x0 + (-(x0)) = 0
# の 6 行の鎖を確かめる。
# 計算する環では x0 = 0 が既に成り立つので、掛けられる側の 0 を QQ[o, x] の不定元 o に置き、
# x0 = 0 を前提にしない形で、どの行にどの規則を当てたかを確かめる（足す側の 0 と逆元は環のもの）。
# 帰属: 多項式環 QQ[o, x]。浮動小数点は使わない。

R.<o, x> = QQ[]
ZERO = R(0)


def f(t):
    """4 行目と 5 行目に共通する形 x·t + (-(x·o))。5 行目は 4 行目の (o + o) を o に置き換えたもの。"""
    return x * t + (-(x * o))


lines = [
    x * o,                                   # 1 行目の左辺 x0
    x * o + ZERO,                            # 加法の単位元を右辺から左辺へ
    x * o + (x * o + (-(x * o))),            # 加法の逆元（z → x0）を右辺から左辺へ
    (x * o + x * o) + (-(x * o)),            # 加法の結合律
    x * (o + o) + (-(x * o)),                # 分配律 a(b+c) = ab+ac を右辺から左辺へ
    x * o + (-(x * o)),                      # 0 + 0 = 0
    ZERO,                                    # 加法の逆元（z → x0）
]

# 0 + 0 = 0 を当てる段（5 行目 → 6 行目）以外は、o を不定元にしたまま恒等的に等しい。
identity_steps = [0, 1, 2, 3, 5]
for k in identity_steps:
    assert lines[k] == lines[k + 1], (k, lines[k], lines[k + 1])

# 0 + 0 = 0 の段: 4 行目・5 行目は f の (o + o) と o への評価で、o = 0 のとき o + o = o。
assert lines[4] == f(o + o) and lines[5] == f(o)
assert (o + o).subs(o=0) == o.subs(o=0)
# 否定コントロール: o が一般の値なら 0 + 0 = 0 の段は成り立たない。
assert lines[4] != lines[5]
# 否定コントロール: 分配律の段で (o + o) を (o + 1) に取り違えると 3 行目と一致しない。
assert x * (o + 1) + (-(x * o)) != lines[3]

# o = 0 を代入すると、全ての行が 0 になり、鎖の両端 x0 と 0 が一致する。
eq_count = len(identity_steps) + 1
assert all(l.subs(o=0) == 0 for l in lines)

print(f"QQ[o, x] で恒等的な段 {len(identity_steps)} 個と、o = 0 でだけ成り立つ 0 + 0 = 0 の段 1 個を確かめた（等号 {eq_count} 個）")
print("o = 0 を代入して全ての行が 0 になった")
print("negative controls (broken lines detected): 2")
print("RESULT: PASS")
