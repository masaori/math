# SageMath Check: 増えた辺の変数を 1 に置いてから全変数を 1 に置くことは全変数を 1 に置くことに等しい

## 対象

**対象ラベル**: `claim_full_boundary_response_outer_edges_to_one_then_value_at_one`

- 内箱 $V_{L'}=\{(0,0,0)\}$、外箱 $V_L=\{0,1\}^3$（8 点・12 辺）、広い外箱 $V_{L''}=\{0,1,2\}\times\{0,1\}^2$（12 点・20 辺）の自由境界の箱で、本文の証明を一段ずつ確認する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_outer_edges_to_one_then_value_at_one.sage` | 合成 $\varepsilon_L\circ\pi_{L'',L}$ が環準同型であること、全ての不定元 $X_e$（$e\in E_L$ では $\pi(X_e)=X_e$、$e\in E_{L''}\setminus E_L$ では $\pi(X_e)=1$）で $\varepsilon_L(\pi_{L'',L}(X_e))=1=\varepsilon_{L''}(X_e)$ となること、普遍性により環準同型として $\varepsilon_L\circ\pi_{L'',L}=\varepsilon_{L''}$ であること、したがって $\varepsilon_L(\pi_{L'',L}(\widetilde R_{L'',L'}))=\varepsilon_{L''}(\widetilde R_{L'',L'})=2^{\#V_{L''}}$ であること | PASS | $\varepsilon_L(\pi_{L'',L}(\widetilde R_{L'',L'}))=4096=2^{12}$ |

## 備考

- すべて `ZZ` 上の多変数多項式環と環準同型の厳密計算であり、浮動小数点・極限・無限和は使わない。

```sh
sage sagemath/check/full-boundary-response-outer-edges-to-one-then-value-at-one/check_outer_edges_to_one_then_value_at_one.sage
```

**2026-08-16 実行: PASS。**
