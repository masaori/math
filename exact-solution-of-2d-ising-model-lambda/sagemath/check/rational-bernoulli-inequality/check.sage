# 対象ラベル: claim_rational_bernoulli_inequality
# 帰属: QQ・ZZ だけを使う厳密計算。浮動小数点は使わない。

samples_h = [QQ(0), QQ(1)/10, QQ(1)/3, QQ(1)/2, QQ(1), QQ(3)/2, QQ(2), QQ(7)/3, QQ(5)]

count = 0
for h in samples_h:
    assert h >= 0
    for n in range(0, 41):
        # 主張: 1 + n h ≤ (1+h)^n
        assert QQ(1) + QQ(n) * h <= (QQ(1) + h) ** n
        count += 1
        # 帰納法の段（n → n+1）を一段ずつ
        lhs = QQ(1) + QQ(n + 1) * h
        s1 = QQ(1) + QQ(n + 1) * h + QQ(n) * (h * h)   # 0 ≤ n h² を足す
        s2 = (QQ(1) + QQ(n) * h) * (QQ(1) + h)         # 分配則
        s3 = (QQ(1) + h) ** n * (QQ(1) + h)             # 帰納法の仮定に 0 ≤ 1+h を掛ける
        s4 = (QQ(1) + h) ** (n + 1)                     # 冪の定義
        assert QQ(n) * (h * h) >= 0 and lhs <= s1
        assert s1 == s2
        assert QQ(1) + h >= 0 and s2 <= s3
        assert s3 == s4
        count += 4

print("PASS: rational-bernoulli-inequality (%d checks)" % count)
