# SageMath Check: 開境界正方形の密度の列が定める下組・下組は空でない

## 対象

**対象ラベル**: `def_open_square_density_lower_set`, `claim_open_square_density_lower_set_nonempty`

- 実行日: 2026-08-17
- 状態: PASS（141 検査、$L$ は 1 から 4 まで、$q$ は 8 値。10 秒）
- 帰属: `ZZ`/`QQ` と素因数分解による厳密計算。浮動小数点は使わない。

## 検査内容

証人 $\varepsilon:=\iota(\ell_2)$、$N:=1$ について、`claim_open_square_density_lower_set_nonempty` の証明の中身を検査する。

- 準備の第一: $0=\iota(0)=\iota(\log1)\le_{\Lambda_{\mathbb Q}}\iota(\log2)=\iota(\ell_2)$（各段を辞書の等号と決定手続きで）。
- 準備の第二: $\ell_2(2)=1\ne0$、$\iota(\ell_2)\ne0$。
- 本体: $q\in\{\tfrac1{10},\tfrac13,\tfrac12,\tfrac23,1,\tfrac32,\tfrac{22}7,5\}$、$1\le L\le4$ の各組で、
  三段 $-\iota(\ell_2)+\varepsilon=-\iota(\ell_2)+\iota(\ell_2)=0\le_{\Lambda_{\mathbb Q}}\Psi^{\mathrm{op}}_L(q)$ と結論
  $-\iota(\ell_2)+\varepsilon\le_{\Lambda_{\mathbb Q}}\Psi^{\mathrm{op}}_L(q)$ を検査する（下組の所属を有限範囲で確かめる。
  「$1\le L$ を満たすすべての $L$」の全称そのものは本文の証明が担う）。

一辺 4 の分配多項式は行配位についての動的計画法で計算し、一辺 1〜3 で全列挙と一致することを確かめる。
順序は `def_rational_log_order_group_order` の決定手続き、加法・逆元・有理数倍は `def_rational_log_order_group` のとおり素数ごとに計算する。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/open-square-density-lower-set-nonempty/check.sage
```
