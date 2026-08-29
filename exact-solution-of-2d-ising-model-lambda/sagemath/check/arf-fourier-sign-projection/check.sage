"""四つのスピン構造の Arf--Fourier 符号射影を整数上で検査する。"""


def quadratic_parity(a, b, h, v):
    return (h * v + (1 - a) * h + (1 - b) * v) % 2


def sign(exponent):
    return ZZ(-1) ** exponent


for h in (0, 1):
    for v in (0, 1):
        signed_sum = ZZ(0)
        for a in (0, 1):
            for b in (0, 1):
                arf_sign = sign((1 - a) * (1 - b))
                sector_sign = sign(quadratic_parity(a, b, h, v))
                signed_sum += arf_sign * sector_sign
        assert signed_sum == 2
        assert QQ(signed_sum) / 2 == 1

print("PASS: 四つの巻き付き偶奇で Arf 符号付き四項和が 1 になる")
