# SageMath Check: 素指数を大きさで切り詰める粗視化は箱サイズ極限の一致に十分でない

**対象ラベル**: `claim_magnitude_truncated_prime_exponents_are_not_sufficient_for_limit_quantity`

素指数データ（`def_positive_rational_prime_exponent_data`）を、素数は残したまま各成分の値を
高さ $N$ で切り詰める粗視化（$v_p \mapsto \min\{v_p, N\}$）が、箱サイズ極限に対して十分でない
ことを示す反例を、本文と同じ列で確認する。切り詰めの高さ $N$ を変えても同じ形の反例が
作れることを、いくつかの高さについて追う。

| 確かめた段 | 方法 | ステータス |
| --- | --- | --- |
| 素数 $2$ での素指数が $N$ と $N+1$ で一致しないこと（切り詰めで落ちる情報の所在） | `QQ` の付値を厳密比較 | PASS |
| 素数 $2$ での切り詰めた値が一致すること | `ZZ` の最小値を厳密比較 | PASS |
| $2$ 以外の素数では素指数も切り詰めた値もともに $0$ であること | `QQ` の付値と `ZZ` の最小値を厳密比較 | PASS |
| $a$ が定数列で候補値 $2^N$ との差が $0$ であること | 各添字で `QQ` の厳密比較 | PASS |
| $b$ が定数列で候補値 $2^{N+1}$ との差が $0$ であること | 各添字で `QQ` の厳密比較 | PASS |
| 二つの候補値を同時に近づけられないこと | 有理な候補値ごとに幅 $1/2$ での両立不能を厳密比較 | PASS |

極限の存在と値そのものは箱の大きさの極限を使う実数側の言明なので有限検査の対象外である。
浮動小数点、実対数、指数関数、無限和、級数、積分、微分は使わない。

```sh
sage sagemath/check/magnitude-truncated-prime-exponents-are-not-sufficient-for-limit-quantity/check.sage
```

**2026-08-23 実行: すべて通過。**
