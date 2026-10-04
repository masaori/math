# SageMath Check: 破れた辺の双対像の巻き付き偶奇

## 対象

**対象ラベル**: `claim_dual_broken_edges_winding_zero`

- 併せて検証: `def_broken_edge_set`、`def_dual_edge_map`、`def_torus_winding_parities`
- 範囲: 破れた辺集合の双対像の二つの巻き付き偶奇がともに零であること

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---|---|---|---|
| `check.sage` | $L=1,2,3,4$ の全配位について、双対像の境界辺数を元の周期閉路の破れ数へ対応させ、二つの偶奇を厳密検査する | PASS | すべて自明セクター |

## 実行方法

```sh
sage -c "__file__ = 'sagemath/check/dual-broken-edges-winding-zero/check.sage'; load(__file__)"
```

**2026-08-12 実行: すべて通過。**

## 自然数の余りによる各等号の検査

横向き・縦向きの二つの鎖に共通する計算を、長さ一から六の全126個の二値巡回列で一行ずつ検査する。自然数の和と余りだけを使い、剰余類の元との暗黙の同一視をしない。格子の二方向から巡回列へ移す対応は、上記の全配位検査で確認する。

| ファイル | 対応する操作 | 状態 |
|---|---|---|
| `check_binary_encoding.sage` | 二値の四場合による指示関数の符号化 | PASS（4組） |
| `check_encoding_substitution.sage` | 指示関数の等式の代入 | PASS（126列） |
| `check_sum_residues.sage` | 各項の余りと有限和の余り | PASS（126列） |
| `check_sum_distribute.sage` | 有限和の分配 | PASS（126列） |
| `check_cyclic_reindex.sage` | 巡回移動の全単射による再添字付け | PASS（126列） |
| `check_sum_double.sage` | 同じ自然数の和を二倍へ書き換える | PASS（126列） |
| `check_multiple_residue.sage` | 二の倍数の余り | PASS（126列） |

2026-10-04 再実行: 一辺一から四の全66,066配位と、行別7本（符号の4組・各126列）が全て通過した。この環境では上記コマンドを micromamba の SageMath 環境で実行した。
