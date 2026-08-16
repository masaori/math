# SageMath Check: Archimedes 性の倍率以上の自然数で割れば上界を超えない

## 対象

**対象ラベル**: `claim_rational_log_order_group_div_ge_multiplier_le`

- 実行日: 2026-08-17
- 状態: PASS（素数 $2,3,5$ の係数 4 通りの 64 ベクトルから、非負の $\varepsilon$ 38 個、$\mu$ 64 個、$n\in\{0,1,2,3\}$、$a\in\{1,\dots,5\}$ のうち仮定 $\mu\le n\varepsilon$、$n\le a$ を満たす 28491 組で主張と鎖の五段、$n\le a$ を外すと主張が落ちる例 878 組。数秒）
- 帰属: `QQ` と素因数分解による厳密計算。浮動小数点は使わない。

## 検査内容

分配関数は要らない（主張は $\Lambda_{\mathbb Q}$ の順序と有理数倍だけ）。仮定 $0\le\varepsilon$、$\mu\le n\cdot\varepsilon$、$a\ge1$、$n\le a$ を満たす組で:
主張 $\frac1a\cdot\mu\le\varepsilon$（`def_rational_log_order_group_order` の決定手続きで判定）、
準備（$0\le\frac1a$、$\frac na\le1$。$\mathbb Q$ の順序）、
第一段（$\frac1a\mu\le\frac1a(n\varepsilon)$。`claim_rational_log_order_group_nonneg_scalar_monotone`）、
第二段（$\frac1a(n\varepsilon)=(\frac1a n)\varepsilon$。有理数倍の結合則）、
第三段（$\frac1a n=\frac na$。$\mathbb Q$ の四則）、
第四段（$\frac na\varepsilon\le1\cdot\varepsilon$。`claim_rational_log_order_group_scalar_compare_nonneg`）、
第五段（$1\cdot\varepsilon=\varepsilon$）。
$n\le a$ を外した組では主張が落ちる例が実在することも数える（仮定が余計でないことの確認）。

## 実行

```sh
sage sagemath/check/rational-log-order-group-div-ge-multiplier-le/check.sage
```
