# 対象ラベル: claim_quadratic_positive_mul_nonnegative
# 帰属: QQ の厳密計算。浮動小数点を使わない。

BOUND = 6
samples = sorted(set(QQ(n) / QQ(d) for n in range(0, BOUND + 1) for d in range(1, BOUND + 1)))

checked = 0
case_counts = {(i, j): 0 for i in range(2) for j in range(2)}
for a in samples:
    for b in samples:
        if (a, b) == (0, 0):
            continue
        for ap in samples:
            for bp in samples:
                if (ap, bp) == (0, 0):
                    continue
                A = a * ap + 2 * (b * bp)
                B = a * bp + b * ap
                assert A >= 0
                assert B >= 0
                assert (A, B) != (0, 0)

                left_cases = ([a > 0] if a > 0 else []) + ([b > 0] if b > 0 else [])
                right_cases = ([ap > 0] if ap > 0 else []) + ([bp > 0] if bp > 0 else [])
                assert left_cases and right_cases
                if a > 0 and ap > 0:
                    assert 0 < a * ap <= A
                    case_counts[(0, 0)] += 1
                if a > 0 and bp > 0:
                    assert 0 < a * bp <= B
                    case_counts[(0, 1)] += 1
                if b > 0 and ap > 0:
                    assert 0 < b * ap <= B
                    case_counts[(1, 0)] += 1
                if b > 0 and bp > 0:
                    assert 0 < 2 * (b * bp) <= A
                    case_counts[(1, 1)] += 1
                checked += 1

assert checked > 0
assert all(count > 0 for count in case_counts.values())
print(f"OK: 正錐の非負係数条件どうしの積を {checked} 組で厳密検査した ({case_counts})")
