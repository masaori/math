# SageMath Check: 整数冪の実対数は整数倍である

## 対象

**対象ラベル**: `claim_real_logarithm_int_power`

- 実行日: 2026-08-17
- 状態: PASS（正の有理数 9 個 × 整数冪 $k\in[-8,8]$、1246 検査。約 3 秒）
- 帰属: `QQ` 上の多項式環による厳密計算。不定元 $\ell_p$ は素数 $p$ の実対数
  $\log_{\mathbb R}(\iota_{\mathbb Q\to\mathbb R}(p))$ を表す**記号**であり、実対数の値は計算しない。
  主張の証明が $\log_{\mathbb R}$ について使うのは「乗法を加法へ移す」だけなので、
  正の有理数 $u=\prod p^{e_p}$ に $L(u):=\sum e_p\ell_p$ を対応させる写像（乗法を加法へ移す。
  検査の冒頭でこの性質を確かめる）を実対数の模型とし、証明の各段を記号のまま確かめる。
  実数体そのものの上での等式は Lean（`realLog_zpow`）が担う。浮動小数点は使わない。

## 検査内容

`claim_real_logarithm_int_power` の証明の各段を、模型 $L$ の上で一行ずつ確かめる。

- 準備 $\log_{\mathbb R}(1)=0$（$1=1\cdot1$、乗法を加法へ、移項）。
- 自然数冪の帰納法（$n=0$ の三段、$n\to n+1$ の五段を $n\le7$ で）。
- 逆数 $\log_{\mathbb R}(v^{-1})=-\log_{\mathbb R}(v)$（三段と移項）。
- $k<0$ の六段（整数冪の定義・逆数・帰納法・$-(st)=(-s)t$・$\iota(-r)=-\iota(r)$・$k=-(n+1)$）と結論。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/real-logarithm-int-power/check.sage
```
