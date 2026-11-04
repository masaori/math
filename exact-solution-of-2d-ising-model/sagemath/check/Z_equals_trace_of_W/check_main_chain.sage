# 対象ラベル: Z_equals_trace_of_W
# 証明の本体の鎖 tr((V_1V_2)^n) = ⋯ = tr(W^n)（6 等号）の各行。n = 1..6、k := n - 1。
# 準備 1 を満たす一般の組として B・V_2 を独立に取り V_1 := BB、W := (BV_2)B と置く。
# 巡回性の行（第 4 → 5 等号）は、トレースの前の行列どうしは一般に異なる（対照）ことも確かめる。
# 対照: V_1 を B と独立に取ると、BB = V_1 に依る等号だけが崩れる。準備 1 を引く第 1 → 2 等号（0 始まりの添字 1）と、
# 準備 3 を引く第 5 → 6 等号（添字 5。準備 3 は準備 1 に依る）の二つである。
load("_prelude.sage")

P = power_by_definition


def chain(B, V1, V2, W, n):
    k = n - 1
    return [
        P(V1 * V2, n),
        (V1 * P(V2 * V1, k)) * V2,
        ((B * B) * P(V2 * V1, k)) * V2,
        (B * (B * P(V2 * V1, k))) * V2,
        B * ((B * P(V2 * V1, k)) * V2),
        ((B * P(V2 * V1, k)) * V2) * B,
        P(W, n),
    ]


ok = True
n_eq = 0
for desc, mk in generic_families():
    mats = mk(['B', 'V'])
    B, V2 = mats['B'], mats['V']
    V1 = B * B
    W = (B * V2) * B
    for n in range(1, 7):
        rows = chain(B, V1, V2, W, n)
        for a, b in zip(rows, rows[1:]):
            ok &= (a.trace() == b.trace()); n_eq += 1
        ok &= (rows[0].trace() == (W ** n).trace())   # 主張（Sage 組み込みの冪で）
    print(f"{desc}: ok={ok}")

mats = generic_ring(['B', 'V', 'U'], 2)[1]
B, V2, U = mats['B'], mats['V'], mats['U']
W = (B * V2) * B
rows = chain(B, B * B, V2, W, 2)
ctrl_cyc = rows[4] != rows[5]
print(f"対照 巡回性の行の両側の行列は異なる: {ctrl_cyc}")
rows = chain(B, U, V2, W, 2)
broken = [j for j, (a, b) in enumerate(zip(rows, rows[1:])) if a.trace() != b.trace()]
print(f"対照 V_1 ≠ BB で崩れる等号の位置: {broken}")
ok &= ctrl_cyc and broken == [1, 5]
print(f"checked {n_eq} equalities")
exact_result(ok)
