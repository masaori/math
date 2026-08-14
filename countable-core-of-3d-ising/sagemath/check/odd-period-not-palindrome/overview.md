# SageMath Check: 奇数周期では多重度が回文でない

**対象ラベル**: `claim_periodic_not_palindrome`

本文の周期族の定義と、奇数周期の反例を構成する証明の各段を確かめる。
すべて `ZZ` と有限集合の全数列挙による厳密計算であり、浮動小数点は使わない。

| 確かめた段 | 本文のラベル | 方法 | ステータス |
| --- | --- | --- | --- |
| 定数配位は周期辺を破らない | `claim_periodic_constant_unbroken` | $L=1,3,5$ の定数配位 | PASS |
| 一周の辺積はスピン積の二乗になる | `claim_periodic_no_all_broken` | $L=1,3,5$ の一周上の全 $2^L$ 配位 | PASS |
| 奇数周期では全辺を破る配位が無い | `claim_periodic_no_all_broken` | $L=1,3,5$ の一周上の全 $2^L$ 配位 | PASS |
| 奇数周期で多重度が回文でない | `claim_periodic_not_palindrome` | $L=1$ の周期箱の全 $2$ 配位 | PASS |
| 偶数周期では回文性が保たれる校正 | `claim_periodic_not_palindrome` | $L=2$ の周期箱の全 $2^8$ 配位 | PASS |

箱の選び方：$L=1$ は周期端点が始点自身へ戻る最小の奇数周期で、周期箱の全配位を列挙して
$\Omega^{\mathrm{per}}_1(0)=2$ と $\Omega^{\mathrm{per}}_1(\#E^{\mathrm{per}}_1)=0$ を直接比較できる。
$L=3,5$ は自己辺を持たない奇数周期について、本文が使う方向 1 の一周を全数列挙する。
$L=2$ は最小の非自明な偶数周期で、周期箱の全配位を列挙し、奇数と偶数の差を校正する。

```sh
sage sagemath/check/odd-period-not-palindrome/check.sage
```

**2026-08-14 実行: すべて通過。**
