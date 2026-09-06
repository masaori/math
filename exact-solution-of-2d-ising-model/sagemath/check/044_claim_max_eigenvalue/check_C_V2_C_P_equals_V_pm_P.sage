# 対象: symmetrized_transfer_matrix_on_sectors の CV2CP = V^(±)P
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_sector_representation_prelude.sage'))


def sides(data):
    return data['C'] * data['V2'] * data['C'] * data['P'], data['Vpm'] * data['P']


check_sector_representation_identity("CV2CP = V^(pm)P", sides)
