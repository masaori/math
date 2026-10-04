# 一側閉包の平行帰路の反復

**対象ラベル**: `claim_one_sided_parallel_return_repetition`

本文の整数除法の二場合と各等号を、整数格子上で個別に検査する。辺長一から三、各巻き付き成分が負の三から三（同時に零を除く）の144組、二つの平行移動、周期数一から四を使う。周期長一・片方の巻き付きが零・全ての符号・最終歩を含む。一般の場合は Lean 二版が保証する。

| ファイル | 対応する操作 | 状態 |
|---|---|---|
| `check_inside_substitute_index.sage` | i+1=(an+b)+1 | PASS（17280例） |
| `check_inside_reassociate.sage` | (an+b)+1=an+(b+1) | PASS（17280例） |
| `check_inside_quotient.sage` | 商は a | PASS（17280例） |
| `check_inside_remainder.sage` | 余りは b+1 | PASS（17280例） |
| `check_inside_expand.sage` | 第三部分の点を展開 | PASS（17280例） |
| `check_inside_cancel.sage` | 共通の加数を消す | PASS（17280例） |
| `check_inside_negate.sage` | 隣接差の符号反転 | PASS（17280例） |
| `check_inside_step.sage` | 符号反転歩の定義 | PASS（17280例） |
| `check_seam_substitute_index.sage` | i+1=(an+b)+1 | PASS（2880例） |
| `check_seam_reassociate.sage` | 加法の結合則 | PASS（2880例） |
| `check_seam_substitute_remainder.sage` | b+1=n の代入 | PASS（2880例） |
| `check_seam_factor.sage` | 分配則 | PASS（2880例） |
| `check_seam_quotient.sage` | 商は a+1 | PASS（2880例） |
| `check_seam_remainder.sage` | 余りは零 | PASS（2880例） |
| `check_seam_expand.sage` | 第三部分の点を展開 | PASS（2880例） |
| `check_seam_zero.sage` | 階段の始点は零 | PASS（2880例） |
| `check_seam_collect.sage` | 整数倍の係数をまとめる | PASS（2880例） |
| `check_seam_coefficient.sage` | 係数は負の一 | PASS（2880例） |
| `check_seam_negate.sage` | 隣接差の符号反転 | PASS（2880例） |
| `check_seam_endpoint.sage` | 階段の終点は周期ベクトル | PASS（2880例） |
| `check_seam_last_index.sage` | n=b+1 の代入 | PASS（2880例） |
| `check_seam_step.sage` | 符号反転歩の定義 | PASS（2880例） |
| `check_repetition.sage` | 有限の歩ベクトル列は c 回の連結 | PASS（1152例） |

実行日: 2026-10-04。`check.sage` で全23本が通過した。浮動小数・実数への脱出はない。
