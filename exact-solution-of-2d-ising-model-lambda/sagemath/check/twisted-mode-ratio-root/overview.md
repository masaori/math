# 同じねじれのモード比の検証

**対象ラベル**: `claim_twisted_mode_ratio_root`

横・縦の両方に共通する三段の等式を、辺長 1〜4、二つのねじれ、全てのモード対について `QQbar` の厳密等号で照合する。有限例の検算であり、一般の辺長の証明は本文と Lean が担う。

| ファイル | 状態 | 結果 |
|---|---|---|
| `check-quotient-power.sage` | PASS（2026-10-27） | 全モード対で商の冪法則が成立 |
| `check-common-power.sage` | PASS（2026-10-27） | 全モード対で共通の冪へ置換可能 |
| `check-unit-quotient.sage` | PASS（2026-10-27） | 非零符号の商は 1 |
