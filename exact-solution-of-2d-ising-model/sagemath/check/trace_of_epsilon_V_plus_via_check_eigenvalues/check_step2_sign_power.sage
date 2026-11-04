# 対象ラベル: trace_of_epsilon_V_plus_via_check_eigenvalues（Step 2: (Π_{μ=1}^{k} ǔ^{(ϵ_μ)})_C = (−1_C)^{k−|ϵ|_k} の帰納法）
# k = 1、ϵ_1 = 1:  (Π_{μ≤1} ǔ)_C = (ǔ^{(ϵ_1)})_C = (ǔ^{(1)})_C = 1_C = (−1_C)^0 = (−1_C)^{1−|ϵ|_1}
# k = 1、ϵ_1 = 0:  (Π_{μ≤1} ǔ)_C = (ǔ^{(ϵ_1)})_C = (ǔ^{(0)})_C = −1_C = 1_C(−1_C) = (−1_C)^0(−1_C) = (−1_C)^1 = (−1_C)^{1−|ϵ|_1}
# k → k+1、ϵ_{k+1} = 1: ((Π_{≤k} ǔ)ǔ^{(ϵ_{k+1})})_C = (Π_{≤k})_C(ǔ^{(ϵ_{k+1})})_C = (−1_C)^{k−|ϵ|_k}(ǔ)_C = (−1_C)^{k−|ϵ|_k}1_C
#                       = (−1_C)^{k−|ϵ|_k} = (−1_C)^{(k+1)−|ϵ|_{k+1}}
# k → k+1、ϵ_{k+1} = 0: … = (−1_C)^{k−|ϵ|_k}(−1_C) = (−1_C)^{(k−|ϵ|_k)+1} = (−1_C)^{(k+1)−|ϵ|_{k+1}}
# ℂ は QQ(i)（i^2 = −1）で持ち、包含 inclusion_rr_to_cc は QQ → QQ(i) の r ↦ r + 0i、冪は def_power_of_complex_number の帰納法
# （z^0 := 1_C、z^{m+1} := z^m z）を関数で組む。実数の有限積は def_finite_product_of_real_numbers どおり左から掛ける。
# 帰納法の各段の行を、M_col = 1..7 の全ての ϵ ∈ {0,1}^{M_col} と全ての k で確かめる。|ϵ|_k の性質
# （|ϵ|_1 = ϵ_1、|ϵ|_{k+1} = |ϵ|_k + ϵ_{k+1}、0 ≤ |ϵ|_k ≤ k、|ϵ|_M = |ϵ|）も確かめる。
# 帰属: 全て厳密（QQ・QQ(i)）。
load("_prelude.sage")

Ci = QuadraticField(-1, 'i')
inc = lambda r: Ci(r)                      # inclusion_rr_to_cc


def cpow(z, m):
    """def_power_of_complex_number。"""
    out = Ci(1)
    for _ in range(m):
        out = out * z
    return out


mone = inc(-1)
one = inc(1)
count = 0
negatives = 0
for M in range(1, 8):
    for eps in itertools.product([1, 0], repeat=M):
        assert popcount_prefix(eps, 1) == eps[0] and popcount_prefix(eps, M) == sum(eps)
        for k in range(1, M):
            assert popcount_prefix(eps, k + 1) == popcount_prefix(eps, k) + eps[k]
        for k in range(1, M + 1):
            assert 0 <= popcount_prefix(eps, k) <= k
        # k = 1
        u1 = u_sign(eps[0])
        if eps[0] == 1:
            lines = [inc(left_product([u_sign(e) for e in eps[:1]])), inc(u_sign(eps[0])), inc(u_sign(1)), one, cpow(mone, 0), cpow(mone, 1 - popcount_prefix(eps, 1))]
        else:
            lines = [inc(left_product([u_sign(e) for e in eps[:1]])), inc(u_sign(eps[0])), inc(u_sign(0)), mone, one * mone, cpow(mone, 0) * mone, cpow(mone, 1), cpow(mone, 1 - popcount_prefix(eps, 1))]
        for x, y in zip(lines, lines[1:]):
            assert x == y, (eps, 1)
            count += 1
        # k → k + 1
        for k in range(1, M):
            pk = left_product([u_sign(e) for e in eps[:k]])
            ek = popcount_prefix(eps, k)
            e_next = eps[k]
            assert inc(pk) == cpow(mone, k - ek)          # 帰納法の仮定（前の段で示した値）
            common = [inc(left_product([u_sign(e) for e in eps[:k + 1]])), inc(pk * u_sign(e_next)), inc(pk) * inc(u_sign(e_next)), cpow(mone, k - ek) * inc(u_sign(e_next))]
            if e_next == 1:
                assert (k + 1) - popcount_prefix(eps, k + 1) == k - ek
                lines = common + [cpow(mone, k - ek) * one, cpow(mone, k - ek), cpow(mone, (k + 1) - popcount_prefix(eps, k + 1))]
            else:
                assert (k + 1) - popcount_prefix(eps, k + 1) == (k - ek) + 1
                lines = common + [cpow(mone, k - ek) * mone, cpow(mone, (k - ek) + 1), cpow(mone, (k + 1) - popcount_prefix(eps, k + 1))]
            for x, y in zip(lines, lines[1:]):
                assert x == y, (eps, k)
                count += 1
        # 結論: (Π_{μ≤M} ǔ)_C = (−1_C)^{M−|ϵ|}
        assert inc(left_product([u_sign(e) for e in eps])) == cpow(mone, M - sum(eps))
        # 否定コントロール: 指数を |ϵ| にすると、M_col が奇数なら外れる（M − |ϵ| と |ϵ| の偶奇が違う）
        if M % 2 == 1:
            assert inc(left_product([u_sign(e) for e in eps])) != cpow(mone, sum(eps))
            negatives += 1
# 否定コントロール: ǔ^{(0)} を +1 にすると (−1_C)^{M−|ϵ|} と外れる ϵ がある
assert any(inc(left_product([1 for e in eps])) != cpow(mone, 3 - sum(eps)) for eps in itertools.product([1, 0], repeat=3))
negatives += 1
print(f"checked {count} lines")
print(f"negative controls: {negatives}")
print("RESULT: PASS")
