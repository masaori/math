# SageMath Check: 構成した置換の軌道は偶数長

**対象ラベル**: `claim_matching_pair_even_orbit`

要素数 0・2・4・6 の順序付き完全マッチング対を全列挙する。有限集合と整数の厳密計算だけを使う。有限検算は一般証明の代用ではない。

| ファイル | 本文の行 | ステータス |
|---|---|---|
| `check_zero.sage` | 零回の反復 | PASS |
| `check_step.sage` | 一歩の反復 | PASS |
| `check_color.sage` | 一歩の色反転 | PASS |
| `check_parity.sage` | 回数の偶奇と色の対応 | PASS |
| `check_length.sage` | 周期・軌道長・偶数性 | PASS |
| `check.sage` | 行別検算の統合 | PASS |

実行日: 2026-10-24。SageMath 10.9 で行別5本は各1,388始点、統合は236対・1,388始点で通過した。空集合と共有対を含む。
