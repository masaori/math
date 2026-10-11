# 非負有理数の標本。既存の統合検算と同じ分子・分母 1..15 と零を使う。
BOUND = 15
samples = sorted({QQ(0)} | {
    QQ(num) / QQ(den)
    for num in range(1, BOUND + 1)
    for den in range(1, BOUND + 1)
})
assert len(samples) == 144
