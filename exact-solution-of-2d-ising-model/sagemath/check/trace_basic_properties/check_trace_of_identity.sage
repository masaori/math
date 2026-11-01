# 対象ラベル: trace_basic_properties
# (3) tr(I_{Mat(n,C)}) = Σ_{k=1}^{n} 1_C の鎖を一行ずつ。ℂ を本文 definition_of_cc どおり実数の対で持ち
# （共通の準備 _shared/complex_as_real_pairs.sage。成分の環は QQ）、単位行列は δ から組む。
load("_prelude.sage")
load("../../_shared/complex_as_real_pairs.sage")

R = QQ
ONE = iota(1, R)
ZERO = iota(0, R)


def delta_pair(i, j):
    """def_kronecker_delta の δ_ij を対で: 1_C = (1,0)、0_C = (0,0)。"""
    return ONE if i == j else ZERO


def pair_sum(zs):
    s = ZERO
    for z in zs:
        s = cc_add(s, z)
    return s


def to_pair(z):
    """QQ(i) の元を (実部, 虚部) の対へ。比べる側の独立な経路を、鎖の値の型へつなぐ。"""
    return (R(z.real()), R(z.imag()))


for n in SIZES:
    I_pairs = [[delta_pair(i, j) for j in range(n)] for i in range(n)]   # (I)_ij := δ_ij（def_identity_matrix）
    lines = [
        pair_sum(I_pairs[k][k] for k in range(n)),                       # Σ (I)_kk  (def_trace)
        pair_sum(delta_pair(k, k) for k in range(n)),                    # Σ δ_kk    (def_identity_matrix)
        pair_sum(ONE for k in range(n)),                                 # Σ 1_C     (def_kronecker_delta の i = j)
    ]
    for t in range(len(lines) - 1):
        assert lines[t] == lines[t + 1], (n, t)
    # 比べる側: Sage の identity_matrix の trace（QQ(i) の中）を対に直したものが、鎖の両端と一致する
    tr_sage = identity_matrix(K, n).trace()
    assert to_pair(tr_sage) == lines[0] == lines[-1]
    assert body_identity(K, n) == identity_matrix(K, n)
    print(f"n = {n}: 鎖の 2 個の等号と主張を実数の対で確かめ、Sage の trace と一致した")

print("RESULT: PASS")
