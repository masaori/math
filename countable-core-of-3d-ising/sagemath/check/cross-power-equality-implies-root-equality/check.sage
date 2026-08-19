# 対象ラベル: claim_cross_power_equality_implies_root_equality
# 交差べき等式 A^M=B^N から正の乗根の一致 A^{1/N}=B^{1/M} を導く証明の可算側の段を、
# 乗根が正有理数になる例で証明と同順に確認する。
# 帰属: QQ の厳密計算だけを使う。実数・浮動小数点・対数・極限は使わない。

failures = []


def check(label, condition):
    if not condition:
        failures.append(label)


# 乗根が正有理数に取れる例。(A, N, x) と (B, M, y) は x^N=A, y^M=B を満たす。
# 証明の一行ずつ: x^{NM}=(x^N)^M=A^M=B^N=(y^M)^N=y^{MN}=y^{NM}、単射性で x=y。
examples = [
    (QQ(8), 3, QQ(2), QQ(4), 2, QQ(2)),
    (QQ(27) / 8, 3, QQ(3) / 2, QQ(9) / 4, 2, QQ(3) / 2),
    (QQ(1) / 32, 5, QQ(1) / 2, QQ(1) / 4, 2, QQ(1) / 2),
]

for A, N, x, B, M, y in examples:
    tag = f"A={A},N={N},B={B},M={M}"
    check(f"正値 {tag}", A > 0 and B > 0 and x > 0 and y > 0)
    check(f"乗根の定義 x^N=A {tag}", x**N == A)
    check(f"乗根の定義 y^M=B {tag}", y**M == B)
    # 仮定: 交差べき等式は QQ の有限回の積で判定できる
    check(f"仮定 A^M=B^N {tag}", A**M == B**N)
    # 証明の各行
    check(f"x^(NM)=(x^N)^M {tag}", x ** (N * M) == (x**N) ** M)
    check(f"(x^N)^M=A^M {tag}", (x**N) ** M == A**M)
    check(f"B^N=(y^M)^N {tag}", B**N == (y**M) ** N)
    check(f"(y^M)^N=y^(MN) {tag}", (y**M) ** N == y ** (M * N))
    check(f"y^(MN)=y^(NM) {tag}", y ** (M * N) == y ** (N * M))
    check(f"結論 x=y {tag}", x == y)

# 正の自然数乗の単射性の有限標本: 正有理数 x≠y なら x^k≠y^k
injectivity_samples = [QQ(1) / 3, QQ(1) / 2, QQ(1), QQ(3) / 2, QQ(2), QQ(7) / 3]
for k in [1, 2, 3, 6]:
    for x in injectivity_samples:
        for y in injectivity_samples:
            if x != y:
                check(f"単射性 x={x},y={y},k={k}", x**k != y**k)

# 負例: 交差べき等式が成り立たない組は仮定の段で検出される
check("負例 2^1 != 3^1", QQ(2) ** 1 != QQ(3) ** 1)
check("負例 4^3 != 8^1", QQ(4) ** 3 != QQ(8) ** 1)

if failures:
    print("FAIL:")
    for label in failures:
        print("  " + label)
    raise SystemExit(1)
print("PASS: cross-power-equality-implies-root-equality の可算側の段をすべて確認した")
