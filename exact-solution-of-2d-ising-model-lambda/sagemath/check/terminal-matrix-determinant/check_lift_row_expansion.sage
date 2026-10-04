# 対象ラベル: claim_terminal_matrix_determinant
if 'terminal_determinant_chains' not in globals():
    load('sagemath/check/terminal-matrix-determinant/_prelude.sage')
terminal_det_check('lift_row_expansion', terminal_lift_chains, 0)
