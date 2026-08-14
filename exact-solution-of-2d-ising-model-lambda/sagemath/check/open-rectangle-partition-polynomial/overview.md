# SageMath Check: 開境界長方形の分配多項式

## 対象

**対象ラベル**: `def_open_rectangle_vertices`, `def_open_rectangle_edges`, `def_open_rectangle_configuration`, `def_open_rectangle_broken_bond_count`, `def_open_rectangle_partition_polynomial`

- 実行日: 2026-08-15
- 結果: すべて通過（合計 108 件）
- 帰属: 頂点・辺・配位・破れボンド数は有限集合と $\mathbb{N}$、分配多項式は
  $\mathbb{Z}[x]$ で厳密に計算した。浮動小数点・$\mathbb{R}/\mathbb{C}$ は使わない。

## 何を確かめるか

$a,b\in\{1,2,3\}$ の全長方形について、本文の定義をそのまま実装し、次を確かめる。

- 頂点数が $ab$ で、頂点の重複が無い。
- 辺数が $a(b-1)+(a-1)b$ で、辺の番号に重複がなく、両端が頂点集合に属する。
- 配位数が $2^{ab}$ で、各配位の定義域が頂点集合と一致する。
- 破れボンド数が $0$ 以上、辺数以下である。
- $Z^{\mathrm{op}}_{a,b}(x)$ が本文どおり配位ごとの単項式の和であり、係数が非負で、
  $Z^{\mathrm{op}}_{a,b}(1)=2^{ab}$ である。

## 検査できないこと（黙って広げない）

有限標本検査は、任意の正の $a,b$ に対する定義の well-defined 性を証明しない。
普遍量化された定義の形式化は次の tick の Lean 具体版が担う。この検査は、本文の端点写像と
破れボンド数を独立に実装し、分配多項式がその数え上げと一致することを確認する。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/open-rectangle-partition-polynomial/check.sage
```
