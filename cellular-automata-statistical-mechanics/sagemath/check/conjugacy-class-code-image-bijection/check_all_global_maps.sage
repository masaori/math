# def_conjugacy_class_all_global_maps の検算。
# |V| = 0,1,2 について、A^V の元数 q=2^|V| と全写像表の個数 q^q を照合し、
# 各写像表の各出力セルが全近傍 V 上の真理値表としてその写像を再現することを検査する。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

checked_tables = 0
checked_cell_values = 0
for cell_count, size in ((0, 1), (1, 2), (2, 4)):
    tables = tuple(itertools.product(range(size), repeat=size))
    assert len(tables) == size ** size == (2 ** cell_count) ** (2 ** cell_count)
    for table in tables:
        checked_tables += 1
        local_rules = tuple(
            tuple((table[configuration] >> cell) & 1 for configuration in range(size))
            for cell in range(cell_count)
        )
        for configuration in range(size):
            reconstructed_output = 0
            for cell in range(cell_count):
                # N(cell)=V なので入力の全配位を読む局所真理値表は、出力配位の cell 成分を返せばよい。
                local_output = local_rules[cell][configuration]
                reconstructed_output += local_output << cell
                checked_cell_values += 1
            assert reconstructed_output == table[configuration]

print(f"PASS tables={checked_tables} local_values={checked_cell_values}")
