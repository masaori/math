# 同方向の双対内積の検証

**対象ラベル**: `claim_same_direction_dual_inner_orthogonality`

辺長 1〜4、四つのねじれ、全方向、全モード対を `QQbar` の厳密等号で照合する。有限例の検算であり、一般の辺長の証明は本文と Lean が担う。

| ファイル | 状態 | 結果 |
|---|---|---|
| `check-reindex.sage` | PASS（2026-10-27） | 終点による再添字付け |
| `check-ratio-powers.sage` | PASS（2026-10-27） | モード比の冪 |
| `check-factor-sums.sage` | PASS（2026-10-27） | 代表の再添字付けと有限和の分配 |
| `check-orthogonality.sage` | PASS（2026-10-27） | 等比和の二場合と積 |
