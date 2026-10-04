# 対象ラベル: claim_terminal_matrix_entries
if 'terminal_cases' not in globals():
    load('sagemath/check/terminal-matrix-entries/_prelude.sage')

terminal_check_pairs('check_final_identity_substitution.sage', terminal_final_chain, 0)
