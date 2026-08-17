# 対象ラベル: claim_real_algebraic_min_unique
#
# 主張: 空でない有限部分集合 X ⊂ R は、「m ∈ X かつ任意の y ∈ X について y = m または m <_R y」
# を満たす元 m をちょうど 1 つ持つ（<_R は「差が零でない元の平方」）。
# 本文の証明は、存在が |X| の帰納法（1 元の場合 → 元を 1 つ足す場合。三分法で x_1 と x_2 を比べ、
# x_1 <_R x_2 の枝で推移律を使う）、一意性が三分法の排他性である。R のモデルは AA。厳密計算のみ。

import os
from itertools import combinations

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))


def lt_R(a, b):
    """def_real_algebraic_strict_order のモデル: b - a が零でない元の平方であること。"""
    d = b - a
    return d != AA(0) and d.is_square()


def is_min(X, m):
    """本文の「X の最小元」の条件。"""
    if m not in X:
        return False
    return all(y == m or lt_R(m, y) for y in X)


def main():
    base = [AA(0), AA(1), AA(-1), AA(2) / 3, AA(2).sqrt(), -AA(5).sqrt() / 7]

    print("1. 空でない部分集合すべてで、条件を満たす元がちょうど 1 つであること")
    n_checked = 0
    for k in range(1, len(base) + 1):
        for X in combinations(base, k):
            X = list(X)
            mins = [m for m in X if is_min(X, m)]
            assert len(mins) == 1, (X, mins)
            n_checked += 1
    assert n_checked == 63
    print("   通過（%d 集合）" % n_checked)

    print("2. 唯一の最小元 m について、各 y ≠ m の証人 w = sqrt(y - m) が AA の元で零でないこと")
    for k in range(1, len(base) + 1):
        for X in combinations(base, k):
            X = list(X)
            m = [x for x in X if is_min(X, x)][0]
            for y in X:
                if y == m:
                    continue
                w = (y - m).sqrt()
                assert w in AA
                assert w != AA(0)
                assert w * w == y - m
    print("   通過")

    print("3. 帰納法の一歩の場合分け（x_1 と古い最小元 x_2 の比較で新しい最小元が決まること）")
    for k in range(1, len(base)):
        for Y in combinations(base, k):
            Y = list(Y)
            x2 = [x for x in Y if is_min(Y, x)][0]
            for x1 in base:
                if x1 in Y:
                    continue
                X = Y + [x1]
                # 三分法: x1 ≠ x2 なので x1 <_R x2 と x2 <_R x1 のちょうど一方
                assert x1 != x2
                assert lt_R(x1, x2) != lt_R(x2, x1)
                expected = x1 if lt_R(x1, x2) else x2
                assert is_min(X, expected), (X, expected)
                mins = [m for m in X if is_min(X, m)]
                assert mins == [expected], (X, mins, expected)
    print("   通過")


main()
