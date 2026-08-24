# 対象ラベル: claim_rational_power_base_congruences
# P_L(a,b) の両端項による合同式と、点数乗表示から従う底の合同式を
# ZZ・QQ と有限和だけで確認する。

def box_vertices(L):
    return [(x, y, z) for x in range(L) for y in range(L) for z in range(L)]

def box_edges(L):
    E = []
    for v in box_vertices(L):
        for d in range(3):
            w = list(v)
            w[d] += 1
            w = tuple(w)
            if w[d] < L:
                E.append((v, w))
    return E

def multiplicities(L):
    V = box_vertices(L)
    E = box_edges(L)
    idx = {v: i for i, v in enumerate(V)}
    Om = [ZZ(0)] * (len(E) + 1)
    for s in range(2 ** len(V)):
        broken = sum(
            ((s >> idx[v]) & 1) != ((s >> idx[w]) & 1)
            for (v, w) in E
        )
        Om[broken] += 1
    return Om

def P_L(Om, a, b, nE):
    return sum(Om[m] * ZZ(a) ** m * ZZ(b) ** (nE - m) for m in range(nE + 1))

CASES = [(1, 1), (1, 2), (2, 1), (2, 3), (3, 2), (5, 4), (7, 9)]
Om = multiplicities(2)
nE = len(box_edges(2))
nV = len(box_vertices(2))
assert nE == 12 and nV == 8

print("== 段 1: 回文性と両端係数 ==")
for m in range(nE + 1):
    assert Om[m] == Om[nE - m]
assert Om[0] == Om[nE]
print("  PASS")

print("== 段 2: P_L の法 a・法 b の合同式 ==")
for a, b in CASES:
    assert gcd(ZZ(a), ZZ(b)) == 1
    P = P_L(Om, a, b, nE)
    assert (P - Om[0] * ZZ(b) ** nE) % a == 0
    assert (P - Om[0] * ZZ(a) ** nE) % b == 0
print("  PASS")

print("== 段 3: 点数乗表示が成立する q=1 で整数等式と結論 ==")
a = ZZ(1)
b = ZZ(1)
u = ZZ(2)
v = ZZ(1)
P = P_L(Om, a, b, nE)
assert P * v ** nV == u ** nV * b ** nE
assert (Om[0] * v ** nV - u ** nV) % a == 0
assert (Om[0] * v ** nV) % b == 0
print("  PASS")

print("== 段 4: 整数等式からの合同式の推移を有限標本で確認 ==")
checked = 0
for a, b in CASES:
    P = P_L(Om, a, b, nE)
    for u in range(1, 9):
        for v in range(1, 9):
            if gcd(ZZ(u), ZZ(v)) != 1:
                continue
            if P * ZZ(v) ** nV != ZZ(u) ** nV * ZZ(b) ** nE:
                continue
            assert (Om[0] * ZZ(v) ** nV - ZZ(u) ** nV) % a == 0
            assert (Om[0] * ZZ(v) ** nV) % b == 0
            checked += 1
assert checked > 0
print("  PASS（条件を満たす標本", checked, "件）")
print("ALL PASS")
