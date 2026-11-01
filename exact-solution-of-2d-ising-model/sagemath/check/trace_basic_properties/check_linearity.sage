# 対象ラベル: trace_basic_properties
# (1) 線型性の鎖を一行ずつ。α, β と A, B の成分を QQ 上の不定元に置き、各行の値をその行に書かれた式どおりに組む。
load("_prelude.sage")

for n in SIZES:
    P, (al, be), (A, B) = generic(n, ["A", "B"], scalars=["alpha", "beta"])
    aA = body_scalar(al, A)
    bB = body_scalar(be, B)
    S = body_sum(aA, bB)
    # 本文の定め方どおりに組んだ αA + βB が、Sage の和とスカラー倍と一致する（比べる側の独立な経路）
    assert S == al * A + be * B
    lines = [
        body_trace(S),                                                   # tr(αA+βB)
        sum(S[k, k] for k in range(n)),                                  # Σ (αA+βB)_kk          (def_trace)
        sum(aA[k, k] + bB[k, k] for k in range(n)),                      # Σ ((αA)_kk + (βB)_kk) (def_matrix_sum)
        sum(al * A[k, k] + be * B[k, k] for k in range(n)),              # Σ (α A_kk + β B_kk)   (def_matrix_scalar_multiple)
        sum(al * A[k, k] for k in range(n)) + sum(be * B[k, k] for k in range(n)),  # 並べ替え
        al * sum(A[k, k] for k in range(n)) + be * sum(B[k, k] for k in range(n)),  # 分配法則
        al * body_trace(A) + be * body_trace(B),                         # α tr(A) + β tr(B)     (def_trace)
    ]
    for t in range(len(lines) - 1):
        assert lines[t] == lines[t + 1], (n, t)
    # 主張の両端を Sage の trace と比べる
    assert lines[0] == (al * A + be * B).trace()
    assert lines[-1] == al * A.trace() + be * B.trace()
    print(f"n = {n}: 鎖の 6 個の等号と主張を不定元で確かめた")

print("RESULT: PASS")
