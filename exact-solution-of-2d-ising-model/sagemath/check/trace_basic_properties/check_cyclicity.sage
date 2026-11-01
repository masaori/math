# 対象ラベル: trace_basic_properties
# (2) 巡回性の鎖を一行ずつ。A, B の成分を QQ 上の不定元に置き、各行の値をその行に書かれた二重和どおりに組む。
load("_prelude.sage")

for n in SIZES:
    P, _, (A, B) = generic(n, ["A", "B"])
    AB = body_product(A, B)
    BA = body_product(B, A)
    lines = [
        body_trace(AB),                                                               # tr(AB)
        sum(AB[k, k] for k in range(n)),                                              # Σ_k (AB)_kk        (def_trace)
        sum(sum(A[k, j] * B[j, k] for j in range(n)) for k in range(n)),              # Σ_k Σ_j A_kj B_jk  (mat_mult)
        sum(sum(B[j, k] * A[k, j] for j in range(n)) for k in range(n)),              # Σ_k Σ_j B_jk A_kj  (積の交換)
        sum(sum(B[j, k] * A[k, j] for k in range(n)) for j in range(n)),              # Σ_j Σ_k B_jk A_kj  (和の順序交換)
        sum(BA[j, j] for j in range(n)),                                              # Σ_j (BA)_jj        (mat_mult)
        body_trace(BA),                                                               # tr(BA)             (def_trace)
    ]
    for t in range(len(lines) - 1):
        assert lines[t] == lines[t + 1], (n, t)
    # 成分の式で組んだ積が Sage の行列積と一致し、主張の両端が Sage の trace と一致する
    assert AB == A * B and BA == B * A
    assert lines[0] == (A * B).trace() and lines[-1] == (B * A).trace()
    # 主張が AB = BA に頼っていないことの対照: n ≥ 2 で AB ≠ BA でも tr は一致する
    if n >= 2:
        assert A * B != B * A
    print(f"n = {n}: 鎖の 6 個の等号と主張を不定元で確かめた")

print("RESULT: PASS")
