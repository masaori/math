# 対象ラベル: complex_exp_of_real_argument
# 冪・項・部分和の鎖を QQ[x] の不定元で確かめる。ℂ は definition_of_cc どおり実数の対で持つ。
#   (x_C)^0 = 1_C = (x^0)_C
#   (x_C)^{m+1} = (x_C)^m x_C = (x^m)_C x_C = (x^m x)_C = (x^{m+1})_C           （m = 0,…,39）
#   (x_C)^m/m! = (1/m!)_C (x_C)^m = (1/m!)_C (x^m)_C = ((1/m!) x^m)_C = (x^m/m!)_C   （m = 0,…,40）
#   Σ_{m=0}^{0} (x_C)^m/m! = (x_C)^0/0! = (x^0/0!)_C = (E_0)_C
#   Σ_{m=0}^{N+1} … = Σ_{m=0}^{N} … + (x_C)^{N+1}/(N+1)! = (E_N)_C + … = (E_N)_C + (x^{N+1}/(N+1)!)_C
#                  = (E_N + x^{N+1}/(N+1)!)_C = (E_{N+1})_C                     （N = 0,…,39）
# 帰納法の各段を、具体の m・N について一つずつ確かめる（一般の m・N は帰納法そのものが担う）。
load("../../_shared/complex_as_real_pairs.sage")

R = PolynomialRing(QQ, 'x')
x = R.gen()
xC = iota(x, R)
MAX = 40


def real_power(m):
    """冪の約束 x^0 := 1、x^{m+1} := x^m x を K = ℝ で。"""
    p = R(1)
    for _ in range(m):
        p = p * x
    return p


def E(N):
    """E_N := Σ_{m=0}^{N} x^m/m!（実数の有限和を左から足す）。"""
    s = R(0)
    for m in range(N + 1):
        s = s + real_power(m) / factorial(m)
    return s


def term_C(m):
    """(x_C)^m/m! := (1/m!)_C (x_C)^m（実数係数は inclusion_rr_to_cc で掛ける。def_exp）。"""
    return cc_mul(iota(QQ(1) / factorial(m), R), cc_power(xC, m, R))


# 冪の帰納法の基底段階。
base = [cc_power(xC, 0, R), iota(1, R), iota(real_power(0), R)]
assert all(c == base[0] for c in base)
# 帰納段階。
for m in range(MAX):
    assert cc_power(xC, m, R) == iota(real_power(m), R)  # 帰納法の仮定に当たる事実
    step = [
        cc_power(xC, m + 1, R),
        cc_mul(cc_power(xC, m, R), xC),
        cc_mul(iota(real_power(m), R), xC),
        iota(real_power(m) * x, R),
        iota(real_power(m + 1), R),
    ]
    assert all(c == step[0] for c in step), m
print("冪の鎖 (x_C)^0 = 1_C = (x^0)_C と、m = 0,…,%d の帰納段階の四行が QQ[x] で成り立つ" % (MAX - 1))

# 項の鎖。
for m in range(MAX + 1):
    chain = [
        term_C(m),
        cc_mul(iota(QQ(1) / factorial(m), R), cc_power(xC, m, R)),
        cc_mul(iota(QQ(1) / factorial(m), R), iota(real_power(m), R)),
        iota((QQ(1) / factorial(m)) * real_power(m), R),
        iota(real_power(m) / factorial(m), R),
    ]
    assert all(c == chain[0] for c in chain), m
print("項の鎖 (x_C)^m/m! = (1/m!)_C (x_C)^m = (1/m!)_C (x^m)_C = ((1/m!) x^m)_C = (x^m/m!)_C が m = 0,…,%d で成り立つ" % MAX)


def complex_partial_sum(N):
    """Σ_{m=0}^{N} (x_C)^m/m! を ℂ の和で左から足す（0_C から始める）。"""
    s = iota(0, R)
    for m in range(N + 1):
        s = cc_add(s, term_C(m))
    return s


# 部分和の帰納法の基底段階。
base = [complex_partial_sum(0), term_C(0), iota(real_power(0) / factorial(0), R), iota(E(0), R)]
assert all(c == base[0] for c in base)
for N in range(MAX):
    assert complex_partial_sum(N) == iota(E(N), R)  # 帰納法の仮定に当たる事実
    step = [
        complex_partial_sum(N + 1),
        cc_add(complex_partial_sum(N), term_C(N + 1)),
        cc_add(iota(E(N), R), term_C(N + 1)),
        cc_add(iota(E(N), R), iota(real_power(N + 1) / factorial(N + 1), R)),
        iota(E(N) + real_power(N + 1) / factorial(N + 1), R),
        iota(E(N + 1), R),
    ]
    assert all(c == step[0] for c in step), N
print("部分和の鎖の基底段階と、N = 0,…,%d の帰納段階の五行が QQ[x] で成り立つ" % (MAX - 1))

# 独立な経路: Sage のガウス有理数 QQ(i) 上の多項式環で Σ x^m/m! を作り、実部が E_N、虚部が 0 であること。
G = QuadraticField(-1, 'ii')
S = PolynomialRing(G, 'x')
xs = S.gen()
for N in [0, 1, 5, 17, MAX]:
    s = sum(xs^m / factorial(m) for m in range(N + 1))
    re = R([c[0] for c in s.list()])
    im = R([c[1] for c in s.list()])
    assert re == E(N) and im == 0, N
print("独立な経路: QQ(i)[x] で作った Σ x^m/m! の実部が E_N、虚部が 0（N = 0, 1, 5, 17, %d）" % MAX)

# 対照: 純虚数 (0,1) の部分和は虚部が 0 にならない（実数の引数であることが効いていることの確認）。
y = (QQ(0), QQ(1))
s = (QQ(0), QQ(0))
for m in range(6):
    s = cc_add(s, cc_mul(iota(QQ(1) / factorial(m), QQ), cc_power(y, m, QQ)))
assert s[1] != 0
print("対照: 引数 (0,1) の部分和 S_5 の虚部は %s で 0 でない" % s[1])
print("RESULT: PASS")
