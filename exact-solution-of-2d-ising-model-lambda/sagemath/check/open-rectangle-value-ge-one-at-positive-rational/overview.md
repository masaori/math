# SageMath Check: 開境界長方形の正の有理点での値は 1 以上である

## 対象

**対象ラベル**: `claim_open_rectangle_value_ge_one_at_positive_rational`

準備として次も検査する（実数体脱出の前へ移した定義と主張）。

- `def_open_rectangle_constant_plus_configuration`（$\tau_{+}\in\Sigma^{\mathrm{op}}_{a,b}$）
- `claim_open_rectangle_constant_plus_breaks_no_bond`（$b^{\mathrm{op}}_{a,b}(\tau_{+})=0$）

- 実行日: 2026-08-16
- 状態: PASS（11472 検査）
- 帰属: `ZZ`/`QQ` の厳密計算だけを使う。浮動小数点は使わない（主張は $\mathbb Q$ で閉じており、実数体は現れない）。

## 検査内容

長方形の形 $(a,b)$ 11 通り（$1\le a,b\le4$、配位数 $2^{ab}\le512$）と正の有理数 $q$ 9 点
（$1$ 未満・$1$・$1$ 超え）について、$\tau_{+}$ が配位であること・破れた辺の集合が空で
$b^{\mathrm{op}}_{a,b}(\tau_{+})=0$ であること、準備「各配位で $0<q^{b^{\mathrm{op}}_{a,b}(\sigma)}$、
$b^{\mathrm{op}}_{a,b}(\sigma)=0$ なら $q^0=1$」、および本文の式変形の各行
（$1=q^0$、$q^0=q^{b^{\mathrm{op}}_{a,b}(\tau_{+})}$、残りの和が $0$ 以上で $\le$ が成り立つこと、
分離した 1 項を有限和へ戻す等式、$\sum_\sigma q^{b^{\mathrm{op}}_{a,b}(\sigma)}$ が $\mathbb Z[x]$ の
開境界分配多項式への代入 $Z^{\mathrm{op}}_{a,b}(q)$ と一致すること）と結論 $1\le Z^{\mathrm{op}}_{a,b}(q)$ を検査する。
整合検査として $q=1$ で $Z^{\mathrm{op}}_{a,b}(1)=2^{ab}$ を確かめる。

## 検査できないこと（黙って広げない）

有限標本検査は任意の $a,b,q$ についての主張の証明ではない。一般の主張は Lean
（`one_le_openPartitionValueRat`、必要十分版 `one_le_sum_pow_of_exponent_zero_necSuf` の共有、
導出版 `one_le_openPartitionValueRat_from_necSuf`）で検証済み（2026-08-16）。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/open-rectangle-value-ge-one-at-positive-rational/check.sage
```
