# 主張「根の番号の対の個数の倍は、次数と次数より一つ小さい数の積である」の式鎖を一行ずつ確かめる。
# 対象ラベル: claim_root_index_pair_count
# 帰属: すべて自然数（Sage の ZZ の非負の元）と有限集合。浮動小数点は使わない。

failures = []
passes = 0
def check(cond, msg):
    global passes
    if not cond:
        failures.append(msg)
    else:
        passes += 1

def Pr(d):
    return set((i, j) for i in range(d) for j in range(d) if i < j)

# 基底: Pr_1 は空で、|Pr_1| + |Pr_1| = 0 + 0 = (0+1)·0
check(Pr(1) == set(), "Pr_1 は空")
l0 = [len(Pr(1)) + len(Pr(1)), 0 + 0, (0 + 1) * 0]
for i in range(len(l0) - 1):
    check(l0[i] == l0[i + 1], "基底 第%d等号" % (i + 1))

for e in range(0, 40):
    P1 = Pr(e + 1)
    P2 = Pr(e + 2)
    C = set((i, e + 1) for i in range(e + 1))
    tag = "e=%d" % e
    # 準備: Pr_{e+2} は互いに素な Pr_{e+1} と C_{e+1} の和集合
    check(C <= P2, tag + ": C_{e+1} ⊂ Pr_{e+2}")
    check(P1 & C == set(), tag + ": Pr_{e+1} と C_{e+1} は互いに素")
    check(P1 | C == P2, tag + ": Pr_{e+2} = Pr_{e+1} ∪ C_{e+1}")
    # i ↦ (i, e+1) は全単射で |C_{e+1}| = e+1
    img = [(i, e + 1) for i in range(e + 1)]
    check(len(set(img)) == e + 1 and set(img) == C, tag + ": i ↦ (i,e+1) は全単射")
    # 個数の式鎖
    l1 = [len(P2), len(P1) + len(C), len(P1) + (e + 1)]
    for i in range(len(l1) - 1):
        check(l1[i] == l1[i + 1], tag + ": 個数の式鎖 第%d等号" % (i + 1))
    # 帰納法の一歩の式鎖（帰納法の仮定 |Pr_{e+1}|+|Pr_{e+1}| = (e+1)e も確かめる）
    check(len(P1) + len(P1) == (e + 1) * e, tag + ": 帰納法の仮定")
    l2 = [len(P2) + len(P2),
          (len(P1) + (e + 1)) + (len(P1) + (e + 1)),
          (len(P1) + len(P1)) + ((e + 1) + (e + 1)),
          (e + 1) * e + ((e + 1) + (e + 1)),
          ((e + 1) + 1) * (e + 1)]
    for i in range(len(l2) - 1):
        check(l2[i] == l2[i + 1], tag + ": 一歩の式鎖 第%d等号" % (i + 1))

# 結論の式鎖: d ≥ 1 と、Pr_d の元を並べた全単射 ν: N_{<N} → Pr_d
for d in range(1, 41):
    nu = sorted(Pr(d))
    N = len(nu)
    e = d - 1
    tag = "d=%d" % d
    check(len(set(nu)) == N and set(nu) == Pr(d), tag + ": ν は全単射")
    l3 = [N + N, len(range(N)) + len(range(N)), len(Pr(d)) + len(Pr(d)),
          len(Pr(e + 1)) + len(Pr(e + 1)), (e + 1) * e, d * (d - 1)]
    for i in range(len(l3) - 1):
        check(l3[i] == l3[i + 1], tag + ": 結論の式鎖 第%d等号" % (i + 1))

if failures:
    print("FAIL", len(failures))
    for f in failures[:20]:
        print("  ", f)
else:
    print("PASS", passes)
