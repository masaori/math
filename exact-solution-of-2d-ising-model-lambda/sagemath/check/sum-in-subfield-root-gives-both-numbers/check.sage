# 主張「和が部分体に入る二数は、二数を根とする二次式の値を零にする部分体の元があれば共に部分体に入る」の
# 式鎖と場合分けを一行ずつ確かめる。
# 対象ラベル: claim_sum_in_subfield_root_gives_both_numbers
# 帰属: 恒等式は整係数多項式環 ZZ[a,b,g]、標本は QQbar の厳密な元。浮動小数点は使わない。

failures = []
passes = 0
def check(cond, msg):
    global passes
    if not cond:
        failures.append(msg)
    else:
        passes += 1

# 式鎖の各等号を、可換な変数 a=α, b=β, g=γ の整係数多項式の恒等式として確かめる
R.<a, b, g> = PolynomialRing(ZZ)
chain = [(g - a) * (g - b),
         g * g - g * b - a * g + a * b,
         g * g - (a * g + b * g) + a * b,
         g * g - (a + b) * g + a * b]
for i in range(len(chain) - 1):
    check(chain[i] == chain[i + 1], "式鎖 第%d等号" % (i + 1))
check(a == g - (g - a) and b == (a + b) - a, "γ-α=0 の場合の四則の等号")
check(b == g - (g - b) and a == (a + b) - b, "γ-β=0 の場合の四則の等号")

# 標本: K を QQbar の部分体 QQ(√2) とする。数体 Kf = QQ(r)（r² = 2）を r ↦ 正の √2 で QQbar へ埋め込み、
# z ∈ K を「z の最小多項式の Kf での根のうち、埋め込みの像が z に等しいものがある」で判定する
s2 = QQbar(2).sqrt()
Kf.<r> = NumberField(QQ["t"]([-2, 0, 1]))
emb = [e for e in Kf.embeddings(QQbar) if e(r) == s2][0]
def in_K(z):
    z = QQbar(z)
    f = z.minpoly()
    return any(emb(rt) == z for rt, _ in f.change_ring(Kf).roots())

samplesK = [QQ(3) / 2 + QQ(1) / 3 * s2, QQ(-2) + s2, QQ(5), QQ(1) / 2 * s2, QQ(-1) / 7 - QQ(2) * s2]
count_case = [0, 0]
for x in samplesK:
    for y in samplesK:
        # α, β ∈ K で α+β ∈ K。γ を α・β の各々、および二次式の値を零にしない K の元として試す
        alpha, beta = QQbar(x), QQbar(y)
        for gam in [alpha, beta] + [QQbar(z) for z in samplesK]:
            val = gam * gam - (alpha + beta) * gam + alpha * beta
            if val != 0:
                continue
            # 仮定が成り立つ標本: 場合分けのどちらかに入り、結論 α, β ∈ K
            prod = (gam - alpha) * (gam - beta)
            check(prod == 0, "標本で (γ-α)(γ-β)=0")
            if gam - alpha == 0:
                count_case[0] += 1
                check(alpha == gam, "γ-α=0 なら α=γ")
            else:
                count_case[1] += 1
                check(gam - beta == 0, "γ-α≠0 なら γ-β=0（零因子が無い）")
                check(beta == gam, "γ-β=0 なら β=γ")
            check(in_K(alpha) and in_K(beta), "結論 α, β ∈ K")
check(count_case[0] > 0 and count_case[1] > 0, "両方の場合が標本に現れる")

# 仮定 γ∈K を外すと結論は成り立たない例（主張を弱めていないことの確認）:
# α=√3, β=-√3 は α+β=0∈K だが、二次式 t²-3 を零にする K の元は無く、α∉K
alpha, beta = QQbar(3).sqrt(), -QQbar(3).sqrt()
check(in_K(alpha + beta) and not in_K(alpha), "γ∈K が無ければ α∈K とは限らない例")

if failures:
    print("FAIL", len(failures))
    for f in failures[:20]:
        print("  ", f)
else:
    print("PASS", passes)
