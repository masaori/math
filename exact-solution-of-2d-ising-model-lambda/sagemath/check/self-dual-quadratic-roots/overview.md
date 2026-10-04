# 自己双対方程式の因数分解と根の全体

**対象ラベル**: `claim_self_dual_quadratic_roots`

実行日: 2026-10-04。帰属は QQbar で、等号を厳密に判定する。有限例の検算であり、任意の代数的数に対する一般証明は本文と Lean が担う。

既存の `check.sage` は、二通りの $s$ と、十七点に二根を重複して加えた十九入力の組合せによる三十八検査を保持する。`check_lines.sage` は両方の $s=±\sqrt 2$ と相異なる十七点の組合せを使い、本文の各等号を別ファイルで検査する。因数分解は三十四組全て、根の代入と各根の導出は対応する根の二組、積が零になる鎖は二次方程式を満たす四組に限定する。零因子の不在による場合分けも、第一因子が零の二組と非零の二組を検査する。

結果: 既存の三十八検査、および行別七十一行の計千百七十等式と零因子の場合分け四件が通過。

| 計算鎖 | 等号の数 | 各行の入力数 | 等式検査数 |
|---|---:|---:|---:|
| 因数分解 | 32 | 34 | 1088 |
| 第一の根から方程式 | 8 | 2 | 16 |
| 第二の根から方程式 | 9 | 2 | 18 |
| 方程式から積が零 | 2 | 4 | 8 |
| 第一因子から根 | 10 | 2 | 20 |
| 第二因子から根 | 10 | 2 | 20 |

プロジェクト直下で実行する。

```sh
sage sagemath/check/self-dual-quadratic-roots/check.sage
sage sagemath/check/self-dual-quadratic-roots/check_lines.sage
```

