# 対象ラベル: claim_terminal_matrix_entries
if 'terminal_cases' not in globals():
    load('sagemath/check/terminal-matrix-entries/_prelude.sage')

terminal_check_pairs('check_row_unit_embedding.sage', terminal_row_chain, 4)
