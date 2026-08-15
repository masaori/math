# SageMath Check: 有理係数の対数順序群の順序は線形順序である

## 対象

**対象ラベル**: `claim_rational_log_order_group_linear_order`

- 実行日: 2026-08-16
- 状態: PASS（216 ベクトル、二元の組 46656 件、三元の組 5062176 件、代表 12 本の三つ組 1728 件）
- 帰属: `ZZ`/`QQ` と素因数分解による厳密計算。浮動小数点は使わない。

## 検査内容

素数 $2,3,5$ の各係数を $-1,-\tfrac12,0,\tfrac13,\tfrac12,\tfrac54$ から選ぶ有限台の有理係数ベクトル
$\lambda,\mu,\nu\in\Lambda_{\mathbb Q}$（零写像を含む）について、`def_rational_log_order_group_order` の決定手続き
$N_\mu\lambda_{N_\lambda}\le_\Lambda N_\lambda\mu_{N_\mu}$ で $\le_{\Lambda_{\mathbb Q}}$ を計算し、
反射律（全ベクトル）、全順序性・反対称律（全ての二元の組）、推移律（全ての三元の組）を検査する。
反対称律の証明が使う「同じ共通分母 $N\le24$ の証人が一致すれば元も一致する」も全ての二元の組で検査する。
さらに代表 12 本の全三つ組で、$N_\lambda N_\mu N_\nu$ が三元すべての共通分母であること
（証人は `claim_common_denominator_multiple` のとおり $N_\mu N_\nu\lambda_{N_\lambda}$ 等）と、
この $N$ における証人の比較が決定手続きの結果と一致すること（定義の言い換え）を検査する。
$\le_\Lambda$ は $\operatorname{rat}_\Lambda$ の値（正の有理数）の比較で計算する。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/rational-log-order-group-linear-order/check.sage
```
