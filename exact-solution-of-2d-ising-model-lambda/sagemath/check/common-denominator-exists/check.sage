# 対象ラベル: claim_common_denominator_exists
# 帰属: ZZ / QQ と素因数分解だけを使う厳密計算。浮動小数点は使わない。

from itertools import product


def qsmul(r, lam_q):
    # Λ_Q の有理数倍（def_rational_log_order_group）
    return {p: QQ(r) * z for p, z in lam_q.items() if r * z != 0}


def iota(lam):
    # ι_{Λ→Λ_Q}
    return {p: QQ(z) for p, z in lam.items()}


def denominator_product(lam_q):
    # N_λ := ∏_{p∈S_λ} den(λ(p))（S_λ は非零値の素数の集合。空積は 1）
    N = ZZ(1)
    for p, v in lam_q.items():
        assert v != 0
        N *= v.denominator()
    return N


def witness_by_formula(N, lam_q):
    # 主張の場合分けの右辺: ν(p) = (N/den)·num（p∈S_λ）、0（p∉S_λ）
    nu = {}
    for p, v in lam_q.items():
        d = v.denominator()
        a = v.numerator()
        assert d >= 1 and N % d == 0          # den は N の因子
        q = N // d                             # ℕ の割り切れる商
        assert ZZ(q) * ZZ(d) == N              # (N/d)·d = N
        val = ZZ(q) * ZZ(a)
        assert QQ(N) * v == QQ(q) * (QQ(d) * v) == QQ(q) * QQ(a) == QQ(val)   # 一続きの鎖の各段
        if val != 0:
            nu[p] = val
    return nu


primes = [2, 3, 5, 7]
coefficients = [QQ(c) for c in ["-5/6", "-1", "-1/2", "0", "1/3", "1/2", "1", "3/2", "7/4", "5"]]
vectors = [
    {p: c for p, c in zip(primes, values) if c != 0}
    for values in product(coefficients, repeat=len(primes))
]

count = 0
for lam in vectors:
    N = denominator_product(lam)
    assert N >= 1
    nu = witness_by_formula(N, lam)
    # 証人は Λ の元（有限台の整数値）で、台は S_λ に含まれる
    assert all(z in ZZ and z != 0 for z in nu.values())
    assert set(nu.keys()) <= set(lam.keys())
    # def_common_denominator: N·λ = ι(ν)（各素数での値の等号）
    assert qsmul(N, lam) == iota(nu)
    # 一意性の裏取り: N·λ の各値が整数であること（別の証人は存在しない）
    assert all(v.denominator() == 1 for v in qsmul(N, lam).values())
    count += 1

# 空集合（λ = 0）: N = 1、証人は零写像
assert denominator_product({}) == 1 and witness_by_formula(ZZ(1), {}) == {}

print("PASS: common-denominator-exists (%d vectors incl. zero, primes %s)" % (count, primes))
