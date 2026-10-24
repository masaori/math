# 対象ラベル: claim_qbar_polynomial_zero_product
# 行別検算と、零多項式を含む全標本の零積性の統合確認。
import os, sys
from pathlib import Path
check_directory = Path(os.path.abspath(sys.argv[0])).parent
line_files = sorted(check_directory.glob('check_*.sage'))
assert len(line_files) == 23
for line_file in line_files:
    load(str(line_file))
all_polynomials = [R.zero()] + polynomials
checked = 0
for f in all_polynomials:
    for g in all_polynomials:
        assert (f*g == R.zero()) == (f == R.zero() or g == R.zero())
        checked += 1
assert checked == 121
print('RESULT: PASS (23 line checks; 121 polynomial pairs)')
