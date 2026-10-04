# 反転置換行列の二乗

**対象ラベル**: `claim_reversal_matrix_square`

定義 `def_reversal_matrix` も併せて検査する。

本文の零項の二行と主鎖の八行を、隣接する式の対ごとに一ファイルへ分ける。辺長一から五の向き付き辺を本文どおり辺番号と向きの対として列挙し、整数環 `ZZ` で計算する。

| ファイル | 式の対 | 状態 | 結果 |
|---|---|---|---|
| `check_off_support_entry.sage` | `J[e,g]J[g,f]=0 J[g,f]` | PASS | 1297296 組 |
| `check_off_support_zero.sage` | `0 J[g,f]=0` | PASS | 1297296 組 |
| `check_product_definition.sage` | `(J^2)[e,f]=sum_g J[e,g]J[g,f]` | PASS | 15664 組 |
| `check_sum_single.sage` | `sum_g J[e,g]J[g,f]=J[e,iota(e)]J[iota(e),f]` | PASS | 15664 組 |
| `check_selected_entry.sage` | `J[e,iota(e)]J[iota(e),f]=1 J[iota(e),f]` | PASS | 15664 組 |
| `check_unit_product.sage` | `1 J[iota(e),f]=J[iota(e),f]` | PASS | 15664 組 |
| `check_reversal_entry.sage` | `J[iota(e),f]=[f=iota(iota(e))]` | PASS | 15664 組 |
| `check_involution.sage` | `[f=iota(iota(e))]=[f=e]` | PASS | 15664 組 |
| `check_equality_symmetry.sage` | `[f=e]=[e=f]` | PASS | 15664 組 |
| `check_identity_definition.sage` | `[e=f]=I[e,f]` | PASS | 15664 組 |
| `check.sage` | SageMath の整数行列積による二乗と単位行列の比較、各行・各列の和 | PASS | 全15,664成分 |

有限サイズの検算であり、任意の辺長についての証明は本文と Lean が担う。浮動小数点、実数体、複素数体を使わない。

実行はプロジェクト直下から `sage -c "load('sagemath/check/reversal-matrix-square/check.sage')"`。行別ファイルも同じ方法で個別に実行できる。

2026-10-04、SageMath 10.9 で全11本が通過。零項の行別2本は各1,297,296組、主鎖の行別8本は各15,664組を検算した。独立した整数行列の積と単位行列の比較も辺長一から五の全15,664成分で一致した。
