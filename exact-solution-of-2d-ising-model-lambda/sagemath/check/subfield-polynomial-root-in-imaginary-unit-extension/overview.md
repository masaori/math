# SageMath Check: 虚数単位を足した体に根を持つこと

## 対象

**対象ラベル**: `claim_positive_natural_two_power_odd_decomposition`, `claim_subfield_polynomial_root_in_imaginary_unit_extension`

- 実行日: 2026-11-20
- 結果: 全検査通過（PASS 2431）
- 帰属: 分解は自然数。多項式は有理係数の多項式の分解体（虚数単位も含む数体）の厳密な元。浮動小数点は使わない。
- 標本: $d=1,\dots,512$ の分解と、最高次の係数が一の有理係数の多項式十二個（次数 1〜8、次数の 2 進付値 0〜3）。$F$ を実代数的数の体、$K=F(\omega)$ を代数的数の全体と読むので、$K$ への所属はこの検査では自明である。

## 何を確かめるか

- 分解: 各 $d$ が $j+j$ か $j+j+1$ であること、奇数の場合の式鎖 $d=1\cdot d=2^0\cdot d$、偶数の場合の $1\le j<d$ と五行の式鎖、$d=2^k m$（$m$ は奇数）。
- 出発点: 奇数個 $m'$ の一次因子の積 $\Pi$ で $\mathrm{ac}_{m'}(\Pi)=\mathrm{ac}_{m'-0}(\Pi)=(-1)^0\cdot1=1$、$k>m'$ で $\mathrm{ac}_k(\Pi)=0$、$\Pi$ の根が因子の根 $\beta(r)$（$r<m'$）であること。
- 一歩の指数: $(k+1)-1=k$。
- 主張の最後の式鎖: $f=\prod_{r<d}(t-\alpha(r))$ と、各 $i<d$ で $\mathrm{aev}_{\alpha(i)}(f)=\prod(\alpha(i)-\alpha(r))=(\alpha(i)-\alpha(i))\cdot\prod_{r\ne i}=0\cdot\prod_{r\ne i}=0$。

有限個の標本の検算であり、普遍量化された主張の証明ではない。帰納法の一歩そのものは
`subfield-polynomial-root-induction-step` が確かめる。

## 実行方法

```sh
sage check.sage
```
