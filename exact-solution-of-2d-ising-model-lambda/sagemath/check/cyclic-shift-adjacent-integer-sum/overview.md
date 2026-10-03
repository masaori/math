# SageMath Check: 巡回移動と隣接二項の整数和

**対象ラベル**: `claim_cyclic_shift_adjacent_integer_sum`

本文の等号一つにつき検査ファイルを一つ置く。すべて `ZZ` と有限な整数行列で計算する。
添字は $1\le m\le12$、$-2m\le k\le2m$、$0\le j<m$ を全数検査する。
有限和は $1\le m\le8$ の各行列単位と負の値も含む整数行列について、同じ範囲の移動量を検査する。
これは有限範囲の検査であり、任意の長さ・整数の表に対する証明は本文と Lean 二版が担う。

| ファイル | 本文の一行 | 状態 |
|---|---|---|
| `check_inverse_left_definition.sage` | 左逆写像の定義の展開 | PASS |
| `check_inverse_left_remainder.sage` | 左逆写像の内側の余りの除去 | PASS |
| `check_inverse_left_cancel.sage` | 左逆写像の整数の相殺 | PASS |
| `check_inverse_left_representative.sage` | 左逆写像の添字が標準の余りであること | PASS |
| `check_inverse_right_definition.sage` | 右逆写像の定義の展開 | PASS |
| `check_inverse_right_remainder.sage` | 右逆写像の内側の余りの除去 | PASS |
| `check_inverse_right_cancel.sage` | 右逆写像の整数の相殺 | PASS |
| `check_inverse_right_representative.sage` | 右逆写像の添字が標準の余りであること | PASS |
| `check_successor_definition.sage` | 次の添字と移動の定義の展開 | PASS |
| `check_successor_remainder.sage` | 次の添字の内側の余りの除去 | PASS |
| `check_successor_associate.sage` | 加法を右に括る | PASS |
| `check_successor_commute.sage` | 整数の加法の交換律 | PASS |
| `check_successor_unassociate.sage` | 加法を左に括る | PASS |
| `check_successor_restore_remainder.sage` | 移動後の添字の余りの挿入 | PASS |
| `check_successor_fold_definition.sage` | 移動後の次の添字の定義へ戻す | PASS |
| `check_sum_successor.sage` | 可換性を有限和の各項へ代入する | PASS |
| `check_sum_reindex.sage` | 全単射で有限和の添字を変更する | PASS |

プロジェクト直下で `sage sagemath/check/cyclic-shift-adjacent-integer-sum/check.sage` を実行する。


2026-10-03 実行: 添字の 15 行は各 2,678 組、有限和の 2 行は各 5,540 組で通過した。
