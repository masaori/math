# 対象ラベル: def_qbar_zero_diagonal_skew_matrix, def_qbar_polynomial_pfaffian
# 入力の零対角反対称性、完全マッチング・符号・有限和の定義の検算。
# 帰属: 有限集合、ZZ、Q(zeta_8)[x]。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

matching_checks = 0
for n in range(9):
    ms = matchings(tuple(range(n)))
    expected = factorial(n)//(2**(n//2)*factorial(n//2)) if n % 2 == 0 else 0
    assert len(ms) == expected and len(set(ms)) == expected
    for m in ms:
        assert all(i < j for i, j in m)
        word = [v for pair in m for v in pair]
        assert sorted(word) == list(range(n))
        equal(coefficient(m), R(Permutation([v + 1 for v in word]).signature()))
        matching_checks += 1
assert matching_checks == 125

matrix_checks = 0
polynomial_checks = 0
for n, kind, A, ms, data in fixtures():
    assert all(A[i, i] == 0 for i in range(n))
    assert A.transpose() == -A
    matrix_checks += 1
    equal(signed_sum(A, data), recursive_pfaffian(A, tuple(range(n))))
    polynomial_checks += 1
    pairs = list(product(ms, repeat=2))
    assert len(pairs) == len(ms)**2 and len(set(pairs)) == len(pairs)
    assert all((m, m) in pairs for m in ms)
    if n == 0:
        equal(signed_sum(A, data), R(1))
    if n % 2 == 1:
        equal(signed_sum(A, data), R(0))
    if kind == "rank_two" and n >= 4:
        equal(signed_sum(A, data), R(0))
assert matrix_checks == 45 and polynomial_checks == 45
print(f"PASS definitions: {matching_checks} matchings/signs, {matrix_checks} matrices, "
      f"{polynomial_checks} independently expanded Pfaffians and 45 ordered-pair sets")
