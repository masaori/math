# SageMath Check: 前錐に一つの元を付け足した集合は前錐である

## 対象

**対象ラベル**: `claim_precone_adjoin_element_is_precone`

- 実行日: 2026-11-17
- 結果: 証明の式変形の各行が多項式の等号として通過し、モデルの標本でも包含と所属が通過
- 帰属: `QQ` 上の多項式環の厳密計算。浮動小数点を使わない。

## 何を確かめるか

- 包含と所属の表示 $t=t+a\cdot0$、$a=0+a\cdot1$。
- 和で閉じることの二行と、積で閉じることの二行を、不定元 $t_1,t_2,t_3,t_4,a$ の多項式の等号として確かめる。
- $F=E=\mathbb Q$、$C_F=\mathbb Q_{>0}$、$T=\mathbb Q_{\ge0}$ のモデルで、標本 8 個の $a$ について
  $T\subseteq T\langle a\rangle$ と $a\in T\langle a\rangle$ を、表示 $t+a\cdot t'$ の証人を作って確かめる。

所属の条件（和・積・平方・$C_F$ の包含）そのものは本文の定義の適用であり、検算の対象は式変形の等号である。

## 実行方法

```sh
sage check.sage
```
