# SageMath Check: 自由エネルギー密度の値集合の上限の存在

## 対象

**対象ラベル**: `def_free_energy_density_value_set`, `claim_free_energy_density_supremum_exists`

- 実行日: 2026-08-15
- 結果: 有限標本検査がすべて通過（合計 50 件）
- 帰属: 非空性の証人（$L=1$ が条件を満たすこと）と $Z_L(t)$ の計算は可算側の厳密検査。
  実対数に触れる検査（上界性・有限モデルの比較）だけ `RealBallField(256)`（ball 算術）を使う。

## 何を確かめるか

- 準備の第一（非空性）: $L=1$ が $L\in\mathbb{N}$、$L\ge1$ を満たすこと（厳密）と、
  証人 $\psi_1(t)$ の値が確定すること（$8$ 件）。
- 準備の第二（上界性）: 各標本 $L,t$ について
  $\psi_L(t)\le_{\mathbb{R}}M_t=\log_{\mathbb{R}}(\iota(2))+\iota(2)\cdot\log_{\mathbb{R}}(1+t)$。
  差の ball の下端が $0$ より大きいことで**厳密に確定**する（全標本で分離。$21$ 件）。
- 上限（最小上界）の性質の有限モデル: 有限部分集合 $\{\psi_L(t)\mid L\in\{1,2,3\}\}$ では
  最大元が (1) すべての元の上界であり、(2) 集合の元なのでどの上界よりも小さいか等しい
  （最小上界）。(1) は ball の比較、(2) は構成による（$21$ 件）。

## 検査できないこと（黙って広げない）

**完備性そのもの（無限集合 $\Psi_t$ の上限の存在）は有限標本では検査できない。**
本文の証明が完備性を公理として使う唯一の箇所であり、その適用の前提
（非空・上に有界）だけを標本で検査した。上限の存在自体の保証は本文の人手証明
（と実数の完備性の宣言 `remark_real_completeness_escape`）が担う。

## 浮動小数点（ball 算術）を使う理由（記録）

実対数の値は一般に超越的で、厳密な閉形式の比較ができない。実対数に触れる検査だけ
`RealBallField`（丸め誤差を厳密に包含する区間算術）を使う。不等式は ball の分離で
厳密に確定できる。可算側で済む検査には浮動小数点を使っていない。

## 範囲の注記（黙って狭めない）

- $L$ の標本は $\{1,2,3\}$、$t$ の標本は正の**有理数** $7$ 点（1 未満・1・1 超えを含む）。
  普遍量化された主張そのものの証明は本文の人手証明が担う。
- Lean 具体版 `freeEnergyDensityValueSet_has_supremum`、必要十分版
  `indexedValueSet_has_supremum_necSuf`、導出
  `freeEnergyDensityValueSet_has_supremum_from_necSuf` があり、`lake build` と
  `scripts/check-no-sorry.sh` の対象に登録している。

## 実行方法

```sh
sage check.sage
```
