# 対象ラベル: claim_gauged_terminal_matrix_determinant
if not globals().get('_gdet_ready', False):
    load('sagemath/check/gauged-terminal-matrix-determinant/_prelude.sage')
_gdet_check('root',2,'root_negative_one_square')
