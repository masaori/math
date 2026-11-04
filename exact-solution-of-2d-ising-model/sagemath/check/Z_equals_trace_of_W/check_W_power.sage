# 対象ラベル: Z_equals_trace_of_W
# 証明の準備 3: W^{k+1} = ((B(V_2V_1)^k)V_2)B の k = 0 の鎖（6 等号）と、k → k+1 の鎖（12 等号）の各行。
# 準備 1 の BB = V_1、W = (BV_2)B を満たす一般の組として、B・V_2 を独立に取り V_1 := BB、W := (BV_2)B と置く。
# 対照: V_1 を B と独立に取ると、BB = V_1 に依る行だけが崩れる。準備 1 を引く (CV_2)(BB) = (CV_2)V_1（0 始まりの添字 7）と、
# 帰納法の仮定の行（添字 1。k での主張そのものが BB = V_1 に依る）の二つである。
load("_prelude.sage")

P = power_by_definition
K_MAX = 4


def chains(B, V1, V2, W, k):
    C = B * P(V2 * V1, k)
    step = [
        P(W, k + 2),
        P(W, k + 1) * W,
        (((B * P(V2 * V1, k)) * V2) * B) * W,
        ((C * V2) * B) * W,
        ((C * V2) * B) * ((B * V2) * B),
        (((C * V2) * B) * (B * V2)) * B,
        ((((C * V2) * B) * B) * V2) * B,
        (((C * V2) * (B * B)) * V2) * B,
        (((C * V2) * V1) * V2) * B,
        ((C * (V2 * V1)) * V2) * B,
        (((B * P(V2 * V1, k)) * (V2 * V1)) * V2) * B,
        ((B * (P(V2 * V1, k) * (V2 * V1))) * V2) * B,
        ((B * P(V2 * V1, k + 1)) * V2) * B,
    ]
    return step


ok = True
n_eq = 0
for desc, mk in generic_families():
    mats = mk(['B', 'V'])
    B, V2 = mats['B'], mats['V']
    V1 = B * B
    W = (B * V2) * B
    I = identity_matrix(B.base_ring(), B.nrows())
    for m in range(0, K_MAX + 3):
        assert P(W, m) == W ** m
    base = [P(W, 1), P(W, 0) * W, I * W, W, (B * V2) * B, ((B * I) * V2) * B, ((B * P(V2 * V1, 0)) * V2) * B]
    for a, b in zip(base, base[1:]):
        ok &= (a == b); n_eq += 1
    for k in range(0, K_MAX):
        ok &= (P(W, k + 1) == ((B * P(V2 * V1, k)) * V2) * B)   # 帰納法の仮定
        st = chains(B, V1, V2, W, k)
        for a, b in zip(st, st[1:]):
            ok &= (a == b); n_eq += 1
    print(f"{desc}: ok={ok}")

# 対照: V_1 を独立に取る（BB ≠ V_1）。崩れる等号の位置（0 始まりの添字）を見る。
mats = generic_ring(['B', 'V', 'U'], 2)[1]
B, V2, V1 = mats['B'], mats['V'], mats['U']
W = (B * V2) * B
st = chains(B, V1, V2, W, 1)
broken = [j for j, (a, b) in enumerate(zip(st, st[1:])) if a != b]
print(f"対照 V_1 ≠ BB で崩れる等号の位置: {broken}")
ok &= (broken == [1, 7])
print(f"checked {n_eq} equalities")
exact_result(ok)
