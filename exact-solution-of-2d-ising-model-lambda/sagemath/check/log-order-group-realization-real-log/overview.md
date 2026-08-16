# SageMath Check: 対数順序群の元の実現は対応する正の有理数の実対数である

## 対象

**対象ラベル**: `claim_log_order_group_realization_real_log`

- 実行日: 2026-08-17
- 状態: PASS（$\Lambda$ の元 470 個（6 素数、指数 $[-3,3]$ と $[-2,2]$ の 3 素数ずつの組と端の例）、
  有限積の実対数の帰納法は正の有理数 9 個の部分集合（元の個数 3 まで）で、10724 検査。約 4 秒）
- 帰属: `QQ` 上の多項式環による厳密計算。不定元 $\ell_p$ は素数 $p$ の実対数
  $\log_{\mathbb R}(\iota_{\mathbb Q\to\mathbb R}(p))$ を表す**記号**であり、実対数の値は計算しない。
  主張の証明が $\log_{\mathbb R}$ について使うのは「乗法を加法へ移す」（とそれから出した整数冪の実対数）
  だけなので、正の有理数 $u=\prod p^{e_p}$ に $L(u):=\sum e_p\ell_p$ を対応させる写像を実対数の模型、
  $\rho(\mu):=\sum_{p\in\operatorname{supp}\mu}\mu(p)\ell_p$ を実現写像の模型とし、
  $\iota_{\mathbb Q\to\mathbb R}$ は模型では恒等として、証明の各段を記号のまま確かめる。
  実数体そのものの上での等式は Lean（`realizeRational_toRational`）が担う。浮動小数点は使わない。

## 検査内容

`claim_log_order_group_realization_real_log` の証明の準備と一続きの鎖を、模型の上で一行ずつ確かめる。

- 準備の第一 $\operatorname{supp}(\iota_{\Lambda\to\Lambda_{\mathbb Q}}(\lambda))=\operatorname{supp}(\lambda)$。
- 準備の第二（$\iota$ が整数冪・有限積を保つ。模型では恒等なので同じ有理数であることの検査）。
- 準備の第三（有限積の実対数は和。空集合の五段と $S\cup\{p_0\}$ の四段）。
- 一続きの鎖の八段（定義・台の一致・$\iota_{\Lambda\to\Lambda_{\mathbb Q}}$ の定義・整数冪の実対数・
  $\iota$ が整数冪を保つ・有限積の実対数は和・$\iota$ が有限積を保つ・$\operatorname{rat}_\Lambda$ の定義）と結論。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/log-order-group-realization-real-log/check.sage
```
