# 互いに漸近一致しない有限和差量 Cauchy 列の検算に共通する定義。
# 有限集合・ZZ・QQ と有限台辞書だけを使う。
import os

load(os.path.join(
    os.path.dirname(os.path.abspath(__file__)),
    '../rational-prime-vector-completeness-boundary/_prelude.sage'))


def binary_geometric_truncation(bits, length):
    assert length > 0
    assert length <= len(bits)
    return {
        increasing_prime(index): QQ(bits[index - 1]) / QQ(2 ** index)
        for index in range(1, length + 1)
        if bits[index - 1] != 0
    }
