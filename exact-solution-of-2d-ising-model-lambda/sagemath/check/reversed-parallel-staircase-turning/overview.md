# SageMath Check: 反転平行階段の循環総回転数零

**対象ラベル**: `claim_reversed_parallel_staircase_turning_zero`

本文の階段の座標式から反転歩を作り、補助列の隣接差、歩の二つの一定区間、平行座標による非後退性、回転表、内部和と閉じる項の相殺を一等号一ファイルで検査する。場合分けを持つ等号は場合ごとに分け、不等号も別ファイルで検査する。併せて `def_winding_parallel_staircase`、`def_winding_parallel_coordinate`、`def_step_turning`、`def_cyclic_total_turning` を照合する。

検査範囲は $L=1,\ldots,5$、$w_{\mathrm h},w_{\mathrm v}\in\{-5,\ldots,5\}$、$(w_{\mathrm h},w_{\mathrm v})\ne(0,0)$ の600例。一方向100例・二方向500例を含み、$n=1$ の空の内部和も検査する。回転表は四方向の全12組の非後退対で照合する。座標・回転数・有限和は `ZZ` にあり、実数と浮動小数点を使わない。この有限検算自体は一般の巻き付き数についての証明ではない。

## 行別の対応

2026-10-03、SageMath 10.9 で以下の全44ファイルを実行し、すべて通過した。

