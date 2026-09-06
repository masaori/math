# 対象: symmetrized_transfer_matrix_on_sectors の BPV2C = CPV2C
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_sector_representation_prelude.sage'))


def sides(data):
    return data['B'] * data['P'] * data['V2'] * data['C'], data['C'] * data['P'] * data['V2'] * data['C']


check_sector_representation_identity("BPV2C = CPV2C", sides)