| 式変形 | ファイル | 結果 |
|---|---|---|
| 因数分解: 右側の和への分配則 | `check_factor_distribute_right.sage` | PASS |
| 因数分解: 第一の積への分配則 | `check_factor_distribute_first.sage` | PASS |
| 因数分解: 第二の積への分配則 | `check_factor_distribute_second.sage` | PASS |
| 因数分解: 積の可換則 | `check_factor_commute_middle.sage` | PASS |
| 因数分解: 第一の差の減法の定義 | `check_factor_first_subtraction.sage` | PASS |
| 因数分解: 第二の差の減法の定義 | `check_factor_second_subtraction.sage` | PASS |
| 因数分解: 外側の加法の結合則 | `check_factor_outer_associativity.sage` | PASS |
| 因数分解: 内側の加法の結合則 | `check_factor_inner_associativity.sage` | PASS |
| 因数分解: 加法の逆元との和 | `check_factor_cancel_middle.sage` | PASS |
| 因数分解: 零元との和 | `check_factor_remove_inner_zero.sage` | PASS |
| 因数分解: 減法の定義 | `check_factor_restore_subtraction.sage` | PASS |
| 因数分解: 仮定 s\cdot s=2 | `check_factor_square_two.sage` | PASS |
| 因数分解: 右側の和への分配則 | `check_factor_expand_square_right.sage` | PASS |
| 因数分解: 第一の積への分配則 | `check_factor_expand_square_left.sage` | PASS |
| 因数分解: 右側の単位元との積 | `check_factor_right_identity.sage` | PASS |
| 因数分解: \xi^2 の定義 | `check_factor_square_definition.sage` | PASS |
| 因数分解: 左側の単位元との積 | `check_factor_left_identity.sage` | PASS |
| 因数分解: 外側の加法の結合則 | `check_factor_associate_outer.sage` | PASS |
| 因数分解: 内側の加法の結合則 | `check_factor_associate_inner.sage` | PASS |
| 因数分解: 加法の結合則 | `check_factor_associate_constant.sage` | PASS |
| 因数分解: 第一の項に単位元との積を挿入 | `check_factor_first_unit.sage` | PASS |
| 因数分解: 第二の項に単位元との積を挿入 | `check_factor_second_unit.sage` | PASS |
| 因数分解: 分配則を逆向きに適用 | `check_factor_collect_units.sage` | PASS |
| 因数分解: 2:=1+1 の定義 | `check_factor_define_two.sage` | PASS |
| 因数分解: 減法の定義 | `check_factor_final_subtraction.sage` | PASS |
| 因数分解: 加法の結合則 | `check_factor_separate_constant.sage` | PASS |
| 因数分解: 2:=1+1 の定義 | `check_factor_expand_two.sage` | PASS |
| 因数分解: 和の加法の逆元 | `check_factor_negate_sum.sage` | PASS |
| 因数分解: 加法の結合則 | `check_factor_associate_inverses.sage` | PASS |
| 因数分解: 加法の逆元との和 | `check_factor_cancel_one.sage` | PASS |
| 因数分解: 零元との和 | `check_factor_remove_constant_zero.sage` | PASS |
| 因数分解: 減法の定義 | `check_factor_restore_final_subtraction.sage` | PASS |
| 第一の根から方程式: 準備の因数分解の等式 | `check_root_plus_factorization.sage` | PASS |
| 第一の根から方程式: 仮定 \xi=-1+s | `check_root_plus_substitution.sage` | PASS |
| 第一の根から方程式: 加法の可換則 | `check_root_plus_commute.sage` | PASS |
| 第一の根から方程式: 加法の結合則 | `check_root_plus_associate.sage` | PASS |
| 第一の根から方程式: 加法の逆元との和 | `check_root_plus_cancel_one.sage` | PASS |
| 第一の根から方程式: 零元との和 | `check_root_plus_remove_zero.sage` | PASS |
| 第一の根から方程式: 元と同じ元との差は零 | `check_root_plus_cancel_s.sage` | PASS |
| 第一の根から方程式: 零元との積 | `check_root_plus_zero_product.sage` | PASS |
| 第二の根から方程式: 準備の因数分解の等式 | `check_root_minus_factorization.sage` | PASS |
| 第二の根から方程式: 仮定 \xi=-1-s | `check_root_minus_substitution.sage` | PASS |
| 第二の根から方程式: 減法の定義 | `check_root_minus_subtraction.sage` | PASS |
| 第二の根から方程式: 加法の可換則 | `check_root_minus_commute.sage` | PASS |
| 第二の根から方程式: 加法の結合則 | `check_root_minus_associate.sage` | PASS |
| 第二の根から方程式: 加法の逆元との和 | `check_root_minus_cancel_one.sage` | PASS |
| 第二の根から方程式: 零元との和 | `check_root_minus_remove_zero.sage` | PASS |
| 第二の根から方程式: 加法の逆元との和 | `check_root_minus_cancel_s.sage` | PASS |
| 第二の根から方程式: 零元との積 | `check_root_minus_zero_product.sage` | PASS |
| 方程式から積が零: 準備の因数分解の等式 | `check_zero_product_factorization.sage` | PASS |
| 方程式から積が零: 仮定 \xi^2+2\xi-1=0 | `check_zero_product_quadratic_zero.sage` | PASS |
| 零因子の不在による場合分け | `check_zero_product_branch.sage` | PASS |
| 第一因子から根: 零元との和 | `check_extract_plus_insert_zero.sage` | PASS |
| 第一因子から根: 加法の逆元との和 | `check_extract_plus_insert_one_inverse.sage` | PASS |
| 第一因子から根: 加法の結合則 | `check_extract_plus_associate_one.sage` | PASS |
| 第一因子から根: 零元との和 | `check_extract_plus_insert_second_zero.sage` | PASS |
| 第一因子から根: 加法の逆元との和 | `check_extract_plus_insert_s_inverse.sage` | PASS |
| 第一因子から根: 加法の結合則 | `check_extract_plus_associate_s.sage` | PASS |
| 第一因子から根: 減法の定義 | `check_extract_plus_subtraction.sage` | PASS |
| 第一因子から根: この場合の仮定 (\xi+1)-s=0 | `check_extract_plus_first_factor_zero.sage` | PASS |
| 第一因子から根: 零元との和 | `check_extract_plus_remove_zero.sage` | PASS |
| 第一因子から根: 加法の可換則 | `check_extract_plus_commute.sage` | PASS |
| 第二因子から根: 零元との和 | `check_extract_minus_insert_zero.sage` | PASS |
| 第二因子から根: 加法の逆元との和 | `check_extract_minus_insert_one_inverse.sage` | PASS |
| 第二因子から根: 加法の結合則 | `check_extract_minus_associate_one.sage` | PASS |
| 第二因子から根: 零元との和 | `check_extract_minus_insert_second_zero.sage` | PASS |
| 第二因子から根: 加法の逆元との和 | `check_extract_minus_insert_s_inverse.sage` | PASS |
| 第二因子から根: 加法の結合則 | `check_extract_minus_associate_s.sage` | PASS |
| 第二因子から根: 上で得た (\xi+1)+s=0 | `check_extract_minus_second_factor_zero.sage` | PASS |
| 第二因子から根: 零元との和 | `check_extract_minus_remove_zero.sage` | PASS |
| 第二因子から根: 加法の可換則 | `check_extract_minus_commute.sage` | PASS |
| 第二因子から根: 減法の定義 | `check_extract_minus_subtraction.sage` | PASS |
