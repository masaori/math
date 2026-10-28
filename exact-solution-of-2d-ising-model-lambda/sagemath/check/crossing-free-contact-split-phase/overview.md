# 横断のない閉歩道の接触点分割と回転位相

**対象ラベル**: `claim_crossing_free_contact_split_children`, `claim_crossing_free_contact_split_phase`

| 検証 | 内容 | 状態 |
|---|---|---|
| `check.sage` | 辺長二、長さ八以下の辺が相異なる閉歩道で、横断のない全接触点 960 組を分割し、自己横断、混合横断、交差形式、回転位相の等式を厳密計算で照合 | PASS（2026-10-28） |

一般の辺長の主張は本文の四半辺の場合分けが担う。Lean 二版は後段で扱う。
