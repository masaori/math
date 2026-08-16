# 対象ラベル: claim_rational_log_order_group_scalar_compare_nonpos
# 帰属: ZZ / QQ と素因数分解だけを使う厳密計算。浮動小数点は使わない。

from itertools import product


def qsmul(r, lam_q):
    # Λ_Q の有理数倍（def_rational_log_order_group）
    return {p: QQ(r) * z for p, z in lam_q.items() if r * z != 0}


def zsmul(n, lam):
    # Λ の整数倍（def_log_order_group）
    return {p: ZZ(n) * z for p, z in lam.items() if n * z != 0}


def iota(lam):
    # ι_{Λ→Λ_Q}
    return {p: QQ(z) for p, z in lam.items()}


def rat_of_log(lam):
    # rat_Λ(λ) = ∏ p^{λ(p)} ∈ Q_{>0}（def_rational_of_log）
    r = QQ(1)
    for p, e in lam.items():
        r *= QQ(p) ** ZZ(e)
    return r


def log_order_le(lam, mu):
    # λ ≤_Λ μ :⟺ rat_Λ(λ) ≤ rat_Λ(μ)（def_log_order_group_order）
    return rat_of_log(lam) <= rat_of_log(mu)


def is_common_denominator(N, lam_q, lam_N):
    # def_common_denominator: N·λ = ι(λ_N)
    return qsmul(N, lam_q) == iota(lam_N)


def denominator_product(lam_q):
    # claim_common_denominator_exists の N_λ（空積は 1）
    N = ZZ(1)
    for v in lam_q.values():
        N *= v.denominator()
    return N


def witness_of_denominator_product(lam_q):
    # claim_common_denominator_exists の証人
    N = denominator_product(lam_q)
    nu = {}
    for p, v in lam_q.items():
        val = ZZ(N // v.denominator()) * ZZ(v.numerator())
        if val != 0:
            nu[p] = val
    return nu


def witness_at(N, lam_q):
    # N が λ の共通分母なら一意な証人 λ_N、そうでなければ None
    scaled = qsmul(N, lam_q)
    if all(v.denominator() == 1 for v in scaled.values()):
        return {p: ZZ(v) for p, v in scaled.items()}
    return None


def rational_log_order_le(lam_q, mu_q):
    # def_rational_log_order_group_order の決定手続き
    # λ ≤_{Λ_Q} μ ⟺ N_μ λ_{N_λ} ≤_Λ N_λ μ_{N_μ}
    Nl, Nm = denominator_product(lam_q), denominator_product(mu_q)
    return log_order_le(zsmul(Nm, witness_of_denominator_product(lam_q)),
                        zsmul(Nl, witness_of_denominator_product(mu_q)))



def qadd(lam_q, mu_q):
    # Λ_Q の加法（def_rational_log_order_group）。素数ごとに Q の和。0 になった素数は台から外す
    out = {}
    for p in set(lam_q) | set(mu_q):
        v = lam_q.get(p, QQ(0)) + mu_q.get(p, QQ(0))
        if v != 0:
            out[p] = v
    return out


def zadd(lam, mu):
    # Λ の加法（def_log_order_group）
    out = {}
    for p in set(lam) | set(mu):
        v = lam.get(p, ZZ(0)) + mu.get(p, ZZ(0))
        if v != 0:
            out[p] = v
    return out



primes = [2, 3, 5]
coefficients = [QQ(c) for c in ["-1", "0", "1/2", "2/3"]]
vectors = [
    {p: c for p, c in zip(primes, values) if c != 0}
    for values in product(coefficients, repeat=len(primes))
]
scalars = [QQ(c) for c in ["-2", "-1/2", "0", "1", "3/2", "7/4", "3"]]
zero = {}

count_nonpos = 0
count_claims = 0
count_chain = 0
for nu in vectors:
    # 仮定: ν ≤_{Λ_Q} 0
    if not rational_log_order_le(nu, zero):
        continue
    count_nonpos += 1
    for r in scalars:
        for s in scalars:
            if not r <= s:
                continue
            # 主張: r ≤ s、ν ≤ 0 ⟹ s·ν ≤_{Λ_Q} r·ν（決定手続きで判定）
            assert rational_log_order_le(qsmul(s, nu), qsmul(r, nu)), (nu, r, s)
            count_claims += 1
            # 証明の鎖を段ごとに検査する
            c = s - r
            assert c >= 0                                                        # Q の順序と減法
            assert rational_log_order_le(qsmul(c, nu), qsmul(c, zero))           # 非負有理数倍の順序保存（λ:=ν, μ:=0）
            assert qsmul(c, zero) == zero                                        # c·0 = 0
            assert rational_log_order_le(qsmul(c, nu), zero)                     # c·ν ≤ 0
            lhs = qadd(qsmul(c, nu), qsmul(r, nu))
            rhs = qadd(zero, qsmul(r, nu))
            assert rational_log_order_le(lhs, rhs)                               # 加法単調性（λ:=c·ν, μ:=0, ν:=r·ν）
            assert c + r == s and qsmul(s, nu) == qsmul(c + r, nu)               # s·ν = (c+r)·ν（c + r = s）
            assert qsmul(c + r, nu) == lhs                                       # 分配則 (c+r)·ν = c·ν + r·ν
            assert rhs == qsmul(r, nu)                                           # 0 + r·ν = r·ν（零写像は単位元）
            count_chain += 1

print("非正のベクトル数:", count_nonpos)
print("主張の検査件数:", count_claims)
print("鎖の検査件数:", count_chain)
print("PASS: claim_rational_log_order_group_scalar_compare_nonpos")
