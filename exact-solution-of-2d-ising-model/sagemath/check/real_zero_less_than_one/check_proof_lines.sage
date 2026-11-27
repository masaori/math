# 対象ラベル: real_zero_less_than_one
# 1 ≤ 0 の場合（第 2 の鎖の結論 1 < 0 から）の 0 = 1 + (−1) < 0 + (−1) = −1、0 < (−1)·(−1) = 1·1 = 1 を導く第 3・第 4 の鎖を確かめる。
# 1 の加法の逆元 −1 を不定元 n に置き（1 + (−1) = 0 を前提にしないため）、
# 逆元を使う段は、その前提が生成するイデアル (1 + n) に差が入ることとして確かめる。
# 不等号の段（順序と加法の両立、正の数どうしの積は正）は、両辺の差が当てた c によらないこと、
# および有理数の標本で公理の形が成り立つことで確かめる（第 2 の鎖の結論 1 < 0 は ℝ では偽なので、段の形だけを確かめる）。
# 帰属: 多項式環 QQ[n] とそのイデアル、有理数 QQ、代数的実数 AA。浮動小数点は使わない。

R.<n> = QQ[]
I_inv = R.ideal([1 + n])          # def_real_difference の加法の逆元 1 + (−1) = 0（−1 を n と書く）

chain1 = [
    R(0),       # 鎖の左辺 0
    1 + n,      # 加法の逆元を右辺から左辺へ
    0 + n,      # 順序と加法の両立（x → 1, y → 0, c → −1）
    n,          # 加法の単位元
]
chain2 = [
    R(0),       # 鎖の左辺 0
    n * n,      # 正の数どうしの積は正（0 < −1 を 2 つの因子へ）
    R(1) * R(1),  # real_negation_times_negation_is_product（a → 1, b → 1）
    R(1),       # 乗法の単位元
]

k = 0
assert (chain1[0] - chain1[1]) in I_inv; k += 1             # 第 3 の鎖 1 段目は 1 + (−1) = 0 のもとで等しい
assert (chain1[1] - chain1[2]) == R(1) - R(0); k += 1       # 2 段目: 両辺の差は x − y = 1 − 0 で、同じ c = n を足しただけ
assert chain1[2] == chain1[3]; k += 1                       # 3 段目は恒等的
assert (chain2[1] - chain2[2]) in I_inv; k += 1             # 第 4 の鎖 2 段目は n = −1 のもとで (−1)(−1) = 1·1
assert chain2[2] == chain2[3]; k += 1                       # 3 段目は恒等的
# 不等号の段の公理の形を有理数の標本で確かめる。
vals = [QQ(-3), QQ(-1)/2, QQ(0), QQ(2)/7, QQ(5)]
m = 0
for x in vals:
    for y in vals:
        if x < y:
            for c in vals:
                assert x + c < y + c; m += 1                # 順序と加法の両立
for a in vals:
    for b in vals:
        if a > 0 and b > 0:
            assert a * b > 0; m += 1                        # 正の数どうしの積は正
# 主張: 0 < 1（QQ と AA で）。0 ≠ 1 も。
assert QQ(0) < QQ(1) and AA(0) < AA(1); k += 1
assert QQ(0) != QQ(1); k += 1
# 否定コントロール: 逆元の前提を外すと 1 段目は成り立たない。
assert chain1[0] != chain1[1]
# 否定コントロール: 前提を外すと n·n = 1·1 は恒等的な等号ではない。
assert chain2[1] != chain2[2]
# 否定コントロール: 第 2 の鎖の結論 1 < 0 は QQ では偽（実際には起きない場合であることの確認）。
assert not (QQ(1) < QQ(0))

print("QQ[n] で 2 本の鎖の 5 段と主張を確かめた（%d 個）。不等号の段の公理の形を有理数の標本 %d 件で確かめた" % (k, m))
print("negative controls (broken lines detected): 3")
print("RESULT: PASS")
