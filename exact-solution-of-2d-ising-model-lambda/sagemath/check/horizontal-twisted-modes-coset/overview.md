# 横方向のねじれたモード集合の剰余類表示

**対象ラベル**: `claim_horizontal_twisted_modes_coset`

辺長 1〜6 の冪根を `QQbar` の厳密等号で照合する。一般の辺長の証明は本文と Lean が担う。

| ファイル | 検証内容 | ステータス | 結果 |
|---|---|---|---|
| `check_periodic_conditions.sage` | 周期条件と冪根集合 | PASS | 2026-10-27、辺長 1〜6 で一致 |
| `check_inverse_power.sage` | 逆元の指数法則 | PASS | 2026-10-27、辺長 1〜6 で一致 |
| `check_inverse_root.sage` | 逆向き包含の冪根条件への代入 | PASS | 2026-10-27、辺長 1〜6 で一致 |
| `check_inverse_simplification.sage` | 逆向き包含の定数計算 | PASS | 2026-10-27、厳密等号で一致 |
| `check_inverse_recovery.sage` | 証人からの元の復元 | PASS | 2026-10-27、辺長 1〜6 で一致 |
| `check_forward_power.sage` | 順向き包含の指数法則 | PASS | 2026-10-27、辺長 1〜6 で一致 |
| `check_forward_substitution.sage` | 順向き包含の冪根条件への代入 | PASS | 2026-10-27、辺長 1〜6 で一致 |
| `check_forward_simplification.sage` | 順向き包含の定数計算 | PASS | 2026-10-27、厳密等号で一致 |
