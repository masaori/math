# SageMath Check: 有理係数の対数順序群の列が定める下組・下組は下に閉じている

## 対象

**対象ラベル**: `def_rational_log_order_group_sequence_lower_set`, `claim_rational_log_order_group_sequence_lower_set_downward_closed`

- 実行日: 2026-08-17
- 状態: PASS（125 ベクトル、$\mu'\le\mu$ を満たすもの 77 件、満たさないもの 48 件、非所属の証人候補 265 組、$L$ は 40 まで。4 秒）
- 帰属: `ZZ`/`QQ` と素因数分解による厳密計算。浮動小数点は使わない。

## 検査内容

列 $\lambda_L:=\iota(\ell_2)+\tfrac1L\cdot\iota(\ell_3)$（$L\ge1$）を取り、`def_rational_log_order_group_sequence_lower_set` の
所属を証人 $(\varepsilon,N)$ について検査する。「$N\le L$ を満たすすべての $L$」は有限範囲 $N\le L\le40$ で検査する
（全称そのものは証明で示す事柄であり、有限回の計算では確かめられない）。

- 所属する例: $\mu:=\iota(\ell_2)+\bigl(-\tfrac12\iota(\ell_3)\bigr)$、$\varepsilon:=\tfrac12\iota(\ell_3)$、$N:=1$
  （$\mu+\varepsilon=\iota(\ell_2)\le\lambda_L$）。
- 所属しない例: $\mu:=\iota(\ell_2)+\iota(\ell_3)$。素数 $2,3,5$ の係数を $-1,-\tfrac12,0,\tfrac13,\tfrac34$ から選ぶ
  正の $\varepsilon$ と $N\in\{1,\dots,5\}$ のすべてで、$\mu+\varepsilon\le\lambda_L$ が範囲内のどこかで落ちる。
- 主張（下に閉じている）: 上の $\mu$ と同じ台の 125 ベクトル $\mu'$ のうち $\mu'\le_{\Lambda_{\mathbb Q}}\mu$ を満たす
  77 件について、同じ証人 $(\varepsilon,N)$ で $\mu'$ が所属すること、および証明の二段
  $\mu'+\varepsilon\le\mu+\varepsilon$（`claim_rational_log_order_group_add_monotone`）、
  $\mu+\varepsilon\le\lambda_L$（証人の性質）と推移律の結論を各 $L$ で検査する。

順序は `def_rational_log_order_group_order` の決定手続き $N_\mu\lambda_{N_\lambda}\le_\Lambda N_\lambda\mu_{N_\mu}$、
加法・逆元・有理数倍は `def_rational_log_order_group` のとおり素数ごとに計算する。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/rational-log-order-group-sequence-lower-set/check.sage
```
