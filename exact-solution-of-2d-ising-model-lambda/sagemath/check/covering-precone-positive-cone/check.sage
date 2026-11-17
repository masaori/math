# 対象ラベル: claim_precone_avoiding_minus_one_meets_negation_at_zero,
#             claim_covering_precone_gives_positive_cone_extension
# 有理数の厳密計算だけを使う。浮動小数点・実数体を使わない。
#
# (A) 本文の -1 の書き直しの三行を、有理関数体 QQ(z) の中で一行ずつ等号として確かめる。
# (B) 和・積の段の式鎖を、有理関数体 QQ(a, b) の中で一行ずつ確かめる（仮定 a+b=0, a*b=0 は代入で入れる）。
# (C) モデル F = QQ、C_F = 正の有理数、E = QQ(s)（s*s = 2）。E の共役 sigma の一つでの符号が非負な元の集合
#     T_sigma は、負の単位元を含まず符号の両側を覆う前錐である（標本で）。
#     C_E := T_sigma から零元を除いた集合について、T_sigma ∩ (-T_sigma) = {0}、正錐の三条件、
#     C_E ∩ QQ = 正の有理数 を標本で確かめる。
# (D) 符号の両側を覆わない前錐 T_{+,-}（両方の共役で非負）では、零元を除いた集合の三分法が崩れる
#     ことを確かめる（第二の仮定が要ることの例）。

# (A) -1 の書き直し
R.<z> = FunctionField(QQ)
lines_A = [
    -1,
    -(1 * 1),
    -((z * z^-1) * (z * z^-1)),
    ((-z) * z) * (z^-1 * z^-1),
]
for i in range(len(lines_A) - 1):
    assert lines_A[i] == lines_A[i + 1], i
print("(A) -1 = -(1*1) = -((z z^-1)(z z^-1)) = ((-z) z)(z^-1 z^-1): 3 行通過", flush=True)

# (B) 和と積の段
P.<a, b> = PolynomialRing(QQ)
Fr = P.fraction_field()
a, b = Fr(a), Fr(b)
# 和: a + b = 0 のもとで -a = -a + 0 = -a + (a + b) = b。仮定は b = -a の代入で入れる。
sub_sum = {b: -a}
lines_sum = [-a, -a + 0, -a + (a + b), b]
vals = [Fr(l).subs(sub_sum) for l in lines_sum]
for i in range(len(vals) - 1):
    assert vals[i] == vals[i + 1], i
# 積: a*b = 0 かつ a != 0 のもとで b = (a^-1 a) b = a^-1 (a b) = a^-1 * 0 = 0。
# 各等号を「仮定を使わない恒等式」と「仮定 a*b = 0 を使う行」に分けて確かめる。
assert b == (a^-1 * a) * b
assert (a^-1 * a) * b == a^-1 * (a * b)
# 第三行は a*b を 0 に置き換えただけ。第四行 a^-1 * 0 = 0。
assert a^-1 * 0 == 0
print("(B) 和の段 3 行・積の段 3 行が通過", flush=True)

# (C) モデル
X = polygen(QQ)
K.<s> = NumberField(X^2 - 2)

def pq(w):
    v = w.vector()
    return (QQ(v[0]), QQ(v[1]))

def sign_pq(p, q):
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

def sgn(w, sigma):
    p, q = pq(w)
    return sign_pq(p, q) if sigma == '+' else sign_pq(p, -q)

def in_T(w, S):
    return all(sgn(w, sigma) >= 0 for sigma in S)

def in_C(w, S):
    return in_T(w, S) and w != 0

SMALL = [QQ(0), QQ(1), QQ(-1), QQ(2), QQ(-2), QQ(1)/2, QQ(-1)/2, QQ(3), QQ(-3), QQ(2)/3, QQ(-5)/3]
SAMPLE = [K(p) + K(q) * s for p in SMALL for q in SMALL]

for S in [('+',), ('-',)]:
    TS = [w for w in SAMPLE if in_T(w, S)]
    # 前錐で -1 を含まず、符号の両側を覆う
    for x in TS:
        for y in TS:
            assert in_T(x + y, S) and in_T(x * y, S)
    for y in SAMPLE:
        assert in_T(y * y, S)
        assert in_T(y, S) or in_T(-y, S)
    assert not in_T(K(-1), S)
    # T ∩ (-T) = {0}
    assert in_T(K(0), S)
    for w in SAMPLE:
        if in_T(w, S) and in_T(-w, S):
            assert w == 0
        # 非零の w について (-w) * w * (w^-1)^2 == -1
        if w != 0:
            assert ((-w) * w) * (w^-1 * w^-1) == -1
    # C_E の三条件
    CS = [w for w in SAMPLE if in_C(w, S)]
    for x in CS:
        for y in CS:
            assert in_C(x + y, S) and in_C(x * y, S)
    for w in SAMPLE:
        cnt = int(w == 0) + int(in_C(w, S)) + int(in_C(-w, S))
        assert cnt == 1
    # 延長の等号 C_E ∩ QQ = 正の有理数
    for c in SMALL:
        assert in_C(K(c), S) == (c > 0)
print("(C) T_+, T_- で T∩(-T)={0}、正錐の三条件、C_E∩QQ = 正の有理数 が通過", flush=True)

# (D) 第二の仮定を外した例
S = ('+', '-')
w = s - 1
assert not in_T(w, S) and not in_T(-w, S)
cnt = int(w == 0) + int(in_C(w, S)) + int(in_C(-w, S))
assert cnt == 0
print("(D) T_{+,-} では s-1 で三分法が崩れる（符号の両側を覆う仮定が要る）", flush=True)
print("claim_precone_avoiding_minus_one_meets_negation_at_zero, claim_covering_precone_gives_positive_cone_extension: 全検査通過")
