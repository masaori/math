# 対象ラベル: claim_enumerated_precone_chain_covers_signs
# 有理数の厳密計算だけを使う。浮動小数点・実数体を使わない。
#
# モデル: F = QQ、C_F = 正の有理数、E = QQ(s)（s*s = 2）。E の元 p + q*s を有理数の組 (p, q) で表す。
# E の二つの共役 sigma_+ : s -> s、sigma_- : s -> -s の「符号」を、p, q の有理数の比較だけで決める
# （p + q*s の符号は、p, q の符号と p*p と 2*q*q の比較で決まる）。
# 空でない S ⊆ {+, -} について T_S := { x in E | S の各 sigma で x の符号が非負 } と置く。
# 確かめること:
#   (A) T_S は (QQ, 正の有理数) に従う E の前錐である（標本で和・積・平方・正の有理数の所属）。
#   (B) -1 ∈ T_S<a> ⇔ S の全ての sigma で a の符号が負（⇐ は証人 t=0, t'=-1/a、⇒ は標本で符号を見る）。
#   (C) a ≠ 0、S' := { sigma in S | a の符号が正 } が空でないとき T_S<a> = T_{S'}（証人を構成して確かめる）。
#   (D) 列挙の先頭 N 個に沿って本文の三つの場合分けで T_n を作ると、各 T_n が -1 を含まず単調に増え、
#       和集合は列挙した全ての z について z か -z を含む。

P.<X> = PolynomialRing(QQ)
K.<s> = NumberField(X^2 - 2)

def pq(z):
    v = z.vector()
    return (QQ(v[0]), QQ(v[1]))

def sign_pq(p, q):
    # p + q*sqrt2 の符号を有理数の比較だけで返す（-1, 0, 1）
    if q == 0:
        return sign(p)
    if p == 0:
        return sign(q)
    if p > 0 and q > 0:
        return 1
    if p < 0 and q < 0:
        return -1
    if p * p > 2 * q * q:
        return sign(p)
    return sign(q)

def sgn(z, sigma):
    p, q = pq(z)
    return sign_pq(p, q) if sigma == '+' else sign_pq(p, -q)

def in_T(z, S):
    return all(sgn(z, sigma) >= 0 for sigma in S)

SMALL = [QQ(0), QQ(1), QQ(-1), QQ(2), QQ(-2), QQ(1)/2, QQ(-1)/2, QQ(3), QQ(-3), QQ(2)/3, QQ(-5)/3]
SAMPLE = [K(p) + K(q) * s for p in SMALL for q in SMALL]
ALL_S = [('+', '-'), ('+',), ('-',)]

# (A) 前錐であること
for S in ALL_S:
    TS = [z for z in SAMPLE if in_T(z, S)]
    for a in TS:
        for b in TS:
            assert in_T(a + b, S) and in_T(a * b, S)
    for y in SAMPLE:
        assert in_T(y * y, S)
    for c in SMALL:
        if c > 0:
            assert in_T(K(c), S)
    assert not in_T(K(-1), S)
print("(A) T_S は前錐で -1 を含まない: 3 通りの S で通過", flush=True)

# (B) -1 ∈ T_S<a> の判定
def minus_one_in_adjoin(S, a):
    return all(sgn(a, sigma) < 0 for sigma in S)

for S in ALL_S:
    TS = [z for z in SAMPLE if in_T(z, S)]
    for a in SAMPLE:
        if minus_one_in_adjoin(S, a):
            t, tp = K(0), -1 / a
            assert in_T(t, S) and in_T(tp, S) and t + a * tp == -1
        else:
            sigma = [sg for sg in S if sgn(a, sg) >= 0][0]
            for t in TS[:12]:
                for tp in TS[:12]:
                    assert sgn(t + a * tp, sigma) >= 0
print("(B) -1 の所属の判定: 証人と符号で通過", flush=True)

# (C) T_S<a> = T_{S'} の証人
def adjoin_S(S, a):
    if a == 0:
        return S
    return tuple(sg for sg in S if sgn(a, sg) > 0)

for S in ALL_S:
    TS = [z for z in SAMPLE if in_T(z, S)]
    for a in SAMPLE:
        if a == 0 or minus_one_in_adjoin(S, a):
            continue
        Sp = adjoin_S(S, a)
        assert len(Sp) > 0
        # ⊆: S' の各 sigma で t + a*t' の符号は非負
        for t in TS[:12]:
            for tp in TS[:12]:
                assert in_T(t + a * tp, Sp)
        # ⊇: T_{S'} の元 x を t + a*t' と書く
        for xx in SAMPLE:
            if not in_T(xx, Sp):
                continue
            if in_T(xx, S):
                t, tp = xx, K(0)
            else:
                t, tp = K(0), xx / a
            assert in_T(t, S) and in_T(tp, S) and t + a * tp == xx
print("(C) T_S<a> = T_{S'}: 両包含の証人が通過", flush=True)

# (D) 列挙に沿った列
xi = SAMPLE  # 列挙の先頭 N 個（E の元だけを並べる。ξ(n) ∉ E の場合はこのモデルに現れない）
S_n = ('+', '-')
history = [S_n]
for a in xi:
    if minus_one_in_adjoin(S_n, a):
        nxt = adjoin_S(S_n, -a)  # 第三の場合: T_n<-ξ(n)>
        assert not minus_one_in_adjoin(S_n, -a)
    else:
        nxt = adjoin_S(S_n, a)   # 第二の場合: T_n<ξ(n)>
    assert len(nxt) > 0                    # -1 ∉ T_{n+1}
    assert set(nxt) <= set(S_n)            # T_n ⊆ T_{n+1}
    S_n = nxt
    history.append(S_n)
for z in xi:
    assert in_T(z, S_n) or in_T(-z, S_n)
print("(D) 列挙 %d 個に沿った列: -1 を含まず単調、和集合 T_{%s} が符号の両側を覆う" % (len(xi), ''.join(S_n)), flush=True)
print("claim_enumerated_precone_chain_covers_signs: 全検査通過")
