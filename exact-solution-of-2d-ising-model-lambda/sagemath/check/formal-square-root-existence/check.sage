# 対象ラベル: claim_formal_square_root_exists
# 平方根係数列の再帰（def_sqrt_coefficient_recursion）を QQbar で実行し、
# Cauchy 積の各次係数が d_n に一致することを打ち切り次数まで厳密検算する。

N = 8


def sqrt_coefficients(d):
    """d: 長さ N+1 の QQbar 係数列（d[0] == 1）。再帰で s_0..s_N を返す。"""
    assert d[0] == QQbar(1)
    s = [QQbar(1)]
    for n in range(1, N + 1):
        middle = sum((s[j] * s[n - j] for j in range(1, n)), QQbar(0))
        s.append((d[n] - middle) / QQbar(2))
    return s


samples = [
    [QQbar(1)] + [QQbar(0)] * N,                                     # D = 1
    [QQbar(1), QQbar(2), QQbar(1)] + [QQbar(0)] * (N - 2),           # D = (1+x)^2
    [QQbar(1), QQbar(-2), QQbar(3)] + [QQbar(0)] * (N - 2),
    [QQbar(1), QQbar.zeta(3), QQbar(0), QQbar(2).sqrt()] + [QQbar(0)] * (N - 3),
]

checks = 0
for d in samples:
    s = sqrt_coefficients(d)
    assert s[0] == QQbar(1)          # ac_0(S) = 1
    checks += 1
    for n in range(N + 1):
        cauchy = sum((s[j] * s[n - j] for j in range(0, n + 1)), QQbar(0))
        assert cauchy == d[n]        # (S·S) の n 次係数 = d_n
        checks += 1

# D = (1+x)^2 では再帰が 1+x をそのまま返すことも確認する（分岐 s_0 = 1 の側）。
s = sqrt_coefficients(samples[1])
assert s[:3] == [QQbar(1), QQbar(1), QQbar(0)]
assert all(c == QQbar(0) for c in s[3:])
checks += 2

print(f"OK: claim_formal_square_root_exists — QQbar の有限標本で {checks} 件を厳密検査した（打ち切り次数 {N}）")