| ファイル | 本文の式ペア・確認対象 | 状態 | 検査件数 |
|---|---|---|---:|
| `check_forward_point_agreement.sage` | 本文の階段と補助列の一致 $G_j=F_j$ | PASS | 10,500 |
| `check_forward_expand_before.sage` | 隣接差の展開 $F_{j+1}-F_j=(j+1)B-jB$（$j<q$） | PASS | 4,950 |
| `check_forward_expand_boundary.sage` | 隣接差の展開 $F_{j+1}-F_j=qB+C-qB$（$j=q$） | PASS | 550 |
| `check_forward_expand_after.sage` | 隣接差を二つの座標式の差へ展開（$j>q$） | PASS | 4,400 |
| `check_forward_reduce_before.sage` | $(j+1)B-jB=((j+1)-j)B$ | PASS | 4,950 |
| `check_forward_reduce_boundary.sage` | $qB+C-qB=C$ | PASS | 550 |
| `check_forward_reduce_after.sage` | 二つの座標式の差を $((j+1-q)-(j-q))C$ へ整理 | PASS | 4,400 |
| `check_forward_unit_before.sage` | $((j+1)-j)B=B$ | PASS | 4,950 |
| `check_forward_unit_boundary.sage` | 隣接差の最後の行で境界の値 $C$ を保つ | PASS | 550 |
| `check_forward_unit_after.sage` | $((j+1-q)-(j-q))C=C$ | PASS | 4,400 |
| `check_reversed_difference_negate.sage` | $u_s=-(G_{n-s}-G_{n-1-s})$ | PASS | 9,900 |
| `check_reversed_difference_forward_before.sage` | 反転した差を $-B$ へ置換（$n-1-s<q$） | PASS | 4,950 |
| `check_reversed_difference_forward_after.sage` | 反転した差を $-C$ へ置換（$n-1-s\ge q$） | PASS | 4,950 |
| `check_reversed_difference_blocks_first.sage` | 添字の条件と符号を代入して $u_s=a$（$s<p$） | PASS | 4,950 |
| `check_reversed_difference_blocks_last.sage` | 添字の条件と符号を代入して $u_s=b$（$s\ge p$） | PASS | 4,950 |
| `check_step_positive_first.sage` | $A>0$ の最初の $LV$ 歩を座標式から直接確認 | PASS | 2,250 |
| `check_step_positive_second.sage` | $A>0$ の残りの $LH$ 歩を座標式から直接確認 | PASS | 2,250 |
| `check_step_nonpositive_first.sage` | $A\le0$ の最初の $LH$ 歩を座標式から直接確認 | PASS | 2,700 |
| `check_step_nonpositive_second.sage` | $A\le0$ の残りの $LV$ 歩を座標式から直接確認 | PASS | 2,700 |
| `check_parallel_coordinate_difference.sage` | $\pi_\gamma(u_s)=\pi_\gamma(G_{n-1-s})-\pi_\gamma(G_{n-s})$ | PASS | 9,900 |
| `check_parallel_coordinate_negative.sage` | $\pi_\gamma(G_{n-1-s})-\pi_\gamma(G_{n-s})<0$ | PASS | 9,900 |
| `check_opposite_coordinate_substitution.sage` | 仮定 $u_t=-u_s$ から $\pi_\gamma(u_t)=\pi_\gamma(-u_s)$ への代入だけを検査 | PASS | 9,900 |
| `check_opposite_coordinate_negation.sage` | $\pi_\gamma(-u_s)=-\pi_\gamma(u_s)$ | PASS | 9,900 |
| `check_opposite_coordinate_positive.sage` | $-\pi_\gamma(u_s)>0$ | PASS | 9,900 |
| `check_turn_case_straight.sage` | $\vartheta(u,u)=0$ の有限方向照合 | PASS | 4 |
| `check_turn_case_positive.sage` | $\vartheta(u,(u_2,-u_1))=1$ の有限方向照合 | PASS | 4 |
| `check_turn_case_negative.sage` | $\vartheta(u,(-u_2,u_1))=-1$ の有限方向照合 | PASS | 4 |
| `check_turn_table.sage` | $\vartheta(u,v)=\tau(u,v)$ を方向番号の差と照合 | PASS | 12 |
| `check_cyclic_decomposition.sage` | $t_\circ(R)$ を内部和と末歩から始歩への項へ分割 | PASS | 600 |
| `check_same_direction_expansion.sage` | $\vartheta(a,a)=a_2a_1-a_1a_2$ | PASS | 4 |
| `check_same_direction_reduction.sage` | $a_2a_1-a_1a_2=0$ | PASS | 4 |
| `check_one_direction_constant.sage` | 一方向の場合の $t_\circ(R)=\sum\vartheta(d,d)+\vartheta(d,d)$ | PASS | 100 |
| `check_one_direction_zero_terms.sage` | $\sum\vartheta(d,d)+\vartheta(d,d)=\sum0+0$ | PASS | 100 |
| `check_one_direction_zero_sum.sage` | $\sum0+0=0$ | PASS | 100 |
| `check_two_direction_internal.sage` | 唯一の内部接合から $\sum\vartheta(u_s,u_{s+1})=\vartheta(a,b)$ | PASS | 500 |
| `check_two_direction_closing.sage` | $\vartheta(u_{n-1},u_0)=\vartheta(b,a)$ | PASS | 500 |
| `check_swapped_expansion.sage` | $\vartheta(b,a)=b_2a_1-b_1a_2$ | PASS | 12 |
| `check_swapped_commutation.sage` | $b_2a_1-b_1a_2=a_1b_2-a_2b_1$ | PASS | 12 |
| `check_swapped_negation.sage` | $a_1b_2-a_2b_1=-(a_2b_1-a_1b_2)$ | PASS | 12 |
| `check_swapped_fold.sage` | $-(a_2b_1-a_1b_2)=-\vartheta(a,b)$ | PASS | 12 |
| `check_two_direction_total_junctions.sage` | $t_\circ(R)=\vartheta(a,b)+\vartheta(b,a)$ | PASS | 500 |
| `check_two_direction_total_subtract.sage` | $\vartheta(a,b)+\vartheta(b,a)=\vartheta(a,b)-\vartheta(a,b)$ | PASS | 500 |
| `check_two_direction_total_zero.sage` | $\vartheta(a,b)-\vartheta(a,b)=0$ | PASS | 500 |
| `check_cyclic_zero.sage` | 方向番号による循環総回転数 $t_\circ(R)=0$ を直接確認 | PASS | 600 |

`construction.sage` は整数による構成だけを持つ。`check.sage` は上表の順に行別検算を実行する。

## 実行方法

プロジェクト直下から一括実行する。

```sh
micromamba run -p /home/masaori/.local/share/math-mamba/envs/sage sage sagemath/check/reversed-parallel-staircase-turning/check.sage
```

個別に実行する場合は、末尾を上表の `check_*.sage` に替える。

## 実行時エラーの記録

2026-10-03 の初回実行は、SageMath 10.9 のファイル実行時に `__file__` が対象の検算を指さず、`construction.sage` の読み込み先を誤って ERROR になった。数学の assertion に到達する前のエラーである。検算の基準は変えず、元のファイル引数 `sys.argv[0]` から読み込み先を取るように修正し、上記の通常ファイル実行で全44本を再実行した。
