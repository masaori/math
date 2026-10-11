# 対象ラベル: claim_quadratic_positive_add_nonnegative
# 対象: 「正錐の非負係数条件どうしの和」の証明。
# 本文の行: b'=0
# 検算する局所条件: 零以下かつ非負の標本（零のみ）
# 背理法の全仮定を同時に満たす事例とは数えない。
# 帰属: QQ / QQbar の厳密計算。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

checked = 0
for bp in qpn_samples:
    if bp <= 0 and 0 <= bp:
        assert bp == 0, bp
        checked += 1
assert checked == 1, checked
print(f"RESULT: PASS (second_prime_antisymmetry: {checked} 件)")
