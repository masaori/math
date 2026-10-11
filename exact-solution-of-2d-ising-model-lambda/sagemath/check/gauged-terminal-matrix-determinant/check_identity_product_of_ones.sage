# 対象ラベル: claim_gauged_terminal_matrix_determinant
if not globals().get('_gdet_ready', False):
    load('sagemath/check/gauged-terminal-matrix-determinant/_prelude.sage')
_gdet_check('identity',4,'identity_product_of_ones')
