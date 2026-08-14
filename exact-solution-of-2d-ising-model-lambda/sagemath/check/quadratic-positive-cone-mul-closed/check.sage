# 対象ラベル: claim_quadratic_positive_cone_mul_closed
# 帰属: QQ の厳密計算。浮動小数点を使わない。

def cond_nonnegative(a, b):
    return a >= 0 and b >= 0 and (a, b) != (0, 0)


def cond_negative_second(a, b):
    return a > 0 and b < 0 and 2 * b * b < a * a


def cond_negative_first(a, b):
    return a < 0 and b > 0 and a * a < 2 * b * b


def positive(a, b):
    return cond_nonnegative(a, b) or cond_negative_second(a, b) or cond_negative_first(a, b)


BOUND = 4
values = sorted(set(
    sign * QQ(n) / QQ(d)
    for n in range(0, BOUND + 1)
    for d in range(1, BOUND + 1)
    for sign in (1, -1)
))

# 正錐の表示の標本（三条件のいずれかを満たす有理数の組）。
cone = [(a, b) for a in values for b in values if positive(a, b)]

checked = 0
by_case = {}
for (a, b) in cone:
    for (ap, bp) in cone:
        A = a * ap + 2 * (b * bp)
        B = a * bp + b * ap
        # 主張: 積の表示は正錐の三条件の少なくとも一つを満たす。
        assert positive(A, B)
        # 転送の根拠: 表示の各成分の乗法・加法の可換則。
        assert (a * ap + 2 * (b * bp), a * bp + b * ap) == (ap * a + 2 * (bp * b), ap * b + bp * a)
        # 場合分けが九通りを尽くすこと(各組がどの場合に入るかを記録する)。
        case = (
            0 if cond_nonnegative(a, b) else (1 if cond_negative_second(a, b) else 2),
            0 if cond_nonnegative(ap, bp) else (1 if cond_negative_second(ap, bp) else 2),
        )
        by_case[case] = by_case.get(case, 0) + 1
        checked += 1

assert checked > 0
# 九通りの場合がすべて実際に現れること(場合分けの網羅の検査)。
assert set(by_case.keys()) == {(i, j) for i in range(3) for j in range(3)}
counts = ", ".join(f"{k}: {v}" for k, v in sorted(by_case.items()))
print(f"OK: 正錐と乗法の両立を {checked} 組で厳密検査した ({counts})")
