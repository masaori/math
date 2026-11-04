# 対象ラベル: trace_of_check_number_operator_product
# 証明の全ての鎖を、M_col = 2, 3, 4 の相異なる添字の全ての列 μ_1, …, μ_k（k = 1..M_col）と全ての e_1, …, e_k ∈ {0,1} について、
# QQ の厳密計算で一行ずつ確かめる。基底段階 tr(I) = 2^{M_col}、準備 1（最後の因子を分ける。k = 1 では P := I）、
# 準備 2（ψ̌_{M_col+1-μ_k} と単位行列・各因子 R_{μ_j}^{(e_j)}・P の可換性）、準備 3 の 10 行、tr(Pň_{μ_k}) の 8 行、
# 移項の 2 行、二場合の鎖、最後の 6 行。鎖の組み立ては _chains.sage（本物の ψ̌ の検算と共有）。
#   D_μ := ψ̌_μ^†、A_μ := ψ̌_{M_col+1-μ}、n_μ := D_μ A_μ（def_check_number_operator）。
# 鎖が使う仮定は check_number_operator_idempotent (2)（A_μD_μ = I - n_μ）と check_number_operators_commute (1) の第 2 式
# （μ ≠ ν で A_μ n_ν = n_ν A_μ）だけなので、ここでは Jordan–Wigner のフェルミ演算子 c_μ を取り、D_μ := c_μ^T、A_μ := c_μ とする
#（本文の ψ̌ で同じ鎖を確かめるのは check_with_check_psi.sage）。
# 否定コントロール: 添字が重なる列（μ_k = μ_j）では準備 2 の可換性と主張の値 2^{M_col-k} が外れることを確かめる。
# 帰属: 成分とトレースは QQ（厳密計算）。
load("_chains.sage")


def kron(factors):
    out = matrix(factors[0].base_ring(), 1, 1, [1])
    for X in factors:
        out = out.tensor_product(X)
    return out


counts = {"chain": 0, "hyp": 0, "assumption": 0, "neg": 0}


def counter(key):
    def check(ok, label):
        assert ok, label
        counts[key] += 1
    return check


sz = matrix(QQ, [[1, 0], [0, -1]])
lower = matrix(QQ, [[0, 1], [0, 0]])
id2 = identity_matrix(QQ, 2)
for M in range(2, 5):
    Id = kron([id2] * M)
    c = [kron([sz] * (k - 1) + [lower] + [id2] * (M - k)) for k in range(1, M + 1)]
    D = [ck.transpose() for ck in c]
    A = c
    n = assumption_lines(M, Id, D, A, counter("assumption"))
    base_case(M, Id, counter("chain"))
    chk = counter("chain")
    hyp = counter("hyp")

    def step_check(ok, label):
        (hyp if "帰納法の仮定" in label else chk)(ok, label)
    for mus, es in all_sequences(M):
        induction_step(M, Id, D, A, n, mus, es, step_check)
    negative_controls(M, A, n, counter("neg"))
print(f"  {counts['chain']} 行（M_col = 2..4 の相異なる添字の全ての列と全ての e で、証明の全ての鎖。QQ の厳密計算）")
print(f"  帰納法の仮定 tr(P) = 2^(M_col-(k-1)) を {counts['hyp']} 列で、鎖が引く仮定の主張を {counts['assumption']} 件で確かめた")
print(f"  否定コントロール {counts['neg']} 件: 添字が重なる列では準備 2 の可換性と 2^(M_col-k) が外れる")
print("RESULT: PASS")
