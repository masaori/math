# 主張「偶数の次数の対の個数は、次数の 2 の冪の指数を一つ下げた冪と奇数の積である」の式鎖を一行ずつ確かめる。
# 対象ラベル: claim_pair_count_two_adic_valuation_decrease
# 帰属: すべて自然数（Sage の ZZ の非負の元）。浮動小数点は使わない。

failures = []
passes = 0
def check(cond, msg):
    global passes
    if not cond:
        failures.append(msg)
    else:
        passes += 1

for k in range(1, 9):
    for j in range(0, 40):
        m = j + j + 1
        d = 2^k * m
        # 仮定 N + N = d·(d-1) を満たす N（d(d-1) は偶数なので一つに決まる）
        N = ZZ(d * (d - 1) / 2)
        tag = "k=%d, m=%d" % (k, m)
        check(N + N == d * (d - 1), tag + ": 仮定 N+N = d(d-1)")
        # 準備
        check(k == (k - 1) + 1, tag + ": k = (k-1)+1")
        a = 2^(k - 1) * m
        check(a >= 1 * 1, tag + ": a ≥ 1·1")
        b = a - 1
        check(b >= 0 and a == b + 1, tag + ": a = b + 1、b は自然数")
        # 第一の式鎖
        l = [d, 2^k * m, 2^((k - 1) + 1) * m, 2 * (2^(k - 1) * m), 2 * a, 2 * (b + 1), (b + b + 1) + 1]
        for i in range(len(l) - 1):
            check(l[i] == l[i + 1], tag + ": 第一の式鎖 第%d等号" % (i + 1))
        # d - 1 = b + b + 1
        check(d - 1 >= 0 and (d - 1) + 1 == (b + b + 1) + 1 and d - 1 == b + b + 1, tag + ": d-1 = b+b+1")
        # 第二の式鎖
        mp = m * (d - 1)
        jp = 2 * j * b + j + b
        l2 = [mp, m * (d - 1), (j + j + 1) * (b + b + 1), jp + jp + 1]
        for i in range(len(l2) - 1):
            check(l2[i] == l2[i + 1], tag + ": 第二の式鎖 第%d等号" % (i + 1))
        check(mp % 2 == 1, tag + ": m' は奇数（対照）")
        # 第三の式鎖
        l3 = [N + N, d * (d - 1), (2 * a) * (d - 1), a * (d - 1) + a * (d - 1)]
        for i in range(len(l3) - 1):
            check(l3[i] == l3[i + 1], tag + ": 第三の式鎖 第%d等号" % (i + 1))
        # 倍の消去
        check(N == a * (d - 1), tag + ": 倍の消去 N = a(d-1)")
        # 第四の式鎖
        l4 = [N, a * (d - 1), 2^(k - 1) * m * (d - 1), 2^(k - 1) * mp]
        for i in range(len(l4) - 1):
            check(l4[i] == l4[i + 1], tag + ": 第四の式鎖 第%d等号" % (i + 1))
        # 対照: N の 2 進付値は k-1
        check(N.valuation(2) == k - 1, tag + ": 対照 N の 2 進付値は k-1")

# 倍の消去 N+N = M+M ⇒ N = M の総当たり
for x in range(60):
    for y in range(60):
        if x + x == y + y:
            check(x == y, "倍の消去 %d %d" % (x, y))

if failures:
    print("FAIL", len(failures))
    for f in failures[:20]:
        print("  ", f)
else:
    print("PASS", passes)
