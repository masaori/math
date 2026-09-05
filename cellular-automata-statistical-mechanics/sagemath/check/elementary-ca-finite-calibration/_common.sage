# 初等セルオートマトン（有限巡回舞台・一様・半径 1・2 値）の全数校正で共有する定義。
# 物理の名前は使わず、有限集合と有限写像だけで書く。浮動小数点は使わない。

NEIGHBOR_POSITIONS = (-1, 0, 1)


def local_table(rule_number):
    """規則番号 n in [0,256) から局所真理値表 f: {0,1}^3 -> {0,1} を返す。

    引数 (a,b,c) は左・中央・右の値であり、添字 4a+2b+c の位のビットを取る。
    """
    return tuple((rule_number >> index) & 1 for index in range(8))


def local_value(table, a, b, c):
    return table[4 * a + 2 * b + c]


def support_by_flip_test(table):
    """一点反転検査による本質的依存台と、実行した値の比較回数を返す。"""
    support = []
    comparisons = 0
    for slot in range(3):
        depends = False
        for code in range(8):
            argument = [(code >> 2) & 1, (code >> 1) & 1, code & 1]
            flipped = list(argument)
            flipped[slot] = 1 - flipped[slot]
            comparisons += 1
            if local_value(table, *argument) != local_value(table, *flipped):
                depends = True
                break
        if depends:
            support.append(NEIGHBOR_POSITIONS[slot])
    return tuple(support), comparisons


def flip_test_comparison_bound(neighborhood_size):
    """claim_support_finite_decidability の上界 |S| * 2^{|S|}。"""
    return neighborhood_size * 2 ** neighborhood_size


def configurations(length):
    return tuple(range(2 ** length))


def global_map_table(table, length):
    """巡回舞台 Z/LZ 上の大域写像を、配位の符号 0..2^L-1 の上の写像表として返す。

    配位 x の符号は sum_i x_i * 2^i とする。舞台の添字は L を法とした加法で回す。
    """
    image = []
    for code in range(2 ** length):
        cells = [(code >> i) & 1 for i in range(length)]
        out = 0
        for i in range(length):
            a = cells[(i - 1) % length]
            b = cells[i]
            c = cells[(i + 1) % length]
            out |= local_value(table, a, b, c) << i
        image.append(out)
    return tuple(image)


def is_bijective(map_table):
    return len(set(map_table)) == len(map_table)


def cycle_type(map_table):
    """全単射な写像表の巡回型を、降順の分割（タプル）として返す。"""
    unseen = set(range(len(map_table)))
    lengths = []
    while unseen:
        start = min(unseen)
        current = start
        size = 0
        while current in unseen:
            unseen.remove(current)
            current = map_table[current]
            size += 1
        lengths.append(size)
    return tuple(sorted(lengths, reverse=True))


def partition_count(n):
    """n の分割の個数（厳密な整数計算のみ）。"""
    counts = [0] * (n + 1)
    counts[0] = 1
    for part in range(1, n + 1):
        for total in range(part, n + 1):
            counts[total] += counts[total - part]
    return counts[n]
