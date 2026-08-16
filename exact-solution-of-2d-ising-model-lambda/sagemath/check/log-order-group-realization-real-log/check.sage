# 対象ラベル: claim_log_order_group_realization_real_log
# 帰属: QQ 上の多項式環（不定元 ℓ_p は素数 p の実対数 log_ℝ(ι(p)) を表す記号）による厳密計算。
#       実対数の値そのものは計算しない。主張の証明が log_ℝ について使うのは「乗法を加法へ移す」
#       （とそれから出した整数冪の実対数）だけなので、正の有理数 u = Π p^{e_p} に L(u) := Σ e_p ℓ_p を
#       対応させる写像（乗法を加法へ移す）を実対数の模型とし、実現写像 ρ_ℝ の模型を
#       ρ(μ) := Σ_{p∈supp μ} μ(p)·ℓ_p として、証明の準備と一続きの鎖の各段を記号のまま確かめる。
#       ι_{ℚ→ℝ} は模型では恒等（有理数を有理数のまま持つ）。浮動小数点は使わない。

PRIMES = [2, 3, 5, 7, 11, 13]
R = PolynomialRing(QQ, ["l%d" % p for p in PRIMES])
ELL = {p: R.gen(i) for i, p in enumerate(PRIMES)}


def L(u):
    # 実対数の模型（乗法を加法へ移す）
    u = QQ(u)
    assert u > 0
    return sum((QQ(e) * ELL[p] for p, e in u.factor()), R(0))


def rho(mu):
    # 実現写像 ρ_ℝ の模型。mu は {素数: 有理数} の辞書（Λ_ℚ の元。値 0 の素数は台に入れない）
    return sum((QQ(c) * ELL[p] for p, c in mu.items() if c != 0), R(0))


def iota_lambda(lam):
    # ι_{Λ→Λ_ℚ}: 整数値を分母 1 の有理数として読む
    return {p: QQ(z) / 1 for p, z in lam.items()}


def supp(mu):
    return frozenset(p for p, c in mu.items() if c != 0)


def rat_lambda(lam):
    # def_rational_of_log: rat_Λ(λ) = Π_{p∈supp λ} p^{λ(p)} ∈ ℚ_{>0}
    return prod((QQ(p) ** z for p, z in lam.items() if z != 0), QQ(1))


checks = 0
# 前提: 模型が「乗法を加法へ移す」を満たすこと（def_real_logarithm の性質）
units = [QQ(1), QQ(2), QQ(3), QQ(1) / 2, QQ(12), QQ(9) / 10, QQ(77) / 8, QQ(1) / 13, QQ(26) / 15]
for u in units:
    for v in units:
        assert L(u * v) == L(u) + L(v)
        checks += 1

# 準備の第三: 有限積の実対数は和（S の元の個数についての帰納法）
import itertools
for r in range(0, 4):
    for S in itertools.combinations(units, r):
        # 空集合の五段
        if r == 0:
            assert L(prod(S, QQ(1))) == L(1)
            assert L(1) == L(QQ(1) ** 0)
            assert L(QQ(1) ** 0) == QQ(0) * L(1)     # claim_real_logarithm_int_power を u:=1, k:=0 で
            assert QQ(0) * L(1) == 0
            assert 0 == sum((L(u) for u in S), R(0))
            checks += 5
        # S ∪ {p0} の四段（p0 は S に無い元）
        for p0 in units:
            if p0 in S:
                continue
            S1 = list(S) + [p0]
            assert L(prod(S1, QQ(1))) == L(p0 * prod(S, QQ(1)))               # 有限積の定義
            assert L(p0 * prod(S, QQ(1))) == L(p0) + L(prod(S, QQ(1)))       # 乗法を加法へ
            assert L(p0) + L(prod(S, QQ(1))) == L(p0) + sum((L(u) for u in S), R(0))  # 帰納法の仮定
            assert L(p0) + sum((L(u) for u in S), R(0)) == sum((L(u) for u in S1), R(0))  # 有限和の定義
            checks += 4

# 一続きの鎖（Λ の元 λ を、6 素数の指数 ∈ [-3,3] から取る）
lambdas = []
for exps in itertools.product(range(-3, 4), repeat=3):
    lambdas.append({2: exps[0], 3: exps[1], 5: exps[2]})
for exps in itertools.product(range(-2, 3), repeat=3):
    lambdas.append({7: exps[0], 11: exps[1], 13: exps[2]})
lambdas.append({})
lambdas.append({2: 3, 13: -2})

for lam in lambdas:
    mu = iota_lambda(lam)
    # 準備の第一: supp(ι(λ)) = supp(λ)
    assert supp(mu) == supp(lam)
    checks += 1
    # 準備の第二: ι は整数冪と有限積を保つ（模型では恒等なので同じ有理数であることの検査）
    for p, z in lam.items():
        assert QQ(p) ** z == QQ(QQ(p) ** z)
        checks += 1
    S = sorted(supp(lam))
    # 鎖の各段
    step0 = rho(mu)
    step1 = sum((mu[p] * ELL[p] for p in supp(mu)), R(0))              # 定義（台に渡る和）
    step2 = sum((mu[p] * ELL[p] for p in S), R(0))                     # supp(ι(λ)) = supp(λ)
    step3 = sum((QQ(lam[p]) / 1 * ELL[p] for p in S), R(0))            # ι(λ)(p) = λ(p)/1
    step4 = sum((L(QQ(p) ** lam[p]) for p in S), R(0))                 # 整数冪の実対数は整数倍
    step5 = sum((L(QQ(QQ(p) ** lam[p])) for p in S), R(0))             # ι は整数冪を保つ
    step6 = L(prod((QQ(QQ(p) ** lam[p]) for p in S), QQ(1)))           # 有限積の実対数は和
    step7 = L(QQ(prod((QQ(p) ** lam[p] for p in S), QQ(1))))           # ι は有限積を保つ
    step8 = L(rat_lambda(lam))                                          # rat_Λ の定義
    for a, b in [(step0, step1), (step1, step2), (step2, step3), (step3, step4),
                 (step4, step5), (step5, step6), (step6, step7), (step7, step8)]:
        assert a == b
        checks += 1
    # 各項について claim_real_logarithm_int_power の適用が正しいこと
    for p in S:
        assert QQ(lam[p]) * L(QQ(p)) == L(QQ(p) ** lam[p])
        checks += 1
    # 結論
    assert rho(iota_lambda(lam)) == L(rat_lambda(lam))
    checks += 1

print("PASS: claim_log_order_group_realization_real_log, checks =", checks)
