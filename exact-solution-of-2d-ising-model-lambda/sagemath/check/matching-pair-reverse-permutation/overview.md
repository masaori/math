# SageMath Check: マッチング対を経た置換の再構成

**対象ラベル**: `claim_matching_pair_reverse_permutation`

要素数 0・2・4・6 の全軌道長が偶数の置換を使い、第一色と第二色の各分岐で復元した写像の値を元の置換と比較する。整数と有限集合の厳密演算のみを使う。

| ファイル | 本文との対応 | ステータス |
|---|---|---|
| `check_first_color.sage` | 第一色では第一の相手が元の置換である | PASS |
| `check_second_color.sage` | 第二色では第二の相手が元の置換である | PASS |
| `check.sage` | 二場合を合わせた置換の一致 | PASS |

実数体への脱出はない。
実行日: 2026-10-24。SageMath 10.9 で 1,388 始点について通過。
