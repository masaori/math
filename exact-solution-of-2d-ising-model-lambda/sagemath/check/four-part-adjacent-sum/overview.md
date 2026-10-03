# SageMath Check: 四部分の循環隣接和の分割

**対象ラベル**: `claim_four_part_adjacent_sum`

本文の等号28行を一行一ファイルで検査する。有限和の区間分割は正の長さ1から8と整数多項式5種の320例、二列の分割は整数ベクトル3種から作る長さ1から4の全列対14,400例、四部分は長さ1から4の各組に対する8通りの整数列2,048例および一項列の全81組で検査する。各部分の長さが一の場合、空の内部和と接合の添字も検査対象に含まれる。

計算は整数の厳密演算のみを使う。循環和は巡回添字で独立に計算する。これらの有限例は一般の長さや座標についての証明ではなく、一般の場合は Lean の具体版・必要十分版と導出版が担う。

2026-10-03、SageMath 10.9 で全28本を実行し、すべて通過した。

| ファイル | 本文の等号 | 状態 | 検査件数 |
|---|---|---|---:|
| `check_interval_split.sage` | 有限和を前半と添字を移した後半へ分割 | PASS | 320 |
| `check_prefix_last_term.sage` | 前半の有限和の末項を取り出す | PASS | 320 |
| `check_prefix_substitution.sage` | 前半の隣接対を元の列へ置換 | PASS | 14,400 |
| `check_prefix_internal.sage` | 前半の有限和を内部和の記号へ戻す | PASS | 14,400 |
| `check_boundary_substitution.sage` | 境界の一項を末項と先頭へ置換 | PASS | 14,400 |
| `check_tail_substitution.sage` | 後半の隣接対を元の列へ置換 | PASS | 14,400 |
| `check_tail_internal.sage` | 後半の有限和を内部和の記号へ戻す | PASS | 14,400 |
| `check_binary_expand.sage` | 連結の内部和を有限和へ展開 | PASS | 14,400 |
| `check_binary_partition.sage` | 連結の内部和を前半・境界・後半へ分割 | PASS | 14,400 |
| `check_binary_prefix.sage` | 分割後の前半だけを置換 | PASS | 14,400 |
| `check_binary_boundary.sage` | 分割後の境界だけを置換 | PASS | 14,400 |
| `check_binary_tail.sage` | 分割後の後半だけを置換 | PASS | 14,400 |
| `check_uv_last.sage` | 二部分の末項 | PASS | 2,129 |
| `check_uvw_last.sage` | 三部分の末項 | PASS | 2,129 |
| `check_z_last.sage` | 四部分の末項 | PASS | 2,129 |
| `check_z_first.sage` | 四部分の先頭を三部分の先頭へ置換 | PASS | 2,129 |
| `check_uvw_first.sage` | 三部分の先頭を二部分の先頭へ置換 | PASS | 2,129 |
| `check_uv_first.sage` | 二部分の先頭を最初の列の先頭へ置換 | PASS | 2,129 |
| `check_four_outer.sage` | 外側の二列分割 | PASS | 2,129 |
| `check_four_middle.sage` | 中間の二列分割 | PASS | 2,129 |
| `check_four_inner.sage` | 内側の二列分割 | PASS | 2,129 |
| `check_four_uv_last.sage` | 二部分の末項を代入 | PASS | 2,129 |
| `check_four_uvw_last.sage` | 三部分の末項を代入 | PASS | 2,129 |
| `check_four_associate.sage` | 加法の結合律で括弧を整理 | PASS | 2,129 |
| `check_cyclic_expand.sage` | 循環する隣接和を内部和と閉じる項へ分割 | PASS | 2,129 |
| `check_cyclic_internal.sage` | 内部和の分割結果を代入 | PASS | 2,129 |
| `check_cyclic_last.sage` | 閉じる項の末歩を代入 | PASS | 2,129 |
| `check_cyclic_first.sage` | 閉じる項の始歩を代入 | PASS | 2,129 |

`construction.sage` は整数列と有限和を定義する。`check.sage` は上表の順に各行を実行する。

プロジェクト直下で実行する。

```sh
micromamba run -p /home/masaori/.local/share/math-mamba/envs/sage sage sagemath/check/four-part-adjacent-sum/check.sage
```

個別実行では末尾を上表のファイル名へ替える。
