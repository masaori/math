# 対象ラベル: claim_dual_broken_edges_winding_zero
import os
import sys
winding_directory = os.path.dirname(os.path.abspath(__file__)) if '__file__' in globals() else os.path.dirname(os.path.abspath(sys.argv[0]))
if 'winding_rows' not in globals():
    load(os.path.join(winding_directory, 'construction.sage'))
load(os.path.join(winding_directory, 'check_binary_encoding.sage'))
load(os.path.join(winding_directory, 'check_encoding_substitution.sage'))
load(os.path.join(winding_directory, 'check_sum_residues.sage'))
load(os.path.join(winding_directory, 'check_sum_distribute.sage'))
load(os.path.join(winding_directory, 'check_cyclic_reindex.sage'))
load(os.path.join(winding_directory, 'check_sum_double.sage'))
load(os.path.join(winding_directory, 'check_multiple_residue.sage'))
