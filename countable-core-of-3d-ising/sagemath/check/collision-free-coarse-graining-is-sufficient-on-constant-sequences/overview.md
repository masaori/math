# SageMath Check: 衝突を持たない粗視化は定数列の箱サイズ極限に十分である

**対象ラベル**: `claim_collision_free_coarse_graining_is_sufficient_on_constant_sequences`

本文の有限側の各段を、衝突を持たない粗視化の具体例として恒等写像と
正の有理数の素指数データを用いて確かめる。

| 確かめた段 | 方法 | ステータス |
| --- | --- | --- |
| 粗視化の値の一致から元の値の一致が従うこと | `QQ` の厳密比較と素因数分解の一意性 | PASS |
| 定数列の三つの値が要求された集合に属すること | `QQ_{>0}` と `ZZ_{\ge1}` の帰属を各添字で確認 | PASS |
| $M(L)=1$ の乗根列が元の定数列に等しいこと | `QQ` の冪の厳密比較 | PASS |
| 各候補値との差が全添字で $0$ であること | `QQ` の厳密比較 | PASS |
| 値の衝突を持つ写像では逆向きが破れること | $1$ と $2$ を一点へ潰す写像で確認 | PASS |

極限の存在そのものは箱の大きさの極限を使う実数側の言明なので有限検査の対象外である。
浮動小数点、実対数、指数関数、無限和、級数、積分、微分は使わない。

```sh
sage sagemath/check/collision-free-coarse-graining-is-sufficient-on-constant-sequences/check.sage
```

**2026-08-23 実行: すべて通過。**
