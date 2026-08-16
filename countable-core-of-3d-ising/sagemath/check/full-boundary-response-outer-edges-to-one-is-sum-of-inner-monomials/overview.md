# SageMath Check: 増えた辺の変数を 1 に置いた境界応答多項式は配位ごとの元の外箱の破れ辺の単項式の有限和

## 対象

**対象ラベル**: `claim_full_boundary_response_outer_edges_to_one_is_sum_of_inner_monomials`

- 内箱 $V_{L'}=\{(0,0,0)\}$、外箱 $V_L=\{0,1\}^3$（8 点・12 辺）、広い外箱 $V_{L''}=\{0,1,2\}\times\{0,1\}^2$（12 点・20 辺）の自由境界の箱で、本文の証明を一段ずつ確認する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_outer_edges_to_one_is_sum.sage` | $\widetilde R_{L'',L'}$ が全 $2^{12}$ 配位 $\sigma$ の単項式 $\prod_{e\in B(\sigma)}X_e$ の有限和であること（定義）、環準同型 $\pi_{L'',L}$ が有限和を保つこと、各項の像が前主張のとおり $\prod_{e\in B(\sigma)\cap E_L}X_e$ であること、したがって $\pi_{L'',L}(\widetilde R_{L'',L'})=\sum_{\sigma}\prod_{e\in B(\sigma)\cap E_L}X_e$（$E_L$ 上の単項式の有限和）であること | PASS | 4096 項すべてで一致、左辺と右辺が `ZZ` 上で等しい |

## 備考

- すべて `ZZ` 上の多変数多項式環と環準同型の厳密計算であり、浮動小数点・極限・無限和は使わない。

```sh
sage sagemath/check/full-boundary-response-outer-edges-to-one-is-sum-of-inner-monomials/check_outer_edges_to_one_is_sum.sage
```

**2026-08-16 実行: PASS。**
