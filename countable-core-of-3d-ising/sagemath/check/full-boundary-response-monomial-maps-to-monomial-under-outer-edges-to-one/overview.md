# SageMath Check: 各配位の単項式は増えた辺の変数を 1 に置く代入で単項式に写る

## 対象

**対象ラベル**: `claim_full_boundary_response_monomial_maps_to_monomial_under_outer_edges_to_one`

- 内箱 $V_{L'}=\{(0,0,0)\}$、外箱 $V_L=\{0,1\}^3$（8 点・12 辺）、広い外箱 $V_{L''}=\{0,1,2\}\times\{0,1\}^2$（12 点・20 辺）の自由境界の箱で、本文の証明を一段ずつ確認する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_monomial_maps_to_monomial.sage` | 不定元の行き先（$e\in E_L$ なら $\pi(X_e)=X_e$、$e\in E_{L''}\setminus E_L$ なら $\pi(X_e)=1$）、広い外箱の全 $2^{12}$ 配位 $\sigma$ について $B(\sigma)$ が $B(\sigma)\cap E_L$ と $B(\sigma)\setminus E_L$ の互いに素な和集合であること、環準同型が有限積を保つこと、行き先の場合分けにより $\pi_{L'',L}(\prod_{e\in B(\sigma)}X_e)=\prod_{e\in B(\sigma)\cap E_L}X_e$（$E_L$ 上の相異なる不定元の積）であること | PASS | 4096 配位すべてで一致 |

## 備考

- すべて `ZZ` 上の多変数多項式環と環準同型の厳密計算であり、浮動小数点・極限・無限和は使わない。

```sh
sage sagemath/check/full-boundary-response-monomial-maps-to-monomial-under-outer-edges-to-one/check_monomial_maps_to_monomial.sage
```

**2026-08-16 実行: PASS。**
