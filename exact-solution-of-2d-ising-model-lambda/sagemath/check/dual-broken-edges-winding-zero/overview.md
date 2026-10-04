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
sage sagemath/check/dual-broken-edges-winding-zero/check.sage
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

## 双対辺から自然数の巡回和への各等号

本文の二方向を、辺長一から三の全530配位で検算する。双対写像から作った逆写像と座標を戻す式を独立に比較し、原像の指示子と端点の代入は各辺でも確かめる。和の偶奇がたまたま一致するだけの検査にしない。

| ファイル | 対応する操作 | 状態 |
|---|---|---|
| `check_winding_definition.sage` | 巻き付き偶奇の定義を境界辺の指示子の和へ開く | PASS（1,060方向） |
| `check_dual_preimage_indicator.sage` | 双対像への所属を唯一の原像への所属へ移す | PASS（3,140辺・1,060和） |
| `check_dual_inverse_coordinates.sage` | 逆写像に境界辺の座標を代入する | PASS（3,140辺・1,060和） |
| `check_primal_cyclic_reindex.sage` | 一つ戻す巡回置換で破れ辺の和を再添字付けする | PASS（1,060方向） |
| `check_edge_encoding_substitution.sage` | 原格子の破れ指示子に二値符号化を代入する | PASS（3,140辺・1,060和） |
| `check_endpoint_substitution.sage` | 辺の端点を行・列の座標に代入する | PASS（3,140辺・1,060和） |

2026-10-04 実行: 追加六本、既存の自然数の行別七本、辺長一から四の全66,066配位の統合検査が全て通過した。追加六本は `check_lines.sage` からも単独でも実行できる。検算は全て厳密な整数計算である。

同日の単独起動の初回は、Sage CLI の `__file__` が対象ファイルでなく `sage/all.py` を指したため、補助ファイルの読込で ERROR になった。直接起動時は `sys.argv[0]`、`load` 起動時は明示した `__file__` から対象ディレクトリを得るよう直し、`sage check_lines.sage` で行別13本の PASS、`sage check.sage` で全66,066配位と行別13本の PASS を確認した。
