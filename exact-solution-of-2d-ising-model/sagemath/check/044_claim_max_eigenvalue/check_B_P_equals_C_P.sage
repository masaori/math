# 対象: symmetrized_transfer_matrix_on_sectors の BP = CP
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_sector_representation_prelude.sage'))


def sides(data):
    return data['B'] * data['P'], data['C'] * data['P']


check_sector_representation_identity("BP = CP", sides)
