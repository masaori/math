# 対象ラベル: site_pauli_prefix_product_kronecker_form
# s = 1 の鎖と s → s+1 の鎖（6 行）を、M_col = 1..4、全ての r と (a_1,…,a_r) ∈ {x,y,z}^r で厳密に。
# 各行の両辺: 第 1 行は P_{s+1} := P_s σ_{s+1}^{a_{s+1}}（body_product）、第 2 行は二つのクロネッカー積の積、
# 第 3〜6 行は因子ごとの 2 次の積をその行の形どおりに組んだクロネッカー積（def_kronecker の成分の式）。
load("_prelude.sage")
import itertools

total = 0
for M in [1, 2, 3, 4]:
    for r in range(1, M + 1):
        for a in itertools.product('xyz', repeat=r):
            Ps = [None, site(M, 1, a[0])]
            assert Ps[1] == kron([PAULI[a[0]]] + [I2] * (M - 1))
            for s in range(1, r):
                left = [PAULI[a[k]] for k in range(s)] + [I2] * (M - s)
                right = [I2] * s + [PAULI[a[s]]] + [I2] * (M - s - 1)
                P_next = body_product(Ps[s], site(M, s + 1, a[s]))
                lines = [P_next,
                         body_product(kron(left), kron(right)),
                         kron([body_product(PAULI[a[k]], I2) for k in range(s)] + [body_product(I2, PAULI[a[s]])] + [body_product(I2, I2)] * (M - s - 1)),
                         kron([PAULI[a[k]] for k in range(s)] + [body_product(I2, PAULI[a[s]])] + [body_product(I2, I2)] * (M - s - 1)),
                         kron([PAULI[a[k]] for k in range(s + 1)] + [body_product(I2, I2)] * (M - s - 1)),
                         kron([PAULI[a[k]] for k in range(s + 1)] + [I2] * (M - s - 1))]
                assert Ps[s] == kron(left)
                check_chain(lines, f"M={M} a={a} s={s}")
                Ps.append(P_next)
            assert prefix_product(M, list(a)) == kron([PAULI[x] for x in a] + [I2] * (M - r))
            total += 1
print(f"  M_col=1..4 の {total} 通りの (r, a) で、帰納法の各行と主張が成り立つ")
print("RESULT: PASS")
