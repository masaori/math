# SageMath Check: 開境界正方形の密度の下組の元は密度の上からの評価以下である

## 対象

**対象ラベル**: `claim_open_square_density_lower_set_le_upper_bound`

- 実行日: 2026-08-17
- 状態: PASS（244 検査、$L$ は 1 から 4 まで、$q$ は 8 値。4 秒）
- 帰属: `ZZ`/`QQ` と素因数分解による厳密計算。浮動小数点は使わない。

## 検査内容

所属の証人 $(\varepsilon,N)$ を持つ $\mu$ について、`claim_open_square_density_lower_set_le_upper_bound` の証明の五段
$\mu=0+\mu\le_{\Lambda_{\mathbb Q}}\varepsilon+\mu=\mu+\varepsilon\le_{\Lambda_{\mathbb Q}}\Psi^{\mathrm{op}}_N(q)\le_{\Lambda_{\mathbb Q}}\iota(\ell_2)+2\iota(\log(1+q))$
と結論 $\mu\le_{\Lambda_{\mathbb Q}}\iota(\ell_2)+2\iota(\log(1+q))$ を検査する。

- $q\in\{\tfrac1{10},\tfrac13,\tfrac12,\tfrac23,1,\tfrac32,\tfrac{22}7,5\}$。
- $\mu$ の標本: 空でないことの証人 $\mu=-\iota(\ell_2)$（$\varepsilon=\iota(\ell_2)$、$N=1$）と、それ以下の三つの元
  （$-2\iota(\ell_2)$、$-\iota(\ell_3)$、$-\iota(\ell_2)-\iota(\ell_5)$。下に閉じているので所属する）、
  および $\varepsilon=\tfrac12\iota(\ell_2)$、$N=2$ で $\mu:=\Psi^{\mathrm{op}}_2(q)-\varepsilon-\iota(\ell_2)$。
  所属（$N\le L$ を満たすすべての $L$）は有限範囲 $N\le L\le4$ で直接確かめる（全称そのものは本文の証明が担う）。

一辺 4 の分配多項式は行配位についての動的計画法で計算し、一辺 1〜3 で全列挙と一致することを確かめる。
順序は `def_rational_log_order_group_order` の決定手続きで比べる。共通分母は分母の最小公倍数で取る
（`claim_common_denominator_multiple` により結果は共通分母の取り方に依らない。分母の積で取ると
$\Psi^{\mathrm{op}}_L(q)$ どうしの比較で指数が $16^{10}$ 程度になり $\mathrm{rat}_\Lambda$ の計算が実行不能になる。実測: 5 分超）。
加法・逆元・有理数倍は `def_rational_log_order_group` のとおり素数ごとに計算する。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/open-square-density-lower-set-le-upper-bound/check.sage
```
