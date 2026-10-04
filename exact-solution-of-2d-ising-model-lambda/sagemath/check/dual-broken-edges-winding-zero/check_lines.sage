# 対象ラベル: claim_dual_broken_edges_winding_zero
import os
import sys
winding_entry = sys.argv[0] if sys.argv[0].endswith('.sage') else __file__
winding_directory = os.path.dirname(os.path.abspath(winding_entry))
if 'winding_rows' not in globals():
    load(os.path.join(winding_directory, 'construction.sage'))
load(os.path.join(winding_directory, 'check_binary_encoding.sage'))
load(os.path.join(winding_directory, 'check_encoding_substitution.sage'))
load(os.path.join(winding_directory, 'check_sum_residues.sage'))
load(os.path.join(winding_directory, 'check_sum_distribute.sage'))
load(os.path.join(winding_directory, 'check_cyclic_reindex.sage'))
load(os.path.join(winding_directory, 'check_sum_double.sage'))
load(os.path.join(winding_directory, 'check_multiple_residue.sage'))

load(os.path.join(winding_directory, 'check_winding_definition.sage'))
load(os.path.join(winding_directory, 'check_dual_preimage_indicator.sage'))
load(os.path.join(winding_directory, 'check_dual_inverse_coordinates.sage'))
load(os.path.join(winding_directory, 'check_primal_cyclic_reindex.sage'))
load(os.path.join(winding_directory, 'check_edge_encoding_substitution.sage'))
load(os.path.join(winding_directory, 'check_endpoint_substitution.sage'))
