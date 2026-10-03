# SageMath Check: 反復有限列の内部隣接和の増分

**対象ラベル**: `claim_repeated_adjacent_sum_difference`

本文の等号23行と、連結の前半を述べる文中の等号1行を、一行一ファイルで検査する。
四つの整数ベクトルからなる長さ1から4の全340列と、長さ5から12の各8列を使う。
各列を1から6回反復する2,424組を全ファイルで検査し、長さ一の空和も含める。
周期性は0から5周期と一周期を越える添字、連結は境界の前後を検査する。

計算は整数の厳密演算のみを使う。循環和は巡回添字の有限和として独立に計算する。
有限例から一般の場合を推論せず、一般の長さと反復数は Lean の具体版・必要十分版と導出版で証明する。

2026-10-03、SageMath 10.9 で24本を実行し、各2,424組の検査がすべて通過した。

| ファイル | 本文の等号 | 状態 | 検査した組数 |
|---|---|---|---:|
| `check_period_definition.sage` | 周期性の式で反復列を展開 | PASS | 2,424 |
| `check_period_remainder.sage` | 周期数の倍数を余りから除く | PASS | 2,424 |
| `check_period_fold.sage` | 余りの式を反復列へ戻す | PASS | 2,424 |
| `check_first_definition.sage` | 先頭の反復列を展開 | PASS | 2,424 |
| `check_first_remainder.sage` | 先頭の余りを零へ置換 | PASS | 2,424 |
| `check_last_index.sage` | 末項の添字を前周期と最後の位置へ分ける | PASS | 2,424 |
| `check_last_period.sage` | 末項から前周期を除く | PASS | 2,424 |
| `check_last_remainder.sage` | 末項の反復列を元の列へ戻す | PASS | 2,424 |
| `check_join_prefix.sage` | 連結の前半は元の反復列に等しい | PASS | 2,424 |
| `check_join_definition.sage` | 連結の後半を展開 | PASS | 2,424 |
| `check_join_period.sage` | 後半の添字へ周期分を加える | PASS | 2,424 |
| `check_join_index.sage` | 後半の添字を元に戻す | PASS | 2,424 |
| `check_base_expand.sage` | 一周期の内部和を展開 | PASS | 2,424 |
| `check_base_substitute.sage` | 一周期の隣接項を元の列へ置換 | PASS | 2,424 |
| `check_base_fold.sage` | 有限和を元の列の内部和へ戻す | PASS | 2,424 |
| `check_difference_length.sage` | 追加した一周期を長さの和へ書き換える | PASS | 2,424 |
| `check_difference_join.sage` | 反復列を同じ列の連結へ置換 | PASS | 2,424 |
| `check_difference_split.sage` | 二列の内部和と接合へ分割 | PASS | 2,424 |
| `check_difference_last.sage` | 接合の末項を置換 | PASS | 2,424 |
| `check_difference_first.sage` | 接合の先頭を置換 | PASS | 2,424 |
| `check_difference_base.sage` | 一周期の内部和を置換 | PASS | 2,424 |
| `check_difference_cancel.sage` | 共通の内部和を消す | PASS | 2,424 |
| `check_difference_commute.sage` | 加法の交換律で一周期の内部和を前へ移す | PASS | 2,424 |
| `check_difference_cyclic.sage` | 内部和と閉じる接合を循環隣接和へ戻す | PASS | 2,424 |

`construction.sage` は有限列、整数の重み、内部和、循環和を定義する。
`check.sage` は上表の順に各行を実行する。プロジェクト直下で実行する。

```sh
micromamba run -p /home/masaori/.local/share/math-mamba/envs/sage sage sagemath/check/repeated-adjacent-sum/check.sage
```
