# SageMath Check: 正錐の非負係数条件どうしの積

**対象ラベル**: `claim_quadratic_positive_mul_nonnegative`

**実行結果**: PASS（2026-10-11）。行別41本、計848,331確認と、既存統合検算330,625組が通過。

本文の41計算行を1行1ファイルで検査する。非負有理数は分子0〜4・分母1〜4の重複を除いた集合から取り、両入力の係数対が非零の組を調べる。四場合は対応する係数が正の組に限る。表示と所属は二次体の両根について、積の係数公式を参照せず数体の正規形から検査する。

| ファイル | 検証する本文の行 | ステータス | 結果 |
|---|---|---|---|
| `check_representation_first.sage` | 積の第一係数の表示 | PASS | 40,898確認 |
| `check_representation_second.sage` | 積の第二係数の表示 | PASS | 40,898確認 |
| `check_nonnegative_aa.sage` | 第一係数どうしの積の非負性 | PASS | 20,449確認 |
| `check_nonnegative_bb.sage` | 第二係数どうしの積の非負性 | PASS | 20,449確認 |
| `check_nonnegative_weighted_bb.sage` | 第二係数積の二倍の非負性 | PASS | 20,449確認 |
| `check_nonnegative_ab.sage` | 左の第一係数と右の第二係数の積の非負性 | PASS | 20,449確認 |
| `check_nonnegative_ba.sage` | 左の第二係数と右の第一係数の積の非負性 | PASS | 20,449確認 |
| `check_nonnegative_first_sum.sage` | 第一係数の表示式の非負性 | PASS | 20,449確認 |
| `check_nonnegative_first_result.sage` | 第一係数の表示式から係数への置換 | PASS | 20,449確認 |
| `check_nonnegative_second_sum.sage` | 第二係数の表示式の非負性 | PASS | 20,449確認 |
| `check_nonnegative_second_result.sage` | 第二係数の表示式から係数への置換 | PASS | 20,449確認 |
| `check_left_positive_to_nonzero.sage` | 左入力の正値性と非零性 | PASS | 20,449確認 |
| `check_left_demorgan.sage` | 左入力のド・モルガンの法則 | PASS | 20,449確認 |
| `check_left_pair_nonzero.sage` | 左入力の組の非零性 | PASS | 20,449確認 |
| `check_left_truth.sage` | 左入力の非零仮定 | PASS | 20,449確認 |
| `check_right_positive_to_nonzero.sage` | 右入力の正値性と非零性 | PASS | 20,449確認 |
| `check_right_demorgan.sage` | 右入力のド・モルガンの法則 | PASS | 20,449確認 |
| `check_right_pair_nonzero.sage` | 右入力の組の非零性 | PASS | 20,449確認 |
| `check_right_truth.sage` | 右入力の非零仮定 | PASS | 20,449確認 |
| `check_positive_aa.sage` | 第一係数どうしが正の場合の正積 | PASS | 17,424確認 |
| `check_aa_add_zero.sage` | 第一係数積への零の加算 | PASS | 17,424確認 |
| `check_aa_bound.sage` | 第一係数積の加法による上界 | PASS | 17,424確認 |
| `check_aa_result.sage` | 第一係数どうしが正の場合の表示への置換 | PASS | 17,424確認 |
| `check_positive_ab.sage` | 左の第一係数と右の第二係数が正の場合の正積 | PASS | 17,424確認 |
| `check_ab_add_zero.sage` | 第一の交差積への零の加算 | PASS | 17,424確認 |
| `check_ab_bound.sage` | 第一の交差積の加法による上界 | PASS | 17,424確認 |
| `check_ab_result.sage` | 第一の交差積が正の場合の表示への置換 | PASS | 17,424確認 |
| `check_positive_ba.sage` | 左の第二係数と右の第一係数が正の場合の正積 | PASS | 17,424確認 |
| `check_ba_zero_add.sage` | 第二の交差積の左への零の加算 | PASS | 17,424確認 |
| `check_ba_bound.sage` | 第二の交差積の加法による上界 | PASS | 17,424確認 |
| `check_ba_result.sage` | 第二の交差積が正の場合の表示への置換 | PASS | 17,424確認 |
| `check_positive_bb.sage` | 第二係数どうしが正の場合の正積 | PASS | 17,424確認 |
| `check_positive_weighted_bb.sage` | 正の第二係数積の二倍の正値性 | PASS | 17,424確認 |
| `check_weighted_bb_zero_add.sage` | 第二係数積の二倍の左への零の加算 | PASS | 17,424確認 |
| `check_weighted_bb_bound.sage` | 第二係数積の二倍の加法による上界 | PASS | 17,424確認 |
| `check_weighted_bb_result.sage` | 第二係数どうしが正の場合の表示への置換 | PASS | 17,424確認 |
| `check_product_pair_coordinates.sage` | 出力の組の等号 | PASS | 20,449確認 |
| `check_product_pair_demorgan.sage` | 出力のド・モルガンの法則 | PASS | 20,449確認 |
| `check_product_pair_positive.sage` | 出力の非零性と正値性 | PASS | 20,449確認 |
| `check_product_pair_truth.sage` | 四場合による出力の正係数 | PASS | 20,449確認 |
| `check_product_membership.sage` | 積の正錐への所属 | PASS | 40,898確認 |
| `check_global.sage` | 非負かつ非零な入力の積と四場合の統合検算（分子0〜6・分母1〜6） | PASS | 330,625組、各場合304,704組 |

すべて `QQ` または二次体での厳密計算であり、浮動小数点を使わない。有限標本の検算であって一般命題の証明ではない。

実行: プロジェクト直下で `sage sagemath/check/quadratic-positive-mul-nonnegative/check.sage`。各 `check_*.sage` は単独でも実行できる。
