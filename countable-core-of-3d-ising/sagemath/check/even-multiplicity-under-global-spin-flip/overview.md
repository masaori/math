# SageMath Check: 全スピン反転による多重度の偶数性

**対象ラベル**: `claim_even_multiplicity`

本文の証明を、小さい箱の全配位について一段ずつ検証する。有限集合と `ZZ` の厳密計算だけを使い、
浮動小数点および非可算への脱出は使わない。

| 確かめた段 | 本文のラベル | 方法 |
| --- | --- | --- |
| 全スピン反転を二回適用すると元の配位へ戻る | `def_global_spin_flip` | $L=1,2$ の全配位 |
| 全スピン反転が破れ辺集合と破れ数を保つ | `def_broken_count`・`def_global_spin_flip` | $L=1,2$ の全配位・全内部辺 |
| 原点の値が変わるため不動点を持たない | `def_global_spin_flip` | $L=1,2$ の全配位 |
| 各破れ数の水準集合が互いに交わらない二元軌道へ分割される | `def_multiplicity` | $L=1,2$ の全水準集合 |
| 各多重度が $2$ と自然数の積になる | `claim_even_multiplicity` | $L=1,2$ の全水準集合 |

箱の一辺を $1$ と $2$ に固定する。$L=1$ は辺が無い縮退した場合、$L=2$ は三方向の内部辺を持つ
最小の場合であり、全 $2^8$ 配位を列挙する。

```sh
sage sagemath/check/even-multiplicity-under-global-spin-flip/check.sage
```

**2026-08-15 実行: すべて通過。**
