# 主張「順序付き部分体に虚数単位を足した表示は一意である」の式鎖と背理を一行ずつ確かめる。
# 対象ラベル: claim_imaginary_unit_extension_unique_representation
# 帰属: 恒等式は整係数多項式環 ZZ[a,a1,b,b1,w] と有理関数体、標本は QQbar の厳密な元。浮動小数点は使わない。

failures = []
passes = 0
def check(cond, msg):
    global passes
    if not cond:
        failures.append(msg)
    else:
        passes += 1

# 式鎖の各等号（仮定の代入の段を除く）を多項式の恒等式として確かめる。a1=a', b1=b', w=ω
R.<a, a1, b, b1, w> = PolynomialRing(ZZ)
check((b - b1) * w == b * w - b1 * w, "式鎖 第1等号（分配法則）")
check(b * w - b1 * w == (a + b * w) - (a + b1 * w), "式鎖 第2等号")
check((a1 + b1 * w) - (a + b1 * w) == a1 - a, "式鎖 第4等号")
# 仮定 a+bω = a'+b'ω の下での第3等号: 差 ((a+bω)-(a+b'ω)) - ((a'+b'ω)-(a+b'ω)) は仮定の両辺の差に等しい
check(((a + b * w) - (a + b1 * w)) - ((a1 + b1 * w) - (a + b1 * w)) == (a + b * w) - (a1 + b1 * w), "式鎖 第3等号は仮定の差")
# 背理の段: b-b' ≠ 0 のとき (b-b')^{-1}((b-b')ω) = ω（有理関数体で）
Fr = R.fraction_field()
check(Fr(b - b1)**(-1) * (Fr(b - b1) * Fr(w)) == Fr(w), "逆元で ω を取り出す")
# b = b' + (b-b')、a = (a+bω) - bω、(a'+b'ω) - b'ω = a'
check(b == b1 + (b - b1), "b の四則")
check(a == (a + b * w) - b * w and (a1 + b1 * w) - b1 * w == a1, "a の四則")

# 標本: F = QQ(√2)（正錐は QQbar の実の正の元）、ω = i。F の元を数体 QQ(r)（r²=2）の元で与え、
# 正の √2 への埋め込みで QQbar へ送る
s2 = QQbar(2).sqrt()
I = QQbar(-1).sqrt()
check(I * I == -1, "ω·ω = -1")
samplesF = [QQ(0), QQ(1), QQ(-3) / 2, s2, QQ(1) / 3 - s2, QQ(2) + QQ(5) / 7 * s2]
reps = [(x, y) for x in samplesF for y in samplesF]
for (x, y) in reps:
    for (x1, y1) in reps:
        same_value = (QQbar(x) + QQbar(y) * I == QQbar(x1) + QQbar(y1) * I)
        same_pair = (QQbar(x) == QQbar(x1) and QQbar(y) == QQbar(y1))
        check(same_value == same_pair, "表示が一致するのは係数が一致するときだけ")
        if same_value:
            # 式鎖の値 (b-b')ω = a'-a
            check((QQbar(y) - QQbar(y1)) * I == QQbar(x1) - QQbar(x), "標本で (b-b')ω = a'-a")

# 仮定 ω ∉ F（正錐の存在）を外すと結論は成り立たない例（主張を弱めていないことの確認）:
# F = QQ(i) は ω = i を含み、0 + 1·i = i + 0·i は係数の異なる二つの表示である
check(QQbar(0) + QQbar(1) * I == I + QQbar(0) * I and QQbar(0) != I, "ω ∈ F なら表示は一意でない例")

if failures:
    print("FAIL", len(failures))
    for f in failures[:20]:
        print("  ", f)
else:
    print("PASS", passes)
