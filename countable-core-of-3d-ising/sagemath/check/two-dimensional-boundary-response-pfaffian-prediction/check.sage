# 対象ラベル: claim_two_dimensional_boundary_response_pfaffian_prediction
# 正本の有限例検証を読み込み、同じ厳密多項式比較を実行する。
from pathlib import Path

check_dir = Path(__file__).resolve().parent
source = check_dir.parent / "two-dimensional-boundary-response-even-subgraph-sum" / "check_kasteleyn_pfaffian_denominator_clearing.sage"
load(str(source))
