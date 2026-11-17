# SageMath Check: 部分体を係数とする多項式の除法

## 対象

**対象ラベル**: `claim_subfield_coefficient_polynomial_division`

- 実行日: 2026-11-17
- 結果: 全検査通過（$F=\mathbb Q(s)$、$s\cdot s=2$。最高次の番号 $0$〜$5$ の割る多項式と次数 $-\infty$〜$10$ の割られる多項式の無作為な組 400 個）
- 帰属: 数体 $\mathbb Q(s)$ と `QQ` の厳密計算。浮動小数点を使わない。

## 何を確かめるか

本文の証明の段を、行ごとに次で確かめる。普遍量化された主張の証明ではない。

- 単項式の係数の段: $\mathrm{ac}_i(\widehat c\cdot t^m)$ を積の係数の有限和として計算し、$i=m$ で $c$、それ以外で零元になること。$\widehat c\cdot t^m$ の係数が $F$ に属すること。
- 単項式を掛けた係数の段: $\mathrm{ac}_k(\widehat c\cdot t^m\cdot h)$ を積の係数の有限和として計算し、$k\ge m$ で $c\cdot\mathrm{ac}_{k-m}(h)$、$k<m$ で零元になること。
- 帰納法: 本文の $P(d)$ をそのまま再帰で辿り、割る必要のない場合の等式と余りの上界、一歩の場合の $g'$ の所属、$k\ge d+1$ と $k=d$ の鎖の各行、合成の三行を確かめる。
- 結論: 係数の尽きる番号 $d$ を次数 $+1$（零多項式なら $0$）に取って得た $u,r$ が $g=u\cdot h+r$ と余りの上界を満たし、Sage の `quo_rem` と一致すること。

## 実行方法

```sh
sage check.sage
```
