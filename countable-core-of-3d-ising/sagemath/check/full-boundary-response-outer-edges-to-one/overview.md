# SageMath Check: 外箱を広げた辺変数を 1 に置くと、辺変数を 1 に置かない境界応答多項式は 2 冪倍に戻る

## 対象

**対象ラベル**: `claim_full_boundary_response_outer_edges_to_one`

- 内箱 $V_{L'}=\{(0,0,0)\}$、外箱 $V_L=\{0,1\}^3$（8 点・12 辺）、広い外箱
  $V_{L''}=\{0,1,2\}\times\{0,1\}\times\{0,1\}$（12 点・20 辺）の自由境界の箱で、本文の主張を一段ずつ確認する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_outer_edges_to_one.sage` | 箱と辺の包含、$\widetilde R=\mathcal Z$ の直接の有限和、代入 $\pi_{L'',L}$ が環準同型であること、$\pi_{L'',L}(\widetilde R_{L'',L'})=2^{\#V_{L''}-\#V_L}\widetilde R_{L,L'}$ | PASS | $2^{12}$ 配位と $2^{8}$ 配位の直接の有限和で $\pi_{L'',L}(\widetilde R_{L'',L'})=16\,\widetilde R_{L,L'}$ |

## 備考

- すべて `ZZ` 上の多変数多項式環の厳密計算であり、浮動小数点・極限・無限和は使わない。
- 代入 $\pi_{L'',L}$ は `PolynomialRing.hom` で作り、加法・乗法・単位元の保存を代表元で確かめている。

```sh
sage sagemath/check/full-boundary-response-outer-edges-to-one/check_outer_edges_to_one.sage
```

**2026-08-16 実行: PASS。**
