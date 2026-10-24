# SageMath Check: 構成した置換の軌道と二歩軌道の合併

**対象ラベル**: `claim_matching_pair_reconstructed_orbit`

要素数 0・2・4・6 の順序付き完全マッチング対を全列挙し、整数と有限集合だけで検算する。有限検算は一般証明の代用ではない。

| ファイル | 本文との対応 | ステータス |
|---|---|---|
| `check_two_steps.sage` | 色反転と二歩の写像 | PASS |
| `check_component_closed.sage` | 合併の二つの相手写像での閉性 | PASS |
| `check_inclusions.sage` | 軌道と合併の両包含 | PASS |
| `check.sage` | 行別検算の統合 | PASS |

実行日: 2026-10-24。SageMath 10.9 で236対・1,388始点について通過。空集合と共有対を含む。
