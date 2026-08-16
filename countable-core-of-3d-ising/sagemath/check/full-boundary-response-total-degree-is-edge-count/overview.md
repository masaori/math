# SageMath Check: 辺変数を 1 に置かない境界応答多項式の全次数は辺の総数に等しい

## 対象

**対象ラベル**: `claim_full_boundary_response_total_degree_is_edge_count`

- 内箱 $V_{L'}=\{(0,0,0)\}$、外箱 $V_L=\{0,1\}^3$（8 点・12 辺）の自由境界の箱で、本文の証明を一段ずつ確認する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_total_degree_is_edge_count.sage` | 各配位の単項式が相異なる不定元の積で全次数 $\#B(\sigma)\le\#E_L$ であること、有限和 $\widetilde R_{L,L'}$ の各単項式の全次数が高々 $\#E_L$ であること、単項式 $\prod_{e\in E_L}X_e$ の係数が $B(\sigma)=E_L$ となる配位の個数 $\Omega_L(\#E_L)$ で $2$ 以上であること、全次数がちょうど $\#E_L$ であること | PASS | $2^{8}$ 配位の有限和で全次数 $12=\#E_L$、$\prod X_e$ の係数 $\Omega_L(12)=2$ |

## 備考

- すべて `ZZ` 上の多変数多項式環の厳密計算であり、浮動小数点・極限・無限和は使わない。

```sh
sage sagemath/check/full-boundary-response-total-degree-is-edge-count/check_total_degree_is_edge_count.sage
```

**2026-08-16 実行: PASS。**
