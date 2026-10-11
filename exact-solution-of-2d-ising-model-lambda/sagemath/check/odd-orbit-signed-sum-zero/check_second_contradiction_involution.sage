# 対象ラベル: claim_odd_orbit_signed_sum_zero
# 対象: tools_claim_odd_orbit_signed_sum_zero の証明
# 式・判定: ρ = F(F(ρ)) (F(ρ)=τ)
# 帰属: 有限置換集合、ZZ、Q(zeta_8)[x]。浮動小数点を使わない。
from pathlib import Path
import sys

source_path = Path(globals().get('__file__', sys.argv[0])).resolve()
if not (source_path.parent / '_prelude.sage').is_file():
    source_path = Path(sys.argv[0]).resolve()
__file__ = str(source_path)
load(str(source_path.parent / '_prelude.sage'))
count = 0
for r in oss_stages:
    rho = r['sigma']
    assert r['F'][rho] == r['tau']
    assert rho not in r['R']
    assert rho == r['F'][r['F'][rho]]
    count += 1
oss_record('second_contradiction_involution', count)
