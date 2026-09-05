# 対象ラベル: claim_cyclic_offset_collision
# 式ペア・判定: 衝突条件、像の元数、単射境界を定義から別々に検査する。
# 帰属: 有限集合・ZZ・NN。浮動小数点と R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

cases = 0
for length in range(1, 13):
    for radius in range(0, 9):
        domain = offsets(radius)
        for vertex in cells(length):
            image = projected_neighborhood(length, radius, vertex)
            for j in domain:
                for k in domain:
                    same_image = projection(length, vertex, j) == projection(length, vertex, k)
                    difference_divisible = (j - k) % length == 0
                    assert same_image == difference_divisible
                    cases += 1
            assert len(image) == min(length, 2 * radius + 1)
            is_injective = len(image) == len(domain)
            assert is_injective == (2 * radius + 1 <= length)
            if length < 2 * radius + 1:
                assert -radius + length in domain
                assert projection(length, vertex, -radius) == projection(length, vertex, -radius + length)

print('collision pairs:', cases)
print('RESULT: PASS')

