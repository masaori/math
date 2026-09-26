# 対象: symmetrized_transfer_matrix_on_sectors の CV2PC = CV2CP
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_sector_representation_prelude.sage'))


def sides(data):
    return data['C'] * data['V2'] * data['P'] * data['C'], data['C'] * data['V2'] * data['C'] * data['P']


check_sector_representation_identity("CV2PC = CV2CP", sides)
