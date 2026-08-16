# SageMath Check: 辺変数を 1 に置かない境界応答多項式の全変数を 1 に置いた値は配位の総数

## 対象

**対象ラベル**: `claim_full_boundary_response_value_at_one`

- 内箱 $V_{L'}=\{(0,0,0)\}$、外箱 $V_L=\{0,1\}^3$（8 点・12 辺）の自由境界の箱で、本文の証明を一段ずつ確認する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_value_at_one.sage` | $\widetilde R_{L,L'}$ が配位ごとの単項式 $\prod_{e\in B(\sigma)}X_e$ の有限和であること、全不定元を 1 に置く環準同型 $\varepsilon_L$ が各単項式を 1 に写すこと、有限和を保つので像が項数（配位の個数）に等しいこと、その個数が $2^{\#V_L}$ であること | PASS | $\varepsilon_L(\widetilde R_{L,L'})=256=2^{8}$ |

## 備考

- すべて `ZZ` 上の多変数多項式環と環準同型の厳密計算であり、浮動小数点・極限・無限和は使わない。

```sh
sage sagemath/check/full-boundary-response-value-at-one/check_value_at_one.sage
```

**2026-08-16 実行: PASS。**
