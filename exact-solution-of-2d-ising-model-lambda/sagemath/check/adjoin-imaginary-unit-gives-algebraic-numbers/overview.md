# SageMath Check: 正の元が平方で奇数次の多項式が根を持つ部分体に虚数単位を足すと代数的数の全体になる

## 対象

**対象ラベル**: `claim_adjoin_imaginary_unit_gives_algebraic_numbers`

- 実行日: 2026-11-21
- 結果: 全検査通過（PASS 241）
- 帰属: 標本は `QQbar` の厳密な元と `QQbar[t]` の多項式。浮動小数点は使わない。
- 標本の部分体は二つ。
  - $F=$ 実代数的数の全体（`AA`）。主張の仮定を満たす。$\omega=i$。$\xi$ は七つ（有理数、実の二次、$i$、非実の二次、$\sqrt[3]{2}+i$、$\sqrt{-5}+1/2$、$\sqrt{2+i}$）。$p$ は $F$ 上の最小次数の零化多項式に零でない有理数を掛けたもの（最高次の係数で割る段が自明にならないように）。一次因子の積の主張の代わりに、$g$ の根を `QQbar` の中で取る。
  - $F=\mathbb{Q}$。主張の仮定を満たさない。準備と (一)〜(五) は仮定を使わないので同じく通る。$\xi=\sqrt2+i$ と $\xi=\sqrt[3]{2}$ では $g$ の一次因子の根が $\mathrm{Lin}_{\mathbb{Q}}(\omega)$ に入らず、結論が成り立たない。仮定が一次因子の積の主張を通してだけ効くことの確認であり、所属判定が自明でないことの確認でもある。

## 何を確かめるか

- 準備: $p\in F[t]$、$p\ne0$、$\mathrm{aev}_\xi(p)=0$、$k>n$ で係数が零、$c=\mathrm{ac}_n(p)\ne0$、$c,c^{-1}\in F$。
- (一) 各 $k$ で $\mathrm{ac}_k(g)$ の四行の式鎖（積の係数、$i=0$ の項を分ける、定数の係数、零元との積と和）。
- (二) $\mathrm{ac}_k(g)\in F$、$\mathrm{ac}_k(g)=\mathrm{ac}_k(g)+0\cdot\omega\in\mathrm{Lin}_F(\omega)$。
- (三) $\mathrm{ac}_n(g)=c^{-1}\mathrm{ac}_n(p)=c^{-1}c=1$。
- (四) $k>n$ で $\mathrm{ac}_k(g)=c^{-1}\mathrm{ac}_k(p)=c^{-1}\cdot0=0$。
- (五) $\mathrm{aev}_\xi(g)$ の四行の式鎖。
- $g=\prod_{i<n}(t-\widehat{\alpha(i)})$、ある $r<n$ で $\xi=\alpha(r)$、$\alpha$ の値と $\xi$ の $\mathrm{Lin}_F(\omega)$ への所属、$\xi=a+b\omega$（$a,b\in F$）。

有限個の標本の検算であり、普遍量化された主張の証明ではない。

## 実行方法

```sh
sage check.sage
```
