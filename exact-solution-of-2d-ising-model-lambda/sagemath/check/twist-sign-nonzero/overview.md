# SageMath Check: 短い対のねじれ符号の非零性

**対象ラベル**: `claim_twist_sign_nonzero`

## 検査内容

| ファイル | 検証内容 | 状態 | 結果 |
|---|---|---|---|
| `check_sign_from_parity_zero.sage` | 偶数の指数で符号は零乗と一致 | PASS | 16 通りのうち偶数の場合 |
| `check_zero_power.sage` | 負の一の零乗は一 | PASS | 厳密な整数等号 |
| `check_sign_from_parity_one.sage` | 奇数の指数で符号は一乗と一致 | PASS | 16 通りのうち奇数の場合 |
| `check_one_power.sage` | 負の一の一乗は負の一 | PASS | 厳密な整数等号 |
| `check_constant_embedding.sage` | 正負の一の定数多項式は零でない | PASS | 2 通りとも非零 |

2026-10-25 に実行した。整数、`QQbar`、`QQbar[x]` の厳密計算だけを使う。実数体への脱出はない。

## 実行方法

```sh
sage sagemath/check/twist-sign-nonzero/check.sage
```
