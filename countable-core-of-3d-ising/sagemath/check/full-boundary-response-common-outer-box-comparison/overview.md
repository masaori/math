# SageMath Check: 辺変数を 1 に置かない境界応答多項式の、共通の外箱を経由した比較

## 対象

**対象ラベル**: `claim_full_boundary_response_common_outer_box_comparison`

- 内箱 $V_{L'}=\{(0,0,0)\}$、共通の外箱 $V_{L_0}=\{0,1\}^3$（8 点・12 辺）、二つの外箱
  $V_{L_1}=\{0,1,2\}\times\{0,1\}\times\{0,1\}$ と $V_{L_2}=\{0,1\}\times\{0,1,2\}\times\{0,1\}$
  （各 12 点・20 辺。互いに含まない）の自由境界の箱で、本文の主張を証明と同じ順で確認する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_common_outer_box_comparison.sage` | 箱と辺の包含（$V_{L_1}$ と $V_{L_2}$ が互いに含まないことも）、$\widetilde R=\mathcal Z$ の直接の有限和、二つの三つ組への外箱依存性の適用 $\pi_{L_i,L_0}(\widetilde R_{L_i,L'})=2^{\#V_{L_i}-\#V_{L_0}}\widetilde R_{L_0,L'}$、2 冪の積で結んだ $2^{\#V_{L_2}}\pi_{L_1,L_0}(\widetilde R_{L_1,L'})=2^{\#V_{L_1}}\pi_{L_2,L_0}(\widetilde R_{L_2,L'})$ | PASS | 両辺とも $2^{16}\,\widetilde R_{L_0,L'}$ に一致 |

## 備考

- すべて `ZZ` 上の多変数多項式環の厳密計算であり、浮動小数点・極限・無限和は使わない。
- 外箱依存性の主張の検証（`full-boundary-response-outer-edges-to-one/`）と同じ箱の作り方・同じ代入の作り方を用いる。

```sh
sage sagemath/check/full-boundary-response-common-outer-box-comparison/check_common_outer_box_comparison.sage
```

**2026-08-16 実行: PASS。**
