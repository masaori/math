from pathlib import Path


def make_twist_sign_cases():
    cases = []
    for L in range(1, 6):
        for edge in range(1, 2 * L**2 + 1):
            horizontal = edge <= L**2
            offset = edge - 1 if horizontal else edge - L**2 - 1
            row, column = divmod(offset, L)
            ch = NN(horizontal and column == L - 1)
            cv = NN(not horizontal and row == L - 1)
            for reverse in (0, 1):
                for a in (0, 1):
                    for b in (0, 1):
                        n = NN(a * ch + b * cv)
                        sign = ZZ(1)
                        if a == 1 and ch == 1:
                            sign = -sign
                        if b == 1 and cv == 1:
                            sign = -sign
                        cases.append((n, NN(n // 2), NN(n % 2),
                                      NN((a * ch + b * cv) % 2), sign, "edge"))
    # 商が正の場合も含む、格子とは独立した整数冪の補助検算。
    for value in range(258):
        n = NN(value)
        sign = prod(ZZ(-1) for unused in range(value))
        cases.append((n, NN(n // 2), NN(n % 2), NN(n % 2), sign, "scalar"))
    return cases


if "_twist_sign_cases" not in globals():
    _twist_sign_cases = make_twist_sign_cases()
