# SageMath Check: 虚数単位を足した体の根で割った商の係数は虚数単位を足した体に入る

## 対象

**対象ラベル**: `claim_imaginary_unit_extension_factor_quotient_coefficient`

- 実行日: 2026-11-20
- 結果: 全検査通過（PASS 247）
- 帰属: 標本は `QQbar` の厳密な元と `QQbar[t]` の多項式。浮動小数点は使わない。`Lin_F(ω)` への所属は、実部・虚部の最小多項式から `QQ(√2)` の元かを厳密に判定する。
- 標本: $F=\mathbb{Q}(\sqrt2)$、$\omega=i$。$\mathrm{Lin}_F(\omega)$ の元五つ、係数が $\mathrm{Lin}_F(\omega)$ の多項式三つ。

## 何を確かめるか

- 準備 (一) の閉性、(三) 和の係数、(四) 積の係数の公式と所属、(六) $t^k$ の係数、(七) $K_{k+1}(w)=K_k(w)\widehat w+t^k$ と $K_k(w)$ の係数の所属。
- 主張: $g=\sum_{k=0}^{n}\widehat{\mathrm{ac}_k(f)}K_k(w)$ の係数が $\mathrm{Lin}_F(\omega)$ に属すること（$n$ を次数とそれより大きい値の両方で）。
- $f=(t-\widehat w)h$ と作ったとき $g=h$ で $f=(t-\widehat w)g$（`claim_qbar_factor_theorem` の商であること）。
- 係数の仮定を外すと崩れる例（$f=\sqrt3\,t$、$w=1$ で $g=\sqrt3\notin\mathrm{Lin}_F(\omega)$）。主張を弱めていないことの確認。

有限個の標本の検算であり、普遍量化された主張の証明ではない。

## 実行方法

```sh
sage check.sage
```
