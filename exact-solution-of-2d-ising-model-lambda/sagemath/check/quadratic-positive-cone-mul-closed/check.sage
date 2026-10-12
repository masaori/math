# 対象ラベル: claim_quadratic_positive_cone_mul_closed
# 帰属: QQ の厳密計算。浮動小数点を使わない。

def cond_nonnegative(a, b):
    return a >= 0 and b >= 0 and (a, b) != (0, 0)


def cond_negative_second(a, b):
    return a > 0 and b < 0 and 2 * b * b < a * a


def cond_negative_first(a, b):
    return a < 0 and b > 0 and a * a < 2 * b * b


def positive(a, b):
    return cond_nonnegative(a, b) or cond_negative_second(a, b) or cond_negative_first(a, b)


BOUND = 4
values = sorted(set(
    sign * QQ(n) / QQ(d)
    for n in range(0, BOUND + 1)
    for d in range(1, BOUND + 1)
    for sign in (1, -1)
))

# 正錐の表示の標本（三条件のいずれかを満たす有理数の組）。
cone = [(a, b) for a in values for b in values if positive(a, b)]

checked = 0
by_case = {}
for (a, b) in cone:
    for (ap, bp) in cone:
        A = a * ap + 2 * (b * bp)
        B = a * bp + b * ap
        # 主張: 積の表示は正錐の三条件の少なくとも一つを満たす。
        assert positive(A, B)
        # 転送の根拠: まず各積の乗法可換則、次に第二成分の加法可換則。
        assert (a * ap + 2 * (b * bp), a * bp + b * ap) == (ap * a + 2 * (bp * b), bp * a + ap * b)
        assert (ap * a + 2 * (bp * b), bp * a + ap * b) == (ap * a + 2 * (bp * b), ap * b + bp * a)
        # 場合分けが九通りを尽くすこと(各組がどの場合に入るかを記録する)。
        case = (
            0 if cond_nonnegative(a, b) else (1 if cond_negative_second(a, b) else 2),
            0 if cond_nonnegative(ap, bp) else (1 if cond_negative_second(ap, bp) else 2),
        )
        by_case[case] = by_case.get(case, 0) + 1
        checked += 1

assert checked > 0
# 九通りの場合がすべて実際に現れること(場合分けの網羅の検査)。
assert set(by_case.keys()) == {(i, j) for i in range(3) for j in range(3)}
counts = ", ".join(f"{k}: {v}" for k, v in sorted(by_case.items()))
print(f"OK: 正錐と乗法の両立を {checked} 組で厳密検査した ({counts})")

# 本文の四等号・転送の含意・九場合の十二所属を一行ずつ検査する。
from pathlib import Path
import sys

_qpm_source = Path(globals().get('__file__', sys.argv[0])).resolve()
if not (_qpm_source.parent / '_prelude.sage').is_file():
    _qpm_source = Path(sys.argv[0]).resolve()
_qpm_directory = _qpm_source.parent
load(str(_qpm_directory / '_prelude.sage'))
_qpm_files = (
    'check_representation_mul.sage',
    'check_commute_products.sage',
    'check_commute_second_sum.sage',
    'check_representation_reverse_mul.sage',
    'check_membership_transfer.sage',
    'check_nonnegative_nonnegative.sage',
    'check_nonnegative_negative_second.sage',
    'check_nonnegative_negative_first.sage',
    'check_negative_second_nonnegative_reverse.sage',
    'check_negative_second_nonnegative.sage',
    'check_negative_second_negative_second.sage',
    'check_negative_second_negative_first.sage',
    'check_negative_first_nonnegative_reverse.sage',
    'check_negative_first_nonnegative.sage',
    'check_negative_first_negative_second_reverse.sage',
    'check_negative_first_negative_second.sage',
    'check_negative_first_negative_first.sage',
)
assert {path.name for path in _qpm_directory.glob('check_*.sage')} == set(_qpm_files)
for _qpm_filename in _qpm_files:
    __file__ = str(_qpm_directory / _qpm_filename)
    load(__file__)
assert len(_qpm_results) == 17
print('COVERAGE: 264 coefficient pairs; two roots; %s' % dict(_qpm_case_counts))
print('RESULT: PASS (17 lines; %d checks; legacy %d rational pairs)'
      % (sum(count for count, kind in _qpm_results.values()), checked))
