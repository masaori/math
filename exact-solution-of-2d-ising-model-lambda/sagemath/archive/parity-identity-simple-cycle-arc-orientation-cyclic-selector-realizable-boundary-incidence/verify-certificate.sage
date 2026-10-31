"""保存済み証拠だけから切断候補の実現可能性集計を再検査する。"""

import json
from pathlib import Path


certificate_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-selector-realizable-boundary-incidence/"
    "certificate.json")
certificate = json.loads(certificate_path.read_text())

assert certificate["kind"] == (
    "cyclic-selector-realizable-boundary-incidence")
assert certificate["both_connected_record_count"] == 489
assert certificate["realizability_patterns"] == [
    {
        "candidate_zero_realizable": False,
        "candidate_one_realizable": True,
        "count": 153,
    },
    {
        "candidate_zero_realizable": True,
        "candidate_one_realizable": False,
        "count": 174,
    },
    {
        "candidate_zero_realizable": True,
        "candidate_one_realizable": True,
        "count": 162,
    },
]
assert certificate["selected_unrealizable_count"] == 0
assert certificate["selected_not_minimum_realizable_count"] == 0

print(
    "PASS: 保存済み証拠から、切断位置は全489項で実現可能集合の最小元と一致し、"
    "両候補が実現可能な162項により一意性は成り立たないことを確認した")
