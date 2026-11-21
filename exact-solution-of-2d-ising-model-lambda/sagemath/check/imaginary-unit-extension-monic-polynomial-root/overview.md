# SageMath Check: 虚数単位を足した体を係数とする、最高次の係数が一の多項式は、その体に根を持つ

## 対象

**対象ラベル**: `claim_imaginary_unit_extension_monic_polynomial_root`

- 実行日: 2026-11-21
- 結果: 全検査通過（PASS 131）
- 帰属: 標本は `QQbar` の厳密な元と `QQbar[t]` の多項式。浮動小数点は使わない。
- 標本: $F=$ 実代数的数の全体（`AA`。正の元は平方で、奇数次の多項式は根を持つので主張の仮定を満たす）、$\omega=i$、$\mathrm{Lin}_F(\omega)=\overline{\mathbb{Q}}$、$\mathrm{cj}_\omega(a+bi)=a-bi$。番号 $d$ の係数が 1 の多項式五つ（次数 1〜4、係数に虚部を持つものと持たないもの）。

## 何を確かめるか

- 準備 (一) $\mathrm{cj}_\omega(0)=0$、$\mathrm{cj}_\omega(1)=1$。
- 準備 (二) $k>d$ で $\mathrm{ac}_k(\mathrm{cjp}_\omega(g))=0$、$\mathrm{ac}_d(\mathrm{cjp}_\omega(g))=1$。
- 準備 (三) $h=g\cdot\mathrm{cjp}_\omega(g)$ の係数が $F$ に入る。
- 準備 (四) $k>d+d$ で $\mathrm{ac}_k(h)=0$、$\mathrm{ac}_{d+d}(h)=\mathrm{ac}_d(g)\cdot\mathrm{ac}_d(\mathrm{cjp}_\omega(g))=1$。
- 主張: $h$ の全ての根 $z$ について $\mathrm{aev}_z(g)\cdot\mathrm{aev}_z(\mathrm{cjp}_\omega(g))=\mathrm{aev}_z(h)=0$、$\mathrm{aev}_z(g)\ne0$ なら $\mathrm{aev}_z(\mathrm{cjp}_\omega(g))=0$ かつ $\mathrm{aev}_{\mathrm{cj}_\omega(z)}(g)=\mathrm{cj}_\omega(0)=0$。二つの場合が両方とも標本に現れることも確かめる。
- $d\ge1$ の仮定が要ること（単位元には根が無い）。

有限個の標本の検算であり、普遍量化された主張の証明ではない。

## 実行方法

```sh
sage check.sage
```
