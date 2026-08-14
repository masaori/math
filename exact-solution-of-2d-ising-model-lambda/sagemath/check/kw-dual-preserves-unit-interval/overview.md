# SageMath Check: 双対変換は零と一の間の有理数を保つ

## 対象

**対象ラベル**: `def_unit_interval_rationals`, `claim_kw_dual_preserves_unit_interval`

- 実行日: 2026-08-14
- 結果: 検査点 489 点すべて通過
- 帰属: `QQ`（有理数）の厳密計算。浮動小数点は使わない。
  双対変換の値の計算だけ `QQbar` を併用し、`QQ` の中の計算との一致を突き合わせる。

## 何を確かめるか

集合 $\mathbb{Q}_{(0,1)}=\{r\in\mathbb{Q}:0<r<1\}$（`def_unit_interval_rationals`）と、
主張 $q\in\mathbb{Q}_{(0,1)}\Rightarrow\mathrm{KW}(q)\in\mathbb{Q}_{(0,1)}$
（`claim_kw_dual_preserves_unit_interval`）について、証明の各段を一段ずつ確かめる。

- 準備: $1<1+q$、$0<1+q$、$1+q\ne0$、$t:=(1+q)^{-1}\in\mathbb{Q}$、$(1+q)\cdot t=1$、
  `QQbar` における逆元との一致、$0<t$、$0<1-q$、$1-q<1+q$
- 鎖 1: $\mathrm{KW}(q)=(1-q)\cdot t\in\mathbb{Q}$（`QQbar` で計算した定義どおりの値との一致を含む）
- 鎖 2: $0<\mathrm{KW}(q)$
- 鎖 3: $\mathrm{KW}(q)<(1+q)\cdot t=1$
- 結論: $\mathrm{KW}(q)\in\mathbb{Q}_{(0,1)}$

検査点は分母 $2$ から $40$ までの全既約分数 $q=a/b\in(0,1)$ の 489 点である。
`QQ`・`QQbar` の等号・順序比較は厳密であり、数値近似を経由しない。

## 実行方法

```sh
sage check.sage
```
