# 負の第二係数条件どうしの和の行別検算

**対象ラベル**: `claim_quadratic_positive_add_negative_second_negative_second`

本文二十五計算行を一行一ファイルで検査する。分子・分母が一から六の正の有理数23個から、負の第二係数条件を満たす係数対213個を取り、全45,369組を使う。各行の確認件数が固定件数に一致することも検査する。

和の表示と正錐への所属は二次体 `QuadraticField(2)` で計算する。`s²=2` の二つの根を使い、正規形から係数を読み直すことで、和の表示を検証コードへ仮定として埋め込まない。この二行は各90,738件である。他の行は `QQ` 上で厳密比較する。浮動小数点は使わず、実数体・複素数体への脱出はない。有限サンプルの検算は一般証明を代用しない。

| ファイル | 本文の行 | 結果 | 確認数 |
|---|---|---|---|
| `check_sum_representation.sage` | 和の表示 | PASS（2026-10-11） | 90,738 |
| `check_first_zero_add.sage` | 第一係数の符号・零和への書換え | PASS（2026-10-11） | 45,369 |
| `check_first_sum_positive.sage` | 第一係数の符号・加法の狭義単調性 | PASS（2026-10-11） | 45,369 |
| `check_second_sum_negative.sage` | 第二係数の符号・加法の狭義単調性 | PASS（2026-10-11） | 45,369 |
| `check_second_zero_add.sage` | 第二係数の符号・零和の簡約 | PASS（2026-10-11） | 45,369 |
| `check_second_product_positive.sage` | 負の第二係数の積の正値性 | PASS（2026-10-11） | 45,369 |
| `check_cross_positive.sage` | 交差項の左辺の正値性 | PASS（2026-10-11） | 45,369 |
| `check_cross_nonnegative.sage` | 交差項の左辺の非負性 | PASS（2026-10-11） | 45,369 |
| `check_first_product_positive.sage` | 正の第一係数の積の正値性 | PASS（2026-10-11） | 45,369 |
| `check_first_product_nonnegative.sage` | 交差項の右辺の非負性 | PASS（2026-10-11） | 45,369 |
| `check_second_prime_square_positive.sage` | 第二係数の平方の正値性 | PASS（2026-10-11） | 45,369 |
| `check_weighted_second_prime_square_positive.sage` | 掛ける右因子の正値性 | PASS（2026-10-11） | 45,369 |
| `check_first_square_positive.sage` | 掛ける左因子の正値性 | PASS（2026-10-11） | 45,369 |
| `check_product_square_expand.sage` | 積の平方比較・左辺の整列 | PASS（2026-10-11） | 45,369 |
| `check_product_square_left.sage` | 積の平方比較・第一条件を右乗法で拡大 | PASS（2026-10-11） | 45,369 |
| `check_product_square_right.sage` | 積の平方比較・第二条件を左乗法で拡大 | PASS（2026-10-11） | 45,369 |
| `check_product_square_fold.sage` | 積の平方比較・右辺の整列 | PASS（2026-10-11） | 45,369 |
| `check_cross_comparison.sage` | 既存の平方比較主張の適用 | PASS（2026-10-11） | 45,369 |
| `check_cross_twice.sage` | 交差項比較の正の二倍 | PASS（2026-10-11） | 45,369 |
| `check_sum_square_expand.sage` | 和の平方の展開 | PASS（2026-10-11） | 45,369 |
| `check_sum_square_first.sage` | 和の平方比較・第一の平方を置換 | PASS（2026-10-11） | 45,369 |
| `check_sum_square_cross.sage` | 和の平方比較・交差項を置換 | PASS（2026-10-11） | 45,369 |
| `check_sum_square_second.sage` | 和の平方比較・第二の平方を置換 | PASS（2026-10-11） | 45,369 |
| `check_sum_square_fold.sage` | 和の平方へ復元 | PASS（2026-10-11） | 45,369 |
| `check_cone_membership.sage` | 正錐の第二条件から所属 | PASS（2026-10-11） | 90,738 |

既存の `check.sage` にある総合検算45,369組も通過した。行別二十五本は合計1,224,963確認。既存の2026-08-14の平方比較・平方展開の検査範囲を保ち、各行の検算を追加している。

プロジェクト直下から実行する。

```sh
sage sagemath/check/quadratic-positive-add-negative-second-negative-second/check.sage
```

2026-10-11 に既存総合検算と本文二十五行の検算がすべて通過。
