# 一側閉包の周期持ち上げ部分の反復

**対象ラベル**: `claim_one_sided_periodic_lift_repetition`

長さ一から四の全340個の単位歩列と二つの始点を使う。周期ベクトルは各歩列の総変位とし、正負の基点・周期境界・零変位・周期長一を含める。周期数は一から三、並進の整数係数は負の二から二。各等号を一ファイルで検査し、最後に有限列全体の反復を照合する。有限例の検査であり、一般の場合は Lean 二版で保証する。

| ファイル | 対応する操作 | 状態 |
|---|---|---|
| `check_translation_substitute.sage` | j=qm+r の代入 | PASS（23,720例） |
| `check_translation_regroup.sage` | 整数の環の法則 | PASS（23,720例） |
| `check_translation_quotient.sage` | 並進した添字の商 | PASS（23,720例） |
| `check_translation_remainder.sage` | 並進した添字の余り | PASS（23,720例） |
| `check_translation_expand.sage` | 周期持ち上げの展開 | PASS（23,720例） |
| `check_translation_distribute.sage` | 整数倍の分配則 | PASS（23,720例） |
| `check_translation_reassociate.sage` | 加法の結合則 | PASS（23,720例） |
| `check_translation_fold.sage` | 周期持ち上げへ戻す | PASS（23,720例） |
| `check_step_division.sage` | 歩の添字の整数除法 | PASS（105,072例） |
| `check_step_upper_substitute.sage` | 終点添字への代入 | PASS（105,072例） |
| `check_step_upper_reassociate.sage` | 終点添字の加法の整理 | PASS（105,072例） |
| `check_step_lower_substitute.sage` | 始点添字への代入 | PASS（105,072例） |
| `check_step_lower_reassociate.sage` | 始点添字の加法の整理 | PASS（105,072例） |
| `check_step_substitute.sage` | 隣接差への添字の代入 | PASS（105,072例） |
| `check_step_translate.sage` | 隣接二点の周期並進 | PASS（105,072例） |
| `check_step_cancel.sage` | 共通の並進の消去 | PASS（105,072例） |
| `check_step_word.sage` | 一周期の歩の定義 | PASS（105,072例） |
| `check_repetition.sage` | 有限列全体の反復 | PASS（14,232例） |

実行日: 2026-10-04。`check.sage` から全18本を実行して通過した。住処は整数と整数格子の有限列であり、浮動小数点を使わない。
