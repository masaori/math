# SageMath Check: 構成した置換から第二の完全マッチングを復元する

**対象ラベル**: `claim_matching_pair_second_recovery`

要素数 0・2・4・6 の順序付きマッチング対を全列挙し、第一色、第二色、対の族をそれぞれ検算する。有限検算は一般証明の代用ではない。

| ファイル | 本文との対応 | ステータス |
|---|---|---|
| `check_first_color.sage` | 第一色での逆置換による復元 | PASS |
| `check_second_color.sage` | 第二色での置換による復元 | PASS |
| `check_pair_family.sage` | 点ごとの対と対の族の等号 | PASS |
| `check.sage` | 行別検算の統合 | PASS |

実行日: 2026-10-24。SageMath 10.9 で 236 対・1,388 始点について通過。空集合と共有対を含む。
